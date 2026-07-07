-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 08:47:32

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_health_insurance_v1`.`workforce` COMMENT 'Manages the internal workforce — employee records, organizational hierarchy, job roles, compensation, benefits administration, payroll, performance management, workforce planning, and EAP programs. Owns HR master data, payroll cost allocations to cost centers, role-based access control (RBAC) for PHI/PII systems, and training/certification records required for HIPAA workforce training compliance. Distinct from provider credentialing which governs external clinical staff.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique system-generated identifier for the employee.',
    `job_role_id` BIGINT COMMENT 'Foreign key linking to workforce.job_role. Business justification: Employees belong to a job role; linking employee to job_role eliminates redundant job_title column and enables role‑centric reporting.',
    `manager_employee_id` BIGINT COMMENT 'Employee identifier of the direct manager.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: An employee fills a specific authorized position (headcount slot). This is a fundamental HR relationship - the position defines the role classification, pay grade, FTE allocation, and compliance requi',
    `group_id` BIGINT COMMENT 'Foreign key linking to employer.employer_group. Business justification: Required for enrollment processing: links each employee to their employer group for premium allocation, ACA reporting, and group‑level analytics.',
    `access_level` STRING COMMENT 'Level of access granted to protected health information systems.. Valid values are `none|basic|sensitive|restricted`',
    `address_line1` STRING COMMENT 'First line of the employees mailing address.',
    `birth_date` DATE COMMENT 'Employees birth date for age and EEO reporting.',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for performance bonuses.',
    `city` STRING COMMENT 'City component of the employees mailing address.',
    `cost_center` STRING COMMENT 'Cost center code used for expense allocation.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the employees residence.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `department` STRING COMMENT 'Business department to which the employee belongs.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `email` STRING COMMENT 'Primary email address for employee communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in case of emergency.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact.. Valid values are `^+?[0-9]{10,15}$`',
    `employment_status` STRING COMMENT 'Current employment state of the employee.. Valid values are `active|terminated|on_leave|retired|inactive`',
    `employment_status_code` STRING COMMENT '',
    `employment_type` STRING COMMENT 'Category of employment relationship.. Valid values are `full_time|part_time|contract|temporary|intern`',
    `ethnicity` STRING COMMENT 'Self‑identified ethnicity for equal employment opportunity reporting.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Practitioner)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `first_name` STRING COMMENT 'Employees given name.',
    `gender` STRING COMMENT 'Self‑identified gender for reporting and analytics.. Valid values are `male|female|non_binary|prefer_not_to_answer`',
    `health_plan_eligible` BOOLEAN COMMENT 'Indicates if the employee is eligible for employer-sponsored health coverage.',
    `hipaa_training_completion_date` DATE COMMENT 'Date the employee completed mandatory HIPAA workforce training.',
    `hire_date` DATE COMMENT 'Date the employee commenced employment.',
    `i9_verification_date` DATE COMMENT 'Date the employees I‑9 employment eligibility was verified.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `last_name` STRING COMMENT 'Employees family name.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `middle_name` STRING COMMENT 'Employees middle name or initial, if applicable.',
    `organization_level` STRING COMMENT 'Level within the corporate hierarchy (e.g., staff, manager, director, executive).',
    `pay_frequency` STRING COMMENT 'How often the employee is paid.. Valid values are `monthly|biweekly|weekly|semi_monthly`',
    `phone_number` STRING COMMENT 'Primary telephone number for the employee.. Valid values are `^+?[0-9]{10,15}$`',
    `postal_code` STRING COMMENT 'ZIP or postal code for the employees mailing address.. Valid values are `^d{5}(-d{4})?$`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was first created in the system.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employee record.',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `salary_amount` DECIMAL(18,2) COMMENT 'Annual base salary amount before bonuses or incentives.',
    `salary_currency` STRING COMMENT 'Currency of the salary amount.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `security_training_completion_date` DATE COMMENT 'Date the employee completed required security awareness training.',
    `ssn` STRING COMMENT 'Government‑issued identifier for tax and payroll purposes.. Valid values are `^d{3}-d{2}-d{4}$`',
    `state` STRING COMMENT 'State or province component of the employees mailing address.',
    `termination_date` DATE COMMENT 'Date the employees employment ended, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Authoritative master record for all internal workforce members — full-time, part-time, contract, and temporary employees. Captures employee demographics (name, date of birth, gender, ethnicity for EEO reporting), contact information, employment status (active, inactive, terminated, on leave), hire date, termination date, employment type, FLSA classification, EEO category, I-9 verification status, PHI/PII access authorization level, and current position assignment. This is the single source of truth for internal workforce identity, distinct from the provider domain which governs external clinical staff and from the member domain which governs insured individuals. Sourced from the HRIS and integrated with RBAC systems for PHI access governance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'System-generated unique identifier for the position record.',
    `job_role_id` BIGINT COMMENT 'Foreign key linking to workforce.job_role. Business justification: Positions are defined by a job role; linking position to job_role removes duplicated role attributes stored in position.',
    `bonus_eligible` BOOLEAN COMMENT 'True if the position is eligible for performance bonuses.',
    `competency_level` STRING COMMENT 'Standard competency tier required for the position (e.g., Level 1, Level 2).',
    `compliance_training_completed` BOOLEAN COMMENT 'Indicates whether mandatory compliance training (e.g., HIPAA, OSHA) has been completed for the role.',
    `cost_center_code` STRING COMMENT 'Code of the cost center to which the positions labor costs are charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the position record was first created.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `department_code` STRING COMMENT 'Identifier for the department that houses the position.',
    `position_description` STRING COMMENT 'Narrative description of duties, responsibilities, and scope of the position.',
    `eeo1_category` STRING COMMENT 'Equal Employment Opportunity category for reporting (e.g., Management, Professional, Technical). [ENUM-REF-CANDIDATE: management|professional|technical|sales|administrative|executive|other — promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when the position is retired or closed (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the position becomes active for staffing.',
    `employment_type` STRING COMMENT 'Classification of employment relationship for the position.. Valid values are `full_time|part_time|contract|temporary`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: PractitionerRole)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `flsa_classification` STRING COMMENT 'Fair Labor Standards Act classification indicating exempt or non‑exempt status.. Valid values are `exempt|non_exempt`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Proportion of a full‑time workload assigned to the position (e.g., 1.00 for full‑time, 0.50 for half‑time).',
    `hipaa_privacy_training_required` BOOLEAN COMMENT 'Indicates whether the position must complete HIPAA privacy training.',
    `incentive_plan` STRING COMMENT 'Name of any incentive or commission plan linked to the position.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_managerial` BOOLEAN COMMENT 'True if the position includes managerial responsibilities.',
    `job_code` STRING COMMENT 'Internal code used to identify the job classification for the position.',
    `language_requirements` STRING COMMENT 'Comma‑separated list of languages required or preferred for the position.',
    `last_review_date` DATE COMMENT 'Date of the most recent performance review for the position.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `next_review_due_date` DATE COMMENT 'Scheduled date for the next performance review.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether the position is eligible for overtime compensation.',
    `pay_grade` STRING COMMENT 'Compensation band identifier for the position.',
    `pay_grade_max` DECIMAL(18,2) COMMENT 'Maximum salary amount for the pay grade.',
    `pay_grade_mid` DECIMAL(18,2) COMMENT 'Midpoint salary amount for the pay grade.',
    `pay_grade_min` DECIMAL(18,2) COMMENT 'Minimum salary amount for the pay grade.',
    `phi_access_tier` STRING COMMENT 'Level of protected health information access granted to the role.. Valid values are `none|low|medium|high`',
    `position_status` STRING COMMENT 'Current staffing status of the position.. Valid values are `vacant|filled|closed|pending`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `remote_allowed` BOOLEAN COMMENT 'Indicates whether the position can be performed remotely.',
    `required_certifications` STRING COMMENT 'Comma‑separated list of certifications required for the position (e.g., CPC, PMP).',
    `salary_band` STRING COMMENT 'Broad salary band classification used for budgeting.',
    `shift_type` STRING COMMENT 'Typical work shift pattern for the position.. Valid values are `day|night|rotating|flex`',
    `supervisory_level` STRING COMMENT 'Numeric level indicating depth of supervisory responsibility (e.g., 0 = individual contributor).',
    `title` STRING COMMENT 'Official title of the position (e.g., Senior Claims Analyst).',
    `travel_required` BOOLEAN COMMENT 'True if the role requires regular travel.',
    `union_member` BOOLEAN COMMENT 'True if the position is covered by a labor union.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the position record.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Master record for all authorized positions (headcount slots) and their role classifications within the organization. Captures position title, job code, role code, role title, job family, job function, FLSA classification, EEO-1 category, pay grade (with minimum/midpoint/maximum range), FTE allocation, cost center assignment, department, required certifications, PHI access tier, and whether the position requires HIPAA privacy training. Serves as the single source of truth for both headcount management and role classification — the position entity is the authoritative owner of all role classification attributes, eliminating the need for a separate job role reference table. Supports workforce planning by tracking filled vs. vacant positions and approved headcount budgets. Serves as the classification backbone for compensation banding, RBAC provisioning, and regulatory EEO reporting. A position can be vacant or filled by multiple employees over time.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` (
    `job_role_id` BIGINT COMMENT 'System-generated unique identifier for the job role record.',
    `job_org_unit_id` BIGINT COMMENT 'add column org_unit_id (BIGINT) with FK to workforce.org_unit.org_unit_id - job roles are defined within organizational units',
    `job_workforce_org_unit_id` BIGINT COMMENT 'Foreign key link added per relation requirement.',
    `org_unit_id` BIGINT COMMENT '',
    `compensation_band` STRING COMMENT 'Band identifier (e.g., A, B, C) used for salary planning and budgeting.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which labor costs for this role are allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the role record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `eeo_category` STRING COMMENT 'Equal Employment Opportunity classification used for federal reporting. [ENUM-REF-CANDIDATE: executive|managerial|professional|technical|clerical|service|labor|other — 8 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when the role definition is retired or superseded (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the role definition becomes effective for new hires.',
    `external_system_source` STRING COMMENT 'Name of the source system that originally supplied the role record.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `flsa_exempt_status` STRING COMMENT 'Indicates whether the role is exempt from overtime under the Fair Labor Standards Act.. Valid values are `exempt|non_exempt`',
    `hipaa_training_required` BOOLEAN COMMENT 'Indicates whether the role must complete HIPAA privacy and security training.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_clinical` BOOLEAN COMMENT 'True if the role involves direct clinical activity or patient care.',
    `is_managerial` BOOLEAN COMMENT 'True if the role includes supervisory responsibilities.',
    `job_family` STRING COMMENT 'High‑level grouping of related roles (e.g., Clinical, Administrative, Operations).',
    `job_function` STRING COMMENT 'Specific functional area within the job family (e.g., Claims Processing, Provider Relations).',
    `last_review_date` DATE COMMENT 'Date when the role definition was last reviewed for accuracy or policy changes.',
    `legacy_role_code` STRING COMMENT 'Identifier for the role in legacy HR systems, if applicable.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `organization_unit` STRING COMMENT 'Top‑level business unit or division where the role resides (e.g., Claims, Provider Relations).',
    `pay_currency` STRING COMMENT 'Currency in which the pay grades are expressed.. Valid values are `USD|CAD|EUR`',
    `pay_grade_max` DECIMAL(18,2) COMMENT 'Highest annual salary or hourly rate applicable to the role.',
    `pay_grade_min` DECIMAL(18,2) COMMENT 'Lowest annual salary or hourly rate applicable to the role.',
    `phi_access_tier` STRING COMMENT 'Level of access the role has to Protected Health Information, aligned with HIPAA role‑based access controls.. Valid values are `none|low|medium|high`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `required_certifications` STRING COMMENT 'Comma‑separated list of professional certifications required for the role (e.g., CPC, CPHQ).',
    `role_access_level` STRING COMMENT 'General system access level granted to the role.. Valid values are `read|write|admin`',
    `role_code` STRING COMMENT 'Unique alphanumeric code used to reference the job role across systems.',
    `role_description` STRING COMMENT 'Detailed description of responsibilities, scope, and expectations for the role.',
    `role_level` STRING COMMENT 'Numeric level indicating the roles position in the organizational hierarchy.',
    `role_notes` STRING COMMENT 'Free‑form field for additional remarks or special considerations.',
    `role_owner_department` STRING COMMENT 'Department responsible for maintaining the role definition.',
    `role_risk_level` STRING COMMENT 'Risk classification based on PHI access and business impact.. Valid values are `low|medium|high`',
    `role_status` STRING COMMENT 'Current lifecycle status of the role definition.. Valid values are `active|inactive|deprecated`',
    `role_title` STRING COMMENT 'Official title of the job role as displayed to employees and managers.',
    `role_version` STRING COMMENT 'Version number incremented each time the role definition is changed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the role record.',
    CONSTRAINT pk_job_role PRIMARY KEY(`job_role_id`)
) COMMENT 'Reference master defining all job roles and role families used across the health plan. Captures role code, role title, job family, job function, FLSA exemption status, EEO-1 category, minimum and maximum pay grade, required certifications, PHI access tier, and whether the role requires HIPAA privacy training. Serves as the classification backbone for compensation banding, RBAC provisioning, and regulatory EEO reporting. Distinct from position (which is a headcount slot) and employee (which is a person).';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'System-generated unique identifier for the organizational unit.',
    `parent_org_unit_id` BIGINT COMMENT 'Identifier of the immediate parent unit for hierarchy traversal.',
    `address_line1` STRING COMMENT 'First line of the units mailing address.',
    `annual_budget_amount` DECIMAL(18,2) COMMENT 'Approved budget for the fiscal year, in US dollars.',
    `audit_status` STRING COMMENT 'Result of the most recent audit.. Valid values are `passed|failed|pending`',
    `city` STRING COMMENT 'City component of the units address.',
    `org_unit_code` STRING COMMENT 'Enterprise‑wide unique code used to reference the org unit in external systems.',
    `compliance_training_required` BOOLEAN COMMENT 'Indicates whether staff in the unit must complete HIPAA workforce training.',
    `cost_center_code` STRING COMMENT 'Financial cost‑center code associated with the unit for budgeting and reporting.',
    `country` STRING COMMENT 'Three‑letter ISO country code where the unit is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the org unit record was first created in the system.',
    `data_classification` STRING COMMENT 'Classification level for data owned by the unit (restricted, confidential, internal, public).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `org_unit_description` STRING COMMENT 'Free‑form description of the units purpose and scope.',
    `effective_end_date` DATE COMMENT 'Date when the unit was retired or merged; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the organizational unit became active.',
    `email` STRING COMMENT 'Primary email address for unit communications.',
    `external_reference_code` STRING COMMENT 'Identifier used by external systems (e.g., ERP) to reference the unit.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Organization)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_account_code` STRING COMMENT 'GL account number used to post payroll and expense allocations for the unit.',
    `headcount` STRING COMMENT 'Number of full‑time equivalent employees assigned to the unit.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_cost_center` BOOLEAN COMMENT 'True if the unit is designated as a cost center for financial reporting.',
    `is_profit_center` BOOLEAN COMMENT 'True if the unit generates revenue and is tracked as a profit center.',
    `last_audit_date` DATE COMMENT 'Date of the most recent internal audit of the unit.',
    `location` STRING COMMENT 'Primary office or facility name where the unit operates.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `org_unit_name` STRING COMMENT 'Human‑readable name of the department, division, business unit, or team.',
    `notes` STRING COMMENT 'Additional free‑form remarks about the unit.',
    `org_level` STRING COMMENT 'Depth of the unit in the hierarchy (e.g., 1 = enterprise, 2 = division).',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the unit.. Valid values are `active|inactive|closed|pending`',
    `org_unit_type` STRING COMMENT 'Classification of the unit within the corporate hierarchy.. Valid values are `department|division|business_unit|team|cost_center`',
    `payroll_allocation_method` STRING COMMENT 'Method used to allocate payroll costs to the unit.. Valid values are `direct|percentage|headcount`',
    `phone_number` STRING COMMENT 'Primary contact telephone for the unit.',
    `postal_code` STRING COMMENT 'ZIP or postal code for the units address.',
    `primary_function` STRING COMMENT 'Core functional area of the unit (e.g., Claims Processing, Member Services).',
    `rbac_scope` STRING COMMENT 'Scope of role‑based access control applied to the unit.. Valid values are `enterprise|regional|department|team`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'Name of the source system that supplied the record (e.g., Facets, Workday).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `state` STRING COMMENT 'State or province component of the units address.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the org unit record.',
    `version_number` STRING COMMENT 'Version of the record for optimistic concurrency control.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Master record for all organizational units — departments, divisions, business units, cost centers, and teams — within the health plan enterprise. Captures org unit name, org unit type (department, division, BU, team), parent org unit for hierarchy traversal, cost center code, GL cost center mapping, responsible executive, and effective dates. Supports payroll cost allocation, RBAC scoping, workforce planning, and financial reporting by cost center. Enables full organizational hierarchy traversal from enterprise level to team level.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` (
    `employment_record_id` BIGINT COMMENT 'System-generated unique identifier for the employment record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom this record pertains.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational unit the employee belonged to before the action.',
    `position_id` BIGINT COMMENT 'Identifier of the employees position before the action.',
    `tertiary_employment_hr_business_partner_employee_id` BIGINT COMMENT 'Identifier of the HR business partner assigned to manage the employees case.',
    `action_effective_date` DATE COMMENT 'Date on which the employment action becomes effective.',
    `action_number` STRING COMMENT 'Business identifier assigned to the employment action by the HR system.',
    `action_subtype` STRING COMMENT 'More specific classification within the action type (e.g., voluntary termination, involuntary termination, written warning).',
    `action_type` STRING COMMENT 'High-level category of the employment action (e.g., hire, promotion, disciplinary). [ENUM-REF-CANDIDATE: hire|rehire|transfer|promotion|demotion|leave_of_absence|termination|disciplinary — promote to reference product]',
    `appeal_status` STRING COMMENT 'Current status of any appeal filed by the employee against the action.. Valid values are `pending|approved|denied`',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `employee_acknowledgment_status` STRING COMMENT 'Indicates whether the employee has acknowledged receipt of the action notice.. Valid values are `acknowledged|not_acknowledged`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `incident_description` STRING COMMENT 'Narrative description of the incident that triggered a disciplinary action.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `lifecycle_status` STRING COMMENT 'Current workflow state of the employment action record.. Valid values are `draft|submitted|approved|closed|rejected`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `new_pay_grade` STRING COMMENT 'Pay grade or salary band of the employee after the action.',
    `policy_violated` STRING COMMENT 'Reference to the specific HR policy or code of conduct that was breached.',
    `prior_pay_grade` STRING COMMENT 'Pay grade or salary band of the employee before the action.',
    `reason_code` STRING COMMENT 'Standardized code indicating the business reason for the action (e.g., performance, restructuring, policy violation).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the employment record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employment record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Operational status of the employment record within the system.. Valid values are `active|inactive|archived`',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `suspension_duration_days` STRING COMMENT 'Number of calendar days the employee is suspended, if applicable.',
    `termination_date` DATE COMMENT 'Date on which the employees termination becomes effective, if the action is a termination.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_employment_record PRIMARY KEY(`employment_record_id`)
) COMMENT 'Transactional record capturing the full employment lifecycle and all formal disciplinary actions for each employee. Each record represents a distinct employment action — hire, rehire, transfer, promotion, demotion, leave of absence, termination, or disciplinary action (verbal/written warnings, PIPs, suspensions, terminations for cause). Captures effective date, action type, action subtype, prior and new position, prior and new org unit, prior and new pay grade, reason code, approving manager, incident description (for disciplinary actions), policy violated, employee acknowledgment status, appeal status, HR business partner assigned, and duration (for suspensions). Provides a complete audit trail of employment history required for ERISA compliance, COBRA eligibility determination, progressive discipline tracking, wrongful termination defense, EEOC charge response, and workforce analytics. Disciplinary records are maintained with restricted access due to sensitive employment law implications. Sourced from the HRIS action history.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` (
    `compensation_id` BIGINT COMMENT 'System-generated unique identifier for the compensation record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the compensation change.',
    `compensation_plan_id` BIGINT COMMENT 'Identifier of the broader compensation plan to which this record belongs.',
    `payroll_run_id` BIGINT COMMENT 'add column payroll_run_id (BIGINT) with FK to workforce.payroll_run.payroll_run_id - compensation entries reference payroll runs',
    `primary_compensation_employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom this compensation applies.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the compensation change was approved.',
    `base_amount` DECIMAL(18,2) COMMENT 'Annual base salary amount for salaried employees.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Monetary amount of any bonus component.',
    `bonus_frequency` STRING COMMENT 'How often the bonus is paid.. Valid values are `annual|quarterly|monthly|one-time`',
    `bonus_type` STRING COMMENT 'Classification of the bonus.. Valid values are `performance|sign-on|retention|spot`',
    `change_reason` STRING COMMENT 'Reason for the compensation change (e.g., promotion, market adjustment).',
    `compensation_code` STRING COMMENT 'Business identifier or code assigned to the compensation package.',
    `compensation_status` STRING COMMENT 'Current lifecycle status of the compensation record.. Valid values are `active|pending|terminated|planned`',
    `compensation_type` STRING COMMENT 'Category of compensation component.. Valid values are `base|hourly|bonus|equity|allowance|overtime`',
    `cost_center_code` STRING COMMENT 'Financial cost center associated with the employees compensation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compensation record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|GBP|CAD|AUD|JPY`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date when the compensation becomes effective.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `end_date` DATE COMMENT 'Date when the compensation record expires or is superseded.',
    `equity_amount` DECIMAL(18,2) COMMENT 'Monetary value of equity compensation.',
    `equity_type` STRING COMMENT 'Form of equity granted.. Valid values are `stock|stock_option|restricted_stock|phantom`',
    `equity_vesting_schedule` STRING COMMENT 'Description of the vesting timeline for equity awards.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Hourly compensation rate for non‑salaried employees.',
    `incentive_target_pct` DECIMAL(18,2) COMMENT 'Target percentage of base salary for variable incentive plans.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_exempt` BOOLEAN COMMENT 'Indicates whether the employee is exempt from overtime regulations.',
    `is_flexible` BOOLEAN COMMENT 'True if the employee participates in a flexible compensation program.',
    `location_code` STRING COMMENT 'Geographic location or worksite code for the employee.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `compensation_name` STRING COMMENT 'Human‑readable name of the compensation package (e.g., "2024 Merit Increase").',
    `notes` STRING COMMENT 'Free‑form text for additional comments or justification.',
    `overtime_eligibility` BOOLEAN COMMENT 'Indicates whether the employee is eligible for overtime pay.',
    `pay_frequency` STRING COMMENT 'How often the employee is paid.. Valid values are `weekly|biweekly|semimonthly|monthly|quarterly|annually`',
    `pay_grade` STRING COMMENT 'Internal grade or band used for compensation planning.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `salary_range_max` DECIMAL(18,2) COMMENT 'Maximum salary for the employees grade or market band.',
    `salary_range_mid` DECIMAL(18,2) COMMENT 'Midpoint of the salary range for the employees grade.',
    `salary_range_min` DECIMAL(18,2) COMMENT 'Minimum salary for the employees grade or market band.',
    `shift_differential` DECIMAL(18,2) COMMENT 'Additional percentage added for non‑standard shift work.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compensation record.',
    CONSTRAINT pk_compensation PRIMARY KEY(`compensation_id`)
) COMMENT 'Master record for each employees current and historical compensation package. Captures base salary or hourly rate, pay frequency, pay grade, salary range minimum/midpoint/maximum, incentive target percentage, shift differential, overtime eligibility, effective date, and compensation change reason. Supports payroll processing, compensation equity analysis, merit cycle administration, and regulatory pay equity reporting. Maintains point-in-time compensation history to support retroactive payroll adjustments and audit requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique identifier for the payroll run record.',
    `cost_center_id` BIGINT COMMENT 'Cost‑center to which payroll expenses are allocated.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who executed or approved the payroll run.',
    `group_id` BIGINT COMMENT 'Identifier of the health‑insurance entity that is the employer of the workforce.',
    `comments` STRING COMMENT 'Free‑form text for additional information or audit notes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll run record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_posting_reference` STRING COMMENT 'Reference identifier used when posting the payroll run to the general ledger.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_manual_run` BOOLEAN COMMENT 'Indicates whether the payroll run was executed manually (true) or automatically (false).',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `pay_date` DATE COMMENT 'Date on which employees are paid for this run.',
    `payroll_batch_number` BIGINT COMMENT 'Identifier of the batch grouping multiple payroll runs for bulk processing.',
    `payroll_cycle_code` STRING COMMENT 'Code representing the recurring payroll cycle (e.g., bi‑weekly, monthly).',
    `payroll_run_status` STRING COMMENT 'Current lifecycle status of the payroll run.. Valid values are `pending|processed|approved|posted|rejected`',
    `payroll_type` STRING COMMENT 'Classification of the payroll run (e.g., regular, off‑cycle, bonus).. Valid values are `regular|off_cycle|bonus|retroactive|adjustment`',
    `period_end_date` DATE COMMENT 'Last calendar date of the payroll period covered by this run.',
    `period_start_date` DATE COMMENT 'First calendar date of the payroll period covered by this run.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `run_execution_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the payroll processing engine executed the run.',
    `run_number` STRING COMMENT 'Business identifier assigned to the payroll run by the payroll system.',
    `total_employee_deductions` DECIMAL(18,2) COMMENT 'Aggregate employee‑withheld amounts (e.g., benefits, retirement, taxes).',
    `total_employer_tax` DECIMAL(18,2) COMMENT 'Aggregate employer‑paid tax amounts (e.g., FICA, FUTA) for the run.',
    `total_gross_amount` DECIMAL(18,2) COMMENT 'Sum of all gross earnings before deductions for the run.',
    `total_net_amount` DECIMAL(18,2) COMMENT 'Sum of net earnings after all deductions and taxes for the run.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll run record.',
    `version_number` STRING COMMENT 'Incremental version number for audit and change tracking.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Transactional record for each payroll processing cycle executed for the health plan workforce. Captures payroll period start and end dates, pay date, payroll type (regular, off-cycle, bonus), total gross pay, total net pay, total employer tax liability, total employee deductions, payroll status (pending, processed, approved, posted), and GL posting reference. Each payroll run is the authoritative record for a pay cycle and links to individual payroll disbursements. Sourced from the payroll processing system.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` (
    `payroll_disbursement_id` BIGINT COMMENT 'Unique identifier for the payroll disbursement line record.',
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee receiving the payment.',
    `payroll_run_id` BIGINT COMMENT 'Identifier of the payroll run (header) to which this disbursement belongs.',
    `time_and_attendance_id` BIGINT COMMENT 'Foreign key linking to workforce.time_and_attendance. Business justification: A payroll disbursement is calculated from a specific time_and_attendance record for an employees pay period. This FK creates traceability from the payment back to the timesheet that drove it. Hours o',
    `allocated_benefit_cost_amount` DECIMAL(18,2) COMMENT 'Allocated amount for employee benefit contributions (e.g., medical, dental).',
    `allocated_employer_tax_amount` DECIMAL(18,2) COMMENT 'Employer‑paid tax portion allocated to the cost center.',
    `allocated_gross_amount` DECIMAL(18,2) COMMENT 'Portion of gross pay amount allocated to the cost center.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of the payroll cost allocated to the specified cost center/LOB.',
    `bank_account_number` STRING COMMENT 'Employees bank account number for direct deposit.. Valid values are `^d{4,17}$`',
    `bank_routing_number` STRING COMMENT '9‑digit routing number of the employees bank for direct deposit.. Valid values are `^d{9}$`',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Timestamp of the first clock‑in event for the employee in the period.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Timestamp of the last clock‑out event for the employee in the period.',
    `cost_center_code` STRING COMMENT 'Code identifying the cost center to which payroll cost is allocated.. Valid values are `^[A-Z0-9]{4,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll disbursement record was created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `employee_role` STRING COMMENT 'Functional role of the employee within the organization.. Valid values are `clinical|administrative|support|executive`',
    `federal_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of federal income tax withheld from gross pay.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fica_tax_withheld` DECIMAL(18,2) COMMENT 'Social Security (FICA) tax amount deducted.',
    `gl_account_number` STRING COMMENT 'GL account number used for posting payroll expense.. Valid values are `^[0-9]{4,10}$`',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total earnings before any deductions or taxes.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `line_number` STRING COMMENT 'Sequential number of the line within the payroll run.',
    `lob_code` STRING COMMENT 'Business line to which the payroll cost is attributed.. Valid values are `medical|dental|vision|wellness|pharmacy|behavioral`',
    `manager_approval_date` DATE COMMENT 'Date when the manager approved the timesheet.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `medicare_tax_withheld` DECIMAL(18,2) COMMENT 'Medicare tax amount deducted.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Final amount paid to the employee after all deductions.',
    `other_deductions_total` DECIMAL(18,2) COMMENT 'Sum of voluntary and involuntary deductions (e.g., 401k, health premiums).',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours (typically >40 per week) recorded for the employee.',
    `pay_date` DATE COMMENT 'Calendar date on which the net pay was disbursed.',
    `pay_period_end_date` DATE COMMENT 'Last calendar date of the pay period covered by this disbursement.',
    `pay_period_start_date` DATE COMMENT 'First calendar date of the pay period covered by this disbursement.',
    `pay_stub_number` STRING COMMENT 'Unique reference printed on the employees pay stub.. Valid values are `^[A-Z0-9]{8,12}$`',
    `payment_method` STRING COMMENT 'Method used to deliver net pay to the employee.. Valid values are `direct_deposit|check|paycard`',
    `payroll_disbursement_type` STRING COMMENT 'Classification of the disbursement (e.g., regular salary, bonus).. Valid values are `regular|bonus|commission|adjustment`',
    `payroll_status` STRING COMMENT 'Current processing status of the payroll disbursement.. Valid values are `processed|pending|error|reversed`',
    `pto_hours` DECIMAL(18,2) COMMENT 'Paid time‑off hours used during the pay period.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular (non‑overtime) hours recorded for the employee in the pay period.',
    `shift_differential_hours` DECIMAL(18,2) COMMENT 'Hours worked that qualify for shift‑differential pay (e.g., night shift).',
    `sick_hours` DECIMAL(18,2) COMMENT 'Sick‑leave hours taken in the pay period.',
    `state_tax_withheld` DECIMAL(18,2) COMMENT 'Amount of state income tax withheld from gross pay.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the employee is exempt from certain taxes.',
    `timesheet_approval_date` DATE COMMENT 'Date when the timesheet was approved by the employee.',
    `timesheet_status` STRING COMMENT 'Current processing status of the employees timesheet.. Valid values are `submitted|approved|rejected|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_payroll_disbursement PRIMARY KEY(`payroll_disbursement_id`)
) COMMENT 'Individual employee-level payroll detail record within a payroll run, serving as the single reconciliation surface from time entry through pay calculation to cost distribution. Captures time/attendance inputs (regular and overtime hours worked, PTO/sick time used, shift differentials, absence codes, clock-in/clock-out timestamps, timesheet approval status, manager approval date), pay calculation (employee gross pay, federal and state tax withholdings, FICA, voluntary deductions for medical/dental/vision/401k/FSA/HSA, net pay, payment method, bank routing and account reference, pay stub reference number), and cost allocation distribution (cost center, GL account, LOB allocation with allocation percentages and allocated amounts for gross pay, employer tax, and benefit cost). Provides the line-level detail supporting payroll reconciliation, W-2 preparation, employee pay stub generation, FLSA overtime compliance, PMPM cost analysis, departmental budget variance reporting, and financial cost center attribution. Links to payroll_run for cycle-level aggregation.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` (
    `payroll_cost_allocation_id` BIGINT COMMENT 'Unique surrogate identifier for each payroll cost allocation line.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department that owns the cost center.',
    `payroll_disbursement_id` BIGINT COMMENT 'Foreign key linking to workforce.payroll_disbursement. Business justification: Payroll cost allocations split a specific employees pay across cost centers. While payroll_run_id + primary_payroll_employee_id implicitly identify the disbursement, a direct FK to payroll_disburseme',
    `payroll_run_id` BIGINT COMMENT 'Identifier of the payroll run to which this allocation belongs.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee whose payroll cost is being allocated.',
    `tertiary_payroll_updated_by_user_employee_id` BIGINT COMMENT 'System user responsible for the most recent change.',
    `allocated_benefit_cost` DECIMAL(18,2) COMMENT 'Cost of employee benefits allocated to the cost center.',
    `allocated_employer_tax_amount` DECIMAL(18,2) COMMENT 'Employer-paid tax (e.g., Social Security, Medicare) allocated to the cost center.',
    `allocated_gross_pay_amount` DECIMAL(18,2) COMMENT 'Portion of the employees gross wages allocated to the cost center.',
    `allocation_amount_total` DECIMAL(18,2) COMMENT 'Sum of gross pay, employer tax, and benefit cost allocated to the cost center.',
    `allocation_date` DATE COMMENT 'Calendar date on which the allocation entry was created.',
    `allocation_percentage` DECIMAL(18,2) COMMENT 'Proportion of the employees total payroll cost assigned to this cost center (expressed as a percent).',
    `allocation_reason` STRING COMMENT 'Business reason driving the allocation (e.g., regular payroll, bonus, correction).. Valid values are `regular|adjustment|correction|bonus|overtime`',
    `allocation_sequence` STRING COMMENT 'Line order of the allocation within the payroll run for deterministic processing.',
    `allocation_status` STRING COMMENT 'Lifecycle state of the allocation record.. Valid values are `pending|allocated|reversed|error`',
    `cost_center_code` STRING COMMENT 'Code representing the cost center to which the payroll cost is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the allocation line was inserted into the system.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary amounts (e.g., USD, EUR).. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Date when the allocation ceases to be effective; null indicates open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the allocation becomes effective for reporting purposes.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Location)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `gl_account_code` STRING COMMENT 'Chart of accounts code that receives the allocated payroll expense.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_manual_adjustment` BOOLEAN COMMENT 'True if the allocation was a manual correction rather than an automated calculation.',
    `lob_code` STRING COMMENT 'Identifier of the business line (e.g., Medical, Dental, Vision) for cost attribution.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Optional textual remarks providing context for the allocation.',
    `payroll_period` STRING COMMENT 'Year‑month string representing the payroll period for this allocation.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the last modification to the allocation line.',
    CONSTRAINT pk_payroll_cost_allocation PRIMARY KEY(`payroll_cost_allocation_id`)
) COMMENT 'Transactional record distributing payroll costs across cost centers, GL accounts, and lines of business (LOB) for each payroll run. Captures employee, payroll run, cost center, GL account code, LOB allocation, department, allocated gross pay amount, allocated employer tax amount, allocated benefit cost, and allocation percentage. Critical for financial reporting, PMPM cost analysis, and departmental budget variance reporting. Enables the finance domain to accurately attribute workforce costs to operational cost centers.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` (
    `employee_benefit_enrollment_id` BIGINT COMMENT 'System‑generated unique identifier for each employee benefit enrollment record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who is enrolling in the benefit.',
    `health_plan_id` BIGINT COMMENT 'Identifier of the benefit plan being elected.',
    `subscriber_id` BIGINT COMMENT 'add column member_subscriber_id (BIGINT) with FK to member.subscriber.subscriber_id - employee benefit enrollments create member subscribers',
    `benefit_year` STRING COMMENT 'Calendar year to which the enrollment belongs.',
    `cobra_end_date` DATE COMMENT 'Date when COBRA coverage would terminate, if applicable.',
    `cobra_start_date` DATE COMMENT 'Date when COBRA coverage would begin, if applicable.',
    `contribution_frequency` STRING COMMENT 'How often contributions are deducted from payroll.. Valid values are `monthly|quarterly|annually`',
    `coverage_tier` STRING COMMENT 'Level of coverage selected for the employee.. Valid values are `Employee Only|Employee+Spouse|Family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for contribution amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date on which the elected coverage becomes active.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount the employee contributes toward the benefit.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount the employer contributes toward the benefit.',
    `enrollment_number` STRING COMMENT 'External enrollment reference number used in communications and reporting.',
    `enrollment_source` STRING COMMENT 'Origin of the enrollment action.. Valid values are `open_enrollment|new_hire|qualifying_life_event|admin_change`',
    `enrollment_status` STRING COMMENT 'Current lifecycle state of the enrollment.. Valid values are `active|pending|terminated|cancelled`',
    `enrollment_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the enrollment transaction was recorded.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: EnrollmentRequest)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_aca_compliant` BOOLEAN COMMENT 'Indicates whether the enrollment satisfies ACA employer‑mandate reporting requirements.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_cobra_eligible` BOOLEAN COMMENT 'Indicates whether the enrollment is eligible for COBRA continuation coverage.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the enrollment record.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form text for any additional information or comments about the enrollment.',
    `payroll_deduction_code` STRING COMMENT 'Internal code used by payroll to apply the contribution.',
    `plan_type` STRING COMMENT 'Category of the benefit (e.g., Medical, Dental, Vision, Life, Disability, Retirement, FSA, HSA, HRA, EAP).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `termination_date` DATE COMMENT 'Date on which the coverage ends, if applicable.',
    `total_contribution_amount` DECIMAL(18,2) COMMENT 'Sum of employee and employer contributions.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    CONSTRAINT pk_employee_benefit_enrollment PRIMARY KEY(`employee_benefit_enrollment_id`)
) COMMENT 'Transactional record capturing each employees enrollment in employer-sponsored benefit plans — medical, dental, vision, life insurance, disability (STD/LTD), 401k, FSA, HSA, HRA, and EAP. Captures plan type, coverage tier (employee only, employee + spouse, family), effective date, termination date, employee contribution amount, employer contribution amount, and enrollment source (open enrollment, new hire, qualifying life event). Distinct from member enrollment (which governs insured members) — this tracks the employee as a benefits consumer. Supports COBRA administration and ACA employer mandate reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'System-generated unique identifier for the leave request record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee submitting the leave request.',
    `accommodation_details` STRING COMMENT 'Free‑text description of any ADA or other accommodations requested.',
    `ada_accommodation_required` BOOLEAN COMMENT 'True if the leave request includes a disability accommodation under the ADA.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the request was approved or denied.',
    `approved_days` DECIMAL(18,2) COMMENT 'Total number of leave days approved.',
    `approved_end_date` DATE COMMENT 'Last day of leave as approved.',
    `approved_start_date` DATE COMMENT 'First day of leave as approved by HR/manager.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the leave cost (if any) is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the leave request record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `denial_reason` STRING COMMENT 'Reason provided when a leave request is denied.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `end_date` DATE COMMENT 'Last calendar day the employee wishes to be on leave.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `fmla_eligible` BOOLEAN COMMENT 'Indicates whether the employee meets eligibility criteria for FMLA leave.',
    `intermittent` BOOLEAN COMMENT 'True if the leave is to be taken on an intermittent schedule.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `leave_balance_after` DECIMAL(18,2) COMMENT 'Projected leave balance after the approved leave is deducted.',
    `leave_balance_before` DECIMAL(18,2) COMMENT 'Accrued leave balance (in days) available to the employee before this request.',
    `leave_policy_code` STRING COMMENT 'Code referencing the specific leave policy governing this request.',
    `leave_status` STRING COMMENT 'Current lifecycle status of the leave request.. Valid values are `requested|approved|denied|in_progress|closed`',
    `leave_type` STRING COMMENT 'Category of leave being requested (e.g., FMLA, personal, military, parental, bereavement, disability).. Valid values are `fmla|personal|military|parental|bereavement|disability`',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional comments or remarks entered by the employee or reviewer.',
    `payroll_amount` DECIMAL(18,2) COMMENT 'Monetary amount (in USD) that will be deducted or added to payroll due to the leave.',
    `payroll_impact` BOOLEAN COMMENT 'True if the approved leave affects payroll calculations (e.g., paid vs unpaid).',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `request_number` STRING COMMENT 'Human‑readable reference number assigned to the leave request.',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the leave request was initially submitted.',
    `requested_days` DECIMAL(18,2) COMMENT 'Total number of leave days requested (including fractions).',
    `return_to_work_date` DATE COMMENT 'Date the employee is scheduled to resume regular duties after leave.',
    `start_date` DATE COMMENT 'First calendar day the employee wishes to be on leave.',
    `updated_by` STRING COMMENT 'User ID or system name that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the leave request record.',
    `created_by` STRING COMMENT 'User ID or system name that created the leave request record.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Transactional record for all employee leave requests and approved leave events — FMLA, ADA accommodations, personal leave, military leave (USERRA), parental leave, bereavement, and short-term disability. Captures leave type, requested start and end dates, approved start and end dates, intermittent leave indicator, FMLA eligibility determination, ADA accommodation details, leave status (requested, approved, denied, in-progress, closed), and return-to-work date. Supports FMLA compliance tracking, STD/LTD coordination, and workforce availability planning.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'System-generated unique identifier for each performance review record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee being reviewed.',
    `average_goal_rating` DECIMAL(18,2) COMMENT 'Average of all goal ratings for the review cycle.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary review event (e.g., review start).',
    `calibration_status` STRING COMMENT 'Indicates whether the review has been calibrated across the organization.. Valid values are `calibrated|pending|not_calibrated`',
    `compensation_grade` STRING COMMENT 'HR compensation grade applicable to the employee.',
    `competency_communication_rating` STRING COMMENT 'Score (1‑5) for the employees communication competency.',
    `competency_leadership_rating` STRING COMMENT 'Score (1‑5) for the employees leadership competency.',
    `competency_teamwork_rating` STRING COMMENT 'Score (1‑5) for the employees teamwork competency.',
    `confidentiality_level` STRING COMMENT 'Classification of the review data for security handling.. Valid values are `restricted|confidential|internal|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary fields.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `department` STRING COMMENT 'Organizational department to which the employee belongs.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `employee_self_assessment_ref` STRING COMMENT 'Identifier of the employees self‑assessment document.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `goal_1_rating` STRING COMMENT 'Rating (1‑5) for the first performance goal.',
    `goal_2_rating` STRING COMMENT 'Rating (1‑5) for the second performance goal.',
    `goal_3_rating` STRING COMMENT 'Rating (1‑5) for the third performance goal.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_finalized` BOOLEAN COMMENT 'Indicates whether the review has been formally finalized.',
    `job_role` STRING COMMENT 'Title or role of the employee at the time of review.',
    `location_code` STRING COMMENT 'Code representing the employees primary work location.',
    `manager_name` STRING COMMENT 'Legal full name of the manager (restricted PII).',
    `manager_narrative` STRING COMMENT 'Free‑text comments from the manager about performance.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `merit_increase_percentage` DECIMAL(18,2) COMMENT 'Proposed merit increase expressed as a percent of base salary.',
    `merit_increase_recommendation_amount` DECIMAL(18,2) COMMENT 'Proposed monetary merit increase based on the review.',
    `notes` STRING COMMENT 'Free‑form field for any extra comments or observations.',
    `overall_rating` STRING COMMENT 'Aggregated rating of employee performance for the cycle.. Valid values are `exceeds|meets|needs_improvement|unsatisfactory|outstanding`',
    `performance_improvement_plan_due_date` DATE COMMENT 'Target date for completion of the Performance Improvement Plan.',
    `performance_improvement_plan_flag` BOOLEAN COMMENT 'True if the employee is placed on a Performance Improvement Plan.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the review record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the review record.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `review_completion_date` DATE COMMENT 'Date the review was finalized.',
    `review_cycle_number` STRING COMMENT 'Sequential number of the review cycle for the employee (e.g., 1 for first annual).',
    `review_due_date` DATE COMMENT 'Date by which the review must be completed.',
    `review_number` STRING COMMENT 'Human‑readable identifier assigned to the review cycle (e.g., PR‑2024‑001).',
    `review_period_end` DATE COMMENT 'Last day of the performance review period.',
    `review_period_start` DATE COMMENT 'First day of the performance review period.',
    `review_status` STRING COMMENT 'Current lifecycle state of the performance review.. Valid values are `pending|in_progress|completed|closed|cancelled`',
    `review_type` STRING COMMENT 'Classification of the review cycle (e.g., annual, mid‑year, probationary).. Valid values are `annual|mid-year|probationary|performance_improvement_plan|exit|other`',
    `salary_adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment to base salary resulting from the review.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Transactional record for each formal employee performance evaluation cycle. Captures review period, review type (annual, mid-year, probationary, PIP), overall performance rating, individual goal ratings, competency ratings, manager narrative, employee self-assessment reference, calibration status, merit increase recommendation, and review completion date. Supports merit cycle administration, succession planning, and performance improvement plan (PIP) tracking. Links to compensation for merit-based pay adjustments.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` (
    `training_record_id` BIGINT COMMENT 'System-generated unique identifier for the training record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who completed the training.',
    `training_course_id` BIGINT COMMENT 'Unique identifier of the training course.',
    `assessment_result_description` STRING COMMENT 'Free-text description of the assessment outcome or comments.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved on the training assessment (0-100).',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the employee completed the training.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delivery_method` STRING COMMENT 'Method used to deliver the training.. Valid values are `eLearning|Instructor-led|Webinar`',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date when the training certification expires and must be renewed.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_expired` BOOLEAN COMMENT 'Flag indicating whether the training certification has expired.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional remarks or comments about the training record.',
    `pass_fail_status` STRING COMMENT 'Indicates whether the employee passed the training assessment.. Valid values are `Pass|Fail`',
    `recertification_required` BOOLEAN COMMENT 'Indicates if the employee must recertify the training after expiration.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the training record was first created in the data warehouse.',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the training record.',
    `record_version` STRING COMMENT 'Version number for optimistic concurrency control.',
    `trainer_name` STRING COMMENT 'Legal name of the trainer or instructor.',
    `training_hours` DECIMAL(18,2) COMMENT 'Total hours of instruction completed for the training.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training was delivered.',
    `training_record_number` STRING COMMENT 'Business identifier assigned to the training record for external reference.',
    `training_record_status` STRING COMMENT 'Current lifecycle status of the training record.. Valid values are `Completed|In_Progress|Expired|Failed|Pending`',
    `training_type` STRING COMMENT 'Category of training required for compliance or development. [ENUM-REF-CANDIDATE: HIPAA Privacy|HIPAA Security|Fraud Waste and Abuse|Compliance|Clinical|Leadership|Technical — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'Transactional record tracking completion of mandatory and elective training courses for each employee. Captures course name, course code, training type (HIPAA Privacy, HIPAA Security, Fraud Waste and Abuse, Compliance, Clinical, Leadership, Technical), delivery method (eLearning, instructor-led, webinar), completion date, expiration date, pass/fail status, assessment score, and training hours. HIPAA workforce training compliance requires annual completion tracking for all employees with PHI access. Supports NCQA accreditation, CMS audit readiness, and state DOI compliance.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` (
    `rbac_assignment_id` BIGINT COMMENT 'System-generated unique identifier for the RBAC assignment record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom access is granted.',
    `assignee_employee_id` BIGINT COMMENT 'Identifier of the user who created the assignment record.',
    `policy_document_id` BIGINT COMMENT 'add column phi_disclosure_log_id (BIGINT) - actually add system_resource (no FK) attribute set for HIPAA workforce access; add policy_document_id (BIGINT) with FK to compliance.policy_document.policy_document_id',
    `rbac_last_updated_by_employee_id` BIGINT COMMENT 'Identifier of the user who performed the latest update.',
    `rbac_policy_document_id` BIGINT COMMENT 'FK to compliance policy document governing this access assignment',
    `rbac_role_id` BIGINT COMMENT 'Unique identifier of the security role assigned to the employee.',
    `access_level` STRING COMMENT 'Level of access granted (e.g., read‑only, write, administrative).. Valid values are `read|write|admin`',
    `access_reason_code` STRING COMMENT 'Standardized code representing the business reason for the access (e.g., CLAIM_PROCESSING, MEMBER_SERVICE).',
    `access_scope` STRING COMMENT 'Textual description of the data or functional scope covered by the assignment.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the access request was approved.',
    `business_justification` STRING COMMENT 'Narrative explanation of why the employee requires this access, supporting HIPAA minimum‑necessary compliance.',
    `comments` STRING COMMENT 'Free‑form notes related to the assignment, such as audit observations.',
    `compliance_framework` STRING COMMENT 'Regulatory framework governing the access (e.g., HIPAA, SOC 2).. Valid values are `hipaa|soc2|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RBAC assignment record was created.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_date` DATE COMMENT 'Date when the access becomes active.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date when the access is scheduled to expire (null if indefinite).',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_temporary` BOOLEAN COMMENT 'True if the access is granted for a limited, temporary period.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `rbac_assignment_status` STRING COMMENT 'Current lifecycle status of the assignment.. Valid values are `active|inactive|pending|revoked|expired`',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `revocation_date` DATE COMMENT 'Date when the access was actually revoked, if earlier than expiration.',
    `risk_level` STRING COMMENT 'Risk classification of the access based on sensitivity of data.. Valid values are `low|medium|high`',
    `system_name` STRING COMMENT 'Name of the system or application for which the role provides access.',
    `system_resource` STRING COMMENT 'System resource identifier for HIPAA workforce access control',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the assignment record.',
    CONSTRAINT pk_rbac_assignment PRIMARY KEY(`rbac_assignment_id`)
) COMMENT 'Association record governing role-based access control (RBAC) assignments for employees accessing PHI/PII systems. Captures employee, assigned role, system or application name, access level, business justification, approving manager, effective date, expiration date, and access revocation date. Critical for HIPAA minimum necessary standard compliance — ensures employees only access PHI required for their job function. Supports OCR audit readiness, SOC 2 compliance, and access recertification campaigns. Owned by the workforce domain as the authoritative source for workforce access rights.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` (
    `headcount_plan_id` BIGINT COMMENT 'System-generated unique identifier for the workforce headcount plan record.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager responsible for the hire.',
    `headcount_last_updated_by_employee_id` BIGINT COMMENT 'Identifier of the system user who last modified the plan.',
    `headcount_requisition_requestor_employee_id` BIGINT COMMENT 'Identifier of the system user who created the plan.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Headcount plans are created per organizational unit. The plan has org_unit_code (STRING) but no proper FK to org_unit. Adding org_unit_id enables joining to get full org unit details (budget, location',
    `actual_headcount` STRING COMMENT 'Headcount actually employed at the end of the period.',
    `application_deadline` DATE COMMENT 'Last date candidates may submit applications.',
    `approved_fte` DECIMAL(18,2) COMMENT 'Number of full‑time equivalent positions approved in the plan.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'Difference between budgeted and actual headcount cost (currency).',
    `budget_variance_percent` DECIMAL(18,2) COMMENT 'Percentage variance between budgeted and actual headcount cost.',
    `budgeted_headcount` STRING COMMENT 'Total headcount budgeted for the planning period.',
    `candidate_start_date` DATE COMMENT 'First day of employment for the hired candidate.',
    `compliance_review_status` STRING COMMENT 'Status of internal compliance review for the headcount plan.. Valid values are `pending|completed|exempt`',
    `contract_headcount` STRING COMMENT 'Number of contingent or contract workers included in the plan.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which headcount costs are allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `department_code` STRING COMMENT 'Code identifying the department within the org unit that the plan targets.',
    `diversity_hiring_indicator` BOOLEAN COMMENT 'Flag indicating whether the hire satisfies diversity hiring goals.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date the headcount plan becomes effective.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date the headcount plan expires or is superseded; null if open‑ended.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `filled_fte` DECIMAL(18,2) COMMENT 'Number of FTEs that have been filled to date.',
    `fiscal_year` STRING COMMENT 'Calendar year to which the plan applies, expressed as a four‑digit year.',
    `headcount_variance` STRING COMMENT 'Numeric difference between approved FTE and actual filled FTE.',
    `interview_stages_completed` STRING COMMENT 'Number of interview rounds completed for the requisition.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_contractor` BOOLEAN COMMENT 'True if the position is filled by a contractor or contingent worker.',
    `job_posting_date` DATE COMMENT 'Date the position was posted to the job market.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the plan.',
    `number_of_applicants` STRING COMMENT 'Total count of candidates who applied for the position.',
    `offer_accepted_date` DATE COMMENT 'Date the candidate accepted the job offer.',
    `offer_extended_date` DATE COMMENT 'Date an offer was extended to the selected candidate.',
    `plan_created_timestamp` TIMESTAMP COMMENT 'Date‑time when the headcount plan record was initially created.',
    `plan_identifier` STRING COMMENT 'Business-visible identifier or code for the headcount plan.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the headcount plan.. Valid values are `draft|submitted|approved|rejected|closed`',
    `plan_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the plan record.',
    `planning_period` STRING COMMENT 'Frequency of the planning horizon for the headcount plan.. Valid values are `annual|quarterly|monthly`',
    `position_title` STRING COMMENT 'Job title of the position being recruited.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `recruitment_cycle_code` STRING COMMENT 'Code representing the recruitment cycle (e.g., Q1_2024).',
    `requisition_number` STRING COMMENT 'Unique identifier for the recruitment requisition linked to the plan.',
    `requisition_status` STRING COMMENT 'Current status of the recruitment requisition.. Valid values are `open|closed|cancelled|on_hold`',
    `source_of_hire` STRING COMMENT 'Channel through which the candidate was sourced.. Valid values are `internal|referral|job_board|recruiter|agency|social_media`',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days from posting to start date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `vacant_fte` DECIMAL(18,2) COMMENT 'Number of FTE positions still vacant.',
    CONSTRAINT pk_headcount_plan PRIMARY KEY(`headcount_plan_id`)
) COMMENT 'Master record for approved workforce headcount plans and the full recruitment lifecycle by org unit, department, and fiscal year. Captures workforce planning attributes (planning period, org unit, approved FTE count, filled FTE count, vacant FTE count, budgeted headcount, actual headcount, contract/contingent headcount, plan status) and recruitment execution attributes (requisition number, position being filled, hiring manager, recruiter assigned, job posting date, application deadline, number of applicants, interview stages completed, offer extended date, offer accepted date, candidate start date, time-to-fill metric, source of hire, requisition status, and diversity hiring indicators). Supports annual workforce planning cycles, budget variance analysis, executive headcount reporting, recruiter productivity tracking, diversity hiring reporting, and planned-vs-actual staffing comparison across cost centers and lines of business.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` (
    `disciplinary_action_id` BIGINT COMMENT 'Unique identifier for the disciplinary action record.',
    `compliance_event_id` BIGINT COMMENT 'add column compliance_event_id (BIGINT) with FK to workforce.compliance_event.compliance_event_id - disciplinary actions follow compliance events',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee subject to the disciplinary action.',
    `tertiary_disciplinary_manager_employee_id` BIGINT COMMENT 'Identifier of the employees direct manager.',
    `tertiary_quinary_disciplinary_updated_by_user_employee_id` BIGINT COMMENT 'System user identifier who performed the latest update.',
    `acknowledgment_status` STRING COMMENT 'Whether the employee has acknowledged the disciplinary action.. Valid values are `acknowledged|not_acknowledged|pending`',
    `acknowledgment_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee acknowledged the action.',
    `action_date` DATE COMMENT 'Date the disciplinary action was formally taken.',
    `action_number` STRING COMMENT 'External reference number assigned to the disciplinary action.',
    `action_type` STRING COMMENT 'Category of disciplinary action taken.. Valid values are `verbal_warning|written_warning|performance_improvement_plan|suspension|termination`',
    `appeal_deadline` DATE COMMENT 'Last date the employee may file an appeal.',
    `appeal_outcome` STRING COMMENT 'Result of the appeal process.. Valid values are `upheld|overturned|modified|withdrawn`',
    `appeal_status` STRING COMMENT 'Current status of any appeal filed against the disciplinary action.. Valid values are `none|filed|under_review|resolved|rejected`',
    `disciplinary_action_category` STRING COMMENT 'High‑level category of the disciplinary action.. Valid values are `performance|conduct|attendance|safety|policy`',
    `confidentiality_level` STRING COMMENT 'Data classification level for the record.. Valid values are `restricted|confidential|internal|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disciplinary action record was created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for the penalty amount.. Valid values are `USD|EUR|GBP|CAD|JPY`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `disciplinary_action_status` STRING COMMENT 'Overall lifecycle status of the disciplinary action record.. Valid values are `open|closed|in_progress|cancelled`',
    `documentation_attached` BOOLEAN COMMENT 'True if supporting documentation is attached to the record.',
    `duration_days` STRING COMMENT 'Number of days the disciplinary action lasts (applicable to suspensions).',
    `effective_date` DATE COMMENT 'Date the disciplinary action becomes effective (e.g., start of suspension).',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `incident_description` STRING COMMENT 'Narrative description of the incident that triggered the disciplinary action.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_repeat_offense` BOOLEAN COMMENT 'Indicates whether this is a repeat disciplinary offense for the employee.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Additional free‑text comments or observations related to the disciplinary action.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty associated with the disciplinary action, if any.',
    `policy_violated` STRING COMMENT 'Name or code of the company policy that was breached.',
    `prior_action_count` STRING COMMENT 'Number of prior disciplinary actions recorded for the employee.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Operational status of the record for data management purposes.. Valid values are `active|inactive|archived`',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `suspension_end_date` DATE COMMENT 'Date a suspension period ends; null if not a suspension.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_disciplinary_action PRIMARY KEY(`disciplinary_action_id`)
) COMMENT 'Transactional record for formal employee disciplinary actions — verbal warnings, written warnings, performance improvement plans (PIPs), suspensions, and terminations for cause. Captures action type, incident description, policy violated, action date, effective date, duration (for suspensions), HR business partner assigned, manager of record, employee acknowledgment status, and appeal status. Supports progressive discipline tracking, wrongful termination defense, and EEOC charge response. Maintained with restricted access due to sensitive employment law implications.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` (
    `compliance_event_id` BIGINT COMMENT 'Unique surrogate key for each workforce compliance event record.',
    `background_check_id` BIGINT COMMENT 'Foreign key linking to workforce.background_check. Business justification: Compliance events that are triggered by background screening results should reference the specific background_check record. The compliance_event duplicates screening_result, adverse_action_reason, and',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee subject to the compliance event.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to vendor.vendor. Business justification: Regulatory compliance events must record the screening vendor that performed the check for audit and reporting.',
    `completion_date` DATE COMMENT 'Actual date the compliance activity was completed.',
    `compliance_event_status` STRING COMMENT 'Current workflow status of the compliance event.. Valid values are `pending|in_progress|completed|waived|closed`',
    `compliance_outcome` STRING COMMENT 'Result of the compliance activity after evaluation.. Valid values are `compliant|non_compliant|pending|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance event record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `due_date` DATE COMMENT 'Date by which the compliance activity must be completed.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `event_number` STRING COMMENT 'Business identifier assigned to the compliance event (e.g., "HC-2024-00123").',
    `event_timestamp` TIMESTAMP COMMENT 'Date‑time when the compliance event was recorded or became effective.',
    `event_type` STRING COMMENT 'High‑level category of the compliance event.. Valid values are `hipaa_training|background_screening|i9_verification|annual_attestation|conflict_of_interest|mandatory_reporting`',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form comments or additional information about the compliance event.',
    `order_date` DATE COMMENT 'Date the screening request was placed with the vendor.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `remediation_action` STRING COMMENT 'Corrective steps taken when the event is non‑compliant.',
    `responsible_party` STRING COMMENT 'Individual or role accountable for ensuring the compliance event is addressed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the compliance event record.',
    CONSTRAINT pk_compliance_event PRIMARY KEY(`compliance_event_id`)
) COMMENT 'Workforce-specific compliance event tracker for employee compliance events including background checks, training completions, and regulatory requirements. Note: compliance.compliance_event does not exist in this model; this is the sole compliance_event product, scoped to the workforce domain.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` (
    `background_check_id` BIGINT COMMENT 'System-generated unique identifier for the background check record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee subject to the background check.',
    `background_initiator_employee_id` BIGINT COMMENT 'Identifier of the system user who created the record.',
    `background_last_updated_by_employee_id` BIGINT COMMENT 'Identifier of the system user who last updated the record.',
    `employee_screening_id` BIGINT COMMENT 'add column employee_screening_id (BIGINT) with FK to compliance.employee_screening.employee_screening_id - background check feeds compliance employee screening record',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the screening vendor.',
    `adjudication_decision` STRING COMMENT 'Final HR decision based on the screening result.. Valid values are `no_action|termination|reassignment|warning`',
    `adverse_action_reason` STRING COMMENT 'Reason for any adverse action taken as a result of the screening.',
    `background_check_status` STRING COMMENT 'Current lifecycle status of the background screening process.. Valid values are `ordered|in_progress|completed|cancelled`',
    `check_number` STRING COMMENT 'External reference number assigned to the screening request.',
    `completion_timestamp` TIMESTAMP COMMENT 'Date and time when the background check was completed.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the screening with CMS and DOI requirements.. Valid values are `compliant|non_compliant|pending`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost charged for the background screening.',
    `cost_currency_code` STRING COMMENT 'Three‑letter ISO currency code for the screening cost (e.g., USD).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the background check record was first created in the system.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_federal_program_access` BOOLEAN COMMENT 'True if the employee has access to Medicare/Medicaid programs, triggering mandatory screening.',
    `is_oig_exclusion_flag` BOOLEAN COMMENT 'Result of the OIG exclusion check (true if the employee is on the exclusion list).',
    `is_oig_exclusion_required` BOOLEAN COMMENT 'Indicates whether OIG exclusion screening is mandatory for the employee.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form notes or comments related to the screening.',
    `order_timestamp` TIMESTAMP COMMENT 'Date and time when the background check was ordered.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `result` STRING COMMENT 'Outcome of the background check.. Valid values are `clear|flagged|adverse`',
    `screening_type` STRING COMMENT 'Category of background screening performed.. Valid values are `criminal|oig_exclusion|sam_debarment|credit|education|employment`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the background check record.',
    CONSTRAINT pk_background_check PRIMARY KEY(`background_check_id`)
) COMMENT 'Transactional record for pre-employment and periodic background screening events for health plan employees. Captures screening type (criminal, OIG exclusion, SAM debarment, credit, education verification, employment verification), screening vendor, order date, completion date, result (clear, flagged, adverse action), adverse action reason, and adjudication decision. OIG exclusion screening is mandatory for all employees with access to federal healthcare programs (Medicare, Medicaid) — non-compliance creates False Claims Act exposure. Supports CMS compliance and state DOI licensing requirements.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` (
    `time_and_attendance_id` BIGINT COMMENT 'Unique surrogate key for each time and attendance record.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee to whom the time record belongs.',
    `absence_code` STRING COMMENT 'Standardized code representing the type of absence for the record.. Valid values are `VAC|SICK|FMLA|ADA|UNPAID`',
    `absence_reason` STRING COMMENT 'Free‑text description providing context for the absence.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'Exact date‑time the employee clocked in for a shift.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'Exact date‑time the employee clocked out for a shift.',
    `cost_center_code` STRING COMMENT 'Code identifying the cost center to which labor costs are allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the time and attendance record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `department_code` STRING COMMENT 'Organizational department identifier for the employee.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `flsa_compliance` BOOLEAN COMMENT 'True if the recorded hours comply with Fair Labor Standards Act regulations.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total earnings before taxes and deductions for the period.',
    `holiday_hours` DECIMAL(18,2) COMMENT 'Hours recorded for paid holidays.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `job_role_code` STRING COMMENT 'Code representing the employees job role or title.',
    `location_code` STRING COMMENT 'Identifier for the physical location where the employee performed the work.',
    `manager_approval_status` STRING COMMENT 'Approval state of the timesheet as indicated by the employees manager.. Valid values are `pending|approved|rejected`',
    `manager_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the manager approved or rejected the timesheet.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Final amount paid to the employee after taxes and deductions.',
    `notes` STRING COMMENT 'Free‑form comments or remarks associated with the record.',
    `overtime_eligibility` BOOLEAN COMMENT 'Indicates whether the employee is eligible for overtime pay under FLSA.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Hours worked beyond the standard schedule that are payable at an overtime rate.',
    `pay_period_code` STRING COMMENT 'Alphanumeric code representing the specific pay period (e.g., 2023-09).',
    `payroll_integration_status` STRING COMMENT 'Indicates whether the timesheet has been successfully sent to payroll processing.. Valid values are `pending|integrated|failed`',
    `payroll_processed_timestamp` TIMESTAMP COMMENT 'Timestamp when payroll system completed processing for this timesheet.',
    `period_end_date` DATE COMMENT 'Last calendar date of the pay period covered by the record.',
    `period_start_date` DATE COMMENT 'First calendar date of the pay period covered by the record.',
    `pto_used_hours` DECIMAL(18,2) COMMENT 'Hours deducted from the employees accrued PTO balance for the period.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Hours worked at the standard rate, excluding overtime and other premiums.',
    `shift_code` STRING COMMENT 'Code representing the scheduled shift (e.g., DAY, NIGHT).',
    `shift_differential_hours` DECIMAL(18,2) COMMENT 'Hours worked during shifts that attract a differential premium (e.g., night shift).',
    `sick_hours_used` DECIMAL(18,2) COMMENT 'Hours taken as sick leave during the period.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the employee submitted the timesheet.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax withheld from the gross pay for the period.',
    `time_and_attendance_status` STRING COMMENT 'Current lifecycle status of the timesheet.. Valid values are `draft|submitted|approved|rejected|cancelled`',
    `time_entry_device_code` STRING COMMENT 'Identifier of the device that recorded the time entry.',
    `time_entry_error_code` STRING COMMENT 'Code indicating any error or exception captured during time entry.',
    `time_entry_method` STRING COMMENT 'Method used to capture the time entry.. Valid values are `clock_in|clock_out|manual`',
    `time_entry_source` STRING COMMENT 'Origin of the time entry record (e.g., badge swipe, web portal).. Valid values are `badge|web|mobile|biometric`',
    `time_entry_type` STRING COMMENT 'Classification of the time entry (regular, overtime, PTO, etc.).. Valid values are `regular|overtime|pto|holiday|sick`',
    `timesheet_number` STRING COMMENT 'Business identifier assigned to the timesheet for tracking and reference.',
    `total_hours_worked` DECIMAL(18,2) COMMENT 'Aggregate number of hours (including all categories) recorded for the period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    CONSTRAINT pk_time_and_attendance PRIMARY KEY(`time_and_attendance_id`)
) COMMENT 'Transactional record capturing employee time and attendance data for each pay period — regular hours, overtime hours, PTO used, sick time used, holiday hours, shift differentials, and absence codes. Captures clock-in/clock-out timestamps, approved timesheet status, manager approval date, and payroll integration status. Supports FLSA overtime compliance, PTO accrual balance management, and payroll processing accuracy. Feeds directly into payroll_disbursement calculations for hourly and non-exempt employees.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Primary key for compensation_plan',
    `job_role_id` BIGINT COMMENT 'add column job_role_id (BIGINT) with FK to workforce.job_role.job_role_id - comp plans align to job roles',
    `parent_compensation_plan_id` BIGINT COMMENT 'Self-referencing FK on compensation_plan (parent_compensation_plan_id)',
    `base_amount` DECIMAL(18,2) COMMENT 'Fixed base salary or compensation amount specified in the plan.',
    `benefit_plan_name` STRING COMMENT 'Human-readable name of the associated benefit plan.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Specific bonus amount allocated within the plan.',
    `commission_rate` DECIMAL(18,2) COMMENT 'Commission rate expressed as a percentage for sales or incentive compensation.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the compensation plan record was first created in the system.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `currency` STRING COMMENT 'ISO 4217 three-letter currency code used for monetary amounts in the plan.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the compensation plan becomes effective.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the compensation plan ceases to be effective. Null indicates open-ended.',
    `equity_type` STRING COMMENT 'Type of equity instrument used in the plan.',
    `equity_units` STRING COMMENT 'Number of equity units (e.g., shares, options) granted under the plan.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: InsurancePlan)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `plan_category` STRING COMMENT 'Category of the plan within the compensation structure.',
    `plan_code` STRING COMMENT 'Alphanumeric code that uniquely identifies the compensation plan within the organization.',
    `plan_description` STRING COMMENT 'Detailed description of the compensation plan, including its purpose and scope.',
    `plan_document_checksum` STRING COMMENT 'MD5 checksum of the compensation plan document for integrity verification.',
    `plan_document_created_at` TIMESTAMP COMMENT 'Timestamp when the compensation plan document was first created.',
    `plan_document_format` STRING COMMENT 'Format of the compensation plan document, e.g., PDF, DOCX.',
    `plan_document_language` STRING COMMENT 'Human-readable language of the compensation plan document.',
    `plan_document_language_code` STRING COMMENT 'ISO 639-1 two-letter code for the document language.',
    `plan_document_size` STRING COMMENT 'Size of the compensation plan document in bytes.',
    `plan_document_status` STRING COMMENT 'Current status of the compensation plan document.',
    `plan_document_type` STRING COMMENT 'File format of the compensation plan document.',
    `plan_document_updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compensation plan document.',
    `plan_document_url` STRING COMMENT 'URL pointing to the electronic document that defines the compensation plan.',
    `plan_document_version` STRING COMMENT 'Version number of the compensation plan document.',
    `plan_name` STRING COMMENT 'Human-readable name of the compensation plan.',
    `plan_notes` STRING COMMENT 'Free-text notes or comments about the compensation plan.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the compensation plan.',
    `plan_type` STRING COMMENT 'Primary type of compensation covered by the plan.',
    `plan_version` STRING COMMENT 'Version number of the compensation plan, incremented on each update.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `termination_date` DATE COMMENT 'Date when the compensation plan was terminated, if applicable.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compensation plan record.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `variable_amount` DECIMAL(18,2) COMMENT 'Variable component of compensation, such as performance bonus or incentive.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the compensation plan record.',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Master reference table for compensation_plan. Referenced by plan_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` (
    `rbac_role_id` BIGINT COMMENT 'Primary key for rbac_role',
    `parent_rbac_role_id` BIGINT COMMENT 'Self-referencing FK on rbac_role (parent_rbac_role_id)',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the role record was first created.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_from` DATE COMMENT 'Date when the role becomes active in the system.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `effective_until` DATE COMMENT 'Date when the role ceases to be active; null if open-ended.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `role_code` STRING COMMENT 'Alphanumeric code used to identify the role in business processes.',
    `role_description` STRING COMMENT 'Detailed description of the roles purpose and responsibilities.',
    `role_group` STRING COMMENT 'Logical grouping of roles for organizational or functional purposes.',
    `role_is_active` BOOLEAN COMMENT 'Flag indicating if the role is currently active.',
    `role_is_archived` BOOLEAN COMMENT 'Flag indicating if the role has been archived.',
    `role_is_current` BOOLEAN COMMENT 'Flag indicating if the role is the current version in use.',
    `role_is_default` BOOLEAN COMMENT 'Flag indicating if the role is the default for a given context.',
    `role_is_deleted` BOOLEAN COMMENT 'Flag indicating if the role has been deleted.',
    `role_is_external` BOOLEAN COMMENT 'Flag indicating if the role is intended for external users.',
    `role_is_internal` BOOLEAN COMMENT 'Flag indicating if the role is intended for internal use.',
    `role_is_legacy` BOOLEAN COMMENT 'Flag indicating if the role is legacy and may be phased out.',
    `role_is_persistent` BOOLEAN COMMENT 'Flag indicating if the role is persistent.',
    `role_is_retired` BOOLEAN COMMENT 'Flag indicating if the role has been retired.',
    `role_is_revoked` BOOLEAN COMMENT 'Flag indicating if the role has been revoked.',
    `role_is_system` BOOLEAN COMMENT 'Flag indicating if the role is system-defined.',
    `role_is_temporary` BOOLEAN COMMENT 'Flag indicating if the role is temporary.',
    `role_is_transient` BOOLEAN COMMENT 'Flag indicating if the role is transient.',
    `role_level` STRING COMMENT 'Numeric level indicating role hierarchy depth.',
    `role_name` STRING COMMENT 'Human-readable name of the role.',
    `role_revocation_by` STRING COMMENT 'Identifier of the user or system that performed the revocation.',
    `role_revocation_created_at` TIMESTAMP COMMENT 'Timestamp when the revocation record was created.',
    `role_revocation_created_by` STRING COMMENT 'Identifier of the user or system that created the revocation record.',
    `role_revocation_date` TIMESTAMP COMMENT 'Timestamp when the role was revoked.',
    `role_revocation_effective_from` DATE COMMENT 'Date when the revocation becomes effective.',
    `role_revocation_effective_until` DATE COMMENT 'Date when the revocation ends; null if open-ended.',
    `role_revocation_notes` STRING COMMENT 'Additional notes regarding the revocation.',
    `role_revocation_reason` STRING COMMENT 'Reason for revoking the role.',
    `role_revocation_status` STRING COMMENT 'Current status of the revocation process.',
    `role_revocation_updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the revocation record.',
    `role_revocation_updated_by` STRING COMMENT 'Identifier of the user or system that last updated the revocation record.',
    `role_scope` STRING COMMENT 'Scope of the role (e.g., global, department, team).',
    `role_scope_type` STRING COMMENT 'Classification of the roles scope.',
    `role_status` STRING COMMENT 'Current lifecycle status of the role.',
    `role_type` STRING COMMENT 'Classification of the role (e.g., system, business, admin, user, guest).',
    `updated_at` TIMESTAMP COMMENT 'Timestamp of the most recent update to the role record.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last updated the role.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created the role.',
    CONSTRAINT pk_rbac_role PRIMARY KEY(`rbac_role_id`)
) COMMENT 'Master reference table for rbac_role. Referenced by role_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Primary key for training_course',
    `parent_training_course_id` BIGINT COMMENT 'Self-referencing FK on training_course (parent_training_course_id)',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the training course record.',
    `training_last_updated_by_employee_id` BIGINT COMMENT 'Identifier of the user who last updated the training course record.',
    `vendor_id` BIGINT COMMENT 'Identifier of the training course provider.',
    `certification_awarded` STRING COMMENT 'Indicates if a certification is awarded upon completion.',
    `certification_validity_end` DATE COMMENT 'End date of certification validity period.',
    `certification_validity_start` DATE COMMENT 'Start date of certification validity period.',
    `training_course_code` STRING COMMENT 'External reference code for the training course.',
    `compliance_due_date` DATE COMMENT 'Due date for compliance completion of the training course.',
    `compliance_status` STRING COMMENT 'Compliance status of the training course relative to required standards.',
    `cost` DECIMAL(18,2) COMMENT 'Cost of delivering the training course.',
    `cost_center` STRING COMMENT 'Cost center associated with the training course.',
    `cost_currency` STRING COMMENT 'Currency of the training course cost.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when the training course record was created.',
    `created_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute created_timestamp.',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `delivery_mode` STRING COMMENT 'Delivery mode of the training course.',
    `training_course_description` STRING COMMENT 'Detailed description of the training course content.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training course in hours.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `end_date` DATE COMMENT 'Date when the training course is no longer available.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `format` STRING COMMENT 'Format of the training course delivery.',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `language` STRING COMMENT 'Primary language of the training course content.',
    `learning_objectives` STRING COMMENT 'Learning objectives and outcomes of the training course.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `training_course_name` STRING COMMENT 'Human-readable name of the training course.',
    `prerequisites` STRING COMMENT 'Prerequisite courses or conditions required before enrolling.',
    `provider_address` STRING COMMENT 'Physical address of the training course provider.',
    `provider_email` STRING COMMENT 'Primary email address for the training course provider.',
    `provider_name` STRING COMMENT 'Name of the training course provider.',
    `provider_phone` STRING COMMENT 'Primary phone number for the training course provider.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `required_by` STRING COMMENT 'Regulatory or internal requirement that mandates the training.',
    `start_date` DATE COMMENT 'Date when the training course becomes available.',
    `training_course_status` STRING COMMENT 'Current lifecycle status of the training course.',
    `training_course_type` STRING COMMENT 'Category of the training course (e.g., mandatory, optional).',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when the training course record was last updated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Standard ECM audit/governance attribute updated_timestamp.',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Master reference table for training_course. Referenced by course_id.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` (
    `workforce_certification2_id` BIGINT COMMENT 'System-generated unique identifier for each certification record held by an employee.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee who holds the certification.',
    `training_course_id` BIGINT COMMENT 'FK to training course - certifications are earned from courses',
    `certification_category` STRING COMMENT 'Higher‑level classification of the credential (e.g., license, certificate).. Valid values are `license|credential|certificate|accreditation`',
    `certification_code` STRING COMMENT 'Standard code or abbreviation assigned by the issuing body (e.g., RN, CPC).',
    `certification_name` STRING COMMENT 'Descriptive name of the certification or license (e.g., Registered Nurse, Certified Health Coach).',
    `certification_number` STRING COMMENT 'Unique number assigned by the issuing organization to this certification instance.',
    `certification_type` STRING COMMENT 'Category of the certification indicating its functional domain.. Valid values are `clinical|compliance|it|insurance_license|other`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost incurred to obtain or maintain the certification.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the certification record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the certification cost (e.g., USD).',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `document_reference` STRING COMMENT 'Path or identifier to the stored digital copy of the certification document.',
    `effective_date` DATE COMMENT 'Date the certification becomes effective for role eligibility (may differ from issue date).',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `expiration_date` DATE COMMENT 'Date the certification expires and must be renewed or re‑validated.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates if the certification is required for the employees current role.',
    `issue_date` DATE COMMENT 'Date the certification was originally awarded to the employee.',
    `issuing_organization` STRING COMMENT 'Name of the authority or body that granted the certification.',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the certification.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `renewal_cycle_months` STRING COMMENT 'Number of months between required renewal events.',
    `renewal_date` DATE COMMENT 'Date the most recent renewal was completed.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the certification must be renewed periodically.',
    `renewal_status` STRING COMMENT 'Current renewal state of the certification.. Valid values are `pending|completed|not_required|overdue`',
    `required_for_role` STRING COMMENT 'Job role or function that mandates this certification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the certification record.',
    `verification_date` DATE COMMENT 'Date the certification was last verified for accuracy and authenticity.',
    `verification_status` STRING COMMENT 'Result of the most recent verification process.. Valid values are `verified|unverified|pending`',
    `workforce_certification_status` STRING COMMENT 'Overall lifecycle state of the certification record.. Valid values are `active|expired|revoked|suspended|pending`',
    CONSTRAINT pk_workforce_certification2 PRIMARY KEY(`workforce_certification2_id`)
) COMMENT 'Master record for professional certifications and licenses held by health plan employees — clinical certifications (RN, LCSW, CCM, CPC), compliance certifications (CHC, CHPC), IT certifications, and state insurance licenses. Captures certification type, issuing body, certification number, issue date, expiration date, renewal status, and verification date. Distinct from provider credentialing (which governs external clinical staff) — this tracks internal workforce credentials required for role eligibility and regulatory compliance. Supports NCQA care management staffing standards.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` (
    `workforce_recruitment_id` BIGINT COMMENT 'System-generated unique identifier for the recruitment record.',
    `headcount_plan_id` BIGINT COMMENT 'Foreign key linking to workforce.headcount_plan. Business justification: A recruitment event fulfills an approved headcount plan slot. One headcount plan can spawn multiple recruitment events (e.g., plan approves 5 FTEs, each gets its own requisition). This FK links the ta',
    `job_role_id` BIGINT COMMENT 'Foreign key linking to workforce.job_role. Business justification: A recruitment requisition is for a specific job role. Linking to job_role enables deriving pay grade ranges, FLSA status, required certifications, and PHI access tier from the authoritative job_role m',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: A recruitment requisition belongs to a specific organizational unit. While department_code and cost_center_code exist as strings, they represent different coding schemes than org_units primary key. A',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: A recruitment requisition is opened to fill a specific authorized position (headcount slot). Linking workforce_recruitment to position enables tracking which position each recruitment event is filling',
    `employee_id` BIGINT COMMENT 'Identifier of the manager responsible for the hire.',
    `recruitment_quaternary_workforce_updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who performed the latest update.',
    `tertiary_workforce_created_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who created the record.',
    `application_deadline` DATE COMMENT 'Last date candidates may submit applications.',
    `candidate_start_date` DATE COMMENT 'First day the hired candidate is scheduled to begin work.',
    `compensation_type` STRING COMMENT 'Classification of the compensation model for the role.. Valid values are `salary|hourly|contract`',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the positions salary will be charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the recruitment record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for salary amounts.. Valid values are `^[A-Z]{3}$`',
    `data_quality_score` STRING COMMENT 'Computed data-quality score for ECM scoring.',
    `department_code` STRING COMMENT 'Code identifying the department owning the requisition.',
    `effective_end_date` DATE COMMENT 'Effective end of the record validity window.',
    `effective_start_date` DATE COMMENT 'Effective start of the record validity window.',
    `fhir_last_updated` TIMESTAMP COMMENT 'FHIR meta.lastUpdated for resource versioning',
    `fhir_profile_url` STRING COMMENT 'Canonical FHIR/US Core profile URL this record conforms to',
    `fhir_resource_identifier` STRING COMMENT 'Stable FHIR logical resource id for interop exchange',
    `fhir_resource_type` STRING COMMENT 'FHIR resource type this record maps to for interoperability (default: Basic)',
    `fhir_version` STRING COMMENT 'FHIR meta.versionId optimistic concurrency token',
    `interview_stage_completed` STRING COMMENT 'Most advanced interview stage completed for the requisition.. Valid values are `screen|phone|onsite|final|offer`',
    `is_active` BOOLEAN COMMENT 'Logical active flag for soft-delete and current-state filtering.',
    `is_remote` BOOLEAN COMMENT 'True if the position is designated as remote or hybrid.',
    `job_level` STRING COMMENT 'Organizational level of the position (e.g., IC3, Manager, Director).',
    `job_posting_date` DATE COMMENT 'Date the position was posted to internal/external channels.',
    `location_code` STRING COMMENT 'Internal code representing the primary work location (city/office).',
    `master_entity_code` STRING COMMENT 'Cross-domain master/golden entity key for SSOT resolution.',
    `net_salary_amount` DECIMAL(18,2) COMMENT 'Take‑home salary after standard deductions, as communicated to the candidate.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or observations about the requisition.',
    `number_of_applicants` STRING COMMENT 'Count of distinct candidates who applied to the requisition.',
    `offer_accepted_date` DATE COMMENT 'Date the candidate accepted the employment offer.',
    `offer_extended_date` DATE COMMENT 'Date an employment offer was formally extended to the selected candidate.',
    `record_created_at` TIMESTAMP COMMENT 'Timestamp the record was created (audit lineage).',
    `record_source_system` STRING COMMENT 'System of record / source system that produced this record (SSOT provenance).',
    `record_status` STRING COMMENT 'Standard ECM audit/governance attribute record_status.',
    `record_updated_at` TIMESTAMP COMMENT 'Timestamp the record was last updated (audit lineage).',
    `record_version` STRING COMMENT 'Optimistic-concurrency / change version of the record.',
    `requisition_number` STRING COMMENT 'External business identifier for the open requisition.',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the requisition.. Valid values are `open|on_hold|filled|cancelled`',
    `salary_adjustment_amount` DECIMAL(18,2) COMMENT 'Additional monetary adjustments (e.g., sign‑on bonus) attached to the offer.',
    `salary_offer_amount` DECIMAL(18,2) COMMENT 'Gross annual salary amount offered to the candidate.',
    `source_of_hire` STRING COMMENT 'Channel through which the candidate was sourced.. Valid values are `internal|referral|job_board|recruiter|agency|social_media`',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days from posting to candidate start date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the recruitment record.',
    CONSTRAINT pk_workforce_recruitment PRIMARY KEY(`workforce_recruitment_id`)
) COMMENT 'Transactional record for each open requisition and recruitment event in the talent acquisition lifecycle. Captures requisition number, position being filled, hiring manager, recruiter assigned, job posting date, application deadline, number of applicants, interview stages completed, offer extended date, offer accepted date, candidate start date, time-to-fill metric, source of hire, and requisition status (open, on-hold, filled, cancelled). Supports workforce planning, recruiter productivity tracking, and diversity hiring reporting.';

CREATE OR REPLACE TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` (
    `workforce_certification_id` BIGINT COMMENT 'Primary key',
    `training_course_id` BIGINT COMMENT 'FK to training course that awards this certification',
    CONSTRAINT pk_workforce_certification PRIMARY KEY(`workforce_certification_id`)
) COMMENT 'Workforce certification records';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ADD CONSTRAINT `fk_workforce_job_role_job_org_unit_id` FOREIGN KEY (`job_org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ADD CONSTRAINT `fk_workforce_job_role_job_workforce_org_unit_id` FOREIGN KEY (`job_workforce_org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ADD CONSTRAINT `fk_workforce_job_role_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ADD CONSTRAINT `fk_workforce_employment_record_tertiary_employment_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_employment_hr_business_partner_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_compensation_plan_id` FOREIGN KEY (`compensation_plan_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ADD CONSTRAINT `fk_workforce_compensation_primary_compensation_employee_id` FOREIGN KEY (`primary_compensation_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ADD CONSTRAINT `fk_workforce_payroll_disbursement_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ADD CONSTRAINT `fk_workforce_payroll_disbursement_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ADD CONSTRAINT `fk_workforce_payroll_disbursement_time_and_attendance_id` FOREIGN KEY (`time_and_attendance_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`time_and_attendance`(`time_and_attendance_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ADD CONSTRAINT `fk_workforce_payroll_cost_allocation_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ADD CONSTRAINT `fk_workforce_payroll_cost_allocation_payroll_disbursement_id` FOREIGN KEY (`payroll_disbursement_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement`(`payroll_disbursement_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ADD CONSTRAINT `fk_workforce_payroll_cost_allocation_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ADD CONSTRAINT `fk_workforce_payroll_cost_allocation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ADD CONSTRAINT `fk_workforce_payroll_cost_allocation_tertiary_payroll_updated_by_user_employee_id` FOREIGN KEY (`tertiary_payroll_updated_by_user_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ADD CONSTRAINT `fk_workforce_employee_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ADD CONSTRAINT `fk_workforce_rbac_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ADD CONSTRAINT `fk_workforce_rbac_assignment_assignee_employee_id` FOREIGN KEY (`assignee_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ADD CONSTRAINT `fk_workforce_rbac_assignment_rbac_last_updated_by_employee_id` FOREIGN KEY (`rbac_last_updated_by_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ADD CONSTRAINT `fk_workforce_rbac_assignment_rbac_role_id` FOREIGN KEY (`rbac_role_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`rbac_role`(`rbac_role_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_headcount_last_updated_by_employee_id` FOREIGN KEY (`headcount_last_updated_by_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_headcount_requisition_requestor_employee_id` FOREIGN KEY (`headcount_requisition_requestor_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ADD CONSTRAINT `fk_workforce_headcount_plan_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_compliance_event_id` FOREIGN KEY (`compliance_event_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`compliance_event`(`compliance_event_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_tertiary_disciplinary_manager_employee_id` FOREIGN KEY (`tertiary_disciplinary_manager_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_tertiary_quinary_disciplinary_updated_by_user_employee_id` FOREIGN KEY (`tertiary_quinary_disciplinary_updated_by_user_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ADD CONSTRAINT `fk_workforce_compliance_event_background_check_id` FOREIGN KEY (`background_check_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`background_check`(`background_check_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ADD CONSTRAINT `fk_workforce_compliance_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_background_initiator_employee_id` FOREIGN KEY (`background_initiator_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ADD CONSTRAINT `fk_workforce_background_check_background_last_updated_by_employee_id` FOREIGN KEY (`background_last_updated_by_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ADD CONSTRAINT `fk_workforce_time_and_attendance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_parent_compensation_plan_id` FOREIGN KEY (`parent_compensation_plan_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`compensation_plan`(`compensation_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ADD CONSTRAINT `fk_workforce_rbac_role_parent_rbac_role_id` FOREIGN KEY (`parent_rbac_role_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`rbac_role`(`rbac_role_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_parent_training_course_id` FOREIGN KEY (`parent_training_course_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_training_last_updated_by_employee_id` FOREIGN KEY (`training_last_updated_by_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ADD CONSTRAINT `fk_workforce_workforce_certification2_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ADD CONSTRAINT `fk_workforce_workforce_certification2_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ADD CONSTRAINT `fk_workforce_workforce_recruitment_headcount_plan_id` FOREIGN KEY (`headcount_plan_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`headcount_plan`(`headcount_plan_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ADD CONSTRAINT `fk_workforce_workforce_recruitment_job_role_id` FOREIGN KEY (`job_role_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`job_role`(`job_role_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ADD CONSTRAINT `fk_workforce_workforce_recruitment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ADD CONSTRAINT `fk_workforce_workforce_recruitment_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ADD CONSTRAINT `fk_workforce_workforce_recruitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ADD CONSTRAINT `fk_workforce_workforce_recruitment_recruitment_quaternary_workforce_updated_by_user_employee_id` FOREIGN KEY (`recruitment_quaternary_workforce_updated_by_user_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ADD CONSTRAINT `fk_workforce_workforce_recruitment_tertiary_workforce_created_by_user_employee_id` FOREIGN KEY (`tertiary_workforce_created_by_user_employee_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` ADD CONSTRAINT `fk_workforce_workforce_certification_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_health_insurance_v1`.`workforce`.`training_course`(`training_course_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_health_insurance_v1`.`workforce` SET TAGS ('pii_division' = 'corporate');
ALTER SCHEMA `vibe_health_insurance_v1`.`workforce` SET TAGS ('pii_domain' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('pii_subdomain' = 'employee_management');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('pii_fhir_resource' = 'Practitioner');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('pii_vibe_coding_demo' = 'scoped');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `job_role_id` SET TAGS ('pii_business_glossary_term' = 'Job Role Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('pii_business_glossary_term' = 'Manager ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Group Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `access_level` SET TAGS ('pii_business_glossary_term' = 'PHI Access Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `access_level` SET TAGS ('pii_value_regex' = 'none|basic|sensitive|restricted');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `birth_date` SET TAGS ('pii_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `birth_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `birth_date` SET TAGS ('pii_dob' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `bonus_eligible` SET TAGS ('pii_business_glossary_term' = 'Bonus Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('pii_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `country` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `country` SET TAGS ('pii_fhir_element' = 'address.country');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `department` SET TAGS ('pii_business_glossary_term' = 'Department');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `email` SET TAGS ('pii_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('pii_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('pii_value_regex' = 'active|terminated|on_leave|retired|inactive');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('pii_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('pii_value_regex' = 'full_time|part_time|contract|temporary|intern');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ethnicity` SET TAGS ('pii_business_glossary_term' = 'Ethnicity');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ethnicity` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ethnicity` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ethnicity` SET TAGS ('pii_fhir_element_extension' = 'us-core-ethnicity');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('pii_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('pii_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('pii_value_regex' = 'male|female|non_binary|prefer_not_to_answer');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('pii_fhir_element' = 'gender');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `health_plan_eligible` SET TAGS ('pii_business_glossary_term' = 'Health Plan Eligibility');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `health_plan_eligible` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `health_plan_eligible` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `hipaa_training_completion_date` SET TAGS ('pii_business_glossary_term' = 'HIPAA Training Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('pii_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `i9_verification_date` SET TAGS ('pii_business_glossary_term' = 'I‑9 Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('pii_fhir_element' = 'name.family');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('pii_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('pii_fhir_element' = 'name.given');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `organization_level` SET TAGS ('pii_business_glossary_term' = 'Organization Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `pay_frequency` SET TAGS ('pii_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `pay_frequency` SET TAGS ('pii_value_regex' = 'monthly|biweekly|weekly|semi_monthly');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('pii_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('pii_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('pii_fhir_element' = 'address.postalCode');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('pii_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `salary_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('pii_business_glossary_term' = 'Salary Currency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `salary_currency` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `security_training_completion_date` SET TAGS ('pii_business_glossary_term' = 'Security Training Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ssn` SET TAGS ('pii_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ssn` SET TAGS ('pii_value_regex' = '^d{3}-d{2}-d{4}$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ssn` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ssn` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ssn` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `ssn` SET TAGS ('pii_fhir_element' = 'identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `state` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('pii_subdomain' = 'employee_management');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('pii_fhir_resource' = 'PractitionerRole');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `job_role_id` SET TAGS ('pii_business_glossary_term' = 'Job Role Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `bonus_eligible` SET TAGS ('pii_business_glossary_term' = 'Bonus Eligibility');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `competency_level` SET TAGS ('pii_business_glossary_term' = 'Competency Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `compliance_training_completed` SET TAGS ('pii_business_glossary_term' = 'Compliance Training Completed');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `department_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('pii_business_glossary_term' = 'Position Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `eeo1_category` SET TAGS ('pii_business_glossary_term' = 'EEO‑1 Category');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('pii_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `employment_type` SET TAGS ('pii_value_regex' = 'full_time|part_time|contract|temporary');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('pii_business_glossary_term' = 'FLSA Classification');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('pii_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('pii_business_glossary_term' = 'Full‑Time Equivalent Allocation');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `hipaa_privacy_training_required` SET TAGS ('pii_business_glossary_term' = 'HIPAA Privacy Training Required');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `incentive_plan` SET TAGS ('pii_business_glossary_term' = 'Incentive Plan');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `is_managerial` SET TAGS ('pii_business_glossary_term' = 'Managerial Role Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `job_code` SET TAGS ('pii_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `job_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `language_requirements` SET TAGS ('pii_business_glossary_term' = 'Language Requirements');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `next_review_due_date` SET TAGS ('pii_business_glossary_term' = 'Next Performance Review Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `overtime_eligible` SET TAGS ('pii_business_glossary_term' = 'Overtime Eligibility');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('pii_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `pay_grade_max` SET TAGS ('pii_business_glossary_term' = 'Pay Grade Maximum Salary');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `pay_grade_mid` SET TAGS ('pii_business_glossary_term' = 'Pay Grade Midpoint Salary');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `pay_grade_min` SET TAGS ('pii_business_glossary_term' = 'Pay Grade Minimum Salary');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `phi_access_tier` SET TAGS ('pii_business_glossary_term' = 'PHI Access Tier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `phi_access_tier` SET TAGS ('pii_value_regex' = 'none|low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('pii_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('pii_value_regex' = 'vacant|filled|closed|pending');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `remote_allowed` SET TAGS ('pii_business_glossary_term' = 'Remote Work Eligibility');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `required_certifications` SET TAGS ('pii_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `salary_band` SET TAGS ('pii_business_glossary_term' = 'Salary Band');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `salary_band` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `salary_band` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `shift_type` SET TAGS ('pii_value_regex' = 'day|night|rotating|flex');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `supervisory_level` SET TAGS ('pii_business_glossary_term' = 'Supervisory Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('pii_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `travel_required` SET TAGS ('pii_business_glossary_term' = 'Travel Requirement Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `union_member` SET TAGS ('pii_business_glossary_term' = 'Union Membership Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`position` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('pii_subdomain' = 'employee_management');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `job_role_id` SET TAGS ('pii_business_glossary_term' = 'Job Role Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `job_workforce_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Workforce Org Unit Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `compensation_band` SET TAGS ('pii_business_glossary_term' = 'Compensation Band');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `compensation_band` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `compensation_band` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `eeo_category` SET TAGS ('pii_business_glossary_term' = 'EEO‑1 Category');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `external_system_source` SET TAGS ('pii_business_glossary_term' = 'External System Source');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `flsa_exempt_status` SET TAGS ('pii_business_glossary_term' = 'FLSA Exempt Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `flsa_exempt_status` SET TAGS ('pii_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `hipaa_training_required` SET TAGS ('pii_business_glossary_term' = 'HIPAA Training Required');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `is_clinical` SET TAGS ('pii_business_glossary_term' = 'Clinical Role Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `is_managerial` SET TAGS ('pii_business_glossary_term' = 'Managerial Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `job_family` SET TAGS ('pii_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `job_function` SET TAGS ('pii_business_glossary_term' = 'Job Function');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `last_review_date` SET TAGS ('pii_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `legacy_role_code` SET TAGS ('pii_business_glossary_term' = 'Legacy Role Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `legacy_role_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `organization_unit` SET TAGS ('pii_business_glossary_term' = 'Organization Unit');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `pay_currency` SET TAGS ('pii_business_glossary_term' = 'Pay Currency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `pay_currency` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `pay_grade_max` SET TAGS ('pii_business_glossary_term' = 'Maximum Pay Grade');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `pay_grade_min` SET TAGS ('pii_business_glossary_term' = 'Minimum Pay Grade');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `phi_access_tier` SET TAGS ('pii_business_glossary_term' = 'PHI Access Tier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `phi_access_tier` SET TAGS ('pii_value_regex' = 'none|low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `required_certifications` SET TAGS ('pii_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_access_level` SET TAGS ('pii_business_glossary_term' = 'Role Access Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_access_level` SET TAGS ('pii_value_regex' = 'read|write|admin');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_code` SET TAGS ('pii_business_glossary_term' = 'Job Role Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_description` SET TAGS ('pii_business_glossary_term' = 'Job Role Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_level` SET TAGS ('pii_business_glossary_term' = 'Role Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_notes` SET TAGS ('pii_business_glossary_term' = 'Role Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_owner_department` SET TAGS ('pii_business_glossary_term' = 'Role Owner Department');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_risk_level` SET TAGS ('pii_business_glossary_term' = 'Role Risk Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_status` SET TAGS ('pii_business_glossary_term' = 'Job Role Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_status` SET TAGS ('pii_value_regex' = 'active|inactive|deprecated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_title` SET TAGS ('pii_business_glossary_term' = 'Job Role Title');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `role_version` SET TAGS ('pii_business_glossary_term' = 'Role Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`job_role` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('pii_subdomain' = 'employee_management');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('pii_fhir_resource' = 'Organization');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Parent Organizational Unit Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line1` SET TAGS ('pii_fhir_element' = 'address.line');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `annual_budget_amount` SET TAGS ('pii_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `audit_status` SET TAGS ('pii_business_glossary_term' = 'Audit Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `audit_status` SET TAGS ('pii_value_regex' = 'passed|failed|pending');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('pii_fhir_element' = 'address.city');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `compliance_training_required` SET TAGS ('pii_business_glossary_term' = 'Compliance Training Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `country` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `country` SET TAGS ('pii_fhir_element' = 'address.country');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `data_classification` SET TAGS ('pii_business_glossary_term' = 'Data Classification');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `email` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `email` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `email` SET TAGS ('pii_fhir_element' = 'telecom.email');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `external_reference_code` SET TAGS ('pii_business_glossary_term' = 'External Reference Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `external_reference_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger Account Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount` SET TAGS ('pii_business_glossary_term' = 'Headcount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `is_cost_center` SET TAGS ('pii_business_glossary_term' = 'Is Cost Center Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `is_profit_center` SET TAGS ('pii_business_glossary_term' = 'Is Profit Center Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `location` SET TAGS ('pii_business_glossary_term' = 'Physical Location Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_level` SET TAGS ('pii_business_glossary_term' = 'Organizational Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('pii_value_regex' = 'active|inactive|closed|pending');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('pii_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('pii_value_regex' = 'department|division|business_unit|team|cost_center');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `payroll_allocation_method` SET TAGS ('pii_business_glossary_term' = 'Payroll Allocation Method');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `payroll_allocation_method` SET TAGS ('pii_value_regex' = 'direct|percentage|headcount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('pii_fhir_element' = 'telecom.phone');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('pii_fhir_element' = 'address.postalCode');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `primary_function` SET TAGS ('pii_business_glossary_term' = 'Primary Business Function');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `rbac_scope` SET TAGS ('pii_business_glossary_term' = 'RBAC Scope');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `rbac_scope` SET TAGS ('pii_value_regex' = 'enterprise|regional|department|team');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `state` SET TAGS ('pii_business_glossary_term' = 'State/Province');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `state` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `state` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `state` SET TAGS ('pii_fhir_element' = 'address.state');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`org_unit` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` SET TAGS ('pii_subdomain' = 'employee_management');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `employment_record_id` SET TAGS ('pii_business_glossary_term' = 'Employment Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Prior Organizational Unit ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Prior Position ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `tertiary_employment_hr_business_partner_employee_id` SET TAGS ('pii_business_glossary_term' = 'HR Business Partner ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `tertiary_employment_hr_business_partner_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `tertiary_employment_hr_business_partner_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `action_effective_date` SET TAGS ('pii_business_glossary_term' = 'Action Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `action_number` SET TAGS ('pii_business_glossary_term' = 'Employment Action Number (EAN)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `action_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `action_subtype` SET TAGS ('pii_business_glossary_term' = 'Employment Action Subtype');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `action_type` SET TAGS ('pii_business_glossary_term' = 'Employment Action Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `appeal_status` SET TAGS ('pii_value_regex' = 'pending|approved|denied');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_acknowledgment_status` SET TAGS ('pii_business_glossary_term' = 'Employee Acknowledgment Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `employee_acknowledgment_status` SET TAGS ('pii_value_regex' = 'acknowledged|not_acknowledged');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `incident_description` SET TAGS ('pii_business_glossary_term' = 'Incident Description (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `incident_description` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `lifecycle_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|closed|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `new_pay_grade` SET TAGS ('pii_business_glossary_term' = 'New Pay Grade');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `policy_violated` SET TAGS ('pii_business_glossary_term' = 'Policy Violated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `prior_pay_grade` SET TAGS ('pii_business_glossary_term' = 'Prior Pay Grade');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `reason_code` SET TAGS ('pii_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `record_status` SET TAGS ('pii_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `suspension_duration_days` SET TAGS ('pii_business_glossary_term' = 'Suspension Duration (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employment_record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('pii_business_glossary_term' = 'Compensation ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_plan_id` SET TAGS ('pii_business_glossary_term' = 'Compensation Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_plan_id` SET TAGS ('pii_classification' = 'restricted');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `primary_compensation_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `base_amount` SET TAGS ('pii_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_amount` SET TAGS ('pii_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_frequency` SET TAGS ('pii_business_glossary_term' = 'Bonus Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_frequency` SET TAGS ('pii_value_regex' = 'annual|quarterly|monthly|one-time');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_type` SET TAGS ('pii_business_glossary_term' = 'Bonus Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `bonus_type` SET TAGS ('pii_value_regex' = 'performance|sign-on|retention|spot');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `change_reason` SET TAGS ('pii_business_glossary_term' = 'Compensation Change Reason');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_code` SET TAGS ('pii_business_glossary_term' = 'Compensation Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_code` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('pii_business_glossary_term' = 'Compensation Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('pii_value_regex' = 'active|pending|terminated|planned');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_status` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('pii_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('pii_value_regex' = 'base|hourly|bonus|equity|allowance|overtime');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_type` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|AUD|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Compensation Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Compensation End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `equity_amount` SET TAGS ('pii_business_glossary_term' = 'Equity Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `equity_type` SET TAGS ('pii_business_glossary_term' = 'Equity Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `equity_type` SET TAGS ('pii_value_regex' = 'stock|stock_option|restricted_stock|phantom');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `equity_vesting_schedule` SET TAGS ('pii_business_glossary_term' = 'Equity Vesting Schedule');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `hourly_rate` SET TAGS ('pii_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `incentive_target_pct` SET TAGS ('pii_business_glossary_term' = 'Incentive Target Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `is_exempt` SET TAGS ('pii_business_glossary_term' = 'Exempt Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `is_flexible` SET TAGS ('pii_business_glossary_term' = 'Flexible Compensation Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `location_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_name` SET TAGS ('pii_business_glossary_term' = 'Compensation Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `compensation_name` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Compensation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `overtime_eligibility` SET TAGS ('pii_business_glossary_term' = 'Overtime Eligibility');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('pii_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `pay_frequency` SET TAGS ('pii_value_regex' = 'weekly|biweekly|semimonthly|monthly|quarterly|annually');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `pay_grade` SET TAGS ('pii_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_max` SET TAGS ('pii_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_max` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_max` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_mid` SET TAGS ('pii_business_glossary_term' = 'Salary Range Midpoint');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_mid` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_mid` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_min` SET TAGS ('pii_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_min` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `salary_range_min` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `shift_differential` SET TAGS ('pii_business_glossary_term' = 'Shift Differential Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('pii_business_glossary_term' = 'Payroll Run Identifier (ID)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Identifier (COST_CENTER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'User Identifier Who Processed the Payroll Run (USER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `group_id` SET TAGS ('pii_business_glossary_term' = 'Employer Identifier (EMPLOYER_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments or Notes Regarding the Payroll Run (COMMENTS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `gl_posting_reference` SET TAGS ('pii_business_glossary_term' = 'General Ledger Posting Reference (GL_REF)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `is_manual_run` SET TAGS ('pii_business_glossary_term' = 'Manual Run Flag (MANUAL_FLAG)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_date` SET TAGS ('pii_business_glossary_term' = 'Payroll Pay Date (PAY_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_batch_number` SET TAGS ('pii_business_glossary_term' = 'Payroll Batch Identifier (BATCH_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_batch_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_cycle_code` SET TAGS ('pii_business_glossary_term' = 'Payroll Cycle Code (CYCLE_CD)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_cycle_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_status` SET TAGS ('pii_business_glossary_term' = 'Payroll Run Status (STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_status` SET TAGS ('pii_value_regex' = 'pending|processed|approved|posted|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_type` SET TAGS ('pii_business_glossary_term' = 'Payroll Type (TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_type` SET TAGS ('pii_value_regex' = 'regular|off_cycle|bonus|retroactive|adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `period_end_date` SET TAGS ('pii_business_glossary_term' = 'Payroll Period End Date (END_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `period_start_date` SET TAGS ('pii_business_glossary_term' = 'Payroll Period Start Date (START_DT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_execution_timestamp` SET TAGS ('pii_business_glossary_term' = 'Payroll Run Execution Timestamp (EXEC_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_number` SET TAGS ('pii_business_glossary_term' = 'Payroll Run Number (RUN_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_employee_deductions` SET TAGS ('pii_business_glossary_term' = 'Total Employee Deductions Amount (EMP_DED_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_tax` SET TAGS ('pii_business_glossary_term' = 'Total Employer Tax Liability (EMP_TAX_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_amount` SET TAGS ('pii_business_glossary_term' = 'Total Gross Pay Amount (GROSS_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_amount` SET TAGS ('pii_business_glossary_term' = 'Total Net Pay Amount (NET_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `version_number` SET TAGS ('pii_business_glossary_term' = 'Version Number of Payroll Run Record (VERSION_NO)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_run` ALTER COLUMN `version_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payroll_disbursement_id` SET TAGS ('pii_business_glossary_term' = 'Payroll Disbursement ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payroll_run_id` SET TAGS ('pii_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `time_and_attendance_id` SET TAGS ('pii_business_glossary_term' = 'Time And Attendance Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `allocated_benefit_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Allocated Benefit Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `allocated_employer_tax_amount` SET TAGS ('pii_business_glossary_term' = 'Allocated Employer Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `allocated_gross_amount` SET TAGS ('pii_business_glossary_term' = 'Allocated Gross Pay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('pii_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('pii_value_regex' = '^d{4,17}$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_account_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_value_regex' = '^d{9}$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `clock_in_timestamp` SET TAGS ('pii_business_glossary_term' = 'Clock‑In Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `clock_out_timestamp` SET TAGS ('pii_business_glossary_term' = 'Clock‑Out Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `cost_center_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `employee_role` SET TAGS ('pii_business_glossary_term' = 'Employee Role');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `employee_role` SET TAGS ('pii_value_regex' = 'clinical|administrative|support|executive');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `federal_tax_withheld` SET TAGS ('pii_business_glossary_term' = 'Federal Tax Withheld');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `fica_tax_withheld` SET TAGS ('pii_business_glossary_term' = 'FICA Tax Withheld');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gl_account_number` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gl_account_number` SET TAGS ('pii_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gl_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gl_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gl_account_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gross_pay_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gross_pay_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `gross_pay_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Sequence Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `line_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `lob_code` SET TAGS ('pii_value_regex' = 'medical|dental|vision|wellness|pharmacy|behavioral');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `manager_approval_date` SET TAGS ('pii_business_glossary_term' = 'Manager Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `medicare_tax_withheld` SET TAGS ('pii_business_glossary_term' = 'Medicare Tax Withheld');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `net_pay_amount` SET TAGS ('pii_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `net_pay_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `net_pay_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `other_deductions_total` SET TAGS ('pii_business_glossary_term' = 'Other Deductions Total');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `overtime_hours` SET TAGS ('pii_business_glossary_term' = 'Overtime Hours Worked');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `pay_date` SET TAGS ('pii_business_glossary_term' = 'Pay Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `pay_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `pay_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `pay_stub_number` SET TAGS ('pii_business_glossary_term' = 'Pay Stub Reference Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `pay_stub_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{8,12}$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `pay_stub_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payment_method` SET TAGS ('pii_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payment_method` SET TAGS ('pii_value_regex' = 'direct_deposit|check|paycard');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payroll_disbursement_type` SET TAGS ('pii_business_glossary_term' = 'Payroll Disbursement Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payroll_disbursement_type` SET TAGS ('pii_value_regex' = 'regular|bonus|commission|adjustment');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payroll_status` SET TAGS ('pii_business_glossary_term' = 'Payroll Disbursement Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `payroll_status` SET TAGS ('pii_value_regex' = 'processed|pending|error|reversed');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `pto_hours` SET TAGS ('pii_business_glossary_term' = 'Paid Time Off (PTO) Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `regular_hours` SET TAGS ('pii_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `shift_differential_hours` SET TAGS ('pii_business_glossary_term' = 'Shift Differential Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `sick_hours` SET TAGS ('pii_business_glossary_term' = 'Sick Leave Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `state_tax_withheld` SET TAGS ('pii_business_glossary_term' = 'State Tax Withheld');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `tax_exempt_flag` SET TAGS ('pii_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `timesheet_approval_date` SET TAGS ('pii_business_glossary_term' = 'Timesheet Approval Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `timesheet_status` SET TAGS ('pii_business_glossary_term' = 'Timesheet Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `timesheet_status` SET TAGS ('pii_value_regex' = 'submitted|approved|rejected|pending');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_disbursement` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` SET TAGS ('pii_fhir_resource' = 'Location');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `payroll_cost_allocation_id` SET TAGS ('pii_business_glossary_term' = 'Payroll Cost Allocation ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `payroll_disbursement_id` SET TAGS ('pii_business_glossary_term' = 'Payroll Disbursement Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `payroll_run_id` SET TAGS ('pii_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `tertiary_payroll_updated_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `tertiary_payroll_updated_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `tertiary_payroll_updated_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocated_benefit_cost` SET TAGS ('pii_business_glossary_term' = 'Allocated Benefit Cost');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocated_employer_tax_amount` SET TAGS ('pii_business_glossary_term' = 'Allocated Employer Tax Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocated_gross_pay_amount` SET TAGS ('pii_business_glossary_term' = 'Allocated Gross Pay Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocated_gross_pay_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocated_gross_pay_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_amount_total` SET TAGS ('pii_business_glossary_term' = 'Total Allocation Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_date` SET TAGS ('pii_business_glossary_term' = 'Allocation Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_percentage` SET TAGS ('pii_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_reason` SET TAGS ('pii_business_glossary_term' = 'Allocation Reason');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_reason` SET TAGS ('pii_value_regex' = 'regular|adjustment|correction|bonus|overtime');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_sequence` SET TAGS ('pii_business_glossary_term' = 'Allocation Sequence');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('pii_business_glossary_term' = 'Allocation Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `allocation_status` SET TAGS ('pii_value_regex' = 'pending|allocated|reversed|error');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `gl_account_code` SET TAGS ('pii_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `gl_account_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `is_manual_adjustment` SET TAGS ('pii_business_glossary_term' = 'Manual Adjustment Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `lob_code` SET TAGS ('pii_business_glossary_term' = 'Line of Business (LOB) Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `lob_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Allocation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `payroll_period` SET TAGS ('pii_business_glossary_term' = 'Payroll Period');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`payroll_cost_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` SET TAGS ('pii_fhir_resource' = 'EnrollmentRequest');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employee_benefit_enrollment_id` SET TAGS ('pii_business_glossary_term' = 'Employee Benefit Enrollment ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `health_plan_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `benefit_year` SET TAGS ('pii_business_glossary_term' = 'Benefit Year');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `cobra_end_date` SET TAGS ('pii_business_glossary_term' = 'COBRA End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `cobra_start_date` SET TAGS ('pii_business_glossary_term' = 'COBRA Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('pii_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('pii_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('pii_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('pii_value_regex' = 'Employee Only|Employee+Spouse|Family');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Employee Contribution Amount (EMP_CONTR_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Employer Contribution Amount (EMPLOYER_CONTR_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('pii_business_glossary_term' = 'Enrollment Number (ENROLL_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('pii_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('pii_value_regex' = 'open_enrollment|new_hire|qualifying_life_event|admin_change');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('pii_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('pii_value_regex' = 'active|pending|terminated|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `enrollment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Enrollment Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `is_aca_compliant` SET TAGS ('pii_business_glossary_term' = 'ACA Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `is_cobra_eligible` SET TAGS ('pii_business_glossary_term' = 'COBRA Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `payroll_deduction_code` SET TAGS ('pii_business_glossary_term' = 'Payroll Deduction Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `payroll_deduction_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `total_contribution_amount` SET TAGS ('pii_business_glossary_term' = 'Total Contribution Amount (TOTAL_CONTR_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `total_contribution_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`employee_benefit_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('pii_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `accommodation_details` SET TAGS ('pii_business_glossary_term' = 'Accommodation Details');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `ada_accommodation_required` SET TAGS ('pii_business_glossary_term' = 'ADA Accommodation Required');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_days` SET TAGS ('pii_business_glossary_term' = 'Approved Leave Days');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_end_date` SET TAGS ('pii_business_glossary_term' = 'Approved End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_start_date` SET TAGS ('pii_business_glossary_term' = 'Approved Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('pii_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Requested End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_eligible` SET TAGS ('pii_business_glossary_term' = 'FMLA Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `intermittent` SET TAGS ('pii_business_glossary_term' = 'Intermittent Leave Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_after` SET TAGS ('pii_business_glossary_term' = 'Leave Balance After Request (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_before` SET TAGS ('pii_business_glossary_term' = 'Leave Balance Before Request (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_policy_code` SET TAGS ('pii_business_glossary_term' = 'Leave Policy Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_policy_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_status` SET TAGS ('pii_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_status` SET TAGS ('pii_value_regex' = 'requested|approved|denied|in_progress|closed');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('pii_business_glossary_term' = 'Leave Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('pii_value_regex' = 'fmla|personal|military|parental|bereavement|disability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Leave Request Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_amount` SET TAGS ('pii_business_glossary_term' = 'Payroll Amount Impact');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_impact` SET TAGS ('pii_business_glossary_term' = 'Payroll Impact Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('pii_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `request_timestamp` SET TAGS ('pii_business_glossary_term' = 'Leave Request Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `requested_days` SET TAGS ('pii_business_glossary_term' = 'Requested Leave Days');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `return_to_work_date` SET TAGS ('pii_business_glossary_term' = 'Return‑to‑Work Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Requested Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Record Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`leave_request` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` SET TAGS ('pii_subdomain' = 'talent_development');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('pii_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `average_goal_rating` SET TAGS ('pii_business_glossary_term' = 'Average Goal Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `business_event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Review Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('pii_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('pii_value_regex' = 'calibrated|pending|not_calibrated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_grade` SET TAGS ('pii_business_glossary_term' = 'Compensation Grade');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_grade` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `compensation_grade` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `competency_communication_rating` SET TAGS ('pii_business_glossary_term' = 'Communication Competency Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `competency_leadership_rating` SET TAGS ('pii_business_glossary_term' = 'Leadership Competency Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `competency_teamwork_rating` SET TAGS ('pii_business_glossary_term' = 'Teamwork Competency Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Data Confidentiality Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `department` SET TAGS ('pii_business_glossary_term' = 'Employee Department');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment_ref` SET TAGS ('pii_business_glossary_term' = 'Employee Self‑Assessment Reference');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_1_rating` SET TAGS ('pii_business_glossary_term' = 'Goal 1 Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_2_rating` SET TAGS ('pii_business_glossary_term' = 'Goal 2 Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_3_rating` SET TAGS ('pii_business_glossary_term' = 'Goal 3 Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `is_finalized` SET TAGS ('pii_business_glossary_term' = 'Is Finalized Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `job_role` SET TAGS ('pii_business_glossary_term' = 'Employee Job Role');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Work Location Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `location_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_name` SET TAGS ('pii_business_glossary_term' = 'Manager Full Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_narrative` SET TAGS ('pii_business_glossary_term' = 'Manager Narrative');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('pii_business_glossary_term' = 'Merit Increase Recommendation Percentage');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_recommendation_amount` SET TAGS ('pii_business_glossary_term' = 'Merit Increase Recommendation Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Additional Review Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('pii_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('pii_value_regex' = 'exceeds|meets|needs_improvement|unsatisfactory|outstanding');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_improvement_plan_due_date` SET TAGS ('pii_business_glossary_term' = 'PIP Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_improvement_plan_flag` SET TAGS ('pii_business_glossary_term' = 'PIP Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `record_audit_created` SET TAGS ('pii_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `record_audit_updated` SET TAGS ('pii_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('pii_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_number` SET TAGS ('pii_business_glossary_term' = 'Review Cycle Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_cycle_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_due_date` SET TAGS ('pii_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('pii_business_glossary_term' = 'Performance Review Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_end` SET TAGS ('pii_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_start` SET TAGS ('pii_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('pii_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|closed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('pii_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('pii_value_regex' = 'annual|mid-year|probationary|performance_improvement_plan|exit|other');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Salary Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`performance_review` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` SET TAGS ('pii_subdomain' = 'talent_development');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_record_id` SET TAGS ('pii_business_glossary_term' = 'Training Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_course_id` SET TAGS ('pii_business_glossary_term' = 'Course ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `assessment_result_description` SET TAGS ('pii_business_glossary_term' = 'Assessment Result Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `assessment_score` SET TAGS ('pii_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `completion_timestamp` SET TAGS ('pii_business_glossary_term' = 'Completion Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `delivery_method` SET TAGS ('pii_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `delivery_method` SET TAGS ('pii_value_regex' = 'eLearning|Instructor-led|Webinar');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `is_expired` SET TAGS ('pii_business_glossary_term' = 'Is Expired');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('pii_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `pass_fail_status` SET TAGS ('pii_value_regex' = 'Pass|Fail');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `recertification_required` SET TAGS ('pii_business_glossary_term' = 'Recertification Required');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `trainer_name` SET TAGS ('pii_business_glossary_term' = 'Trainer Full Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `trainer_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `trainer_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_hours` SET TAGS ('pii_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_location` SET TAGS ('pii_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_record_number` SET TAGS ('pii_business_glossary_term' = 'Training Record Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_record_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_record_status` SET TAGS ('pii_business_glossary_term' = 'Training Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_record_status` SET TAGS ('pii_value_regex' = 'Completed|In_Progress|Expired|Failed|Pending');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `training_type` SET TAGS ('pii_business_glossary_term' = 'Training Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_record` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` SET TAGS ('pii_subdomain' = 'compliance_access');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_assignment_id` SET TAGS ('pii_business_glossary_term' = 'RBAC Assignment Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `assignee_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `assignee_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `assignee_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_last_updated_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_last_updated_by_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_last_updated_by_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_role_id` SET TAGS ('pii_business_glossary_term' = 'Role Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_role_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_role_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `access_level` SET TAGS ('pii_business_glossary_term' = 'Access Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `access_level` SET TAGS ('pii_value_regex' = 'read|write|admin');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `access_reason_code` SET TAGS ('pii_business_glossary_term' = 'Access Reason Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `access_reason_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `access_scope` SET TAGS ('pii_business_glossary_term' = 'Access Scope Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `business_justification` SET TAGS ('pii_business_glossary_term' = 'Business Justification for Access');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `comments` SET TAGS ('pii_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `compliance_framework` SET TAGS ('pii_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `compliance_framework` SET TAGS ('pii_value_regex' = 'hipaa|soc2|none');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `is_temporary` SET TAGS ('pii_business_glossary_term' = 'Temporary Access Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_assignment_status` SET TAGS ('pii_business_glossary_term' = 'RBAC Assignment Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `rbac_assignment_status` SET TAGS ('pii_value_regex' = 'active|inactive|pending|revoked|expired');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `revocation_date` SET TAGS ('pii_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `risk_level` SET TAGS ('pii_business_glossary_term' = 'Access Risk Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `system_name` SET TAGS ('pii_business_glossary_term' = 'System or Application Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `system_resource` SET TAGS ('pii_hipaa_workforce_access' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` SET TAGS ('pii_subdomain' = 'talent_development');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` SET TAGS ('pii_fhir_resource' = 'InsurancePlan');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_plan_id` SET TAGS ('pii_business_glossary_term' = 'Workforce Headcount Plan ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Hiring Manager ID (HIRING_MGR_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_last_updated_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Updated By User ID (UPDATED_BY)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_last_updated_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_last_updated_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_requisition_requestor_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID (CREATED_BY)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_requisition_requestor_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_requisition_requestor_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `actual_headcount` SET TAGS ('pii_business_glossary_term' = 'Actual Headcount (ACTUAL_HEADCOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `application_deadline` SET TAGS ('pii_business_glossary_term' = 'Application Deadline (APP_DEADLINE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `approved_fte` SET TAGS ('pii_business_glossary_term' = 'Approved Full‑Time Equivalent (APPROVED_FTE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `budget_variance_amount` SET TAGS ('pii_business_glossary_term' = 'Budget Variance Amount (BUDGET_VAR_AMT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `budget_variance_percent` SET TAGS ('pii_business_glossary_term' = 'Budget Variance Percent (BUDGET_VAR_PCT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `budgeted_headcount` SET TAGS ('pii_business_glossary_term' = 'Budgeted Headcount (BUDGETED_HEADCOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `candidate_start_date` SET TAGS ('pii_business_glossary_term' = 'Candidate Start Date (START_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `compliance_review_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Review Status (COMPLIANCE_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `compliance_review_status` SET TAGS ('pii_value_regex' = 'pending|completed|exempt');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `contract_headcount` SET TAGS ('pii_business_glossary_term' = 'Contract/Contingent Headcount (CONTRACT_HEADCOUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code (COST_CENTER)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code (DEPT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `department_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `diversity_hiring_indicator` SET TAGS ('pii_business_glossary_term' = 'Diversity Hiring Indicator (DIV_HIRE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `filled_fte` SET TAGS ('pii_business_glossary_term' = 'Filled Full‑Time Equivalent (FILLED_FTE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `fiscal_year` SET TAGS ('pii_business_glossary_term' = 'Fiscal Year (FY)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `headcount_variance` SET TAGS ('pii_business_glossary_term' = 'Headcount Variance (HEADCOUNT_VAR)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `interview_stages_completed` SET TAGS ('pii_business_glossary_term' = 'Interview Stages Completed (INTERVIEW_STAGES)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `is_contractor` SET TAGS ('pii_business_glossary_term' = 'Contractor Indicator (IS_CONTRACTOR)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `job_posting_date` SET TAGS ('pii_business_glossary_term' = 'Job Posting Date (POST_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `number_of_applicants` SET TAGS ('pii_business_glossary_term' = 'Number of Applicants (APPLICANT_COUNT)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `offer_accepted_date` SET TAGS ('pii_business_glossary_term' = 'Offer Accepted Date (OFFER_ACC_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `offer_extended_date` SET TAGS ('pii_business_glossary_term' = 'Offer Extended Date (OFFER_EXT_DATE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Plan Created Timestamp (CREATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_identifier` SET TAGS ('pii_business_glossary_term' = 'Plan Identifier (PLAN_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Plan Status (PLAN_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|closed');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `plan_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Plan Updated Timestamp (UPDATED_TS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period` SET TAGS ('pii_business_glossary_term' = 'Planning Period (PERIOD)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `planning_period` SET TAGS ('pii_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `position_title` SET TAGS ('pii_business_glossary_term' = 'Position Title (POSITION_TITLE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `recruitment_cycle_code` SET TAGS ('pii_business_glossary_term' = 'Recruitment Cycle Code (RECRUIT_CYCLE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `recruitment_cycle_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `requisition_number` SET TAGS ('pii_business_glossary_term' = 'Requisition Number (REQ_NUM)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `requisition_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `requisition_status` SET TAGS ('pii_business_glossary_term' = 'Requisition Status (REQ_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `requisition_status` SET TAGS ('pii_value_regex' = 'open|closed|cancelled|on_hold');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `source_of_hire` SET TAGS ('pii_business_glossary_term' = 'Source of Hire (SOURCE_HIRE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `source_of_hire` SET TAGS ('pii_value_regex' = 'internal|referral|job_board|recruiter|agency|social_media');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `time_to_fill_days` SET TAGS ('pii_business_glossary_term' = 'Time to Fill (DAYS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`headcount_plan` ALTER COLUMN `vacant_fte` SET TAGS ('pii_business_glossary_term' = 'Vacant Full‑Time Equivalent (VACANT_FTE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` SET TAGS ('pii_subdomain' = 'compliance_access');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_id` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Action ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_manager_employee_id` SET TAGS ('pii_business_glossary_term' = 'Manager ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_manager_employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_manager_employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_quinary_disciplinary_updated_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_quinary_disciplinary_updated_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_quinary_disciplinary_updated_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `acknowledgment_status` SET TAGS ('pii_value_regex' = 'acknowledged|not_acknowledged|pending');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `acknowledgment_timestamp` SET TAGS ('pii_business_glossary_term' = 'Acknowledgment Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_date` SET TAGS ('pii_business_glossary_term' = 'Action Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Action Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Action Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('pii_value_regex' = 'verbal_warning|written_warning|performance_improvement_plan|suspension|termination');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_deadline` SET TAGS ('pii_business_glossary_term' = 'Appeal Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_business_glossary_term' = 'Appeal Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_outcome` SET TAGS ('pii_value_regex' = 'upheld|overturned|modified|withdrawn');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_status` SET TAGS ('pii_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `appeal_status` SET TAGS ('pii_value_regex' = 'none|filed|under_review|resolved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_category` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Action Category');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_category` SET TAGS ('pii_value_regex' = 'performance|conduct|attendance|safety|policy');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `confidentiality_level` SET TAGS ('pii_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|EUR|GBP|CAD|JPY');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_status` SET TAGS ('pii_business_glossary_term' = 'Disciplinary Action Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_status` SET TAGS ('pii_value_regex' = 'open|closed|in_progress|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `documentation_attached` SET TAGS ('pii_business_glossary_term' = 'Documentation Attached Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `duration_days` SET TAGS ('pii_business_glossary_term' = 'Duration (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `incident_description` SET TAGS ('pii_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `is_repeat_offense` SET TAGS ('pii_business_glossary_term' = 'Repeat Offense Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `penalty_amount` SET TAGS ('pii_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `penalty_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `penalty_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `policy_violated` SET TAGS ('pii_business_glossary_term' = 'Policy Violated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `prior_action_count` SET TAGS ('pii_business_glossary_term' = 'Prior Action Count');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `record_status` SET TAGS ('pii_value_regex' = 'active|inactive|archived');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_end_date` SET TAGS ('pii_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_subdomain' = 'compliance_access');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_redundant_naming_flag' = 'compliance.compliance_event');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_cross_domain_naming_note' = 'workforce_compliance_event_distinct_from_compliance_domain');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_redundant_concept' = 'compliance_event');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_duplicate_concept' = 'compliance_event_cross_domain');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_workforce_compliance_tracker' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_ssot_compliance_event' = 'workforce');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` SET TAGS ('pii_ssot_resolution' = 'no_conflict');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `compliance_event_id` SET TAGS ('pii_business_glossary_term' = 'Workforce Compliance Event ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `background_check_id` SET TAGS ('pii_business_glossary_term' = 'Background Check Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `compliance_event_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Event Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `compliance_event_status` SET TAGS ('pii_value_regex' = 'pending|in_progress|completed|waived|closed');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `compliance_outcome` SET TAGS ('pii_business_glossary_term' = 'Compliance Outcome');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `compliance_outcome` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending|waived');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `due_date` SET TAGS ('pii_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `event_number` SET TAGS ('pii_business_glossary_term' = 'Event Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `event_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `event_timestamp` SET TAGS ('pii_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `event_type` SET TAGS ('pii_business_glossary_term' = 'Event Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `event_type` SET TAGS ('pii_value_regex' = 'hipaa_training|background_screening|i9_verification|annual_attestation|conflict_of_interest|mandatory_reporting');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `order_date` SET TAGS ('pii_business_glossary_term' = 'Screening Order Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `remediation_action` SET TAGS ('pii_business_glossary_term' = 'Remediation Action');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `responsible_party` SET TAGS ('pii_business_glossary_term' = 'Responsible Party');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compliance_event` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` SET TAGS ('pii_subdomain' = 'compliance_access');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_check_id` SET TAGS ('pii_business_glossary_term' = 'Background Check ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_initiator_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_initiator_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_initiator_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_last_updated_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_last_updated_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_last_updated_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Screening Vendor ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `adjudication_decision` SET TAGS ('pii_business_glossary_term' = 'Adjudication Decision');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `adjudication_decision` SET TAGS ('pii_value_regex' = 'no_action|termination|reassignment|warning');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `adverse_action_reason` SET TAGS ('pii_business_glossary_term' = 'Adverse Action Reason');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_check_status` SET TAGS ('pii_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `background_check_status` SET TAGS ('pii_value_regex' = 'ordered|in_progress|completed|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `check_number` SET TAGS ('pii_business_glossary_term' = 'Background Check Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `check_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `completion_timestamp` SET TAGS ('pii_business_glossary_term' = 'Screening Completion Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `cost_amount` SET TAGS ('pii_business_glossary_term' = 'Screening Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `cost_currency_code` SET TAGS ('pii_business_glossary_term' = 'Screening Cost Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `cost_currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `is_federal_program_access` SET TAGS ('pii_business_glossary_term' = 'Federal Program Access Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `is_oig_exclusion_flag` SET TAGS ('pii_business_glossary_term' = 'OIG Exclusion Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `is_oig_exclusion_required` SET TAGS ('pii_business_glossary_term' = 'OIG Exclusion Required Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Background Check Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `order_timestamp` SET TAGS ('pii_business_glossary_term' = 'Screening Order Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `result` SET TAGS ('pii_business_glossary_term' = 'Screening Result');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `result` SET TAGS ('pii_value_regex' = 'clear|flagged|adverse');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `screening_type` SET TAGS ('pii_business_glossary_term' = 'Screening Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `screening_type` SET TAGS ('pii_value_regex' = 'criminal|oig_exclusion|sam_debarment|credit|education|employment');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`background_check` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` SET TAGS ('pii_subdomain' = 'compliance_access');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_and_attendance_id` SET TAGS ('pii_business_glossary_term' = 'Time and Attendance Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Identifier (EMP_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `absence_code` SET TAGS ('pii_business_glossary_term' = 'Absence Code (ABS_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `absence_code` SET TAGS ('pii_value_regex' = 'VAC|SICK|FMLA|ADA|UNPAID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `absence_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `absence_reason` SET TAGS ('pii_business_glossary_term' = 'Absence Reason');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `clock_in_timestamp` SET TAGS ('pii_business_glossary_term' = 'Clock‑In Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `clock_out_timestamp` SET TAGS ('pii_business_glossary_term' = 'Clock‑Out Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code (CC_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code (DEPT_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `department_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `flsa_compliance` SET TAGS ('pii_business_glossary_term' = 'FLSA Compliance Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('pii_business_glossary_term' = 'Gross Pay Amount (GROSS_PAY)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `holiday_hours` SET TAGS ('pii_business_glossary_term' = 'Holiday Hours (HOL_HRS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `job_role_code` SET TAGS ('pii_business_glossary_term' = 'Job Role Code (ROLE_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `job_role_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Work Location Code (LOC_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `location_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `manager_approval_status` SET TAGS ('pii_business_glossary_term' = 'Manager Approval Status (MGR_APPR_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `manager_approval_status` SET TAGS ('pii_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `manager_approval_timestamp` SET TAGS ('pii_business_glossary_term' = 'Manager Approval Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('pii_business_glossary_term' = 'Net Pay Amount (NET_PAY)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `overtime_eligibility` SET TAGS ('pii_business_glossary_term' = 'Overtime Eligibility Flag');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `overtime_hours` SET TAGS ('pii_business_glossary_term' = 'Overtime Hours (OT_HRS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `pay_period_code` SET TAGS ('pii_business_glossary_term' = 'Pay Period Code (PPC)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `pay_period_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `payroll_integration_status` SET TAGS ('pii_business_glossary_term' = 'Payroll Integration Status (PAY_INT_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `payroll_integration_status` SET TAGS ('pii_value_regex' = 'pending|integrated|failed');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `payroll_processed_timestamp` SET TAGS ('pii_business_glossary_term' = 'Payroll Processed Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `period_end_date` SET TAGS ('pii_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `period_start_date` SET TAGS ('pii_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `pto_used_hours` SET TAGS ('pii_business_glossary_term' = 'Paid Time Off Used Hours (PTO_HRS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `regular_hours` SET TAGS ('pii_business_glossary_term' = 'Regular Hours (REG_HRS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `shift_code` SET TAGS ('pii_business_glossary_term' = 'Shift Code (SHIFT_CODE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `shift_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `shift_differential_hours` SET TAGS ('pii_business_glossary_term' = 'Shift Differential Hours (SD_HRS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `sick_hours_used` SET TAGS ('pii_business_glossary_term' = 'Sick Leave Hours Used');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `submission_timestamp` SET TAGS ('pii_business_glossary_term' = 'Timesheet Submission Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `tax_amount` SET TAGS ('pii_business_glossary_term' = 'Tax Withholding Amount (TAX_WTHLD)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_and_attendance_status` SET TAGS ('pii_business_glossary_term' = 'Timesheet Status (TS_STATUS)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_and_attendance_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_device_code` SET TAGS ('pii_business_glossary_term' = 'Time Entry Device Identifier (DEV_ID)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_device_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_device_code` SET TAGS ('pii_device' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_device_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_error_code` SET TAGS ('pii_business_glossary_term' = 'Time Entry Error Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_error_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_method` SET TAGS ('pii_business_glossary_term' = 'Time Entry Method (ENTRY_METHOD)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_method` SET TAGS ('pii_value_regex' = 'clock_in|clock_out|manual');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_source` SET TAGS ('pii_business_glossary_term' = 'Time Entry Source (ENTRY_SRC)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_source` SET TAGS ('pii_value_regex' = 'badge|web|mobile|biometric');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_type` SET TAGS ('pii_business_glossary_term' = 'Time Entry Type (ENTRY_TYPE)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `time_entry_type` SET TAGS ('pii_value_regex' = 'regular|overtime|pto|holiday|sick');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `timesheet_number` SET TAGS ('pii_business_glossary_term' = 'Timesheet Number (TSN)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `timesheet_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `total_hours_worked` SET TAGS ('pii_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`time_and_attendance` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` SET TAGS ('pii_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` SET TAGS ('pii_fhir_resource' = 'InsurancePlan');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('pii_business_glossary_term' = 'Compensation Plan Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `parent_compensation_plan_id` SET TAGS ('pii_business_glossary_term' = 'Parent Compensation Plan Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `parent_compensation_plan_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `parent_compensation_plan_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `parent_compensation_plan_id` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `base_amount` SET TAGS ('pii_business_glossary_term' = 'Base Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `benefit_plan_name` SET TAGS ('pii_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_amount` SET TAGS ('pii_business_glossary_term' = 'Bonus Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `commission_rate` SET TAGS ('pii_business_glossary_term' = 'Commission Rate');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `currency` SET TAGS ('pii_business_glossary_term' = 'Currency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `equity_type` SET TAGS ('pii_business_glossary_term' = 'Equity Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `equity_units` SET TAGS ('pii_business_glossary_term' = 'Equity Units');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_category` SET TAGS ('pii_business_glossary_term' = 'Plan Category');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('pii_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_description` SET TAGS ('pii_business_glossary_term' = 'Plan Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_document_checksum` SET TAGS ('pii_business_glossary_term' = 'Plan Document Checksum');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_document_created_at` SET TAGS ('pii_business_glossary_term' = 'Plan Document Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_document_format` SET TAGS ('pii_business_glossary_term' = 'Plan Document Format');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_document_language` SET TAGS ('pii_business_glossary_term' = 'Plan Document Language');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_document_language_code` SET TAGS ('pii_business_glossary_term' = 'Plan Document Language Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_document_language_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_document_size` SET TAGS ('pii_business_glossary_term' = 'Plan Document Size');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_document_status` SET TAGS ('pii_business_glossary_term' = 'Plan Document Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_document_type` SET TAGS ('pii_business_glossary_term' = 'Plan Document Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_document_updated_at` SET TAGS ('pii_business_glossary_term' = 'Plan Document Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_document_url` SET TAGS ('pii_business_glossary_term' = 'Plan Document Url');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_document_version` SET TAGS ('pii_business_glossary_term' = 'Plan Document Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_notes` SET TAGS ('pii_business_glossary_term' = 'Plan Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_version` SET TAGS ('pii_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `termination_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `variable_amount` SET TAGS ('pii_business_glossary_term' = 'Variable Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`compensation_plan` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` SET TAGS ('pii_subdomain' = 'compliance_access');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `rbac_role_id` SET TAGS ('pii_business_glossary_term' = 'Rbac Role Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `parent_rbac_role_id` SET TAGS ('pii_business_glossary_term' = 'Parent Rbac Role Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `parent_rbac_role_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_code` SET TAGS ('pii_business_glossary_term' = 'Role Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_description` SET TAGS ('pii_business_glossary_term' = 'Role Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_group` SET TAGS ('pii_business_glossary_term' = 'Role Group');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_active` SET TAGS ('pii_business_glossary_term' = 'Role Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_archived` SET TAGS ('pii_business_glossary_term' = 'Role Is Archived');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_current` SET TAGS ('pii_business_glossary_term' = 'Role Is Current');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_default` SET TAGS ('pii_business_glossary_term' = 'Role Is Default');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_deleted` SET TAGS ('pii_business_glossary_term' = 'Role Is Deleted');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_external` SET TAGS ('pii_business_glossary_term' = 'Role Is External');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_internal` SET TAGS ('pii_business_glossary_term' = 'Role Is Internal');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_legacy` SET TAGS ('pii_business_glossary_term' = 'Role Is Legacy');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_persistent` SET TAGS ('pii_business_glossary_term' = 'Role Is Persistent');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_retired` SET TAGS ('pii_business_glossary_term' = 'Role Is Retired');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_revoked` SET TAGS ('pii_business_glossary_term' = 'Role Is Revoked');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_system` SET TAGS ('pii_business_glossary_term' = 'Role Is System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_temporary` SET TAGS ('pii_business_glossary_term' = 'Role Is Temporary');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_is_transient` SET TAGS ('pii_business_glossary_term' = 'Role Is Transient');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_level` SET TAGS ('pii_business_glossary_term' = 'Role Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_name` SET TAGS ('pii_business_glossary_term' = 'Role Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_revocation_by` SET TAGS ('pii_business_glossary_term' = 'Role Revocation By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_revocation_created_at` SET TAGS ('pii_business_glossary_term' = 'Role Revocation Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_revocation_created_by` SET TAGS ('pii_business_glossary_term' = 'Role Revocation Created By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_revocation_date` SET TAGS ('pii_business_glossary_term' = 'Role Revocation Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_revocation_effective_from` SET TAGS ('pii_business_glossary_term' = 'Role Revocation Effective From');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_revocation_effective_until` SET TAGS ('pii_business_glossary_term' = 'Role Revocation Effective Until');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_revocation_notes` SET TAGS ('pii_business_glossary_term' = 'Role Revocation Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_revocation_reason` SET TAGS ('pii_business_glossary_term' = 'Role Revocation Reason');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_revocation_status` SET TAGS ('pii_business_glossary_term' = 'Role Revocation Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_revocation_updated_at` SET TAGS ('pii_business_glossary_term' = 'Role Revocation Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_revocation_updated_by` SET TAGS ('pii_business_glossary_term' = 'Role Revocation Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_scope` SET TAGS ('pii_business_glossary_term' = 'Role Scope');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_scope_type` SET TAGS ('pii_business_glossary_term' = 'Role Scope Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_status` SET TAGS ('pii_business_glossary_term' = 'Role Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `role_type` SET TAGS ('pii_business_glossary_term' = 'Role Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `updated_by` SET TAGS ('pii_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`rbac_role` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` SET TAGS ('pii_subdomain' = 'talent_development');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('pii_business_glossary_term' = 'Training Course Identifier');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `parent_training_course_id` SET TAGS ('pii_business_glossary_term' = 'Parent Training Course Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `parent_training_course_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_last_updated_by_employee_id` SET TAGS ('pii_business_glossary_term' = 'Training Course Updated By User Employee Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_last_updated_by_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_last_updated_by_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `certification_awarded` SET TAGS ('pii_business_glossary_term' = 'Training Course Certification Awarded');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `certification_validity_end` SET TAGS ('pii_business_glossary_term' = 'Training Course Certification Validity End');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `certification_validity_start` SET TAGS ('pii_business_glossary_term' = 'Training Course Certification Validity Start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_code` SET TAGS ('pii_business_glossary_term' = 'Training Course Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `compliance_due_date` SET TAGS ('pii_business_glossary_term' = 'Training Course Compliance Due Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Training Course Compliance Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `cost` SET TAGS ('pii_business_glossary_term' = 'Training Course Cost');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `cost_center` SET TAGS ('pii_business_glossary_term' = 'Training Course Cost Center');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `cost_currency` SET TAGS ('pii_business_glossary_term' = 'Training Course Cost Currency');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `created_at` SET TAGS ('pii_business_glossary_term' = 'Training Course Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `delivery_mode` SET TAGS ('pii_business_glossary_term' = 'Training Course Delivery Mode');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_description` SET TAGS ('pii_business_glossary_term' = 'Training Course Description');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('pii_business_glossary_term' = 'Training Course Duration Hours');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Training Course End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `format` SET TAGS ('pii_business_glossary_term' = 'Training Course Format');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('pii_business_glossary_term' = 'Training Course Language');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `learning_objectives` SET TAGS ('pii_business_glossary_term' = 'Training Course Learning Objectives');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_name` SET TAGS ('pii_business_glossary_term' = 'Training Course Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `prerequisites` SET TAGS ('pii_business_glossary_term' = 'Training Course Prerequisites');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `provider_address` SET TAGS ('pii_business_glossary_term' = 'Training Course Provider Address');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `provider_address` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `provider_address` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `provider_email` SET TAGS ('pii_business_glossary_term' = 'Training Course Provider Email');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `provider_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `provider_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `provider_name` SET TAGS ('pii_business_glossary_term' = 'Training Course Provider Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `provider_phone` SET TAGS ('pii_business_glossary_term' = 'Training Course Provider Phone');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `provider_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `provider_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `required_by` SET TAGS ('pii_business_glossary_term' = 'Training Course Required By');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Training Course Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_status` SET TAGS ('pii_business_glossary_term' = 'Training Course Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_type` SET TAGS ('pii_business_glossary_term' = 'Training Course Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `updated_at` SET TAGS ('pii_business_glossary_term' = 'Training Course Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`training_course` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` SET TAGS ('pii_subdomain' = 'talent_development');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `workforce_certification2_id` SET TAGS ('pii_business_glossary_term' = 'Workforce Certification ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `employee_id` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `employee_id` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `certification_category` SET TAGS ('pii_business_glossary_term' = 'Certification Category');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `certification_category` SET TAGS ('pii_value_regex' = 'license|credential|certificate|accreditation');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `certification_code` SET TAGS ('pii_business_glossary_term' = 'Certification Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `certification_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `certification_name` SET TAGS ('pii_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `certification_number` SET TAGS ('pii_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `certification_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `certification_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `certification_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `certification_type` SET TAGS ('pii_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `certification_type` SET TAGS ('pii_value_regex' = 'clinical|compliance|it|insurance_license|other');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `cost_amount` SET TAGS ('pii_business_glossary_term' = 'Certification Cost Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `effective_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `is_mandatory` SET TAGS ('pii_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `issuing_organization` SET TAGS ('pii_business_glossary_term' = 'Issuing Organization');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `renewal_cycle_months` SET TAGS ('pii_business_glossary_term' = 'Renewal Cycle (Months)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `renewal_date` SET TAGS ('pii_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `renewal_required` SET TAGS ('pii_business_glossary_term' = 'Renewal Required');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `renewal_status` SET TAGS ('pii_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `renewal_status` SET TAGS ('pii_value_regex' = 'pending|completed|not_required|overdue');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `required_for_role` SET TAGS ('pii_business_glossary_term' = 'Required For Role');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'verified|unverified|pending');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `workforce_certification_status` SET TAGS ('pii_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification2` ALTER COLUMN `workforce_certification_status` SET TAGS ('pii_value_regex' = 'active|expired|revoked|suspended|pending');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` SET TAGS ('pii_subdomain' = 'talent_development');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` SET TAGS ('pii_fhir_ready' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` SET TAGS ('pii_fhir_resource' = 'Basic');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` SET TAGS ('pii_ecm' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` SET TAGS ('pii_ssot' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` SET TAGS ('pii_fhir_interop' = 'ready');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` SET TAGS ('pii_authority_source' = 'verbatim_reviewer_comments_working_group_sheet');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` SET TAGS ('pii_subdomain_reviewed' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `workforce_recruitment_id` SET TAGS ('pii_business_glossary_term' = 'Workforce Recruitment Record ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `headcount_plan_id` SET TAGS ('pii_business_glossary_term' = 'Headcount Plan Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `job_role_id` SET TAGS ('pii_business_glossary_term' = 'Job Role Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `position_id` SET TAGS ('pii_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `employee_id` SET TAGS ('pii_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `recruitment_quaternary_workforce_updated_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Updated By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `recruitment_quaternary_workforce_updated_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `recruitment_quaternary_workforce_updated_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `tertiary_workforce_created_by_user_employee_id` SET TAGS ('pii_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `tertiary_workforce_created_by_user_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `tertiary_workforce_created_by_user_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `application_deadline` SET TAGS ('pii_business_glossary_term' = 'Application Deadline');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `candidate_start_date` SET TAGS ('pii_business_glossary_term' = 'Candidate Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `compensation_type` SET TAGS ('pii_business_glossary_term' = 'Compensation Type');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `compensation_type` SET TAGS ('pii_value_regex' = 'salary|hourly|contract');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `compensation_type` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `compensation_type` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `cost_center_code` SET TAGS ('pii_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `cost_center_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `currency_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `data_quality_score` SET TAGS ('pii_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `department_code` SET TAGS ('pii_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `department_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `effective_end_date` SET TAGS ('pii_fhir_element' = 'period.end');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `effective_start_date` SET TAGS ('pii_fhir_element' = 'period.start');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `fhir_last_updated` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `fhir_profile_url` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `fhir_resource_identifier` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `fhir_resource_type` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `fhir_version` SET TAGS ('pii_business_glossary_term' = 'FHIR Interoperability');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `fhir_version` SET TAGS ('pii_interop' = 'fhir');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `interview_stage_completed` SET TAGS ('pii_business_glossary_term' = 'Interview Stage Completed');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `interview_stage_completed` SET TAGS ('pii_value_regex' = 'screen|phone|onsite|final|offer');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `is_active` SET TAGS ('pii_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `is_remote` SET TAGS ('pii_business_glossary_term' = 'Remote Work Indicator');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `job_level` SET TAGS ('pii_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `job_posting_date` SET TAGS ('pii_business_glossary_term' = 'Job Posting Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `location_code` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `master_entity_code` SET TAGS ('pii_business_glossary_term' = 'Master Entity Id');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `net_salary_amount` SET TAGS ('pii_business_glossary_term' = 'Net Salary Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `net_salary_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `net_salary_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Recruitment Notes');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `number_of_applicants` SET TAGS ('pii_business_glossary_term' = 'Number of Applicants');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `offer_accepted_date` SET TAGS ('pii_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `offer_extended_date` SET TAGS ('pii_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `record_created_at` SET TAGS ('pii_business_glossary_term' = 'Record Created At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `record_source_system` SET TAGS ('pii_business_glossary_term' = 'Record Source System');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `record_status` SET TAGS ('pii_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `record_status` SET TAGS ('pii_governance' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `record_updated_at` SET TAGS ('pii_business_glossary_term' = 'Record Updated At');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `requisition_number` SET TAGS ('pii_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `requisition_number` SET TAGS ('pii_denormalized_natural_key' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `requisition_status` SET TAGS ('pii_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `requisition_status` SET TAGS ('pii_value_regex' = 'open|on_hold|filled|cancelled');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('pii_business_glossary_term' = 'Salary Adjustment Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `salary_adjustment_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `salary_offer_amount` SET TAGS ('pii_business_glossary_term' = 'Salary Offer Amount');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `salary_offer_amount` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `salary_offer_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `source_of_hire` SET TAGS ('pii_business_glossary_term' = 'Source of Hire');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `source_of_hire` SET TAGS ('pii_value_regex' = 'internal|referral|job_board|recruiter|agency|social_media');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `time_to_fill_days` SET TAGS ('pii_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_recruitment` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_fhir_element' = 'meta.lastUpdated');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_health_insurance_v1`.`workforce`.`workforce_certification` SET TAGS ('pii_subdomain' = 'talent_development');
