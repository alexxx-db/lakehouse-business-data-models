-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 14:11:23

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`workforce` COMMENT 'Healthcare workforce and human capital management. Owns employees, physicians, contract staff, FTE (Full-Time Equivalent) tracking, credentialing, privileging, competency assessments, CME (Continuing Medical Education), shift scheduling, time and attendance, payroll, benefits, talent management, and OSHA compliance. Integrates with Workday HCM and Symplr credentialing.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique surrogate identifier for each workforce member record in the Healthcare data lakehouse. Primary key for the employee master record.',
    `care_site_id` BIGINT COMMENT 'Identifier of the primary facility (hospital, clinic, outpatient center) where the workforce member is assigned. For contingent workers, this is the contracted facility assignment.',
    `clinician_id` BIGINT COMMENT 'The 10-digit National Provider Identifier (NPI) assigned by CMS for clinical workforce members who are licensed providers. Null for non-clinical or non-licensed staff.',
    `manager_employee_id` BIGINT COMMENT 'Employee ID of the direct supervisor or manager for this workforce member. Supports organizational hierarchy traversal, performance management workflows, and approval routing in Workday HCM.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Employee should link to their current position assignment. This is a fundamental workforce relationship - every employee holds a position. Adding position_id enables retrieval of position details (FTE',
    `specialty_id` BIGINT COMMENT 'add column provider_specialty_id (BIGINT) with FK to provider.specialty.specialty_id - employees who are clinical staff need specialty tracking for scheduling and competency but employee lacks this link',
    `background_check_status` STRING COMMENT 'Status of the pre-employment and periodic background check for the workforce member. Required by Joint Commission and state regulations for all healthcare workers with patient contact.. Valid values are `cleared|pending|failed|not_required`',
    `bill_rate` DECIMAL(18,2) COMMENT 'Hourly bill rate charged by the staffing agency for a contingent workforce member. Used for contract cost management and budget variance analysis. Null for direct employees.',
    `clinical_role_type` STRING COMMENT 'Specific clinical role classification for clinical workforce members (e.g., Registered Nurse, Physician, Pharmacist, Radiologic Technologist, Medical Assistant). Null for non-clinical staff. Used for staffing ratio compliance and scope-of-practice enforcement. [ENUM-REF-CANDIDATE: physician|registered_nurse|licensed_practical_nurse|pharmacist|radiologic_technologist|medical_assistant|respiratory_therapist|physical_therapist|occupational_therapist|social_worker — promote to reference product]',
    `cme_hours_completed` DECIMAL(18,2) COMMENT 'Total Continuing Medical Education (CME) hours completed by the workforce member in the current compliance cycle. Tracked in Workday HCM Learning and Symplr.',
    `cme_hours_required` DECIMAL(18,2) COMMENT 'Total Continuing Medical Education (CME) hours required per compliance cycle for this workforce member based on their role, specialty, and state licensing requirements.',
    `contract_end_date` DATE COMMENT 'End date of the staffing contract for contingent workers. Triggers renewal workflow or offboarding. Null for direct employees.',
    `contract_start_date` DATE COMMENT 'Start date of the staffing contract for contingent workers (travel nurses, locum tenens, agency staff). Null for direct employees. Used for contract lifecycle management and scheduling.',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which the workforce members labor costs are allocated. Integrates with SAP S/4HANA FI/CO for labor cost accounting and budget variance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee master record was first created in the Healthcare data lakehouse. Supports audit trail, data lineage, and HIPAA audit log requirements.',
    `credential_verification_status` STRING COMMENT 'Current status of primary credential verification through Symplr or primary source verification. Drives privileging decisions and scheduling eligibility for clinical staff.. Valid values are `verified|pending|expired|failed|not_applicable`',
    `date_of_birth` DATE COMMENT 'Date of birth of the workforce member. Required for benefits eligibility determination, age-based compliance checks, and identity verification.',
    `department_code` STRING COMMENT 'Organizational department code to which the workforce member is primarily assigned (e.g., ICU, ED, Pharmacy, Radiology). Sourced from Workday HCM organizational hierarchy.',
    `employment_status` STRING COMMENT 'Current lifecycle status of the workforce members employment relationship with the organization. Drives access provisioning, payroll processing, and scheduling eligibility.. Valid values are `active|on_leave|terminated|retired|suspended`',
    `employment_type` STRING COMMENT 'Classification of the workforce members employment arrangement. Full-time and part-time are direct employees; PRN (pro re nata/as needed) are on-call staff; contract includes locum tenens and travel nurses; contingent includes agency and per diem staff.. Valid values are `full_time|part_time|prn|contract|contingent`',
    `first_name` STRING COMMENT 'Legal given (first) name of the workforce member as recorded in Workday HCM and used for identity verification, payroll, and HR documentation.',
    `flsa_classification` STRING COMMENT 'Indicates whether the workforce member is classified as exempt or non-exempt under the Fair Labor Standards Act (FLSA). Determines overtime eligibility and payroll processing rules.. Valid values are `exempt|non_exempt`',
    `fte_value` DECIMAL(18,2) COMMENT 'The Full-Time Equivalent (FTE) value representing the proportion of a full-time schedule this workforce member is budgeted for (e.g., 1.0 = full-time, 0.5 = half-time, 0.2 = PRN). Critical for workforce planning, staffing ratios, and budget management.',
    `gender` STRING COMMENT 'Self-reported gender identity of the workforce member. Used for EEO reporting, benefits administration, and workforce diversity analytics.. Valid values are `male|female|non_binary|undisclosed`',
    `hire_date` DATE COMMENT 'The official date on which the workforce member was hired or onboarded by the organization. Used for tenure calculations, benefits eligibility, and regulatory reporting.',
    `last_name` STRING COMMENT 'Legal family (last) name of the workforce member as recorded in Workday HCM and used for identity verification, payroll, and HR documentation.',
    `license_expiration_date` DATE COMMENT 'Expiration date of the workforce members primary professional license. Triggers automated renewal alerts in Symplr credentialing. Expired licenses result in scheduling ineligibility.',
    `license_number` STRING COMMENT 'Primary professional license number issued by the state licensing board (e.g., RN license, MD license, PharmD license). Used for credentialing verification and regulatory compliance.',
    `license_state` STRING COMMENT 'Two-letter US state code for the primary professional license held by the workforce member. Used for scope-of-practice enforcement, telehealth eligibility, and regulatory compliance.. Valid values are `^[A-Z]{2}$`',
    `middle_name` STRING COMMENT 'Legal middle name or initial of the workforce member. Used for disambiguation in the Master Patient Index (MPI) and credentialing records.',
    `oig_exclusion_check_date` DATE COMMENT 'Date of the most recent OIG List of Excluded Individuals and Entities (LEIE) screening for this workforce member. Supports monthly compliance verification required by CMS.',
    `oig_exclusion_checked` BOOLEAN COMMENT 'Indicates whether the workforce member has been screened against the OIG List of Excluded Individuals and Entities (LEIE). Required for all employees involved in federally funded healthcare programs (Medicare, Medicaid). Must be checked at hire and monthly thereafter.',
    `original_hire_date` DATE COMMENT 'The original hire date for rehired employees, preserving continuous service credit for benefits, seniority, and retirement vesting calculations. Distinct from hire_date for rehires.',
    `osha_training_current` BOOLEAN COMMENT 'Indicates whether the workforce member has completed all required OSHA workplace safety training (bloodborne pathogens, hazard communication, fire safety) within the required compliance period.',
    `pay_rate` DECIMAL(18,2) COMMENT 'Hourly pay rate paid directly to the contingent workforce member or to the staffing agency. Used for labor cost accounting and contract compliance. Null for salaried direct employees.',
    `personal_email` STRING COMMENT 'Personal (non-institutional) email address for the workforce member. Used for benefit enrollment communications, emergency contact, and off-boarding notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `preferred_name` STRING COMMENT 'The name the workforce member prefers to be called in day-to-day operations, displayed on badges and scheduling systems. May differ from legal name.',
    `primary_specialty` STRING COMMENT 'Primary clinical specialty of the workforce member (e.g., Emergency Medicine, Cardiology, Oncology). Applicable to physicians and advanced practice providers. Used for scheduling, credentialing, and network adequacy reporting.',
    `rehire_eligible` BOOLEAN COMMENT 'Indicates whether a terminated workforce member is eligible for rehire. Set during offboarding based on performance history, termination reason, and compliance review.',
    `staffing_agency_name` STRING COMMENT 'Name of the external staffing agency supplying the contingent workforce member (travel nurse, locum tenens, per diem, agency staff). Null for direct employees.',
    `termination_date` DATE COMMENT 'The date on which the workforce members employment was terminated, resigned, or retired. Null for active employees. Triggers access revocation, final pay processing, and COBRA notifications.',
    `termination_reason` STRING COMMENT 'Reason code for the workforce members separation from the organization. Used for turnover analytics, exit interview tracking, and unemployment claims processing.. Valid values are `voluntary_resignation|involuntary_termination|retirement|end_of_contract|deceased`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employee master record in the Healthcare data lakehouse. Used for change data capture (CDC), ETL processing, and audit compliance.',
    `work_email` STRING COMMENT 'Primary institutional email address assigned to the workforce member. Used for system access, scheduling notifications, and HR communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_phone` STRING COMMENT 'Primary work telephone number for the workforce member, including direct lines and extensions. Used for scheduling, on-call coordination, and HR communications.. Valid values are `^+?[0-9-s().]{7,20}$`',
    `workday_worker_code` STRING COMMENT 'The native worker identifier assigned by Workday HCM Core HR module. Used for system-of-record integration and cross-system reconciliation between the lakehouse and Workday.',
    `worker_category` STRING COMMENT 'Broad categorization of the workforce members role type. Clinical includes physicians, nurses, and allied health; administrative includes billing and coding staff; support includes environmental services and food services; research includes clinical trial staff; contingent includes travel nurses, locum tenens, and agency staff.. Valid values are `clinical|administrative|support|research|contingent`',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for all healthcare workforce members including clinical staff (physicians, nurses, allied health), administrative, support personnel, and contingent workers (travel nurses, locum tenens, per diem, agency staff). SSOT for workforce identity, employment status, FTE classification, job title, department assignment, hire/termination dates, employment type (full-time, part-time, PRN, contract, contingent), FLSA classification, and Workday HCM worker ID. For contingent workers: staffing agency, contract start/end dates, bill/pay rates, contracted role, facility assignment, credential verification status, and contract renewal terms. Integrates with Workday HCM Core HR module.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique surrogate identifier for an authorized organizational position (headcount slot) within the healthcare enterprise. Primary key for the position data product. Role: MASTER_RESOURCE.',
    `care_site_id` BIGINT COMMENT 'Identifier of the physical facility or campus where this position is based (e.g., Main Hospital, Outpatient Clinic, Ambulatory Surgery Center). Supports multi-site workforce planning and regulatory staffing ratio reporting.',
    `job_profile_id` BIGINT COMMENT 'FK to workforce.job_profile',
    `org_unit_id` BIGINT COMMENT 'FK to workforce.org_unit',
    `position_supervisory_org_workforce_org_unit_id` BIGINT COMMENT 'Identifier of the Workday HCM supervisory organization (management hierarchy node) to which this position belongs. Defines the reporting structure and managerial accountability for the position.',
    `position_workforce_org_unit_id` BIGINT COMMENT 'Identifier of the organizational department to which this position is assigned (e.g., ICU Nursing, Emergency Medicine, Pharmacy, Radiology). Used for departmental headcount reporting and workforce planning.',
    `npi_registry_id` BIGINT COMMENT 'Foreign key linking to reference.npi_registry. Business justification: Provider positions may have organizational NPIs for group practice billing under Tax ID. Real-world: group NPI on CMS-1500 box 33, organizational credentialing applications, Medicare enrollment. Suppo',
    `reports_to_position_id` BIGINT COMMENT 'Self-referencing identifier of the parent position to which this position reports in the organizational hierarchy. Enables construction of the position reporting chain for org chart and span-of-control analytics.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual (e.g., VP of Human Resources, CFO, Department Director) who authorized the creation or modification of this position. Used for governance and audit trail purposes.',
    `approved_date` DATE COMMENT 'Date on which this position was formally approved by the authorized budget or workforce planning authority. Used for audit trail and governance compliance.',
    `budgeted_fte` DECIMAL(18,2) COMMENT 'Approved budgeted FTE value for this position as authorized in the annual workforce budget. May differ from fte_allocation when positions are partially funded or shared across cost centers. Used for variance analysis between budgeted and actual FTE.',
    `cme_hours_required` DECIMAL(18,2) COMMENT 'Annual Continuing Medical Education (CME) or Continuing Education (CE) hours required for incumbents in this position to maintain licensure and competency. Used for CME tracking and compliance reporting in Workday Learning.',
    `position_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the position within Workday HCM and downstream systems (e.g., RN-ICU-001, MD-CARD-003). Used for cross-system integration and workforce reporting. Serves as the BUSINESS_IDENTIFIER for this MASTER_RESOURCE entity.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which the salary and benefits expense for this position is charged. Aligns with SAP S/4HANA CO module for financial reporting and FTE budget management.. Valid values are `^[A-Z0-9-]{3,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was first created in the data platform. Serves as the RECORD_AUDIT_CREATED field for this MASTER_RESOURCE entity. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per enterprise convention.',
    `effective_date` DATE COMMENT 'Date on which this position became authorized and effective within the organizational structure. Marks the start of the positions lifecycle for workforce planning and budget tracking purposes.',
    `employment_category` STRING COMMENT 'Standard employment category indicating the scheduled hours commitment for this position. PRN (Pro Re Nata) indicates as-needed staffing common in healthcare. Used for benefits eligibility determination and staffing ratio calculations.. Valid values are `full_time|part_time|prn|casual`',
    `end_date` DATE COMMENT 'Date on which this position is scheduled to be eliminated or closed. Null for ongoing positions. Used for workforce planning, budget forecasting, and headcount reconciliation.',
    `flsa_classification` STRING COMMENT 'Fair Labor Standards Act (FLSA) overtime exemption classification for this position. Determines eligibility for overtime pay. Exempt positions are salaried and not eligible for overtime; non_exempt positions are eligible for overtime pay.. Valid values are `exempt|non_exempt|highly_compensated|independent_contractor`',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Authorized Full-Time Equivalent (FTE) value for this position, expressed as a decimal fraction of a standard full-time schedule (e.g., 1.0 = full-time, 0.5 = half-time, 0.6 = 24 hours/week). Serves as the principal MEASUREMENT_OR_VALUE for this MASTER_RESOURCE entity. Used for FTE budget management and staffing ratio compliance.',
    `headcount_count` STRING COMMENT 'Number of authorized headcount slots represented by this position record. Typically 1, but may be greater for pooled or shared positions. Used for total headcount budget reconciliation.',
    `is_clinical` BOOLEAN COMMENT 'Indicates whether this position is classified as a clinical role requiring licensure, credentialing, or privileging (e.g., RN, MD, PA, RT). Drives integration with Symplr credentialing workflows and The Joint Commission staffing compliance.',
    `is_critical_role` BOOLEAN COMMENT 'Indicates whether this position is designated as a critical or hard-to-fill role requiring succession planning, accelerated recruitment, or retention incentives. Used for talent management and workforce risk reporting.',
    `is_management` BOOLEAN COMMENT 'Indicates whether this position carries managerial or supervisory responsibility over other positions or staff. Used for leadership reporting, succession planning, and FLSA exemption validation.',
    `is_provider` BOOLEAN COMMENT 'Indicates whether this position is designated as a licensed independent practitioner or mid-level provider requiring an NPI (National Provider Identifier) and payer enrollment. Drives integration with provider credentialing and payer enrollment workflows.',
    `is_union_eligible` BOOLEAN COMMENT 'Indicates whether this position is eligible for union membership or covered under a collective bargaining agreement. Used for labor relations management and contract compliance tracking.',
    `job_family` STRING COMMENT 'Broad occupational grouping to which this position belongs within the healthcare enterprise (e.g., Nursing, Physician, Allied Health, Administrative, Support Services, Information Technology). Used for workforce analytics and compensation benchmarking.',
    `location_type` STRING COMMENT 'Designates the expected work location arrangement for this position. Travel applies to travel nurse or locum tenens positions. Used for workforce planning, real estate management, and telehealth staffing.. Valid values are `on_site|remote|hybrid|travel`',
    `osha_job_hazard_category` STRING COMMENT 'OSHA bloodborne pathogen exposure risk category for this position. Category 1: routine exposure to blood/body fluids; Category 2: possible but not routine exposure; Category 3: no exposure expected. Drives PPE requirements, hepatitis B vaccination offers, and OSHA 29 CFR 1910.1030 compliance.. Valid values are `category_1|category_2|category_3`',
    `pay_grade` STRING COMMENT 'Compensation pay grade or band assigned to this position, defining the salary range and step structure (e.g., G7, N3, P5, M2). Confidential business data used for compensation equity analysis and budget planning.. Valid values are `^[A-Z0-9-]{1,10}$`',
    `pay_range_max` DECIMAL(18,2) COMMENT 'Maximum annual base salary (in USD) authorized for this position based on its pay grade. Used for compensation equity analysis, offer management, and budget planning. Confidential business data.',
    `pay_range_min` DECIMAL(18,2) COMMENT 'Minimum annual base salary (in USD) authorized for this position based on its pay grade. Used for compensation equity analysis, offer management, and budget planning. Confidential business data.',
    `required_certification` STRING COMMENT 'Specific professional certification required for this position beyond basic licensure (e.g., BLS, ACLS, PALS, CCRN, CEN, CNOR). Used for competency tracking, onboarding checklists, and Joint Commission compliance.',
    `required_education_level` STRING COMMENT 'Minimum educational attainment required to qualify for this position (e.g., bachelors degree for BSN-required RN positions, doctoral for physician roles). Used for recruitment screening and regulatory compliance.. Valid values are `high_school|associate|bachelor|master|doctoral|professional`',
    `required_license_type` STRING COMMENT 'Type of professional license required to fill this position (e.g., RN, LPN, MD, DO, PA-C, PharmD, RT, LCSW). Used for credentialing validation, vacancy posting requirements, and regulatory compliance reporting. [ENUM-REF-CANDIDATE: RN|LPN|MD|DO|PA-C|PharmD|RT|LCSW|CNA|NP|CRNA|DDS|OT|PT|SLP — promote to reference product]',
    `shift_type` STRING COMMENT 'Standard shift schedule associated with this position (e.g., day, evening, night, rotating). Used for scheduling, differential pay calculations, and staffing coverage analysis.. Valid values are `day|evening|night|rotating|variable|on_call`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this position record was sourced (e.g., Workday HCM, SAP S/4HANA HR). Used for data lineage tracking and ETL reconciliation in the Databricks Silver layer.. Valid values are `workday|sap|meditech|manual`',
    `source_system_position_code` STRING COMMENT 'Native position identifier from the originating system of record (e.g., Workday position ID such as P-00012345). Used for cross-system reconciliation, ETL deduplication, and audit traceability in the Silver layer.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Authorized standard scheduled hours per week for this position (e.g., 40.0 for full-time, 24.0 for 0.6 FTE, 36.0 for three 12-hour shifts). Used for FTE calculation validation and payroll processing.',
    `position_status` STRING COMMENT 'Current lifecycle state of the authorized position. Open indicates a vacancy available for recruitment; filled indicates an active incumbent; frozen indicates a budgetary hold; eliminated indicates the position has been removed from the headcount plan; pending_approval indicates awaiting authorization. Serves as the LIFECYCLE_STATUS for this MASTER_RESOURCE entity.. Valid values are `open|filled|frozen|eliminated|pending_approval`',
    `title` STRING COMMENT 'Official job title of the position as defined in the Workday HCM position management module (e.g., Registered Nurse – ICU, Attending Physician – Cardiology, Medical Laboratory Technician). Serves as the IDENTITY_LABEL for this MASTER_RESOURCE entity.',
    `position_type` STRING COMMENT 'Classification of the position by employment arrangement. Distinguishes regular permanent headcount from temporary, contract, per diem, travel nurse, or seasonal positions. Serves as the primary CLASSIFICATION_OR_TYPE for this MASTER_RESOURCE entity.. Valid values are `regular|temporary|contract|per_diem|traveler|seasonal`',
    `union_code` STRING COMMENT 'Code identifying the labor union or collective bargaining unit associated with this position, if applicable (e.g., SEIU, CNA, AFSCME). Null for non-union positions. Used for labor relations reporting and contract compliance.. Valid values are `^[A-Z0-9-]{1,15}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was last modified in the data platform. Used for change detection, incremental ETL processing, and audit trail compliance. Formatted as yyyy-MM-ddTHH:mm:ss.SSSXXX per enterprise convention.',
    `vacancy_reason` STRING COMMENT 'Reason code explaining why the position is currently open or vacant. Used for turnover analysis, workforce planning, and recruitment prioritization. Populated only when position_status is open. [ENUM-REF-CANDIDATE: new_position|resignation|retirement|termination|leave_of_absence|transfer|promotion — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized organizational positions (headcount slots) within the healthcare enterprise. Tracks position code, title, department, cost center, FTE allocation, required credentials, job family, pay grade, and whether the position is filled or vacant. Supports workforce planning and FTE budget management. Sourced from Workday HCM.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the job profile record in the workforce data platform. Primary key for this entity.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Job profiles for clinical roles define scope of practice via CPT code ranges (e.g., RN job profile includes CPT 96360-96379 infusion therapy). Real-world: scope-of-practice definitions in job descript',
    `org_unit_id` BIGINT COMMENT 'add column workforce_org_unit_id (BIGINT) with FK to workforce.org_unit.org_unit_id - job profiles are defined within organizational units but job_profile only links to reference.cpt_code',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether a pre-employment and/or periodic background check is required for this job profile. Driven by OIG exclusion list screening requirements and state health department regulations.',
    `certification_required` BOOLEAN COMMENT 'Indicates whether one or more professional certifications (e.g., BLS, ACLS, CEN, CCRN) are mandatory requirements for this job profile. When True, triggers certification tracking and renewal workflows.',
    `clinical_role_indicator` BOOLEAN COMMENT 'Flag indicating whether this job profile is classified as a clinical role (True) or a non-clinical/administrative role (False). Drives credentialing, privileging, and licensure verification requirements via Symplr and The Joint Commission standards.',
    `cme_compliance_period_months` STRING COMMENT 'Duration in months of the CME (Continuing Medical Education) compliance cycle for this job profile (e.g., 12 for annual, 24 for biennial). Defines the window within which required CME hours must be completed.',
    `cme_hours_required` DECIMAL(18,2) COMMENT 'Number of CME (Continuing Medical Education) or continuing education hours required per compliance period for this job profile. Applicable to licensed clinical roles. Tracked in Workday HCM Learning and Symplr.',
    `competency_framework_code` STRING COMMENT 'Reference code linking this job profile to the applicable competency framework or assessment model in Workday HCM Learning (e.g., clinical competency sets, leadership competency models). Drives annual competency assessment assignments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the job profile record was first created in the workforce data platform. Supports audit trail, data lineage, and compliance with HIPAA and HITRUST record-keeping requirements.',
    `dea_registration_required` BOOLEAN COMMENT 'Indicates whether a DEA (Drug Enforcement Administration) registration number is required for this job profile to prescribe or administer controlled substances. Applicable to physicians, advanced practice nurses, and pharmacists.',
    `drug_screen_required` BOOLEAN COMMENT 'Indicates whether pre-employment and/or random drug screening is required for this job profile. Particularly relevant for roles with access to controlled substances. Aligns with DEA and OSHA requirements.',
    `effective_date` DATE COMMENT 'Date on which the job profile definition becomes effective and available for use in position and employee assignments. Supports point-in-time workforce reporting.',
    `employment_type` STRING COMMENT 'Defines the standard employment arrangement associated with this job profile (e.g., Full-Time, Part-Time, Per Diem, Contract). Drives benefits eligibility, FTE (Full-Time Equivalent) calculation, and scheduling rules.. Valid values are `Full-Time|Part-Time|Per Diem|Contract|Temporary|Intern`',
    `end_date` DATE COMMENT 'Date on which the job profile is retired or superseded. Null indicates the profile is currently active and open-ended. Used to enforce temporal validity in workforce analytics.',
    `flsa_status` STRING COMMENT 'Indicates whether the job profile is classified as Exempt or Non-Exempt under the Fair Labor Standards Act (FLSA). Non-Exempt employees are entitled to overtime pay. Critical for payroll compliance and labor law adherence.. Valid values are `Exempt|Non-Exempt|Highly Compensated|Computer Employee`',
    `fte_equivalent` DECIMAL(18,2) COMMENT 'Standard FTE (Full-Time Equivalent) value associated with this job profile, representing the proportion of a full-time workload (e.g., 1.0 for full-time, 0.5 for half-time). Used in workforce capacity planning and CMS staffing ratio reporting.',
    `hipaa_access_level` STRING COMMENT 'Defines the level of access to PHI (Protected Health Information) authorized for this job profile under HIPAA minimum necessary standards. Drives role-based access control (RBAC) provisioning in EHR systems such as Epic and Cerner.. Valid values are `No Access|Limited|Standard|Extended|Full`',
    `job_category` STRING COMMENT 'EEO-1 (Equal Employment Opportunity) job category classification required for federal workforce reporting (e.g., Officials and Managers, Professionals, Technicians, Service Workers). Supports EEOC compliance reporting. [ENUM-REF-CANDIDATE: Officials and Managers|Professionals|Technicians|Sales Workers|Administrative Support|Craft Workers|Operatives|Laborers|Service Workers — promote to reference product]',
    `job_code` STRING COMMENT 'Externally-known alphanumeric code that uniquely identifies the job profile across the organization. Used in payroll, scheduling, and HR reporting systems. Sourced from Workday HCM.. Valid values are `^[A-Z0-9]{2,20}$`',
    `job_description` STRING COMMENT 'Full narrative description of the job profile including primary responsibilities, scope of practice, reporting relationships, and essential functions. Used in recruitment, performance management, ADA (Americans with Disabilities Act) compliance, and regulatory filings.',
    `job_family` STRING COMMENT 'Grouping of related job profiles that share common skills, knowledge, and career paths (e.g., Nursing, Pharmacy, Radiology, Administrative, Information Technology). Supports workforce planning and compensation benchmarking.',
    `job_family_group` STRING COMMENT 'Broader organizational grouping above job family that clusters related job families (e.g., Clinical, Non-Clinical, Administrative, Technical). Enables enterprise-level workforce analytics and reporting.',
    `job_level` STRING COMMENT 'Hierarchical level designation within the job family indicating seniority and scope of responsibility (e.g., Entry, Intermediate, Senior, Lead, Principal, Expert). Drives compensation grade assignment and career progression. [ENUM-REF-CANDIDATE: Entry|Intermediate|Senior|Lead|Principal|Expert|Director|Executive — promote to reference product]',
    `job_title` STRING COMMENT 'Official human-readable title of the job profile as defined in Workday HCM (e.g., Registered Nurse, Clinical Pharmacist, Radiologic Technologist). Used on offer letters, org charts, and regulatory filings.',
    `last_reviewed_date` DATE COMMENT 'Date on which the job profile was last formally reviewed and validated by HR and/or the relevant department leadership. Supports compliance with The Joint Commission requirement for periodic job description review.',
    `licensure_required` BOOLEAN COMMENT 'Indicates whether active professional licensure (e.g., RN, MD, PharmD, RT) is a mandatory requirement for this job profile. When True, triggers licensure verification workflows in Symplr and compliance tracking.',
    `management_level` STRING COMMENT 'Indicates whether the job profile is an individual contributor or a people-management role, and at what tier of management. Used for span-of-control analysis, leadership development, and FTE (Full-Time Equivalent) reporting.. Valid values are `Individual Contributor|Manager|Senior Manager|Director|Vice President|Executive`',
    `minimum_education_level` STRING COMMENT 'Minimum educational attainment required for this job profile (e.g., Bachelors Degree in Nursing, Doctor of Medicine). Used in applicant screening, credentialing verification, and regulatory compliance.. Valid values are `High School Diploma|Associate Degree|Bachelors Degree|Masters Degree|Doctoral Degree|Professional Degree`',
    `minimum_experience_years` DECIMAL(18,2) COMMENT 'Minimum number of years of relevant professional experience required for this job profile. Used in applicant screening, internal mobility decisions, and workforce planning.',
    `npi_required` BOOLEAN COMMENT 'Indicates whether employees in this job profile are required to hold an individual NPI (National Provider Identifier) for billing and claims submission purposes. Applicable to licensed independent practitioners and certain allied health professionals.',
    `on_call_required` BOOLEAN COMMENT 'Indicates whether employees in this job profile are required to participate in on-call scheduling rotations. Relevant for clinical roles in ED (Emergency Department), OR (Operating Room), ICU (Intensive Care Unit), and other 24/7 care settings.',
    `osha_exposure_category` STRING COMMENT 'OSHA bloodborne pathogen exposure risk category for this job profile per 29 CFR 1910.1030. Category I: routine exposure tasks; Category II: incidental exposure possible; Category III: no exposure expected. Drives PPE requirements and hepatitis B vaccination mandates.. Valid values are `Category I|Category II|Category III`',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to this job profile, defining the salary range tier within the organizations compensation structure (e.g., G5, G6, Band 3). Confidential business data used in compensation planning and equity analysis.',
    `pay_range_max` DECIMAL(18,2) COMMENT 'Maximum base salary or hourly rate defined for this job profiles pay grade. Caps compensation for the role and is used in offer approvals and merit increase planning.',
    `pay_range_midpoint` DECIMAL(18,2) COMMENT 'Midpoint of the base salary or hourly rate range for this job profile. Represents the market reference point used in compensation benchmarking and compa-ratio calculations.',
    `pay_range_min` DECIMAL(18,2) COMMENT 'Minimum base salary or hourly rate defined for this job profiles pay grade. Used in compensation benchmarking, offer generation, and equity analysis. Expressed in USD.',
    `pay_rate_type` STRING COMMENT 'Indicates whether compensation for this job profile is expressed as an annual salary, an hourly rate, or a daily rate. Drives payroll calculation logic and FLSA overtime applicability.. Valid values are `Salary|Hourly|Daily`',
    `privileging_required` BOOLEAN COMMENT 'Indicates whether clinical privileging through the medical staff office is required for this job profile. Applicable to physicians, advanced practice providers, and other credentialed clinical staff. Integrates with Symplr privileging workflows.',
    `profile_status` STRING COMMENT 'Current lifecycle state of the job profile. Active profiles are available for position and employee assignment. Inactive or Deprecated profiles are retained for historical reference but cannot be assigned to new positions.. Valid values are `Active|Inactive|Pending|Deprecated`',
    `remote_eligible` BOOLEAN COMMENT 'Indicates whether this job profile is eligible for remote or telehealth work arrangements. Drives telehealth credentialing requirements and state licensure compact applicability for clinical roles.',
    `required_certifications` STRING COMMENT 'Comma-delimited list of required professional certifications for this job profile (e.g., BLS, ACLS, PALS, CCRN, CEN, CNOR). Used to configure certification compliance tracking and renewal reminders in Symplr.',
    `required_license_types` STRING COMMENT 'Comma-delimited list of professional license types required for this job profile (e.g., RN, LPN, MD, DO, PharmD, RT, LCSW). Used to configure automated license verification and expiration alerts in Symplr.',
    `rvu_eligible` BOOLEAN COMMENT 'Indicates whether employees in this job profile are eligible for RVU (Relative Value Unit)-based productivity compensation or incentive programs. Applicable to physicians and advanced practice providers billing under CMS fee schedules.',
    `shift_type` STRING COMMENT 'Standard shift assignment associated with this job profile (e.g., Day, Evening, Night, Rotating). Used in workforce scheduling, differential pay calculations, and staffing ratio compliance reporting.. Valid values are `Day|Evening|Night|Rotating|On-Call|Variable`',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Expected number of scheduled work hours per week for this job profile. Used to calculate FTE (Full-Time Equivalent), overtime thresholds, and benefits eligibility under ACA (Affordable Care Act) requirements.',
    `travel_required` BOOLEAN COMMENT 'Indicates whether the job profile requires travel between facilities, patient homes, or other locations as part of standard job duties. Relevant for home health, mobile care, and multi-site roles.',
    `union_code` STRING COMMENT 'Code identifying the specific union or collective bargaining unit associated with this job profile, if applicable (e.g., SEIU, AFSCME, CNA). Used to apply CBA-specific compensation, scheduling, and benefit rules.',
    `union_eligible` BOOLEAN COMMENT 'Indicates whether this job profile is eligible for union membership or is covered under a collective bargaining agreement (CBA). Drives labor relations workflows and CBA-specific pay and scheduling rules.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the job profile record was last modified in the workforce data platform. Used for change detection in ETL (Extract Transform Load) pipelines and audit trail compliance.',
    `workday_job_profile_code` STRING COMMENT 'Source system identifier for this job profile record in Workday HCM. Used for data lineage, ETL (Extract Transform Load) reconciliation, and bi-directional integration between the lakehouse and Workday.',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Standardized job profile definitions used across the healthcare organization. Captures job code, job family, job level, management level, required competencies, required licensure/certifications, exempt/non-exempt status, and associated pay range. Acts as the template for positions and employee job assignments. Sourced from Workday HCM.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` (
    `employment_competency_id` BIGINT COMMENT 'Unique surrogate identifier for each employment competency record, covering credentials, privileges, and credentialing application lifecycle entries for healthcare workforce members.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) at which this privilege or credential is applicable. Null for credentials that are not facility-specific.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Workforce competency records for clinicians. Real business need: unified competency tracking across HR and medical staff systems, credentialing integration, privileging coordination, regulatory compli',
    `employee_id` BIGINT COMMENT 'Reference to the workforce member (employee, physician, contract staff, or allied health professional) to whom this competency record belongs.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Clinical privileges granted for specific procedures identified by CPT codes. Real-world: privilege cards list CPT ranges (e.g., 33510-33536 for CABG), credentialing applications require procedure-spec',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Privileges for device/drug administration procedures using HCPCS (e.g., J-codes for chemotherapy, E-codes for DME ordering authority). Real-world: oncology nurse privileges for specific chemotherapy a',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Medical staff privilege delineation links procedures to diagnosis codes (e.g., cardiac surgeon privileges for ICD-10 I21.* acute MI). Real-world: privilege dictionaries in medical staff bylaws, creden',
    `application_complete_date` DATE COMMENT 'The date on which the credentialing application was deemed complete with all required documentation and verifications received by the Medical Staff Office.',
    `application_decision` STRING COMMENT 'Final decision rendered by the Medical Staff committee on the credentialing or reappointment application.. Valid values are `approved|denied|deferred|withdrawn|pending`',
    `application_decision_date` DATE COMMENT 'The date on which the formal credentialing decision (approval, denial, deferral) was rendered by the Medical Staff committee.',
    `application_submission_date` DATE COMMENT 'The date on which the credentialing or reappointment application was formally submitted by the practitioner to the Medical Staff Office.',
    `application_type` STRING COMMENT 'Type of credentialing or privileging application submitted by the practitioner. Initial applications are for new Medical Staff members; reappointment applications occur on the standard cycle (typically every 2 years).. Valid values are `initial|reappointment|reinstatement|modification|temporary`',
    `appointment_effective_date` DATE COMMENT 'The date from which the Medical Staff appointment or reappointment becomes effective, authorizing the practitioner to practice at the facility.',
    `appointment_expiration_date` DATE COMMENT 'The date on which the Medical Staff appointment expires, triggering the reappointment process. Typically every 24 months per TJC standards.',
    `cme_credit_hours` DECIMAL(18,2) COMMENT 'Number of Continuing Medical Education (CME) credit hours earned by the workforce member relevant to this credential or privilege cycle. Used to verify CME requirements for license renewal and reappointment.',
    `cme_requirement_hours` DECIMAL(18,2) COMMENT 'Total number of CME credit hours required for the current credentialing or license renewal cycle as mandated by the issuing authority or Medical Staff bylaws.',
    `committee_review_date` DATE COMMENT 'The date on which the Credentials Committee or Medical Staff Executive Committee formally reviewed the credentialing application.',
    `competency_assessment_date` DATE COMMENT 'The date on which the formal competency assessment or skills validation was conducted for the workforce member.',
    `competency_assessment_score` DECIMAL(18,2) COMMENT 'Numeric score from a formal competency assessment, skills validation, or simulation evaluation conducted to verify the practitioners proficiency for a specific privilege or clinical activity.',
    `competency_type` STRING COMMENT 'Discriminator indicating whether this record represents a professional credential, a clinical privilege, or a credentialing/re-credentialing application.. Valid values are `credential|privilege|credentialing_application`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this employment competency record was first created in the system, supporting audit trail and data lineage requirements.',
    `credential_category` STRING COMMENT 'Classification of the professional credential type held by the workforce member. Examples include medical license, DEA registration, board certification, nursing license, allied health certification, advanced practice credential. [ENUM-REF-CANDIDATE: medical_license|dea_registration|board_certification|nursing_license|allied_health_certification|advanced_practice_credential|cme_certificate|other — promote to reference product]',
    `credential_number` STRING COMMENT 'The official license, registration, or certification number issued by the credentialing authority (e.g., state medical license number, DEA registration number, board certification number). Constitutes PHI/PII as it directly identifies a licensed individual.',
    `credential_status` STRING COMMENT 'Current lifecycle status of the professional credential as reported by the issuing authority or verified through primary source verification.. Valid values are `active|expired|suspended|revoked|pending_renewal|surrendered`',
    `denial_reason` STRING COMMENT 'Documented reason for denial or deferral of a credentialing application or privilege request by the Medical Staff committee. Classified as confidential per peer review protection statutes.',
    `department_name` STRING COMMENT 'The clinical department within the Medical Staff organization to which the practitioner is assigned (e.g., Department of Medicine, Department of Surgery, Department of Radiology).',
    `expiration_date` DATE COMMENT 'The date on which the credential, license, or certification expires and must be renewed. Null for credentials with no expiration (e.g., certain board certifications).',
    `issue_date` DATE COMMENT 'The date on which the credential, license, or certification was originally issued by the issuing authority.',
    `issuing_authority` STRING COMMENT 'Name of the organization, board, or government body that issued the credential (e.g., State Medical Board, Drug Enforcement Administration, American Board of Internal Medicine, State Board of Nursing).',
    `issuing_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction that issued the credential. Supports international medical graduates and foreign-trained clinicians.. Valid values are `^[A-Z]{3}$`',
    `issuing_state` STRING COMMENT 'Two-letter US state code of the jurisdiction that issued the credential. Applicable for state-issued licenses (medical, nursing, pharmacy). Null for federal or national credentials.. Valid values are `^[A-Z]{2}$`',
    `malpractice_coverage_verified` BOOLEAN COMMENT 'Indicates whether the practitioners professional liability (malpractice) insurance coverage has been verified as meeting the facilitys minimum coverage requirements during the credentialing process.',
    `medical_staff_category` STRING COMMENT 'The Medical Staff membership category assigned to the practitioner, defining their rights, responsibilities, and voting privileges within the Medical Staff organization. [ENUM-REF-CANDIDATE: active|associate|courtesy|consulting|honorary|provisional|affiliate — 7 candidates stripped; promote to reference product]',
    `medical_staff_committee` STRING COMMENT 'Name of the Medical Staff committee responsible for reviewing and approving the clinical privilege (e.g., Credentials Committee, Executive Committee of the Medical Staff, Department of Surgery Peer Review Committee).',
    `npdb_query_date` DATE COMMENT 'The date on which the National Practitioner Data Bank (NPDB) was queried for adverse action reports, malpractice payments, and licensure actions related to this practitioner as part of the credentialing process.',
    `npdb_query_result` STRING COMMENT 'Result of the NPDB query indicating whether adverse action reports or malpractice payment reports were found for the practitioner. Classified as confidential per NPDB disclosure restrictions.. Valid values are `no_report|report_found|pending`',
    `oig_exclusion_check_date` DATE COMMENT 'The most recent date on which the practitioner was screened against the OIG List of Excluded Individuals and Entities (LEIE). Monthly screening is recommended by OIG.',
    `oig_exclusion_checked` BOOLEAN COMMENT 'Indicates whether the practitioner has been screened against the OIG List of Excluded Individuals and Entities (LEIE) as required for participation in Medicare and Medicaid programs.',
    `primary_source_verified` BOOLEAN COMMENT 'Indicates whether the credential has been verified directly with the issuing authority (primary source verification) as required by NCQA and The Joint Commission credentialing standards.',
    `privilege_category` STRING COMMENT 'Classification of the clinical privilege granted by the Medical Staff (e.g., core privileges, special privileges, temporary privileges, telemedicine privileges, surgical privileges). [ENUM-REF-CANDIDATE: core|special|temporary|provisional|telemedicine|surgical|procedural|admitting|consulting — promote to reference product]',
    `privilege_effective_date` DATE COMMENT 'The date from which the clinical privilege becomes operationally effective and the practitioner is authorized to perform the privileged activity at the facility.',
    `privilege_expiration_date` DATE COMMENT 'The date on which the clinical privilege expires and must be reappointed through the Medical Staff reappointment process. Typically aligned with the Medical Staff appointment cycle (every 2 years per TJC).',
    `privilege_grant_date` DATE COMMENT 'The date on which the Medical Staff committee formally approved and granted the clinical privilege to the practitioner.',
    `privilege_procedure_code` STRING COMMENT 'Standardized code identifying the specific procedure, service, or clinical activity for which the privilege is granted. May reference CPT, HCPCS, or facility-defined procedure codes from the Delineation of Privileges form.',
    `privilege_procedure_name` STRING COMMENT 'Human-readable name of the specific procedure, service, or clinical activity for which the privilege is granted (e.g., laparoscopic cholecystectomy, cardiac catheterization, endotracheal intubation).',
    `privilege_status` STRING COMMENT 'Current status of the clinical privilege as granted by the Medical Staff committee. Tracks the full privilege lifecycle from provisional grant through active, suspension, or revocation. [ENUM-REF-CANDIDATE: active|provisional|suspended|revoked|expired|pending|voluntary_relinquishment — 7 candidates stripped; promote to reference product]',
    `psv_date` DATE COMMENT 'The date on which primary source verification of the credential was completed. Required for NCQA and TJC credentialing compliance tracking.',
    `psv_method` STRING COMMENT 'Method used to perform primary source verification of the credential (e.g., online portal query, written confirmation from issuing authority, third-party verification service such as CAQH ProView).. Valid values are `online_portal|written_confirmation|telephone|third_party_service|automated_feed`',
    `renewal_date` DATE COMMENT 'The date on which the credential was most recently renewed. Tracks the renewal cycle for ongoing compliance monitoring.',
    `sam_exclusion_checked` BOOLEAN COMMENT 'Indicates whether the practitioner has been screened against the federal SAM.gov exclusions database, required for federally funded programs and research activities.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this employment competency record was most recently modified, supporting audit trail and change tracking requirements.',
    CONSTRAINT pk_employment_competency PRIMARY KEY(`employment_competency_id`)
) COMMENT 'Master record for the full credentialing and privileging lifecycle of healthcare workforce members. Covers professional credentials (medical licenses, DEA registrations, board certifications, nursing licenses, allied health certifications, advanced practice credentials), clinical privileges (facility-specific procedure and clinical activity authorizations granted by Medical Staff), and credentialing/re-credentialing applications. For credentials: issuing authority, license number, issue/expiration dates, renewal status, primary source verification status. For privileges: privilege category, procedure/service type, facility, granting date, privilege status (active, provisional, suspended, revoked), Medical Staff committee approval. For applications: application type (initial, reappointment), submission date, verification steps, committee review dates, approval/denial decision, effective dates. Integrates with Symplr credentialing and Medical Staff Office workflows. SSOT for all workforce credentialing, privileging, and verification data.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` (
    `competency_assessment_id` BIGINT COMMENT 'Unique system-generated identifier for each competency assessment, immunization, or occupational health screening record. Primary key for this data product.',
    `care_site_id` BIGINT COMMENT 'Reference to the facility or care site where the worker is assigned and where this assessment applies for compliance tracking purposes.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Clinical competency assessments for credentialed providers. Real business need: privileging decisions, OPPE/FPPE requirements, medical staff reappointment, quality assurance, peer review integration f',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Clinical competency assessments use SNOMED for standardized skill/knowledge representation in EHR-integrated competency management systems. Real-world: nursing competency frameworks, clinical document',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Vaccine administration competencies linked to immunization encounter diagnosis codes (Z23). Real-world: vaccine administration training documentation, immunization competency tied to specific vaccines',
    `education_program_id` BIGINT COMMENT 'Reference to the formal education or training program in Workday HCM Learning that is associated with this competency assessment (e.g., annual competency curriculum, new hire orientation program).',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Competency assessments are often position-specific requirements (e.g., clinical competencies for RN positions, safety training for specific roles). Linking to position enables tracking which assessmen',
    `employee_id` BIGINT COMMENT 'Reference to the employee, physician, or contract staff member who is the subject of this competency assessment or occupational health record. Links to the workforce worker entity.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Procedural competency assessments tied to specific CPT codes (e.g., central line insertion CPT 36556 competency validation). Real-world: skills checklists for invasive procedures, annual competency ve',
    `administration_route` STRING COMMENT 'Route by which the vaccine was administered (e.g., intramuscular, subcutaneous, intradermal, oral, intranasal). Required for immunization documentation and adverse event reporting.. Valid values are `intramuscular|subcutaneous|intradermal|oral|intranasal`',
    `administration_site` STRING COMMENT 'Anatomical site on the body where the vaccine was injected (e.g., left deltoid, right deltoid). Required for immunization documentation per CDC and ACIP standards.. Valid values are `left_deltoid|right_deltoid|left_thigh|right_thigh|left_arm|right_arm`',
    `assessment_category` STRING COMMENT 'Top-level category distinguishing whether this record represents a clinical or non-clinical competency evaluation, an occupational immunization, or an occupational health screening (e.g., TB test, N95 fit test).. Valid values are `competency|immunization|health_screening`',
    `assessment_date` DATE COMMENT 'The actual date on which the competency was evaluated, the immunization was administered, or the health screening was performed. This is the principal real-world event date for this record.',
    `assessment_method` STRING COMMENT 'Method used to evaluate or document the competency or health record. For competency: observation, written_exam, simulation, return_demonstration, peer_review. For immunization: administration. For screening: record_review. [ENUM-REF-CANDIDATE: observation|written_exam|simulation|return_demonstration|administration|record_review|peer_review — promote to reference product]',
    `assessment_number` STRING COMMENT 'Externally visible, human-readable identifier for this assessment record, used in compliance reports, audit trails, and occupational health documentation (e.g., CA-2024-00123).',
    `assessment_status` STRING COMMENT 'Current lifecycle status of this assessment record, indicating whether it has been completed, is pending, overdue, formally waived, or declined by the worker.. Valid values are `scheduled|in_progress|completed|overdue|waived|declined`',
    `assessment_type` STRING COMMENT 'Specific type of assessment within the category. For competency: orientation, annual, role-specific, post-incident. For immunization: influenza, hepatitis_B, MMR, varicella, Tdap, COVID-19. For health screening: PPD, IGRA, N95_fit_test, blood_borne_pathogen. [ENUM-REF-CANDIDATE: orientation|annual|role_specific|post_incident|influenza|hepatitis_B|MMR|varicella|Tdap|COVID_19|PPD|IGRA|N95_fit_test — promote to reference product]',
    `attempt_number` STRING COMMENT 'Sequential attempt number for this competency assessment, tracking how many times the worker has been evaluated for this specific competency (1 = initial, 2+ = re-attempts after remediation).',
    `cme_credit_hours` DECIMAL(18,2) COMMENT 'Number of Continuing Medical Education (CME) or Continuing Education (CE) credit hours awarded upon successful completion of this competency assessment, if applicable.',
    `competency_domain` STRING COMMENT 'Clinical or operational domain to which this competency belongs (e.g., medication administration, infection control, patient safety, critical care, age-specific care, equipment operation). Null for immunization and health screening records.',
    `competency_name` STRING COMMENT 'Descriptive name of the specific competency, skill, vaccine, or screening test being assessed or administered (e.g., IV Catheter Insertion, Influenza Vaccine 2024-2025, Annual TB Screening).',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of this assessment record, indicating whether the worker is currently compliant, non-compliant, formally exempt, or pending completion for TJC, CMS, or OSHA requirements.. Valid values are `compliant|non_compliant|exempt|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this competency assessment record was first created in the system, used for audit trail and data lineage tracking.',
    `declination_reason` STRING COMMENT 'Documented reason provided by the worker for declining an immunization or health screening (e.g., religious exemption, medical contraindication, prior immunity documented). Required for OSHA and TJC compliance when immunization is declined.',
    `department_name` STRING COMMENT 'Name of the clinical or operational department where the worker is assigned at the time of this assessment, used for department-level compliance reporting.',
    `due_date` DATE COMMENT 'Date by which this assessment, immunization, or health screening must be completed to remain in compliance with TJC, CMS, or OSHA requirements.',
    `fit_test_protocol` STRING COMMENT 'Protocol used for N95 respirator fit testing: qualitative (pass/fail based on taste/smell detection) or quantitative (numerical fit factor measurement). Required for OSHA 29 CFR 1910.134 compliance.. Valid values are `qualitative|quantitative`',
    `job_role_applicability` STRING COMMENT 'Job role, position, or worker classification for which this competency or health requirement applies (e.g., RN, LPN, Surgical Tech, Environmental Services). Supports role-based compliance tracking.',
    `medical_contraindication` BOOLEAN COMMENT 'Indicates whether a documented medical contraindication exists that exempts the worker from a required immunization or health screening. True when a physician-documented contraindication is on file.',
    `n95_respirator_model` STRING COMMENT 'Make and model of the N95 respirator for which the worker was fit-tested. Required for OSHA respiratory protection program documentation.',
    `next_due_date` DATE COMMENT 'Date when the next recurring assessment, immunization booster, or health screening is due, used for proactive compliance tracking and workforce scheduling.',
    `notes` STRING COMMENT 'Free-text field for assessor or occupational health clinician notes, observations, or additional context related to this assessment, immunization, or health screening record.',
    `outcome` STRING COMMENT 'Final result of the assessment or immunization event. For competency: pass or fail. For observation-based: satisfactory or unsatisfactory. For immunization: administered or declined. [ENUM-REF-CANDIDATE: pass|fail|satisfactory|unsatisfactory|administered|declined|deferred — promote to reference product]',
    `passing_score` DECIMAL(18,2) COMMENT 'Minimum score required to pass this competency assessment. Used to determine pass/fail outcome and trigger remediation workflows when the workers score falls below this threshold.',
    `prior_immunity_documented` BOOLEAN COMMENT 'Indicates whether the worker has documented evidence of prior immunity (e.g., positive titer for MMR or varicella), exempting them from the corresponding immunization requirement.',
    `reassessment_date` DATE COMMENT 'Date on which the worker was re-evaluated following completion of a remediation plan after an initial competency assessment failure.',
    `regulatory_requirement` STRING COMMENT 'Specific regulatory standard or accreditation requirement that mandates this assessment (e.g., TJC HR.01.06.01, CMS CoP §482.42, OSHA 29 CFR 1910.1030, NCQA HEDIS). Used for compliance reporting and audit evidence.',
    `remediation_due_date` DATE COMMENT 'Date by which the worker must complete the assigned remediation plan and be re-assessed for the failed competency.',
    `remediation_plan` STRING COMMENT 'Description of the corrective education, supervised practice, or training plan assigned to the worker following a failed competency assessment, including required activities and timeline.',
    `remediation_required` BOOLEAN COMMENT 'Indicates whether the worker failed this competency assessment and requires a remediation plan before re-assessment. Drives remediation workflow in Workday HCM Learning.',
    `result_interpretation` STRING COMMENT 'Clinical interpretation of the health screening result (e.g., positive, negative, indeterminate for TB tests; reactive/non-reactive for hepatitis B serology). Null for competency assessments.. Valid values are `positive|negative|indeterminate|reactive|non_reactive`',
    `result_value` DECIMAL(18,2) COMMENT 'Qualitative or quantitative result for health screening tests. For PPD: induration measurement in mm (e.g., 10mm). For IGRA: positive/negative/indeterminate. For N95 fit test: pass/fail with fit factor. Null for competency and immunization records.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the worker on a written exam or simulation-based competency assessment (e.g., 85.00 out of 100). Null for immunization and health screening records.',
    `source_record_reference` STRING COMMENT 'Native identifier of this record in the originating source system (e.g., Workday learning activity ID, Symplr compliance record ID). Supports reconciliation and ETL audit.',
    `titer_result` STRING COMMENT 'Result of a serological titer test confirming immunity status for vaccines such as MMR, varicella, or hepatitis B (immune, non_immune, indeterminate). Used to determine whether immunization is required.. Valid values are `immune|non_immune|indeterminate`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this competency assessment record, supporting audit trail requirements and change tracking.',
    `vaccine_dose_number` STRING COMMENT 'Sequence number of the vaccine dose in a multi-dose series (e.g., dose 1, 2, or 3 of hepatitis B series; primary or booster for COVID-19). Null for single-dose vaccines.',
    `vaccine_lot_number` STRING COMMENT 'Manufacturer lot number of the vaccine administered, required for immunization traceability, adverse event reporting, and recall management. Null for non-immunization records.',
    `vaccine_manufacturer` STRING COMMENT 'Name of the pharmaceutical manufacturer of the vaccine administered (e.g., Pfizer, Moderna, Sanofi Pasteur). Required for adverse event reporting and immunization registry submissions.',
    `vaccine_ndc` STRING COMMENT 'National Drug Code (NDC) identifying the specific vaccine product administered. Used for immunization registry reporting, billing, and adverse event tracking.. Valid values are `^[0-9]{5}-[0-9]{4}-[0-9]{2}$`',
    CONSTRAINT pk_competency_assessment PRIMARY KEY(`competency_assessment_id`)
) COMMENT 'Records of competency evaluations, occupational health immunizations, and health screenings for clinical and non-clinical staff. Captures assessment type (competency, immunization, health screening), competency domain or vaccine/test type, assessment method (observation, written, simulation, administration), assessor, date, score/result, pass/fail outcome, remediation plan, and next-due date. For immunizations: vaccine type (influenza, hepatitis B, MMR, varicella, Tdap, COVID-19), lot number, administration date, declination reason. For health screenings: TB testing (PPD/IGRA), N95 fit testing, results. SSOT for all occupational health compliance and workforce competency data. Supports TJC and CMS staffing competency and infection control compliance standards.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Unique system-generated identifier for each shift schedule record. Primary key for the shift_schedule data product.',
    `care_site_id` BIGINT COMMENT 'Identifier of the facility (hospital, clinic, outpatient center) where the shift is scheduled.',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Clinical schedules for credentialed providers. Real business need: provider scheduling, on-call management, clinical coverage planning, productivity tracking, RVU capture, patient access management fo',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Shift schedules are created for specific positions (the authorized headcount slots), not just employees. Linking to position enables position-based scheduling, FTE coverage analysis, and ensures shift',
    `employee_id` BIGINT COMMENT 'Identifier of the employee assigned to this shift. References the workforce employee master record.',
    `swap_source_shift_schedule_id` BIGINT COMMENT 'Reference to the original shift_schedule record from which this shift was swapped. Populated when assignment_status is swapped to maintain the audit trail of shift exchanges.',
    `unit_id` BIGINT COMMENT 'FK to facility.unit',
    `org_unit_id` BIGINT COMMENT 'Identifier of the clinical or non-clinical department/unit (e.g., ICU, ED, OR, outpatient clinic) for which the shift is scheduled.',
    `actual_end_datetime` TIMESTAMP COMMENT 'The actual date and time the employee clocked out or ended the shift. Used for actual hours worked calculation and overtime determination.',
    `actual_hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours the employee actually worked during this shift, based on actual clock-in and clock-out times. Used for payroll processing and overtime variance analysis.',
    `actual_start_datetime` TIMESTAMP COMMENT 'The actual date and time the employee clocked in or began the shift. Compared against scheduled_start_datetime for variance analysis and late-arrival tracking.',
    `agency_name` STRING COMMENT 'Name of the staffing agency or contract labor vendor supplying the worker for this shift, when is_agency_staff is true. Used for vendor performance tracking and agency spend management.',
    `approval_datetime` TIMESTAMP COMMENT 'Date and time when the shift schedule assignment was approved by the responsible manager or charge nurse.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the individual shift assignment (e.g., scheduled, confirmed, swapped, cancelled, no_show, completed). Tracks the workflow state of the shift from planning through execution.. Valid values are `scheduled|confirmed|swapped|cancelled|no_show|completed`',
    `break_minutes` STRING COMMENT 'Total scheduled break time in minutes for this shift (meal and rest breaks). Used for net hours worked calculation and OSHA (Occupational Safety and Health Administration) compliance.',
    `cancellation_reason` STRING COMMENT 'Reason code for shift cancellation when assignment_status is cancelled. Supports workforce analytics on cancellation patterns and FMLA (Family and Medical Leave Act) tracking. [ENUM-REF-CANDIDATE: employee_request|low_census|call_out|fmla|bereavement|administrative|other — promote to reference product]',
    `care_setting` STRING COMMENT 'Classification of the care environment where the shift takes place (e.g., inpatient, ED (Emergency Department), ICU (Intensive Care Unit), OR (Operating Room), outpatient, ambulatory, telehealth). Drives staffing ratio requirements and regulatory reporting. [ENUM-REF-CANDIDATE: inpatient|ed|icu|or|outpatient|ambulatory|telehealth — 7 candidates stripped; promote to reference product]',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this shift schedule record was first created in the system. Supports audit trail and data lineage requirements.',
    `fte_value` DECIMAL(18,2) COMMENT 'FTE (Full-Time Equivalent) contribution of this shift assignment, calculated as scheduled hours divided by standard full-time hours. Used for workforce capacity planning and regulatory staffing ratio reporting.',
    `is_agency_staff` BOOLEAN COMMENT 'Indicates whether the shift is filled by agency or contract (traveler) staff rather than direct-hire employees. Used for labor cost analysis, agency spend tracking, and staffing mix reporting.',
    `is_charge_role` BOOLEAN COMMENT 'Indicates whether the employee is serving in a charge nurse or charge clinician capacity during this shift, carrying supervisory and unit management responsibilities.',
    `is_float_assignment` BOOLEAN COMMENT 'Indicates whether the employee is assigned as a float pool staff member, meaning they are not permanently assigned to this unit and may be deployed across multiple departments as needed.',
    `last_updated_datetime` TIMESTAMP COMMENT 'Date and time when this shift schedule record was most recently modified. Used for change tracking, incremental ETL (Extract Transform Load) processing, and audit compliance.',
    `nurse_to_patient_ratio` DECIMAL(18,2) COMMENT 'Actual nurse-to-patient ratio achieved during this shift, calculated as the number of nurses on duty divided by patient census. Used for regulatory compliance reporting and quality benchmarking.',
    `on_call_response_minutes` STRING COMMENT 'Required response time in minutes for on-call staff to report to the facility when called in. Applicable when shift_type is on_call. Used for operational readiness and SLA (Service Level Agreement) compliance.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours worked beyond the standard shift threshold (typically 8 hours/day or 40 hours/week) that qualify as overtime under FLSA. Used for payroll and labor cost management.',
    `patient_census` STRING COMMENT 'Number of patients in the unit/department at the time of the shift. Used to validate nurse-to-patient ratio compliance and assess staffing adequacy relative to patient volume.',
    `pay_code` STRING COMMENT 'Payroll pay code associated with this shift assignment (e.g., REG for regular, OT for overtime, HOL for holiday, DIFF for differential). Drives payroll processing in Workday HCM.',
    `published_datetime` TIMESTAMP COMMENT 'Date and time when the schedule was published and made visible to staff. Marks the transition from draft to published schedule status.',
    `required_fte_coverage` DECIMAL(18,2) COMMENT 'The minimum FTE (Full-Time Equivalent) staffing level required for the unit/department during this shift period, as defined by staffing plans and nurse-to-patient ratio standards.',
    `schedule_notes` STRING COMMENT 'Free-text notes or comments associated with this shift schedule assignment, capturing special instructions, accommodation requests, or operational context from the scheduler.',
    `schedule_number` STRING COMMENT 'Externally-known business identifier for the shift schedule record, used for cross-system reference and operational communication (e.g., SCH-202401150001).. Valid values are `^SCH-[0-9]{8,12}$`',
    `schedule_period_end_date` DATE COMMENT 'The last date of the scheduling period to which this shift belongs. Defines the boundary of the scheduling block.',
    `schedule_period_start_date` DATE COMMENT 'The first date of the scheduling period (e.g., start of a two-week or four-week scheduling block) to which this shift belongs.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the overall schedule period record (e.g., draft, published, approved, closed, archived). Distinguishes between working schedules and finalized/locked schedules.. Valid values are `draft|published|approved|closed|archived`',
    `scheduled_end_datetime` TIMESTAMP COMMENT 'The planned date and time the employee is scheduled to end the shift. Used for shift duration calculation and overtime tracking.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'Total number of hours the employee is planned to work during this shift, derived from scheduled start and end times. Used for FTE (Full-Time Equivalent) coverage planning.',
    `scheduled_start_datetime` TIMESTAMP COMMENT 'The planned date and time the employee is scheduled to begin the shift. Used for precise scheduling, overtime calculation, and time-and-attendance variance analysis.',
    `shift_category` STRING COMMENT 'Operational category of the shift assignment indicating the nature of the work arrangement (e.g., regular scheduled, overtime, on-call, callback, charge nurse, float pool). Affects pay rate and staffing classification.. Valid values are `regular|overtime|on_call|callback|charge|float`',
    `shift_date` DATE COMMENT 'The calendar date on which the shift is scheduled to occur. Used for day-level staffing planning and nurse-to-patient ratio compliance reporting.',
    `shift_type` STRING COMMENT 'Classification of the shift by time-of-day or operational category (e.g., day, evening, night, on-call, weekend, holiday). Drives differential pay calculations and staffing coverage analysis.. Valid values are `day|evening|night|on_call|weekend|holiday`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this shift schedule record originated (e.g., WORKDAY, EPIC_CADENCE, CERNER, MEDITECH, MANUAL). Supports data lineage and ETL (Extract Transform Load) traceability.. Valid values are `WORKDAY|EPIC_CADENCE|CERNER|MEDITECH|MANUAL`',
    `source_system_record_code` STRING COMMENT 'The native identifier of this shift schedule record in the originating operational system (e.g., Workday shift ID, Epic Cadence schedule ID). Enables reconciliation between the lakehouse and source systems.',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Planned work schedules and individual shift assignments for clinical and non-clinical staff across all care settings (inpatient units, ED, ICU, OR, outpatient clinics). Captures schedule period, unit/department, shift type (day, evening, night, on-call), required FTE coverage, and schedule status. Includes individual employee shift assignments: assigned employee, role, scheduled start/end datetime, assignment status (scheduled, confirmed, swapped, cancelled), float/agency designation, and actual vs. scheduled hours for variance analysis and overtime tracking. SSOT for all workforce scheduling data. Supports nurse-to-patient ratio compliance and operational staffing planning. Integrates with Workday HCM scheduling modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` (
    `time_attendance_id` BIGINT COMMENT 'Unique surrogate identifier for each time and attendance / payroll record in the Workday HCM Time Tracking and Payroll system. Primary key for the time_attendance data product.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) where the worker performed their shift or work assignment.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Time and attendance records must post labor costs to specific GL accounts for payroll expense recognition. Currently has gl_account_code as text. FK to chart_of_accounts enables proper labor cost acco',
    `cost_center_id` BIGINT COMMENT 'Reference to the General Ledger (GL) cost center to which labor costs for this record are allocated. Supports labor cost allocation by department and cost center for financial reporting.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: Payroll accruals and labor costs must align with fiscal period close. Links time/attendance to fiscal period for payroll accrual accuracy, period-end labor cost cutoff, and reconciliation of payroll e',
    `payroll_run_id` BIGINT COMMENT 'The identifier of the Workday HCM payroll run batch in which this record was processed. Used for payroll reconciliation, audit, and reprocessing of failed payroll runs.',
    `position_id` BIGINT COMMENT 'Reference to the specific position or job assignment held by the worker during this pay period, supporting multi-position employees common in healthcare settings.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contract worker whose time and attendance record this row represents. Links to the workforce worker/employee master.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Time and attendance records must be linked to organizational unit for labor cost allocation, payroll processing by org unit, and workforce analytics. time_attendance currently has department_code (den',
    `approval_status` STRING COMMENT 'Current workflow state of the time and attendance record in the approval lifecycle. Pending indicates awaiting manager review; approved indicates manager-confirmed; corrected indicates timekeeper adjustment applied.. Valid values are `pending|approved|rejected|corrected|submitted`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the manager or timekeeper approved this time record. Distinct from payroll processing timestamp; used for SLA monitoring of approval workflows.',
    `base_pay_rate` DECIMAL(18,2) COMMENT 'The employees base hourly rate or annualized salary rate used for payroll calculation. For hourly employees, expressed as dollars per hour; for salaried employees, expressed as annual salary divided by pay periods.',
    `benefits_deduction` DECIMAL(18,2) COMMENT 'Total amount deducted for employee benefits including health insurance premiums, dental, vision, life insurance, and retirement plan contributions (e.g., 401k) during this pay period.',
    `bonus_amount` DECIMAL(18,2) COMMENT 'Any bonus, incentive, or supplemental pay included in this payroll record, such as retention bonuses, sign-on bonuses, or performance incentives. Zero if no bonus applies.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'The date and time the worker clocked in to begin their shift, as recorded by Workday HCM Time Tracking. Represents the principal real-world business event time for shift start.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'The date and time the worker clocked out to end their shift. Null if the worker has not yet clocked out or if a missed punch was recorded.',
    `correction_reason` STRING COMMENT 'Reason code explaining why a timekeeper correction was applied to this record. Required when timekeeper_corrected is True for audit and compliance purposes.. Valid values are `missed_punch|system_error|schedule_change|manager_adjustment|employee_request|other`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this time and attendance record was first created in Workday HCM. Serves as the audit record creation timestamp for data lineage and compliance purposes.',
    `flsa_compliance_flag` BOOLEAN COMMENT 'System-generated flag indicating whether this time record is compliant with FLSA requirements (e.g., overtime thresholds met, minimum wage satisfied). False triggers a compliance review workflow.',
    `flsa_exempt` BOOLEAN COMMENT 'Indicates whether the employee is classified as exempt from FLSA overtime requirements (True = exempt salaried; False = non-exempt hourly). Critical for overtime eligibility determination and FLSA compliance audits.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The Full-Time Equivalent (FTE) percentage associated with this workers position for this pay period, expressed as a decimal (e.g., 1.00 = full-time, 0.50 = half-time). Used for workforce FTE tracking and labor cost allocation.',
    `garnishment_deduction` DECIMAL(18,2) COMMENT 'Total amount withheld for court-ordered wage garnishments (child support, creditor garnishments, tax levies) during this pay period. Zero if no garnishment applies.',
    `gl_account_code` STRING COMMENT 'The General Ledger (GL) account code used to post labor costs for this time record in SAP S/4HANA. Supports financial reporting and labor cost allocation by GL account.',
    `gross_pay_amount` DECIMAL(18,2) COMMENT 'Total gross compensation earned by the employee for the pay period before any deductions, including base pay, shift differentials, overtime pay, and bonuses. Expressed in USD.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this time and attendance record was most recently modified in Workday HCM, including timekeeper corrections, approval status changes, or payroll adjustments.',
    `leave_type` STRING COMMENT 'Identifies the type of leave applied to this time record if the worker was absent. None indicates no leave; FMLA indicates Family and Medical Leave Act protected leave. [ENUM-REF-CANDIDATE: none|pto|fmla|sick|bereavement|jury_duty|military|unpaid — promote to reference product if additional values needed]. Valid values are `none|pto|fmla|sick|bereavement|jury_duty`',
    `meal_break_minutes` STRING COMMENT 'Total minutes deducted for meal breaks during the shift or pay period. Applied per facility meal break policy and state labor law requirements to compute compensable hours.',
    `missed_punch_count` STRING COMMENT 'Number of missed clock-in or clock-out punch events recorded for this worker during the pay period. Used for attendance compliance monitoring and timekeeper correction workflows.',
    `net_pay_amount` DECIMAL(18,2) COMMENT 'Total net compensation paid to the employee after all deductions (taxes, benefits, garnishments) have been subtracted from gross pay. Represents the actual take-home amount.',
    `on_call_hours` DECIMAL(18,2) COMMENT 'Total hours the employee was designated as on-call during the pay period. Tracked separately for on-call differential pay calculations and staffing analytics.',
    `osha_incident_related` BOOLEAN COMMENT 'Indicates whether this time record is associated with an OSHA-reportable workplace incident (e.g., injury, illness resulting in lost time). True triggers linkage to OSHA incident reporting workflows.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Total overtime hours worked during the pay period, as defined by FLSA thresholds (hours exceeding 40 per workweek for non-exempt employees). Used for overtime pay calculation and FLSA compliance reporting.',
    `overtime_pay_amount` DECIMAL(18,2) COMMENT 'Total overtime compensation earned during the pay period, calculated at the applicable overtime rate (typically 1.5x base rate per FLSA) applied to overtime_hours.',
    `pay_period_end_date` DATE COMMENT 'The last calendar date of the pay period covered by this time and attendance record. Together with pay_period_start_date defines the payroll processing window.',
    `pay_period_start_date` DATE COMMENT 'The first calendar date of the pay period covered by this time and attendance record. Used to group time entries into payroll processing cycles.',
    `pay_type` STRING COMMENT 'Indicates whether the employee is compensated on an hourly, salaried, per diem, or contract basis. Drives payroll calculation logic and FLSA exemption status determination.. Valid values are `hourly|salary|per_diem|contract`',
    `payment_method` STRING COMMENT 'The method by which net pay is disbursed to the employee. Direct deposit is the standard method; check and pay card are alternatives for employees without bank accounts.. Valid values are `direct_deposit|check|pay_card`',
    `payroll_run_date` DATE COMMENT 'The date on which the payroll run that processed this record was executed. Distinct from pay_period_end_date; used for payroll processing SLA monitoring.',
    `payroll_run_status` STRING COMMENT 'Indicates the current payroll processing state for this time record. Processed means the record has been included in a completed payroll run; reversed indicates a payroll correction was applied.. Valid values are `not_processed|processing|processed|on_hold|reversed`',
    `regular_hours_worked` DECIMAL(18,2) COMMENT 'Total number of regular (non-overtime) hours worked by the employee during the pay period or shift, as calculated by Workday HCM Time Tracking after meal break deductions.',
    `shift_date` DATE COMMENT 'The calendar date on which the work shift occurred. For overnight shifts, this is the date the shift started. Used for daily labor reporting and scheduling reconciliation.',
    `shift_differential_amount` DECIMAL(18,2) COMMENT 'Additional compensation earned for working evening, night, weekend, or holiday shifts. Calculated based on shift_type and applicable differential rate per the collective bargaining agreement or HR policy.',
    `shift_type` STRING COMMENT 'Classification of the work shift for differential pay and scheduling purposes. [ENUM-REF-CANDIDATE: day|evening|night|on_call|weekend|holiday|rotating — promote to reference product if additional values needed]. Valid values are `day|evening|night|on_call|weekend|holiday`',
    `time_entry_type` STRING COMMENT 'Categorizes the nature of the time entry for payroll calculation and labor cost reporting. [ENUM-REF-CANDIDATE: regular|overtime|on_call|callback|charge|training|orientation|meeting — promote to reference product if additional values needed]. Valid values are `regular|overtime|on_call|callback|charge|training`',
    `timekeeper_corrected` BOOLEAN COMMENT 'Indicates whether a timekeeper or payroll administrator applied a manual correction to this time record. True when a correction has been made; supports audit trail and compliance review.',
    `total_tax_deduction` DECIMAL(18,2) COMMENT 'Total amount withheld for all applicable taxes (federal income tax, state income tax, FICA/Social Security, Medicare) during this pay period. Supports W-2 preparation and tax compliance reporting.',
    CONSTRAINT pk_time_attendance PRIMARY KEY(`time_attendance_id`)
) COMMENT 'Time, attendance, and payroll processing records for all employees. Captures clock-in/clock-out events, total hours worked, overtime hours, missed punches, meal break deductions, pay period totals, approval status, and timekeeper corrections. Includes complete payroll processing: gross pay, net pay, base salary/hourly rate, shift differentials, overtime pay, bonuses, deductions (taxes, benefits, garnishments), pay period dates, payroll run status, payment method (direct deposit, check), and GL cost center allocation. Tracks FLSA compliance flags and supports labor cost allocation by cost center and department. SSOT for all workforce time tracking and payroll data. Sourced from Workday HCM Time Tracking and Payroll modules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique surrogate identifier for each benefit enrollment record in the workforce domain. Primary key for the benefit_enrollment data product.',
    `benefit_plan_id` BIGINT COMMENT 'Reference to the specific benefit plan elected by the worker (e.g., medical plan, dental plan, 403(b) retirement plan). Links to the benefit plan master record.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or worker who elected this benefit plan. Links to the workforce worker/employee master record.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Benefit eligibility and plan offerings often vary by position type (full-time vs. part-time, union vs. non-union, executive vs. staff). Adding position_id enables position-specific benefit analysis an',
    `aca_affordability_flag` BOOLEAN COMMENT 'Indicates whether the employees required contribution for the lowest-cost self-only coverage does not exceed the ACA affordability threshold (percentage of household income or safe harbor). Used for ACA employer mandate compliance and IRS Form 1095-C reporting.',
    `aca_minimum_essential_coverage_flag` BOOLEAN COMMENT 'Indicates whether this medical benefit enrollment satisfies the Affordable Care Act (ACA) Minimum Essential Coverage (MEC) requirement. True for qualifying employer-sponsored health plans. Used for ACA employer mandate compliance reporting on IRS Forms 1094-C and 1095-C.',
    `aca_minimum_value_flag` BOOLEAN COMMENT 'Indicates whether the elected medical plan meets the ACA Minimum Value (MV) standard, meaning the plan pays at least 60% of the total allowed cost of benefits. Required for ACA employer mandate compliance and IRS Form 1095-C Line 14 reporting.',
    `annual_election_amount` DECIMAL(18,2) COMMENT 'The total annual dollar amount elected by the employee for spending accounts (FSA, HSA, dependent care FSA) or retirement plan contributions (403(b)/401(k)). Applicable primarily to FSA, HSA, and retirement benefit types. Null for insurance plan types.',
    `beneficiary_name` STRING COMMENT 'Full legal name of the primary beneficiary designated by the employee for life insurance and retirement benefit plans. Required for life insurance and 403(b)/401(k) plans. Null for health, dental, vision, FSA, and HSA plans.',
    `beneficiary_relationship` STRING COMMENT 'The relationship of the primary beneficiary to the enrolled employee for life insurance and retirement plans. Used for ERISA compliance and beneficiary designation validation.. Valid values are `spouse|child|parent|sibling|domestic_partner|other`',
    `benefit_type` STRING COMMENT 'Category of benefit plan elected by the worker. Classifies the enrollment into major benefit program types: medical, dental, vision, life insurance, disability (short-term or long-term), Flexible Spending Account (FSA), Health Savings Account (HSA), or retirement (403(b)/401(k)). [ENUM-REF-CANDIDATE: medical|dental|vision|life_insurance|disability|fsa|hsa|retirement — 8 candidates stripped; promote to reference product]',
    `carrier_confirmation_date` DATE COMMENT 'The date on which the insurance carrier confirmed receipt and processing of the enrollment eligibility record. Used to reconcile Workday enrollment records against carrier enrollment files and resolve discrepancies.',
    `carrier_eligibility_sent_date` DATE COMMENT 'The date on which the eligibility file for this enrollment was transmitted to the insurance carrier or benefit administrator. Used to track carrier file transmission status and resolve eligibility discrepancies between Workday and the carrier.',
    `carrier_group_number` STRING COMMENT 'The group policy number assigned by the insurance carrier to the healthcare organizations benefit plan. Used on insurance cards, claims submissions, and eligibility verification. Shared across all employees enrolled in the same plan.',
    `carrier_member_number` STRING COMMENT 'The unique member identification number assigned by the insurance carrier to the enrolled employee. Used for claims processing, eligibility verification, and member services. This is a PHI-adjacent identifier that can be used to access health information.',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or benefit administrator providing the elected benefit plan (e.g., Blue Cross Blue Shield, Aetna, Delta Dental, Fidelity Investments). Used for carrier billing, eligibility file transmission, and member ID card generation.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'Indicates whether the employee is eligible for COBRA (Consolidated Omnibus Budget Reconciliation Act) continuation coverage upon termination of this enrollment. True when the enrollment termination is due to a qualifying COBRA event (e.g., employment termination, reduction in hours). Drives COBRA notification workflow.',
    `cobra_notification_date` DATE COMMENT 'The date on which the COBRA election notice was sent to the employee following a qualifying event. The employer must provide notice within 14 days of being notified of the qualifying event. Required for COBRA compliance documentation.',
    `coverage_tier` STRING COMMENT 'Coverage level elected by the employee indicating who is covered under the benefit plan. Drives premium calculation and payroll deduction amounts. Standard tiers: employee only, employee plus spouse, employee plus children, or full family coverage.. Valid values are `employee_only|employee_spouse|employee_children|family`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this benefit enrollment record was first created in the system. Serves as the RECORD_AUDIT_CREATED field for this MASTER_AGREEMENT entity. Used for audit trail and data lineage.',
    `deduction_frequency` STRING COMMENT 'The payroll deduction frequency for the employees benefit premium contribution. Determines how often the employee_premium_amount is deducted from the employees paycheck. Must align with the employees pay frequency in Workday Payroll.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `dependent_count` STRING COMMENT 'The number of dependents (spouse, children, domestic partner) enrolled under this benefit plan election. Used to validate coverage tier selection and for carrier eligibility file reconciliation.',
    `disability_benefit_type` STRING COMMENT 'Specifies whether the disability benefit enrollment is for Short-Term Disability (STD) or Long-Term Disability (LTD) coverage. Applicable only when benefit_type is disability. Drives different elimination periods, benefit durations, and premium rates.. Valid values are `short_term|long_term`',
    `effective_date` DATE COMMENT 'The date on which the benefit coverage becomes effective and the employee is entitled to use the elected benefit plan. This is the MASTER_AGREEMENT EFFECTIVE_FROM date for this enrollment record.',
    `employee_premium_amount` DECIMAL(18,2) COMMENT 'The employees share of the benefit plan premium per pay period, expressed in USD. This is the amount deducted from the employees paycheck via pre-tax or post-tax payroll deduction. Drives payroll deduction configuration in Workday Payroll.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'The employers annual contribution to the employees HSA, FSA, or retirement account (403(b)/401(k) match), expressed in USD. Distinct from employer_premium_amount which applies to insurance plans. Used for IRS reporting and total compensation statements.',
    `employer_match_rate` DECIMAL(18,2) COMMENT 'The employers matching contribution rate as a percentage of the employees retirement contribution, expressed as a decimal (e.g., 0.5000 = 50% match up to a cap). Applicable only when benefit_type is retirement. Used for total compensation reporting and retirement plan compliance.',
    `employer_premium_amount` DECIMAL(18,2) COMMENT 'The employers contribution toward the benefit plan premium per pay period, expressed in USD. Represents the healthcare organizations cost of providing the benefit. Used in total compensation reporting and benefits cost analysis.',
    `enrollment_confirmation_number` STRING COMMENT 'The confirmation number generated by Workday HCM or the carriers enrollment portal upon successful submission of the benefit election. Provided to the employee as proof of enrollment. Used for audit and dispute resolution.',
    `enrollment_number` STRING COMMENT 'Externally-known business identifier for this benefit enrollment record, used in correspondence with carriers, payroll, and HR operations. Sourced from Workday HCM Benefits module.. Valid values are `^ENR-[0-9]{10}$`',
    `enrollment_source` STRING COMMENT 'The business event or process that initiated this benefit enrollment. Distinguishes between annual open enrollment elections, mid-year qualifying life event (QLE) changes (e.g., marriage, birth, loss of other coverage), new hire enrollment, rehire enrollment, or administrative corrections.. Valid values are `open_enrollment|qualifying_life_event|new_hire|rehire|correction`',
    `enrollment_status` STRING COMMENT 'Current lifecycle state of the benefit enrollment record. Active indicates coverage is in force; pending indicates awaiting carrier confirmation; terminated indicates coverage has ended; waived indicates the employee declined coverage; suspended indicates coverage is temporarily paused.. Valid values are `active|pending|terminated|waived|suspended`',
    `enrollment_submitted_date` DATE COMMENT 'The date on which the employee submitted their benefit election in Workday HCM. Distinct from the effective_date (when coverage begins). Used to verify timely enrollment within the election window and for audit trail purposes.',
    `fsa_plan_type` STRING COMMENT 'Specifies the type of Flexible Spending Account (FSA) elected: healthcare FSA (for medical expenses), dependent care FSA (DCFSA for childcare/eldercare), or limited-purpose FSA (for dental/vision only, compatible with HSA). Applicable only when benefit_type is fsa.. Valid values are `healthcare|dependent_care|limited_purpose`',
    `hsa_contribution_limit` DECIMAL(18,2) COMMENT 'The IRS-mandated annual contribution limit applicable to this HSA enrollment based on coverage tier (individual vs. family) and the employees age (catch-up contributions for age 55+). Used to validate that annual_election_amount does not exceed IRS limits. Applicable only when benefit_type is hsa.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this benefit enrollment record was most recently modified in the system. Serves as the RECORD_AUDIT_UPDATED field. Used for change tracking, incremental ETL processing, and audit compliance.',
    `life_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'The face value (death benefit) of the life insurance policy elected by the employee, expressed in USD. Applicable only when benefit_type is life_insurance. May be a flat amount or a multiple of annual salary (e.g., 1x, 2x base salary).',
    `open_enrollment_period` STRING COMMENT 'Identifier for the annual open enrollment window during which this election was made (e.g., OE-2024). Null for mid-year qualifying life event enrollments. Used to group and audit all elections made during a specific open enrollment campaign.. Valid values are `^OE-[0-9]{4}(-[0-9]{2})?$`',
    `other_coverage_carrier` STRING COMMENT 'Name of the insurance carrier providing the employees other coverage when the employee has waived the employers plan due to having coverage elsewhere. Used for coordination of benefits (COB) and ACA compliance documentation.',
    `plan_year` STRING COMMENT 'The calendar or fiscal plan year to which this enrollment applies (e.g., 2024). Used to associate elections with the correct annual benefit period for reporting, compliance, and ACA employer mandate tracking.. Valid values are `^[0-9]{4}$`',
    `pretax_flag` BOOLEAN COMMENT 'Indicates whether the employees premium contribution is deducted on a pre-tax basis under a Section 125 Cafeteria Plan (True) or on a post-tax basis (False). Affects the employees taxable income and W-2 reporting. Most medical, dental, and vision premiums are pre-tax.',
    `qualifying_life_event_type` STRING COMMENT 'Specifies the type of qualifying life event (QLE) that triggered a mid-year benefit change, when enrollment_source is qualifying_life_event. Examples include marriage, divorce, birth, adoption, death of dependent, loss of other coverage, change in employment status. Null when enrollment_source is open_enrollment or new_hire. [ENUM-REF-CANDIDATE: marriage|divorce|birth|adoption|death_of_dependent|loss_of_coverage|employment_change|other — promote to reference product]',
    `retirement_contribution_rate` DECIMAL(18,2) COMMENT 'The employees elected contribution rate as a percentage of gross pay for retirement plans (403(b)/401(k)), expressed as a decimal (e.g., 0.0600 = 6%). Used to calculate per-period retirement deductions in Workday Payroll. Applicable only when benefit_type is retirement.',
    `termination_date` DATE COMMENT 'The date on which the benefit coverage ends and the employee is no longer entitled to the elected benefit plan. Null for currently active enrollments. This is the MASTER_AGREEMENT EFFECTIVE_UNTIL date. Triggers COBRA eligibility notification requirements under federal law.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'The combined total premium for the benefit plan per pay period (employee share plus employer share), expressed in USD. Used for carrier billing reconciliation and total benefits cost reporting.',
    `waiver_reason` STRING COMMENT 'The stated reason why the employee waived (declined) coverage for this benefit plan, when enrollment_status is waived. Common reasons include coverage through spouses employer, coverage through Medicare/Medicaid, or other qualifying coverage. Required for ACA employer mandate compliance documentation.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Employee benefit enrollment records capturing elected benefit plans (medical, dental, vision, life insurance, disability, FSA, HSA, 403(b)/401(k) retirement), coverage tier (employee only, employee+spouse, family), enrollment effective date, termination date, and annual election amounts. Tracks open enrollment events and qualifying life event changes. Sourced from Workday HCM Benefits module.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique system-generated identifier for each employee leave of absence request record in the Workday HCM Absence Management module.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility (hospital, clinic, outpatient center) where the employee is assigned. Used for site-level absence tracking, FMLA 50-employee threshold determination, and operational coverage planning.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contingent worker submitting the leave request. Links to the workforce worker/employee master record.',
    `position_id` BIGINT COMMENT 'Reference to the organizational position held by the employee at the time of the leave request, used for backfill planning and FTE (Full-Time Equivalent) impact analysis.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the organizational department to which the employee belongs at the time of the leave request. Used for departmental absence reporting, coverage planning, and workforce analytics.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the leave request was formally approved or denied by the HR approver in Workday HCM. Used to measure HR processing time and compliance with FMLA 5-business-day notification requirement.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the HR manager or leave administrator who approved or denied the leave request in Workday HCM. Supports audit trail and accountability tracking.',
    `approved_end_date` DATE COMMENT 'The HR-approved last calendar date of the leave of absence. Used for return-to-work planning, benefits administration, and FMLA entitlement tracking.',
    `approved_start_date` DATE COMMENT 'The HR-approved first calendar date of the leave of absence, which may differ from the requested start date. Drives payroll processing, benefits continuation, and FTE (Full-Time Equivalent) reporting.',
    `benefits_continuation` BOOLEAN COMMENT 'Indicates whether the employees group health benefits are being continued during the leave period. FMLA requires employers to maintain group health coverage under the same terms as if the employee had continued working.',
    `cobra_notification_sent` BOOLEAN COMMENT 'Indicates whether a COBRA (Consolidated Omnibus Budget Reconciliation Act) continuation coverage notification was sent to the employee, applicable when benefits are not continued during the leave or upon separation.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the leave request record was first created in the data platform. Used for audit trail and data lineage purposes.',
    `denial_reason` STRING COMMENT 'Documented reason for denial of the leave request (e.g., insufficient FMLA entitlement remaining, ineligible leave type, incomplete certification, operational necessity). Required for compliance documentation and potential grievance or legal proceedings.',
    `fitness_for_duty_received_date` DATE COMMENT 'Date on which the employer received the completed fitness-for-duty medical certification from the employees healthcare provider, clearing the employee to return to work.',
    `fitness_for_duty_required` BOOLEAN COMMENT 'Indicates whether the employer requires a fitness-for-duty medical certification before the employee may return to work. Applicable for FMLA leave taken for the employees own serious health condition.',
    `fmla_eligibility_determination_date` DATE COMMENT 'Date on which HR formally determined and communicated the employees FMLA (Family and Medical Leave Act) eligibility status. FMLA regulations require notification within 5 business days of the leave request.',
    `fmla_eligible` BOOLEAN COMMENT 'Indicates whether the employee meets the FMLA (Family and Medical Leave Act) eligibility criteria at the time of the leave request: employed for at least 12 months, worked at least 1,250 hours in the prior 12 months, and works at a location with 50+ employees within 75 miles.',
    `fmla_hours_remaining` DECIMAL(18,2) COMMENT 'Remaining FMLA (Family and Medical Leave Act) entitlement hours available to the employee in the current FMLA leave year after accounting for hours used. Supports HR compliance monitoring and employee communication.',
    `fmla_hours_used` DECIMAL(18,2) COMMENT 'Cumulative FMLA (Family and Medical Leave Act) hours consumed by the employee in the current FMLA leave year for this request. FMLA entitlement is capped at 480 hours (12 weeks) per year for most qualifying reasons.',
    `hr_notes` STRING COMMENT 'Free-text notes entered by the HR leave administrator documenting case-specific details, communications with the employee, or special circumstances. May contain PHI (Protected Health Information) and is subject to HIPAA confidentiality requirements.',
    `intermittent_duration_hours` DECIMAL(18,2) COMMENT 'Expected duration in hours of each intermittent leave episode as certified by the healthcare provider. Used to calculate FTE (Full-Time Equivalent) impact and schedule coverage needs.',
    `intermittent_frequency` STRING COMMENT 'Expected frequency of intermittent leave episodes as certified by the healthcare provider (e.g., Daily, Weekly, Monthly, As Needed). Used for scheduling and absence pattern monitoring.. Valid values are `Daily|Weekly|Monthly|As_Needed`',
    `is_intermittent` BOOLEAN COMMENT 'Indicates whether the leave is taken intermittently (in separate blocks of time or by reducing the normal weekly or daily work schedule) rather than as a single continuous period. Intermittent FMLA requires separate tracking of each absence episode.',
    `leave_duration_days` DECIMAL(18,2) COMMENT 'Total approved duration of the leave in calendar days, calculated from approved start and end dates. Used for ALOS (Average Length of Stay) benchmarking, workforce planning, and payroll impact analysis.',
    `leave_reason` STRING COMMENT 'Specific reason or qualifying condition for the leave request (e.g., serious health condition of employee, care for family member, military deployment, birth/adoption of child). Constitutes PHI (Protected Health Information) when related to a medical condition and is subject to HIPAA and FMLA confidentiality requirements.',
    `leave_type` STRING COMMENT 'Classification of the leave of absence request. Includes federally protected leave types such as FMLA (Family and Medical Leave Act), USERRA military leave, workers compensation, and employer-defined types such as bereavement and PTO. [ENUM-REF-CANDIDATE: FMLA|Personal|Military|Workers_Compensation|Bereavement|PTO|Parental|Disability|Jury_Duty|Administrative — promote to reference product]',
    `leave_year_start_date` DATE COMMENT 'Start date of the 12-month FMLA leave year applicable to this request. Employers may use a calendar year, fixed year, or rolling 12-month period. Determines the entitlement window for FMLA hour calculations.',
    `medical_certification_expiration_date` DATE COMMENT 'Date on which the medical certification supporting the leave request expires. HR must request recertification before this date for ongoing or intermittent leave.',
    `medical_certification_received_date` DATE COMMENT 'Date on which the employer received the completed medical certification form (e.g., WH-380-E or WH-380-F) from the employee or their healthcare provider.',
    `medical_certification_required` BOOLEAN COMMENT 'Indicates whether a medical certification from a healthcare provider is required to support the leave request. Required for FMLA leave related to a serious health condition.',
    `military_order_number` STRING COMMENT 'Official military order number from the deployment or activation orders provided by the employee for USERRA military leave verification. Supports compliance documentation.',
    `military_service_branch` STRING COMMENT 'Branch of the U.S. Armed Forces for which the employee is taking military leave under USERRA (Uniformed Services Employment and Reemployment Rights Act). Populated only for military leave type requests. [ENUM-REF-CANDIDATE: Army|Navy|Air_Force|Marine_Corps|Coast_Guard|Space_Force|National_Guard — 7 candidates stripped; promote to reference product]',
    `notice_provided_date` DATE COMMENT 'Date on which the employer provided the required FMLA designation notice to the employee, informing them whether the leave qualifies as FMLA and the amount of leave counted against their entitlement.',
    `pay_status` STRING COMMENT 'Compensation status during the leave period. Indicates whether the employee receives full pay, partial pay, short-term disability (STD) benefits, long-term disability (LTD) benefits, or is on unpaid leave. Drives payroll processing in Workday HCM Payroll.. Valid values are `Paid|Unpaid|Partial_Pay|STD|LTD`',
    `pto_hours_applied` DECIMAL(18,2) COMMENT 'Number of accrued PTO (Paid Time Off) hours the employee has elected or is required to use concurrently with the leave period. FMLA regulations permit employers to require concurrent use of accrued paid leave.',
    `request_number` STRING COMMENT 'Externally visible, human-readable business identifier for the leave request, used in correspondence with employees, HR, and payroll teams (e.g., LR-2024-000123).. Valid values are `^LR-[0-9]{4}-[0-9]{6}$`',
    `request_status` STRING COMMENT 'Current workflow lifecycle state of the leave request within Workday HCM Absence Management. Tracks progression from initial submission through HR review, approval or denial, and any subsequent cancellation or withdrawal by the employee. [ENUM-REF-CANDIDATE: Draft|Submitted|Pending_Approval|Approved|Denied|Cancelled|Withdrawn — 7 candidates stripped; promote to reference product]',
    `requested_end_date` DATE COMMENT 'The employee-requested last calendar date of the leave of absence period. May differ from the approved end date if HR modifies the duration during the approval process.',
    `requested_start_date` DATE COMMENT 'The employee-requested first calendar date of the leave of absence period. Used for scheduling, coverage planning, and FMLA eligibility period calculations.',
    `return_to_work_date` DATE COMMENT 'Actual date the employee returned to active employment following the leave of absence. May differ from the approved end date due to early return, extended leave, or AMA (Against Medical Advice) situations.',
    `return_to_work_status` STRING COMMENT 'Outcome status of the employees return to work following the leave. Indicates whether the employee returned as scheduled, extended the leave, separated from employment, or has not yet returned.. Valid values are `Returned|Extended|Separated|Pending|No_Return`',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the employee formally submitted the leave request in Workday HCM. Serves as the BUSINESS_EVENT_TIMESTAMP for this transaction and is used to measure HR response time SLAs.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the leave request record in the data platform. Used for incremental ETL (Extract Transform Load) processing and audit trail.',
    `workday_absence_code` STRING COMMENT 'Native identifier of the leave request record in the Workday HCM Absence Management source system. Used for cross-system reconciliation and ETL (Extract Transform Load) deduplication.',
    `workers_comp_claim_number` STRING COMMENT 'Insurance claim number assigned by the workers compensation carrier for leave requests associated with a workplace injury or illness. Links the leave record to the workers compensation claim for coordinated benefits management.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Employee leave of absence requests and approved leave records, including FMLA (Family and Medical Leave Act), personal leave, military leave (USERRA), workers compensation leave, bereavement, and PTO. Captures leave type, requested start/end dates, approved dates, intermittent leave tracking, FMLA eligibility determination, and return-to-work status. Sourced from Workday HCM Absence Management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique surrogate identifier for each performance review record in the workforce performance management system. Primary key for the performance_review data product.',
    `position_id` BIGINT COMMENT 'Reference to the position held by the worker at the time of the performance review, capturing the role context for the evaluation.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contingent worker who is the subject of this performance review. Links to the workforce worker master record.',
    `review_template_id` BIGINT COMMENT 'Reference to the performance review template or form used for this evaluation cycle, defining the rating scales, competency sections, and goal sections applied.',
    `reviewer_worker_employee_id` BIGINT COMMENT 'Reference to the manager or supervisor who conducted and submitted the performance review. Typically the direct reporting manager in the supervisory organization.',
    `appeal_filed` BOOLEAN COMMENT 'Indicates whether the employee has filed a formal appeal against the performance rating or disciplinary action documented in this review record.',
    `appeal_resolution_date` DATE COMMENT 'The date on which the formal appeal was resolved and a final determination was communicated to the employee. Used for HR compliance and legal documentation.',
    `appeal_status` STRING COMMENT 'Current status of the employees formal appeal against the performance rating or disciplinary action. Populated only when appeal_filed is true.. Valid values are `pending|upheld|overturned|withdrawn`',
    `calibration_date` DATE COMMENT 'The date on which the performance rating for this review was finalized through the HR calibration process. Populated when calibration_status is calibrated or approved.',
    `calibration_status` STRING COMMENT 'Status of the performance rating calibration process for this review, indicating whether the rating has been reviewed and validated through the HR calibration session.. Valid values are `not_required|pending|calibrated|approved`',
    `career_interest_narrative` STRING COMMENT 'Free-text description of the employees stated career interests, desired roles, and long-term professional aspirations as captured during the performance review discussion.',
    `cme_hours_completed` DECIMAL(18,2) COMMENT 'Total Continuing Medical Education (CME) credit hours completed by the employee during the review period, as relevant for clinical staff performance evaluation and credentialing compliance.',
    `competency_rating` STRING COMMENT 'Composite rating reflecting the employees demonstration of required competencies (clinical, behavioral, leadership) as defined in the review template for the position.. Valid values are `exceeds|meets|partially_meets|does_not_meet`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this performance review record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `development_goals_narrative` STRING COMMENT 'Free-text description of agreed-upon professional development goals, training plans, and career growth objectives established during the performance review discussion.',
    `discipline_type` STRING COMMENT 'Type of progressive disciplinary action associated with this review record, if applicable. Captures the formal discipline step per HR policy. [ENUM-REF-CANDIDATE: none|verbal_warning|written_warning|pip|suspension|termination_for_cause — promote to reference product]. Valid values are `none|verbal_warning|written_warning|pip|suspension|termination_for_cause`',
    `due_date` DATE COMMENT 'The deadline by which the performance review must be completed and submitted by the manager. Used for HR compliance tracking and SLA monitoring.',
    `employee_acknowledgment_date` DATE COMMENT 'The date on which the employee acknowledged receipt and review of their completed performance evaluation. Required for HR compliance documentation.',
    `goal_achievement_rating` STRING COMMENT 'Composite rating reflecting the employees achievement of defined performance goals and objectives for the review period. Distinct from competency ratings.. Valid values are `exceeds|meets|partially_meets|does_not_meet`',
    `is_high_potential` BOOLEAN COMMENT 'Indicates whether the employee has been formally designated as high-potential (HiPo) during this review cycle, qualifying them for accelerated development programs and succession consideration.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this performance review record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking and audit compliance.',
    `manager_feedback` STRING COMMENT 'Free-text narrative provided by the reviewing manager summarizing the employees performance, strengths, areas for development, and behavioral observations during the review period.',
    `manager_submission_date` DATE COMMENT 'The date on which the manager formally submitted the completed performance review in Workday HCM. Used to measure review completion timeliness against the due date.',
    `mentorship_participant` BOOLEAN COMMENT 'Indicates whether the employee is currently participating in a formal mentorship program (as mentor or mentee) as documented in the talent profile associated with this review.',
    `merit_increase_eligible` BOOLEAN COMMENT 'Indicates whether the employee is eligible for a merit-based compensation increase based on their overall performance rating and HR policy criteria for the review cycle.',
    `merit_increase_percent` DECIMAL(18,2) COMMENT 'The recommended or approved merit salary increase percentage associated with this performance review outcome. Expressed as a percentage of base salary (e.g., 3.50 = 3.5%).',
    `mobility_preference` STRING COMMENT 'Employees stated preference regarding geographic relocation or mobility for career advancement opportunities, as captured in the talent profile during the review cycle.. Valid values are `open_to_relocation|local_only|remote_preferred|no_preference`',
    `overall_rating` STRING COMMENT 'The final overall performance rating assigned by the manager for the review period. Drives merit increase eligibility, promotion decisions, and succession planning. [ENUM-REF-CANDIDATE: exceeds_expectations|meets_expectations|partially_meets|does_not_meet|outstanding — promote to reference product]. Valid values are `exceeds_expectations|meets_expectations|partially_meets|does_not_meet|outstanding`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score corresponding to the overall performance rating on the defined rating scale (e.g., 1.00–5.00). Enables quantitative comparison and ranking across the workforce for merit and succession analytics.',
    `pip_end_date` DATE COMMENT 'The date on which the Performance Improvement Plan (PIP) period concludes. Used to track PIP duration and schedule follow-up evaluations.',
    `pip_outcome` STRING COMMENT 'The final outcome of a Performance Improvement Plan (PIP) upon conclusion of the PIP period. Drives subsequent HR actions such as continued employment, further discipline, or termination.. Valid values are `successful|unsuccessful|extended|withdrawn`',
    `pip_start_date` DATE COMMENT 'The date on which a Performance Improvement Plan (PIP) was formally initiated for the employee. Populated only when discipline_type is pip.',
    `policy_violation_code` STRING COMMENT 'Standardized code identifying the specific HR or organizational policy that was violated, if this review is associated with a disciplinary action. Aligns with the HR policy code library.',
    `promotion_eligible` BOOLEAN COMMENT 'Indicates whether the employee has been identified as eligible for promotion to a higher-level position based on performance review outcomes and manager recommendation.',
    `review_meeting_date` DATE COMMENT 'The date on which the formal performance review discussion meeting was held between the employee and their manager. Distinct from the manager submission date.',
    `review_number` STRING COMMENT 'Business-facing unique identifier for the performance review record as assigned by Workday HCM Talent Management (e.g., PR-2024-00123). Used for HR correspondence and audit references.',
    `review_period_end_date` DATE COMMENT 'The last date of the performance evaluation period covered by this review. Defines the end of the measurement window for goals, competencies, and conduct.',
    `review_period_start_date` DATE COMMENT 'The first date of the performance evaluation period covered by this review. Defines the beginning of the measurement window for goals, competencies, and conduct.',
    `review_status` STRING COMMENT 'Current workflow state of the performance review record within the Workday HCM Talent Management process. Tracks progression from initiation through employee acknowledgment and final closure. [ENUM-REF-CANDIDATE: not_started|in_progress|self_assessment_complete|manager_review_complete|acknowledged|closed|cancelled — promote to reference product]',
    `review_type` STRING COMMENT 'Classification of the review cycle: annual (year-end), mid_year (mid-cycle check-in), probationary (new hire evaluation), pip (Performance Improvement Plan review), disciplinary, promotion eligibility, or project-based. [ENUM-REF-CANDIDATE: annual|mid_year|probationary|pip|disciplinary|promotion|project — promote to reference product]',
    `self_assessment_narrative` STRING COMMENT 'Free-text self-evaluation submitted by the employee describing their own performance, accomplishments, challenges, and development needs for the review period.',
    `source_system_review_code` STRING COMMENT 'The native identifier of this performance review record in the originating Workday HCM Talent Management system. Used for data lineage, reconciliation, and ETL traceability.',
    `succession_plan_included` BOOLEAN COMMENT 'Indicates whether the employee has been included in a formal succession plan for a critical role as a result of or in conjunction with this performance review.',
    `talent_segment` STRING COMMENT 'Talent segmentation category assigned to the employee based on performance and potential assessment. Used for succession planning, retention strategy, and workforce planning. [ENUM-REF-CANDIDATE: high_potential|key_contributor|solid_performer|needs_development|at_risk — promote to reference product]. Valid values are `high_potential|key_contributor|solid_performer|needs_development|at_risk`',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Comprehensive employee performance management, talent development, and conduct records. Captures performance evaluation cycles (annual, mid-year, probationary), overall ratings, goal achievement, competency ratings, manager feedback, self-assessments, development goals, and review completion status. Includes talent profile data: education history, skills inventory, career interests, mobility preferences, mentorship participation, succession plan inclusion, and high-potential designation. Encompasses progressive discipline records: verbal/written warnings, performance improvement plans (PIPs), suspensions, terminations for cause, policy violations, appeal status, and resolution outcomes. Supports merit increases, promotion eligibility, internal mobility, succession management, workforce planning, and HR compliance documentation. SSOT for all employee performance, talent, and disciplinary data. Sourced from Workday HCM Talent Management.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` (
    `recruitment_id` BIGINT COMMENT 'Unique surrogate identifier for each recruitment record in the Healthcare workforce recruitment lifecycle. Primary key for the recruitment data product. Entity role: TRANSACTION_HEADER — represents a discrete end-to-end hiring event from job requisition through productive employee onboarding.',
    `applicant_id` BIGINT COMMENT 'Reference to the applicant/candidate record in the workforce applicant master. Serves as the PARTY_REFERENCE linking this recruitment transaction to the individual being hired.',
    `care_site_id` BIGINT COMMENT 'Identifier of the hospital, clinic, or outpatient facility where the recruited position is located. Supports multi-facility healthcare system workforce analytics and OSHA facility-level compliance reporting.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Recruitment is for a specific job profile - the standardized role definition that includes requirements, pay grade, competencies, and job family. recruitment currently has job_title and job_family (de',
    `position_id` BIGINT COMMENT 'Reference to the authorized position this recruitment is filling, linking to the workforce position master for headcount control and budgeted Full-Time Equivalent (FTE) validation.',
    `employee_id` BIGINT COMMENT 'Identifier of the HR recruiter assigned to manage this requisition through the full recruitment lifecycle. Used for recruiter workload balancing, time-to-fill performance tracking, and cost-per-hire attribution.',
    `recruitment_hiring_manager_employee_id` BIGINT COMMENT 'Identifier of the manager who initiated the requisition and is responsible for the hiring decision. Used for approval workflow routing and interview panel coordination.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the hiring department or clinical unit to which the recruited employee will be assigned. Used for cost center allocation, headcount reporting, and onboarding routing.',
    `actual_start_date` DATE COMMENT 'The actual first day the new hire reported to work. May differ from target start date due to background check delays or candidate requests. Used for time-to-fill final calculation and onboarding milestone tracking.',
    `applicant_email` STRING COMMENT 'Primary email address of the applicant used for all recruitment communications, interview scheduling, offer delivery, and onboarding portal access provisioning.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `applicant_phone` STRING COMMENT 'Primary contact phone number for the applicant used by recruiters for interview scheduling and offer negotiation communications.. Valid values are `^+?[1-9]d{1,14}$`',
    `application_date` DATE COMMENT 'The date the candidate submitted their application for this position. Used to calculate application-to-offer cycle time and EEOC applicant flow log reporting.',
    `background_check_date` DATE COMMENT 'The date the pre-employment background check was initiated with the screening vendor. Used for compliance tracking and onboarding timeline management.',
    `background_check_status` STRING COMMENT 'Current status of the pre-employment background check for the candidate. Required for all healthcare employees per CMS Conditions of Participation and OIG exclusion screening requirements. Blocks onboarding until cleared.. Valid values are `not_initiated|in_progress|clear|adverse|pending_review|cancelled`',
    `badge_issued` BOOLEAN COMMENT 'Indicates whether a physical access control badge has been issued to the new hire. Required for facility access and patient safety compliance. Tracked as part of onboarding task completion.',
    `cost_per_hire` DECIMAL(18,2) COMMENT 'Total recruitment cost associated with filling this position, including advertising, agency fees, recruiter time, and pre-employment screening costs in USD. Key Key Performance Indicator (KPI) for recruitment efficiency benchmarking.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recruitment record was first created in the system. Serves as the RECORD_AUDIT_CREATED field for audit trail and data lineage purposes.',
    `drug_screen_status` STRING COMMENT 'Status of the pre-employment drug screening test for the candidate. Required for clinical and safety-sensitive positions per OSHA and facility policy. Blocks onboarding for positive results.. Valid values are `not_initiated|pending|negative|positive|cancelled`',
    `employment_type` STRING COMMENT 'Classification of the employment arrangement for the recruited position. Determines benefits eligibility, Full-Time Equivalent (FTE) counting, and payroll processing rules.. Valid values are `full_time|part_time|per_diem|contract|temporary|intern`',
    `fire_safety_training_completed` BOOLEAN COMMENT 'Indicates whether the new hire has completed mandatory fire safety and life safety training as required by The Joint Commission (TJC) Environment of Care standards and OSHA regulations.',
    `fte_value` DECIMAL(18,2) COMMENT 'The Full-Time Equivalent (FTE) value associated with this recruited position, expressed as a decimal (e.g., 1.0 for full-time, 0.5 for half-time). Used for budgeted headcount control and workforce capacity planning.',
    `hipaa_training_completed` BOOLEAN COMMENT 'Indicates whether the new hire has completed mandatory Health Insurance Portability and Accountability Act (HIPAA) privacy and security training as required for all healthcare workforce members with access to Protected Health Information (PHI).',
    `hire_date` DATE COMMENT 'The official date the candidate is hired and becomes an employee of the healthcare organization. Triggers payroll enrollment, benefits eligibility, and system access provisioning. Used as the anchor date for tenure and probationary period calculations.',
    `hire_decision` STRING COMMENT 'The final hiring decision outcome for this recruitment record. Used for EEOC applicant flow log reporting, source-of-hire analytics, and requisition closure.. Valid values are `hired|not_selected|withdrawn|offer_declined`',
    `i9_completion_date` DATE COMMENT 'The date the Form I-9 Employment Eligibility Verification was completed and verified for the new hire. Used for USCIS compliance audits and onboarding task closure.',
    `i9_verification_status` STRING COMMENT 'Status of the Form I-9 Employment Eligibility Verification for the new hire. Mandatory for all U.S. employees per USCIS requirements. Must be completed within 3 business days of hire date.. Valid values are `not_started|pending|completed|reverification_required`',
    `infection_control_training_completed` BOOLEAN COMMENT 'Indicates whether the new hire has completed mandatory infection control training as required by The Joint Commission (TJC), CMS Conditions of Participation, and OSHA bloodborne pathogen standards.',
    `interview_date` DATE COMMENT 'Date of the most recent or primary interview conducted with the applicant. Used for scheduling coordination and time-to-hire milestone tracking.',
    `interview_stage` STRING COMMENT 'The most recent interview stage completed by the applicant. Used to track interview progression, panel scheduling, and candidate experience metrics.. Valid values are `phone_screen|hiring_manager|panel|final|none`',
    `is_clinical_position` BOOLEAN COMMENT 'Indicates whether the recruited position is a clinical role requiring licensure verification, credentialing, or privileging through Symplr or the medical staff office. Triggers additional pre-employment screening workflows.',
    `license_verified` BOOLEAN COMMENT 'Indicates whether the required professional license for the recruited position has been primary source verified prior to the hire date. Mandatory for licensed clinical positions per The Joint Commission (TJC) and CMS standards.',
    `offer_accepted_date` DATE COMMENT 'The date the candidate formally accepted the employment offer. Used to calculate offer-to-start cycle time and trigger pre-employment screening and onboarding workflows.',
    `offer_date` DATE COMMENT 'The date a formal employment offer was extended to the candidate. Used to calculate offer-to-acceptance cycle time and recruiter performance metrics.',
    `offer_status` STRING COMMENT 'Current status of the employment offer extended to the candidate. Drives offer acceptance rate reporting and compensation negotiation tracking.. Valid values are `pending|accepted|declined|rescinded|expired`',
    `offered_salary` DECIMAL(18,2) COMMENT 'The base annual salary amount offered to the candidate in the employment offer letter, in USD. Used for compensation equity analysis, pay range compliance, and budget variance reporting.',
    `oig_exclusion_checked` BOOLEAN COMMENT 'Indicates whether the candidate has been screened against the Office of Inspector General (OIG) List of Excluded Individuals and Entities (LEIE) prior to hire. Mandatory for all healthcare employees to prevent Medicare/Medicaid fraud exposure.',
    `onboarding_completion_date` DATE COMMENT 'The actual date all required onboarding tasks were completed and the new hire was deemed fully productive. Used to calculate onboarding cycle time and close the recruitment record.',
    `onboarding_status` STRING COMMENT 'Current overall status of the new hire onboarding process. Aggregates task-level completion into a single status for manager dashboards and HR compliance reporting.. Valid values are `not_started|in_progress|completed|overdue`',
    `onboarding_target_completion_date` DATE COMMENT 'The target date by which all onboarding tasks (I-9, orientation, required training, badge, system access, policy acknowledgments) must be completed for the new hire. Used for onboarding compliance tracking and manager accountability.',
    `orientation_completion_date` DATE COMMENT 'The date the new hire completed all required new employee orientation sessions. Used as a milestone for onboarding completion tracking and The Joint Commission (TJC) accreditation documentation.',
    `orientation_status` STRING COMMENT 'Status of the new employee orientation attendance for the onboarding new hire. Includes general hospital orientation and department-specific orientation sessions required by The Joint Commission (TJC).. Valid values are `not_scheduled|scheduled|in_progress|completed|waived`',
    `pay_grade` STRING COMMENT 'The compensation pay grade assigned to the offered position, as defined in the Workday HCM compensation structure. Used to validate that the offered salary falls within the approved pay range for the position.',
    `pipeline_stage` STRING COMMENT 'Current stage of the applicant within the recruitment pipeline funnel. Drives workflow automation, recruiter task assignment, and applicant pipeline conversion analytics. [ENUM-REF-CANDIDATE: applied|screening|interview|offer|background_check|hired|rejected|withdrawn — 8 candidates stripped; promote to reference product]',
    `policy_acknowledgment_completed` BOOLEAN COMMENT 'Indicates whether the new hire has completed all required policy acknowledgments (Code of Conduct, HIPAA, Social Media, Workplace Violence, etc.) as part of onboarding. Required for compliance and accreditation.',
    `posting_date` DATE COMMENT 'The date the job requisition was first posted to external and/or internal job boards. Used to calculate time-to-fill and assess posting channel effectiveness.',
    `required_license_type` STRING COMMENT 'The professional license type required for the recruited position (e.g., RN, LPN, MD, NP, PA, PharmD, RT). Used to trigger license verification workflows in Symplr and ensure regulatory compliance prior to hire.',
    `requisition_number` STRING COMMENT 'Externally-known business identifier for the job requisition as assigned by Workday HCM Recruiting. Used across HR, Finance, and hiring manager communications to track the open position request. Serves as the BUSINESS_IDENTIFIER for this TRANSACTION_HEADER entity.. Valid values are `^REQ-[0-9]{4}-[0-9]{6}$`',
    `requisition_open_date` DATE COMMENT 'The date the job requisition was officially opened and approved for active recruiting. Serves as the BUSINESS_EVENT_TIMESTAMP anchor for time-to-fill calculations and recruiter performance metrics.',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the job requisition within the recruitment workflow. Drives workflow routing, headcount reporting, and recruiter workload management. Serves as the LIFECYCLE_STATUS for this TRANSACTION_HEADER entity.. Valid values are `draft|open|on_hold|filled|cancelled|closed`',
    `source_of_hire` STRING COMMENT 'The recruitment channel or source through which the successful candidate was identified (e.g., Indeed, LinkedIn, employee referral, internal transfer, agency, career fair, Workday career site). Key metric for recruitment marketing ROI analysis. [ENUM-REF-CANDIDATE: indeed|linkedin|employee_referral|internal_transfer|agency|career_fair|workday_career_site|direct_application|university|other — promote to reference product]',
    `system_access_provisioned` BOOLEAN COMMENT 'Indicates whether Electronic Health Record (EHR) and required clinical/administrative system access has been provisioned for the new hire. Includes Epic EHR, Workday, and role-specific application access per HIPAA minimum necessary standard.',
    `target_start_date` DATE COMMENT 'The planned first day of work for the new hire as agreed in the offer letter. Used for onboarding scheduling, system access provisioning timelines, and department readiness planning.',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days from requisition open date to offer accepted date. Primary recruitment efficiency Key Performance Indicator (KPI) used for recruiter performance management and workforce planning benchmarking.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this recruitment record was last modified. Serves as the RECORD_AUDIT_UPDATED field for change tracking and data lineage in the Silver layer lakehouse.',
    `workday_candidate_code` STRING COMMENT 'The source system candidate identifier assigned by Workday HCM Recruiting. Used for system-of-record traceability, ETL reconciliation, and integration with Workday HCM Core HR upon hire.',
    CONSTRAINT pk_recruitment PRIMARY KEY(`recruitment_id`)
) COMMENT 'End-to-end recruitment and onboarding lifecycle from job requisition through productive employee. Captures requisition details, posting channels, applicant pipeline, interview stages, offer details, background check status, pre-employment screening results, and hire decision. Includes complete onboarding process: I-9 verification, orientation attendance, policy acknowledgments, system access provisioning, required training completions (HIPAA, infection control, fire safety), badge issuance, department-specific orientation, onboarding start date, target completion date, and task-level completion status. Tracks time-to-fill, source of hire, cost per hire, recruiter assignment. Links to authorized positions for headcount control. SSOT for all hiring and onboarding data. Sourced from Workday HCM Recruiting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` (
    `osha_incident_id` BIGINT COMMENT 'Unique system-generated identifier for each OSHA-recordable workplace injury, illness, or near-miss incident record. Primary key for the osha_incident data product.',
    `care_site_id` BIGINT COMMENT 'Reference to the healthcare facility (hospital, clinic, outpatient center) where the incident occurred.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or contract staff member involved in the incident. Links to the workforce worker/employee master record.',
    `improvement_initiative_id` BIGINT COMMENT 'Foreign key linking to quality.improvement_initiative. Business justification: Healthcare organizations track employee safety incidents (OSHA) alongside patient safety for accreditation and organizational safety culture improvement. When workplace injuries reveal systemic issues',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: OSHA recordable injuries/illnesses coded with ICD-10-CM for workers compensation claims, OSHA 300 log, and BLS injury/illness survey reporting. Real-world: workers comp first reports of injury, OSHA',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Detailed injury/illness documentation using SNOMED for occupational health EHR integration and injury surveillance analytics. Real-world: employee health records, sharps injury tracking, bloodborne pa',
    `position_id` BIGINT COMMENT 'Reference to the workforce position held by the employee at the time of the incident, used to determine OSHA job hazard category and FTE classification.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to insurance.payer. Business justification: OSHA incidents with workers compensation claims require tracking the workers comp insurance payer for claim submission, payment reconciliation, subrogation, and regulatory reporting. Healthcare orga',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: OSHA incidents must be tracked by organizational unit for regulatory reporting and safety analytics. osha_incident currently has department_name (denormalized string) but no FK to org_unit. Adding wor',
    `bloodborne_pathogen_exposure` BOOLEAN COMMENT 'Indicates whether the incident involved potential exposure to bloodborne pathogens (e.g., HIV, HBV, HCV) through needlestick, sharps injury, or mucous membrane contact. Triggers post-exposure prophylaxis (PEP) protocol.',
    `body_part_affected` STRING COMMENT 'The specific body part injured or affected by the illness (e.g., lower back, right hand, eye, finger). Captured per OSHA Form 301 requirements and used for ergonomic and safety trend analysis.',
    `body_side` STRING COMMENT 'Laterality of the body part affected (left, right, bilateral, or not applicable). Supports clinical follow-up and workers compensation documentation.. Valid values are `left|right|bilateral|not_applicable`',
    `corrective_action_completed_date` DATE COMMENT 'Actual date all corrective actions for the incident were completed and verified. Used to measure safety program effectiveness and close the incident lifecycle.',
    `corrective_action_description` STRING COMMENT 'Description of the corrective and preventive actions taken or planned in response to the incident root cause analysis, including engineering controls, administrative controls, and PPE measures.',
    `corrective_action_due_date` DATE COMMENT 'Target completion date for the corrective actions identified in the incident investigation. Used to track remediation timeliness and safety program accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the OSHA incident record was first created in the system. Used for audit trail and data lineage.',
    `days_away_from_work` STRING COMMENT 'Number of calendar days the employee was away from work due to the injury or illness, as recorded on the OSHA 300 log. Capped at 180 days per OSHA reporting rules.',
    `days_restricted_duty` STRING COMMENT 'Number of calendar days the employee was on restricted work activity or job transfer due to the injury or illness, as recorded on the OSHA 300 log. Capped at 180 days per OSHA reporting rules.',
    `event_source` STRING COMMENT 'The object, substance, or exposure that directly produced or inflicted the injury or illness (e.g., needle/syringe, patient handling, floor surface, chemical agent). Coded per BLS OIICS source codes.',
    `incident_datetime` TIMESTAMP COMMENT 'The precise date and time the workplace injury, illness, or near-miss event occurred. This is the principal real-world event timestamp for the incident.',
    `incident_description` STRING COMMENT 'Narrative description of how the injury or illness occurred, including the sequence of events, task being performed, and circumstances. Required field on OSHA Form 301. Classified confidential due to sensitive employee health and safety information.',
    `incident_location` STRING COMMENT 'Specific location within the facility where the incident occurred (e.g., ICU Room 4B, Emergency Department triage bay, pharmacy dispensing area, parking lot). Supports facility safety mapping.',
    `incident_number` STRING COMMENT 'Externally-known, human-readable unique identifier assigned to the incident for tracking, reporting, and OSHA 300 log entry reference (e.g., INC-2024-000123).. Valid values are `^INC-[0-9]{4}-[0-9]{6}$`',
    `incident_status` STRING COMMENT 'Current lifecycle status of the incident record, tracking workflow from initial report through investigation closure or appeal.. Valid values are `open|under_review|closed|appealed|voided`',
    `incident_type` STRING COMMENT 'Classification of the type of workplace incident. Common healthcare incident types include needlestick injuries, musculoskeletal injuries, chemical or bloodborne pathogen exposures, slips/falls, and near-miss events. [ENUM-REF-CANDIDATE: needlestick|musculoskeletal|chemical_exposure|slip_fall|struck_by|near_miss|bloodborne_exposure|respiratory — promote to reference product]',
    `injury_illness_type` STRING COMMENT 'OSHA Form 300 column classification indicating whether the event resulted in an injury or one of the five illness categories as defined by OSHA recordkeeping rules.. Valid values are `injury|skin_disorder|respiratory_condition|poisoning|hearing_loss|all_other_illness`',
    `investigation_completed_date` DATE COMMENT 'Date the formal incident investigation was completed and findings were documented. Used to measure investigation timeliness and compliance with internal safety program SLAs.',
    `is_fatality` BOOLEAN COMMENT 'Indicates whether the incident resulted in the death of the employee. Fatalities must be reported to OSHA within 8 hours under 29 CFR Part 1904.39.',
    `is_hospitalized` BOOLEAN COMMENT 'Indicates whether the employee was admitted as an inpatient to a hospital as a result of the incident. Inpatient hospitalizations must be reported to OSHA within 24 hours.',
    `is_osha_recordable` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA recordability criteria under 29 CFR Part 1904.7 (general recording criteria). True if the incident resulted in days away from work, restricted duty, medical treatment beyond first aid, loss of consciousness, or diagnosis of a significant injury/illness.',
    `is_privacy_case` BOOLEAN COMMENT 'Indicates whether the incident qualifies as a privacy case under OSHA 29 CFR Part 1904.29(b)(7), where the employees name is withheld from the OSHA 300 log to protect confidentiality (e.g., sexual assault, mental illness, HIV/AIDS, needlestick).',
    `is_work_related` BOOLEAN COMMENT 'Indicates whether the injury or illness is determined to be work-related per OSHA 29 CFR Part 1904.5. Work-relatedness is a prerequisite for OSHA recordability.',
    `nature_of_injury` STRING COMMENT 'Describes the physical characteristics of the injury or illness (e.g., laceration, sprain/strain, contusion, puncture wound, burn, fracture). Coded per BLS OIICS nature codes.',
    `osha_300_log_entry_date` DATE COMMENT 'Date the incident was entered onto the OSHA Form 300 Log of Work-Related Injuries and Illnesses. OSHA requires entry within 7 calendar days of receiving information that a recordable case occurred.',
    `osha_300a_included` BOOLEAN COMMENT 'Indicates whether this incident has been included in the OSHA Form 300A Annual Summary of Work-Related Injuries and Illnesses for the applicable calendar year.',
    `osha_301_completed` BOOLEAN COMMENT 'Indicates whether the OSHA Form 301 Injury and Illness Incident Report (or equivalent workers compensation first report of injury) has been completed for this incident.',
    `osha_establishment_number` STRING COMMENT 'The OSHA establishment identifier for the specific business location/facility as registered with OSHA. Required for OSHA 300 log maintenance and electronic submission via OSHAs Injury Tracking Application (ITA).',
    `post_exposure_followup_completed` BOOLEAN COMMENT 'Indicates whether the required post-exposure medical evaluation and follow-up was completed for bloodborne pathogen or chemical exposure incidents, per OSHA and CDC protocols.',
    `ppe_in_use` BOOLEAN COMMENT 'Indicates whether the employee was using required personal protective equipment (PPE) at the time of the incident. Used to assess PPE compliance and effectiveness.',
    `ppe_type` STRING COMMENT 'Type of PPE in use or required at the time of the incident (e.g., gloves, N95 respirator, safety goggles, gown, face shield). Supports PPE adequacy assessment.',
    `reported_datetime` TIMESTAMP COMMENT 'Date and time the incident was formally reported by the employee or supervisor to the safety/HR department. Used to measure reporting timeliness compliance.',
    `return_to_work_date` DATE COMMENT 'Date the employee returned to full or modified duty following the incident. Used to calculate total lost time and validate days-away-from-work counts.',
    `root_cause_category` STRING COMMENT 'High-level categorization of the primary root cause identified through incident investigation. Used to drive corrective action prioritization and systemic safety improvement programs. [ENUM-REF-CANDIDATE: human_error|equipment_failure|process_gap|environmental|training_deficiency|policy_noncompliance|unknown — 7 candidates stripped; promote to reference product]',
    `root_cause_description` STRING COMMENT 'Detailed narrative of the root cause analysis (RCA) findings, including contributing factors, system failures, and causal chain. Supports corrective action planning and regulatory reporting.',
    `severity_level` STRING COMMENT 'Severity classification of the incident outcome, ranging from near-miss through fatality. Drives OSHA recordability determination, workers compensation tier, and escalation protocols. [ENUM-REF-CANDIDATE: near_miss|first_aid|medical_treatment|restricted_duty|days_away|hospitalization|fatality — 7 candidates stripped; promote to reference product]',
    `shift_type` STRING COMMENT 'The work shift during which the incident occurred (day, evening, night, rotating, on-call). Used to identify shift-related safety patterns and fatigue risk.. Valid values are `day|evening|night|rotating|on_call`',
    `supervisor_name` STRING COMMENT 'Name of the employees direct supervisor at the time of the incident, as required on OSHA Form 301. Used for accountability tracking and investigation coordination.',
    `treating_provider_name` STRING COMMENT 'Name of the physician or healthcare provider who treated the injured or ill employee. Required on OSHA Form 301 Section 17.',
    `treatment_facility_name` STRING COMMENT 'Name of the medical facility where the employee received treatment (e.g., occupational health clinic, emergency department, urgent care). Required on OSHA Form 301.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the OSHA incident record was most recently modified, supporting audit trail and change tracking.',
    `witness_names` STRING COMMENT 'Names of any witnesses to the incident. Stored as a delimited string. Classified confidential to protect witness privacy during investigation.',
    `workers_comp_claim_number` STRING COMMENT 'The workers compensation claim number assigned by the insurer or third-party administrator for this incident. Links the OSHA incident record to the workers compensation claim for financial and legal tracking.',
    CONSTRAINT pk_osha_incident PRIMARY KEY(`osha_incident_id`)
) COMMENT 'OSHA-recordable workplace injury, illness, and near-miss incident records for healthcare employees. Captures incident date/time, employee involved, incident type (needlestick, musculoskeletal, exposure, slip/fall), body part affected, injury severity, OSHA recordability determination, days away from work, restricted duty days, root cause analysis, corrective actions, and OSHA 300/300A log entries. Supports OSHA compliance reporting.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` (
    `fte_budget_id` BIGINT COMMENT 'Unique surrogate identifier for each authorized FTE budget allocation record in the workforce financial planning system.',
    `care_site_id` BIGINT COMMENT 'Reference to the physical facility (hospital, clinic, outpatient center) where this FTE budget is authorized. Supports multi-site workforce planning and staffing ratio compliance.',
    `fiscal_period_id` BIGINT COMMENT 'Foreign key linking to finance.fiscal_period. Business justification: FTE budgets are tracked by fiscal period for monthly/quarterly workforce planning. Enables period-over-period FTE variance analysis, budget phasing, and alignment of workforce budget cycles with finan',
    `position_id` BIGINT COMMENT 'Reference to the authorized position in Workday HCM to which this FTE budget line is tied. Enables position-level budget tracking and vacancy analysis.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: FTE budget is allocated by organizational unit. fte_budget currently has department_id (BIGINT with no FK target) and department_name (denormalized string). Adding workforce_org_unit_id links to the a',
    `actual_fte` DECIMAL(18,2) COMMENT 'The actual FTE count consumed during the fiscal period, sourced from Workday HCM time and attendance data. Used for variance analysis against budgeted FTE.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual hours worked recorded in Workday HCM time and attendance for this budget line during the fiscal period. Used for FTE conversion and productivity benchmarking.',
    `actual_labor_cost` DECIMAL(18,2) COMMENT 'Actual labor cost incurred in USD for this budget line during the fiscal period, sourced from SAP S/4HANA payroll postings. Compared against budgeted_labor_cost for variance analysis.',
    `agency_fte` DECIMAL(18,2) COMMENT 'The FTE equivalent of agency or contract labor utilized within this budget line during the fiscal period. Tracked separately from employed FTE for labor cost benchmarking and workforce mix analysis.',
    `approval_date` DATE COMMENT 'The date on which this FTE budget allocation was formally approved by the authorized budget authority. Marks the transition from pending to approved status.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the budget authority (e.g., CFO, VP of Finance, Department Director) who approved this FTE budget allocation. Supports audit trail and governance requirements.',
    `benefits_burden_pct` DECIMAL(18,2) COMMENT 'The percentage applied to base wages to account for employer-paid benefits costs (health insurance, retirement, FICA, workers compensation) for this FTE budget line. Used to calculate total labor cost including benefits.',
    `budget_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this FTE budget allocation record, used for cross-system reference between SAP S/4HANA CO and Workday HCM.. Valid values are `^[A-Z0-9-]{4,20}$`',
    `budget_status` STRING COMMENT 'Current workflow status of this FTE budget allocation record: draft (in preparation), pending_approval (submitted for review), approved (authorized), rejected (denied), or superseded (replaced by a revised version).. Valid values are `draft|pending_approval|approved|rejected|superseded`',
    `budget_version` STRING COMMENT 'Identifies the version of the FTE budget record: original (initial approved budget), revised (mid-year amendment), final (year-end actuals reconciliation), or forecast (rolling forecast update). Supports budget cycle management.. Valid values are `original|revised|final|forecast`',
    `budgeted_avg_hourly_rate` DECIMAL(18,2) COMMENT 'The budgeted average hourly wage rate in USD for positions covered by this FTE budget line, inclusive of base pay and applicable differentials. Used for labor cost projection and variance analysis.',
    `budgeted_fte` DECIMAL(18,2) COMMENT 'The authorized number of Full-Time Equivalent (FTE) positions approved for this department, cost center, job family, and fiscal period. Expressed as a decimal (e.g., 2.5 FTE). The principal quantitative fact of this budget record.',
    `budgeted_hours` DECIMAL(18,2) COMMENT 'Total authorized worked hours budgeted for this FTE line in the fiscal period. Derived from budgeted FTE and standard hours per period; stored for direct comparison with actual hours from time and attendance.',
    `budgeted_labor_cost` DECIMAL(18,2) COMMENT 'Total authorized labor cost in USD for this FTE budget line for the fiscal period, including base wages, differentials, and benefits burden. Used for workforce financial planning and labor cost management.',
    `budgeted_nonproductive_fte` DECIMAL(18,2) COMMENT 'The portion of the total budgeted FTE allocated to non-productive hours including paid time off (PTO), orientation, education, and leave. Supports total labor cost planning.',
    `budgeted_overtime_fte` DECIMAL(18,2) COMMENT 'The FTE equivalent of overtime hours budgeted for this department and fiscal period. Supports overtime cost management and FLSA compliance monitoring.',
    `budgeted_productive_fte` DECIMAL(18,2) COMMENT 'The portion of the total budgeted FTE allocated specifically to productive (direct patient care) hours. Used to calculate staffing ratios and productivity benchmarks per adjusted patient day.',
    `cost_center_code` STRING COMMENT 'SAP S/4HANA CO cost center code to which this FTE budget is financially assigned. Enables labor cost allocation and variance reporting at the cost center level.. Valid values are `^[A-Z0-9-]{3,15}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this FTE budget record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `effective_date` DATE COMMENT 'The date from which this FTE budget allocation becomes effective and binding for workforce planning and financial reporting purposes.',
    `employment_type` STRING COMMENT 'Classification of the workforce category for this FTE budget line: full-time, part-time, per diem, contract, or agency staff. Supports workforce mix planning and FTE conversion calculations.. Valid values are `full_time|part_time|per_diem|contract|agency`',
    `end_date` DATE COMMENT 'The date on which this FTE budget allocation expires or is superseded. Null for open-ended or current-period budgets. Supports temporal budget management and historical reporting.',
    `fiscal_period` STRING COMMENT 'The fiscal period (quarter Q1–Q4 or accounting period P01–P12) within the fiscal year for which this FTE budget is authorized. Supports monthly and quarterly workforce financial planning cycles.. Valid values are `^(Q[1-4]|P(0[1-9]|1[0-2]))$`',
    `fiscal_year` STRING COMMENT 'The four-digit fiscal year to which this FTE budget allocation applies, aligned with the organizations financial planning calendar (e.g., 2024).',
    `flsa_classification` STRING COMMENT 'FLSA classification of the positions covered by this FTE budget line: exempt (salaried, not eligible for overtime) or non-exempt (hourly, eligible for overtime pay). Drives overtime budget calculations.. Valid values are `exempt|non_exempt`',
    `fte_variance` DECIMAL(18,2) COMMENT 'The difference between budgeted FTE and actual FTE (budgeted_fte minus actual_fte) for the fiscal period. Positive value indicates under-utilization; negative value indicates over-budget staffing. Supports labor cost variance reporting.',
    `is_union_position` BOOLEAN COMMENT 'Indicates whether this FTE budget line covers union-represented positions (True) or non-union positions (False). Affects labor cost modeling, scheduling constraints, and collective bargaining agreement compliance.',
    `job_code` STRING COMMENT 'Workday HCM job profile code identifying the specific job classification for this FTE budget line. Aligns with pay grade structures and staffing ratio standards.. Valid values are `^[A-Z0-9-]{3,15}$`',
    `job_family` STRING COMMENT 'Workday HCM job family classification grouping positions by functional role (e.g., Nursing, Physician, Allied Health, Administrative, Support Services). Used for workforce mix analysis and productivity benchmarking. [ENUM-REF-CANDIDATE: Nursing|Physician|Allied Health|Administrative|Support Services|Pharmacy|Laboratory|Radiology|Therapy — promote to reference product]',
    `labor_cost_per_apd` DECIMAL(18,2) COMMENT 'Budgeted labor cost divided by adjusted patient days (APD) for the fiscal period. A key productivity benchmark metric used in healthcare workforce financial planning and CMS value-based purchasing (VBP) reporting.',
    `labor_cost_variance` DECIMAL(18,2) COMMENT 'The difference between budgeted and actual labor cost (budgeted_labor_cost minus actual_labor_cost) in USD. Positive value indicates favorable variance (under budget); negative indicates unfavorable (over budget).',
    `notes` STRING COMMENT 'Free-text field for budget analysts to document justifications, assumptions, mid-year amendments, or special circumstances associated with this FTE budget allocation (e.g., new service line launch, regulatory mandate, census-driven adjustment).',
    `pay_grade` STRING COMMENT 'Workday HCM pay grade assigned to the positions in this FTE budget line. Determines the salary band used for labor cost budgeting and compensation planning.. Valid values are `^[A-Z0-9-]{1,10}$`',
    `pay_type` STRING COMMENT 'Classification of the FTE budget by labor pay category: productive (direct patient care hours), non-productive (PTO, education, orientation), overtime, on-call, or agency/contract labor. Critical for labor cost management and productivity benchmarking.. Valid values are `productive|non_productive|overtime|on_call|agency`',
    `productivity_target_pct` DECIMAL(18,2) COMMENT 'The target productive hours as a percentage of total paid hours for this department and job family (e.g., 85.00%). Used for productivity benchmarking and workforce efficiency reporting.',
    `staffing_ratio_target` DECIMAL(18,2) COMMENT 'The target nurse-to-patient or staff-to-patient ratio for this department and job family as defined by regulatory or organizational standards (e.g., 1:4 for ICU nursing). Supports staffing ratio compliance monitoring.',
    `standard_hours_per_fte` DECIMAL(18,2) COMMENT 'The number of hours per fiscal period that constitutes one FTE for this job family and employment type (e.g., 2080 hours annually, 173.33 hours monthly). Used as the FTE conversion denominator.',
    `union_code` STRING COMMENT 'Code identifying the labor union or collective bargaining unit associated with this FTE budget line (e.g., SEIU, CNA, AFSCME). Impacts wage rates, scheduling rules, and staffing ratio requirements.. Valid values are `^[A-Z0-9-]{2,10}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this FTE budget record was most recently modified, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking and audit compliance.',
    `vacancy_fte` DECIMAL(18,2) COMMENT 'The number of FTE positions that are budgeted but currently unfilled (budgeted_fte minus filled FTE). Supports vacancy rate reporting, recruitment planning, and agency/contract labor justification.',
    CONSTRAINT pk_fte_budget PRIMARY KEY(`fte_budget_id`)
) COMMENT 'Authorized FTE (Full-Time Equivalent) budget allocations by department, cost center, and fiscal period. Captures budgeted FTE count by job family and pay type (productive, non-productive, overtime), actual FTE utilization, variance analysis, budget approval status, and labor cost per adjusted patient day. Supports workforce financial planning, labor cost management, productivity benchmarking, and staffing ratio compliance. Integrates with SAP S/4HANA CO and Workday HCM.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Primary key for org_unit',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the immediate parent organizational unit in the workforce hierarchy, enabling recursive traversal of the org tree (e.g., a department rolls up to a division).',
    `care_site_id` BIGINT COMMENT 'Reference to the physical facility (hospital, clinic, outpatient center) with which this organizational unit is primarily associated. Links workforce org structure to the facility domain.',
    `accreditation_program` STRING COMMENT 'Name of the accreditation program or body applicable to this organizational unit (e.g., TJC, DNV, CARF). Supports compliance tracking and survey readiness reporting.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the individual who approved the creation or most recent structural change to this organizational unit. Supports governance and change management audit trails.',
    `approved_date` DATE COMMENT 'Date on which the creation or most recent structural change to this organizational unit was formally approved. Supports governance workflows and audit documentation.',
    `authorized_headcount` STRING COMMENT 'The total number of approved positions (headcount) authorized for this organizational unit, regardless of FTE value. Distinct from budgeted FTE as it counts positions, not effort.',
    `budgeted_fte` DECIMAL(18,2) COMMENT 'The approved budgeted full-time equivalent (FTE) headcount for this organizational unit for the current fiscal period. Used in workforce planning, variance analysis, and staffing ratio reporting.',
    `org_unit_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the organizational unit within the enterprise. Used in reporting, payroll, and HR system integrations (e.g., DEPT-CARDIO, DIV-SURG).. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `company_code` STRING COMMENT 'SAP S/4HANA company code representing the legal entity or subsidiary to which this organizational unit belongs. Required for multi-entity financial consolidation and intercompany reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the source system (Workday HCM). Supports audit trail and data lineage requirements.',
    `division_name` STRING COMMENT 'Name of the division to which this organizational unit belongs within the enterprise workforce hierarchy. Supports divisional rollup reporting in Workday HCM.',
    `effective_date` DATE COMMENT 'The date on which this organizational unit record became or becomes operationally active. Supports bi-temporal modeling and point-in-time workforce reporting.',
    `email_address` STRING COMMENT 'Primary contact email address for this organizational unit, used for internal communications, scheduling notifications, and HR correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `end_date` DATE COMMENT 'The date on which this organizational unit record was or will be deactivated or dissolved. Null indicates the record is currently active. Supports historical org structure analysis.',
    `fiscal_year_start_month` STRING COMMENT 'The calendar month (1–12) in which the fiscal year begins for this organizational unit. Used for budget cycle alignment and financial period reporting.',
    `gl_account_code` STRING COMMENT 'General ledger (GL) account code associated with this organizational unit for financial expense and revenue posting in SAP S/4HANA FI. Enables financial consolidation and audit trail.. Valid values are `^[0-9]{4,10}$`',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this organizational unit within the enterprise hierarchy. Level 1 represents the top-most entity (e.g., enterprise or health system); higher numbers represent deeper nesting.',
    `hierarchy_path` STRING COMMENT 'Delimited string representing the full ancestry path from the root org unit to this unit (e.g., Health System > Surgical Division > Cardiothoracic Department). Supports hierarchy-aware reporting without recursive queries.',
    `is_clinical` BOOLEAN COMMENT 'Indicates whether this organizational unit is a clinical unit directly involved in patient care delivery. Drives clinical staffing ratios, credentialing requirements, and regulatory reporting.',
    `is_revenue_generating` BOOLEAN COMMENT 'Indicates whether this organizational unit directly generates revenue through patient services, procedures, or billable activities. Used in revenue cycle management (RCM) and financial planning.',
    `is_supervisory_org` BOOLEAN COMMENT 'Indicates whether this org unit is designated as a Workday HCM supervisory organization, which governs worker assignments, position management, and approval chains.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this organizational unit record in the source system. Used for incremental data loading, change detection, and audit compliance.',
    `location_type` STRING COMMENT 'Categorizes the physical or virtual care setting of this organizational unit. Drives staffing model selection, billing rules, and regulatory reporting requirements.. Valid values are `inpatient|outpatient|ambulatory|emergency|virtual|administrative`',
    `org_unit_name` STRING COMMENT 'Full human-readable name of the organizational unit as displayed in Workday HCM and workforce reporting (e.g., Cardiology Department, Surgical Services Division).',
    `osha_establishment_number` STRING COMMENT 'Occupational Safety and Health Administration (OSHA) establishment identifier for this organizational unit, used for OSHA 300 log reporting, injury/illness tracking, and regulatory compliance.',
    `phone_number` STRING COMMENT 'Primary contact phone number for this organizational unit. Used for internal directory, scheduling coordination, and emergency contact routing.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `profit_center_code` STRING COMMENT 'SAP S/4HANA profit center code for this organizational unit, enabling profitability analysis and management accounting at the org unit level.',
    `service_line` STRING COMMENT 'Clinical or operational service line to which this org unit belongs (e.g., Cardiovascular, Oncology, Orthopedics, Emergency Services). Used for service-line-level workforce planning and revenue attribution.',
    `short_name` STRING COMMENT 'Abbreviated or display name for the organizational unit used in dashboards, scheduling systems, and space-constrained UI contexts (e.g., Cardiology, Surg Svcs).',
    `specialty_code` STRING COMMENT 'Standardized code representing the primary clinical specialty of this organizational unit (e.g., NUCC taxonomy code or internal specialty code). Used for provider credentialing alignment and payer contracting.',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. Inactive or dissolved units are retained for historical reporting and audit purposes.. Valid values are `active|inactive|pending|dissolved`',
    `subtype` STRING COMMENT 'Further classification within the org unit type, providing granular segmentation (e.g., Clinical, Administrative, Support, Research, Ancillary). Supports workforce analytics by care delivery category.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the organizational units operating location (e.g., America/Chicago). Used for shift scheduling, time and attendance, and payroll processing accuracy.',
    `org_unit_type` STRING COMMENT 'Classification of the organizational unit within the workforce hierarchy. Determines how the unit is used in headcount, budgeting, and reporting contexts. [ENUM-REF-CANDIDATE: department|division|service_line|cost_center|supervisory_org|team|program|section — promote to reference product if additional types are needed]. Valid values are `department|division|service_line|cost_center|supervisory_org|team`',
    `union_affiliation` STRING COMMENT 'Name or code of the labor union or collective bargaining unit associated with this organizational unit, if applicable. Drives union-specific pay rules, scheduling constraints, and grievance tracking.',
    `workday_integration_code` STRING COMMENT 'External integration identifier used by Workday HCM for API-based data exchange with downstream systems such as payroll processors, benefits administrators, and scheduling platforms.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit hierarchy for the healthcare workforce, defining departments, divisions, service lines, and cost centers as managed in Workday HCM. Captures org unit name, org unit type (department, division, service line), parent org unit, effective dates, cost center code, facility association, and management hierarchy. Serves as the workforce-specific organizational structure distinct from the facility domains physical structure.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` (
    `workforce_provider_network_participation_id` BIGINT COMMENT 'Primary key for the provider_network_participation association',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the clinical workforce member participating in the payer network. Only clinical employees with NPI numbers (physicians, nurses, allied health) participate in payer networks.',
    `payer_id` BIGINT COMMENT 'Foreign key linking to the insurance payer whose network the provider is participating in.',
    `accepting_new_patients_flag` BOOLEAN COMMENT 'Indicates whether this provider is currently accepting new patients covered by this payer. Used for payer provider directories and patient access management. Can vary by payer even for the same provider.',
    `contract_reference_number` STRING COMMENT 'Reference number or identifier for the underlying participation contract or agreement between the healthcare organization and this payer that governs this providers participation terms.',
    `credentialing_expiration_date` DATE COMMENT 'The date on which the providers credentialing with this payer expires and must be renewed. Payers typically require re-credentialing every 2-3 years. Used for proactive renewal tracking.',
    `credentialing_status` STRING COMMENT 'Current status of the providers credentialing with this payer. Determines whether the provider can submit claims to this payer. Values: pending, approved, denied, suspended, expired, in_review.',
    `effective_date` DATE COMMENT 'The date on which this providers participation in this payers network became or will become effective. Claims submitted for services on or after this date can be billed to this payer under this participation agreement.',
    `enrollment_date` DATE COMMENT 'The date on which the provider enrollment application was submitted to this payer. Used for tracking credentialing timelines and regulatory compliance with enrollment processing requirements.',
    `network_participation_status` STRING COMMENT 'Current status of the providers active participation in this payers network. Values: active, inactive, terminated, pending_activation. Distinct from credentialing_status which tracks approval; this tracks operational participation.',
    `network_tier` STRING COMMENT 'The tier or level of network participation assigned by the payer (e.g., Tier 1, Preferred, Standard, Out-of-Network). Affects reimbursement rates and patient cost-sharing. Varies by payer and provider.',
    `payer_provider_number` STRING COMMENT 'The unique provider identifier assigned by this specific payer to this provider for claims submission. Distinct from NPI, this is the payers internal provider ID used in claim transactions and remittance advice.',
    `reimbursement_rate_schedule` STRING COMMENT 'Identifier or code for the fee schedule or reimbursement rate table that applies to this provider-payer participation. Different providers may have different negotiated rates with the same payer based on contract terms.',
    `termination_date` DATE COMMENT 'The date on which this providers participation in this payers network ended or will end. Null for active ongoing participations. Claims for services after this date cannot be submitted under this participation.',
    CONSTRAINT pk_workforce_provider_network_participation PRIMARY KEY(`workforce_provider_network_participation_id`)
) COMMENT 'This association product represents the participation contract between clinical employees (providers) and insurance payers. It captures the credentialing and network participation relationship required for claims submission and reimbursement. Each record links one clinical provider to one payer network with attributes that exist only in the context of this participation relationship, including credentialing status, payer-specific provider identifiers, network tier assignments, and participation dates.. Existence Justification: In healthcare operations, clinical providers (physicians, nurses, allied health professionals) participate in multiple insurance payer networks simultaneously to maximize patient access and reimbursement opportunities. Each payer contracts with many providers across their network. The relationship represents an operational business entity called provider network participation or credentialing that revenue cycle and payer contracting teams actively manage, tracking credentialing status, payer-specific provider numbers, network tier assignments, participation dates, and reimbursement terms for each provider-payer combination.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` (
    `clinical_privilege_id` BIGINT COMMENT 'Unique surrogate identifier for each clinical privilege record. Primary key.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to the specific CPT procedure code for which privilege is granted',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the healthcare workforce member (clinician) who holds this clinical privilege',
    `competency_level` STRING COMMENT 'Level of clinical competency and autonomy granted for this specific procedure. Unrestricted = full independent practice. Supervised = requires attending physician oversight. Proctored = requires observation by peer for quality assurance. Provisional = temporary privilege pending completion of competency assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this clinical privilege record was created in the medical staff services system.',
    `granting_committee` STRING COMMENT 'Name of the medical staff committee or delegated authority that granted this privilege (e.g., Credentials Committee, Surgery Department, Emergency Medicine Section). Used for governance tracking and appeals process.',
    `last_proctoring_date` DATE COMMENT 'Date of the most recent proctored case for this privilege. Used for competency assessment and progression from proctored to unrestricted status. Null if no proctoring has occurred or is not required.',
    `privilege_expiration_date` DATE COMMENT 'Date on which this clinical privilege expires and requires renewal through the reappointment process. Typically aligned with medical staff appointment cycle (1-2 years). Null for permanently revoked privileges.',
    `privilege_grant_date` DATE COMMENT 'Date on which the medical staff credentialing committee or delegated authority granted this specific clinical privilege to the workforce member. Used for privilege history tracking and reappointment scheduling.',
    `privilege_status` STRING COMMENT 'Current lifecycle status of the clinical privilege. Active privileges are valid for clinical operations. Suspended privileges are temporarily inactive pending review. Expired privileges require renewal. Revoked privileges have been permanently removed. Pending privileges are under credentialing committee review.',
    `proctoring_cases_completed` STRING COMMENT 'Number of proctored cases completed for this privilege. Used to track progress toward unrestricted privilege status. Null if proctoring is not required.',
    `proctoring_cases_required` STRING COMMENT 'Total number of proctored cases required before privilege can be upgraded to unrestricted status. Set by credentialing committee based on procedure complexity and clinician experience. Null if proctoring is not required.',
    `restriction_notes` STRING COMMENT 'Free-text description of any specific restrictions, conditions, or limitations placed on this privilege by the credentialing committee. Examples: age restrictions, anatomical site restrictions, technology restrictions. Null if no restrictions apply.',
    `supervision_required` BOOLEAN COMMENT 'Indicates whether this specific privilege requires direct supervision by an attending physician or senior clinician. True for residents, fellows, and clinicians with provisional or supervised competency levels. False for unrestricted privileges.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this clinical privilege record was last modified. Used for audit trail and change tracking.',
    `volume_requirement` STRING COMMENT 'Minimum number of procedures the clinician must perform annually to maintain competency and privilege renewal eligibility. Used by medical staff services for ongoing professional practice evaluation (OPPE). Null if no volume requirement applies.',
    CONSTRAINT pk_clinical_privilege PRIMARY KEY(`clinical_privilege_id`)
) COMMENT 'This association product represents the credentialing relationship between healthcare workforce members and specific CPT procedures they are authorized to perform. It captures the medical staff services offices privilege granting, competency assessment, and ongoing professional practice evaluation. Each record links one employee (clinician) to one CPT code with privilege-specific attributes including grant/expiration dates, competency level, volume requirements, and supervision needs. This is the operational foundation of medical staff credentialing and delineation of privileges.. Existence Justification: Clinical privileges represent the operational credentialing relationship where healthcare providers (physicians, nurses, allied health) are granted authority to perform specific procedures (CPT codes). In real-world medical staff services operations, a single surgeon holds privileges for 20-200 different CPT codes (e.g., appendectomy, cholecystectomy, hernia repair), and each CPT code has 50+ credentialed clinicians across the health system. The medical staff services office actively manages these privileges with grant/expiration dates, competency assessments, volume requirements, and supervision rules.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` (
    `channel_support_assignment_id` BIGINT COMMENT 'Unique surrogate identifier for each support assignment record. Primary key for the association.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the healthcare workforce member assigned to support this interface channel',
    `interface_channel_id` BIGINT COMMENT 'Foreign key linking to the interface channel being supported by this workforce member',
    `assignment_end_date` DATE COMMENT 'The date on which this support assignment ended or is scheduled to end. Null indicates an active ongoing assignment. Used for rotation management and historical analysis.',
    `assignment_start_date` DATE COMMENT 'The date on which this support assignment became effective. Used for historical tracking of support responsibility and workforce planning.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the support assignment. Active indicates current operational assignment, Inactive indicates ended assignment, Suspended indicates temporarily paused (e.g., employee on leave), Pending indicates future scheduled assignment.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this support assignment record was created in the data warehouse.',
    `escalation_tier` STRING COMMENT 'Numeric tier level (1-3) indicating the escalation hierarchy for incident management. Tier 1 is first responder, Tier 2 is technical specialist, Tier 3 is senior architect or vendor escalation.',
    `notification_preference` STRING COMMENT 'The preferred communication channel for notifying this workforce member about incidents or alerts related to this interface channel. Used by incident management and alerting systems.',
    `on_call_rotation` STRING COMMENT 'The on-call rotation schedule identifier or pattern assigned to this support assignment (e.g., Week 1-2, Weekday Primary, Weekend Backup). Used for workforce scheduling and incident routing.',
    `support_role` STRING COMMENT 'The tiered support role assigned to this workforce member for this specific interface channel. Primary indicates first-line support, Backup indicates secondary coverage, Escalation indicates senior technical escalation point, On-Call indicates rotation-based availability.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this support assignment record was last updated in the data warehouse.',
    CONSTRAINT pk_channel_support_assignment PRIMARY KEY(`channel_support_assignment_id`)
) COMMENT 'This association product represents the operational support assignment between healthcare IT workforce members and interface channels. It captures the tiered support structure (primary, backup, escalation), on-call rotation schedules, and assignment lifecycle for incident management and workforce scheduling. Each record links one employee to one interface channel with role-specific attributes that exist only in the context of this support relationship.. Existence Justification: Healthcare IT operations require multi-tiered support coverage for interface channels (HL7 feeds, FHIR endpoints, Direct messaging). A single interface channel has multiple support staff assigned in different roles (primary, backup, escalation), and a single IT workforce member supports multiple interface channels across different systems. Organizations actively manage these assignments for on-call rotations, incident escalation paths, and workforce scheduling.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` (
    `position_procedure_authorization_id` BIGINT COMMENT 'Unique surrogate identifier for this position-procedure authorization record. Primary key.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to the CPT procedure code',
    `position_id` BIGINT COMMENT 'Foreign key linking to the authorized organizational position',
    `authorization_level` STRING COMMENT 'Level of authorization granted to this position for performing this procedure. INDEPENDENT = can perform without supervision; SUPERVISED = requires attending oversight; ASSIST_ONLY = can assist but not perform as primary; RESTRICTED = special conditions apply.',
    `authorization_status` STRING COMMENT 'Current lifecycle status of this authorization. ACTIVE = currently valid; SUSPENDED = temporarily on hold; EXPIRED = past expiration date; REVOKED = permanently removed; PENDING = awaiting approval.',
    `competency_validation_frequency` STRING COMMENT 'How often competency must be revalidated for this position-procedure authorization (e.g., ANNUAL, BIENNIAL, ONE_TIME). Drives credentialing and privileging cycles.',
    `created_date` TIMESTAMP COMMENT 'Timestamp when this authorization record was created in the system.',
    `credentialing_committee_approval_date` DATE COMMENT 'Date on which the medical staff credentialing committee approved this position-procedure authorization. Null if committee approval not required. Supports regulatory compliance and audit trails.',
    `effective_date` DATE COMMENT 'Date on which this position became authorized to perform this procedure. Tracks when credentialing or privilege granting occurred.',
    `expiration_date` DATE COMMENT 'Date on which this authorization expires and must be renewed. Null if authorization does not expire. Supports credentialing cycle management.',
    `minimum_cases_required` STRING COMMENT 'Minimum number of observed or supervised cases required before independent authorization is granted for this position-procedure combination. Null if not applicable. Used in fellowship and residency competency tracking.',
    `notes` STRING COMMENT 'Free-text notes regarding special conditions, restrictions, or context for this authorization (e.g., Limited to outpatient setting only, Requires peer review after first 5 cases). Null if no special notes.',
    `supervision_requirement` STRING COMMENT 'Specific supervision requirements for this position when performing this procedure (e.g., Attending physician must be present, Indirect supervision acceptable, No supervision required). Drives scheduling and staffing rules.',
    `training_description` STRING COMMENT 'Description of specific training, certification, or competency validation required for this position-procedure combination (e.g., ACLS certification, Observed cases: 10, Manufacturer device training). Null if no specific training required.',
    `training_required` BOOLEAN COMMENT 'Indicates whether specific training or certification is required before this position can perform this procedure. True = training prerequisite exists; False = no additional training beyond position requirements.',
    `updated_date` TIMESTAMP COMMENT 'Timestamp when this authorization record was last updated.',
    `volume_expectation` STRING COMMENT 'Expected annual or monthly volume of this procedure for this position type (e.g., 50-100 per year, Core competency - frequent, Rare - maintain competency only). Used for competency maintenance planning and workload forecasting.',
    `created_by` STRING COMMENT 'User or system identifier that created this authorization record.',
    CONSTRAINT pk_position_procedure_authorization PRIMARY KEY(`position_procedure_authorization_id`)
) COMMENT 'This association product represents the authorization relationship between workforce positions and CPT procedure codes. It captures which procedures each position type is credentialed and authorized to perform, including supervision requirements, volume expectations, and training prerequisites. Each record links one position to one CPT code with authorization-specific attributes that exist only in the context of this relationship. Supports competency management, credentialing workflows, and clinical privilege tracking.. Existence Justification: In healthcare workforce management, positions are authorized to perform multiple CPT procedures based on credentials, training, and clinical privileges, and each CPT procedure can be performed by multiple position types with varying authorization levels. The business actively manages position-procedure authorizations as part of credentialing workflows, competency frameworks, and clinical privilege management. This is an operational relationship tracked in medical staff services and HR systems, not an analytical correlation.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Primary key for benefit_plan',
    `financial_entity_id` BIGINT COMMENT 'add column finance_financial_entity_id (BIGINT) with FK to finance.financial_entity.financial_entity_id - benefit plans are administered by financial entities but benefit_plan has only a self-ref',
    `superseded_benefit_plan_id` BIGINT COMMENT 'Self-referencing FK on benefit_plan (superseded_benefit_plan_id)',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or third-party administrator providing the benefit plan.',
    `carrier_policy_number` STRING COMMENT 'Unique policy or contract number assigned by the insurance carrier for this benefit plan.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of covered expenses the employee pays after meeting the deductible.',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are collected for this benefit plan.',
    `copay_emergency_room` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employee pays for emergency room visits under this plan.',
    `copay_primary_care` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employee pays for primary care physician visits under this plan.',
    `copay_specialist` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employee pays for specialist physician visits under this plan.',
    `coverage_level` STRING COMMENT 'Tier of coverage indicating who is eligible under the plan (employee only, family, etc.).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this benefit plan.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount the employee must pay before insurance coverage begins for applicable plan types.',
    `effective_end_date` DATE COMMENT 'Date when the benefit plan ceases to be active. Null for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the benefit plan becomes active and available for employee enrollment.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Standard monetary amount the employee contributes per pay period for this benefit plan.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Standard monetary amount the employer contributes per pay period for this benefit plan.',
    `employer_identification_number` STRING COMMENT 'Federal Employer Identification Number (EIN) of the plan sponsor for IRS and DOL reporting.',
    `enrollment_eligibility_rule` STRING COMMENT 'Business rule or criteria defining which employees are eligible to enroll in this benefit plan.',
    `erisa_plan_number` STRING COMMENT 'Three-digit plan number assigned under ERISA for reporting and compliance purposes.',
    `is_aca_compliant` BOOLEAN COMMENT 'Indicates whether this benefit plan meets Affordable Care Act minimum essential coverage and affordability standards.',
    `is_cobra_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan is subject to COBRA continuation coverage requirements.',
    `is_fsa_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan allows Flexible Spending Account (FSA) participation.',
    `is_hsa_eligible` BOOLEAN COMMENT 'Indicates whether this benefit plan qualifies for Health Savings Account (HSA) contributions under IRS rules.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit plan record was last updated or modified.',
    `minimum_value_percentage` DECIMAL(18,2) COMMENT 'Percentage of total allowed costs covered by the plan, used for ACA compliance determination.',
    `network_type` STRING COMMENT 'Type of provider network structure for this benefit plan (HMO, PPO, EPO, POS, HDHP, Indemnity).',
    `notes` STRING COMMENT 'Additional administrative notes, special instructions, or internal comments about this benefit plan.',
    `open_enrollment_end_date` DATE COMMENT 'Date when the annual open enrollment period ends for this benefit plan.',
    `open_enrollment_start_date` DATE COMMENT 'Date when the annual open enrollment period begins for this benefit plan.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum amount the employee will pay out-of-pocket in a plan year before full coverage applies.',
    `plan_administrator_email` STRING COMMENT 'Email address of the plan administrator for inquiries and administrative communications.',
    `plan_administrator_name` STRING COMMENT 'Name of the individual or department responsible for administering this benefit plan.',
    `plan_administrator_phone` STRING COMMENT 'Phone number of the plan administrator for employee inquiries and support.',
    `plan_category` STRING COMMENT 'High-level classification grouping benefit plans by business function and regulatory treatment.',
    `plan_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the benefit plan in HR systems and employee communications.',
    `plan_description` STRING COMMENT 'Detailed textual description of the benefit plan features, coverage, and key terms.',
    `plan_document_url` STRING COMMENT 'URL or file path to the official plan document, summary plan description, or benefits guide.',
    `plan_name` STRING COMMENT 'Full descriptive name of the benefit plan as presented to employees and in official documentation.',
    `plan_type` STRING COMMENT 'Category of benefit plan indicating the primary coverage area or benefit domain.',
    `plan_year` STRING COMMENT 'Calendar year or plan year for which this benefit plan configuration applies.',
    `benefit_plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan indicating availability for enrollment and administration.',
    `summary_plan_description_url` STRING COMMENT 'URL or file path to the Summary Plan Description (SPD) required under ERISA.',
    `total_premium_amount` DECIMAL(18,2) COMMENT 'Total premium cost per pay period for this benefit plan (employee plus employer contributions).',
    `waiting_period_days` STRING COMMENT 'Number of days a new employee must wait before becoming eligible to enroll in this benefit plan.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Master reference table for benefit_plan. Referenced by benefit_plan_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`education_program` (
    `education_program_id` BIGINT COMMENT 'Primary key for education_program',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or campus where this education program is primarily offered.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department or organizational unit responsible for administering this education program.',
    `prerequisite_education_program_id` BIGINT COMMENT 'Self-referencing FK on education_program (prerequisite_education_program_id)',
    `accreditation_body` STRING COMMENT 'Name of the organization that accredits or approves this education program (e.g., ACCME, ANCC, state boards).',
    `accreditation_effective_date` DATE COMMENT 'Date when the programs accreditation or approval became effective.',
    `accreditation_expiration_date` DATE COMMENT 'Date when the programs accreditation or approval expires and must be renewed.',
    `accreditation_number` STRING COMMENT 'Unique accreditation or approval number assigned by the accrediting body for this program.',
    `accreditation_status` STRING COMMENT 'Current status of the programs accreditation or approval from the governing body.',
    `assessment_method` STRING COMMENT 'Primary method used to assess participant learning and determine successful completion of the program.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a certificate of completion is issued to participants who successfully complete the program.',
    `commercial_support_flag` BOOLEAN COMMENT 'Indicates whether the education program receives commercial support or sponsorship from external organizations.',
    `competency_domain` STRING COMMENT 'Primary competency domain or skill area addressed by this education program (e.g., patient care, medical knowledge, professionalism).',
    `contact_email` STRING COMMENT 'Primary email address for inquiries and communication regarding the education program.',
    `contact_phone` STRING COMMENT 'Primary phone number for inquiries and communication regarding the education program.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Standard cost or tuition fee for enrolling in and completing the education program.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this education program record was first created in the system.',
    `credit_hours` DECIMAL(18,2) COMMENT 'Number of continuing education credit hours awarded upon successful completion of the program.',
    `credit_type` STRING COMMENT 'Type of continuing education credit awarded (e.g., AMA PRA Category 1, ANCC contact hours, CEU).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the program cost (e.g., USD, EUR, GBP).',
    `delivery_method` STRING COMMENT 'Primary method by which the education program content is delivered to participants.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total instructional time in hours required to complete the education program.',
    `effective_end_date` DATE COMMENT 'Date when this education program is no longer available for new enrollments or delivery.',
    `effective_start_date` DATE COMMENT 'Date when this education program becomes available for enrollment and delivery.',
    `frequency_requirement` STRING COMMENT 'How often participants must complete or renew this education program to maintain compliance or credentials.',
    `last_review_date` DATE COMMENT 'Date when the education program content was last reviewed and validated for accuracy and relevance.',
    `learning_objectives` STRING COMMENT 'Specific, measurable learning objectives that participants will achieve upon completion of the program.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether completion of this education program is mandatory for specific roles or credentials.',
    `maximum_enrollment` STRING COMMENT 'Maximum number of participants that can be enrolled in a single offering of this education program.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this education program record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review and update of the education program content.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage score required on assessments to successfully complete the education program.',
    `prerequisite_requirements` STRING COMMENT 'Description of any prerequisite education, credentials, or experience required before enrolling in this program.',
    `program_code` STRING COMMENT 'Externally-known unique code for the education program used in catalogs and registration systems.',
    `program_description` STRING COMMENT 'Detailed description of the education program including objectives, content overview, and learning outcomes.',
    `program_director_credentials` STRING COMMENT 'Professional credentials and qualifications of the program director (e.g., MD, PhD, RN, BSN).',
    `program_director_name` STRING COMMENT 'Full name of the healthcare professional responsible for directing and overseeing this education program.',
    `program_name` STRING COMMENT 'Full official name of the education program as it appears in course catalogs and certificates.',
    `program_status` STRING COMMENT 'Current lifecycle status of the education program indicating availability for enrollment and delivery.',
    `program_type` STRING COMMENT 'Classification of the education program by its primary purpose and target audience.',
    `program_url` STRING COMMENT 'Web address where participants can access detailed information, registration, or online content for the education program.',
    `target_audience` STRING COMMENT 'Description of the intended audience for this education program (e.g., physicians, nurses, allied health professionals).',
    `vendor_provider_name` STRING COMMENT 'Name of the external vendor or organization providing or hosting the education program, if applicable.',
    `version_number` STRING COMMENT 'Version identifier for the education program content, used to track curriculum updates and revisions.',
    CONSTRAINT pk_education_program PRIMARY KEY(`education_program_id`)
) COMMENT 'Master reference table for education_program. Referenced by education_program_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`review_template` (
    `review_template_id` BIGINT COMMENT 'Primary key for review_template',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department or organizational unit that owns or is primarily responsible for this review template.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved this review template for active use.',
    `review_created_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who originally created this review template in the system.',
    `superseded_review_template_id` BIGINT COMMENT 'Self-referencing FK on review_template (superseded_review_template_id)',
    `allows_peer_review` BOOLEAN COMMENT 'Indicates whether this template supports peer review input as part of the assessment process.',
    `allows_self_assessment` BOOLEAN COMMENT 'Indicates whether this template supports self-assessment by the employee as part of the review process.',
    `applicable_role_type` STRING COMMENT 'The job role or position type for which this review template is designed (e.g., physician, nurse, administrative staff, allied health professional).',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this review template was formally approved for use.',
    `archived_date` DATE COMMENT 'The date when this review template was archived and removed from active use.',
    `archived_reason` STRING COMMENT 'Explanation or justification for why this review template was archived or deactivated.',
    `average_completion_time_minutes` STRING COMMENT 'Average time in minutes required to complete a review using this template, based on historical usage data.',
    `cme_credit_hours` DECIMAL(18,2) COMMENT 'Number of Continuing Medical Education (CME) credit hours awarded upon successful completion of this review template.',
    `cme_eligible` BOOLEAN COMMENT 'Indicates whether completion of this review template qualifies for Continuing Medical Education (CME) credits.',
    `compliance_framework` STRING COMMENT 'The specific regulatory or accreditation framework that this review template addresses (e.g., Joint Commission, CMS, OSHA, state medical board requirements). [ENUM-REF-CANDIDATE: joint_commission|cms|osha|state_medical_board|ncqa|dnv|aaahc|carf — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this review template record was first created in the system.',
    `credentialing_required` BOOLEAN COMMENT 'Indicates whether completion of this review template is required for credentialing or privileging purposes.',
    `review_template_description` STRING COMMENT 'Detailed description of the review template including its purpose, scope, and intended use within the workforce management process.',
    `effective_end_date` DATE COMMENT 'The date on which this review template is no longer effective or available for use. Null indicates no planned end date.',
    `effective_start_date` DATE COMMENT 'The date from which this review template becomes effective and available for use in workforce reviews.',
    `escalation_days_after_due` STRING COMMENT 'Number of days after a review due date that an escalation notification should be triggered for overdue reviews.',
    `instructions` STRING COMMENT 'Guidance and instructions for reviewers and reviewees on how to complete and interpret the review template.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether completion of reviews using this template is mandatory for the applicable workforce members.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this review template record was last modified or updated.',
    `last_review_date` DATE COMMENT 'The date when this review template was last reviewed or validated for accuracy and relevance.',
    `maximum_score` DECIMAL(18,2) COMMENT 'The maximum possible score that can be achieved on a review using this template.',
    `minimum_passing_score` DECIMAL(18,2) COMMENT 'The minimum score or threshold required to achieve a passing result when using this review template.',
    `next_review_date` DATE COMMENT 'The scheduled date for the next review or validation of this review template to ensure continued relevance and compliance.',
    `notification_days_before_due` STRING COMMENT 'Number of days before a review is due that notification reminders should be sent to reviewers and reviewees.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this review template is required to meet specific regulatory or accreditation compliance requirements.',
    `requires_employee_acknowledgment` BOOLEAN COMMENT 'Indicates whether the employee or reviewee must formally acknowledge receipt and review of the completed assessment.',
    `requires_manager_approval` BOOLEAN COMMENT 'Indicates whether reviews completed using this template require formal approval from a manager or supervisor.',
    `review_category` STRING COMMENT 'Broad category of the review template that groups similar assessment types for organizational reporting and analysis.',
    `review_frequency` STRING COMMENT 'Expected frequency at which reviews using this template should be conducted for applicable workforce members.',
    `review_period_days` STRING COMMENT 'Number of days that define the standard review period for assessments using this template.',
    `scoring_method` STRING COMMENT 'The methodology used to evaluate and score reviews completed with this template.',
    `review_template_status` STRING COMMENT 'Current lifecycle status of the review template indicating whether it is available for use in workforce reviews.',
    `supports_development_plan` BOOLEAN COMMENT 'Indicates whether this review template includes or supports the creation of an employee development or improvement plan.',
    `template_code` STRING COMMENT 'Unique business identifier code for the review template used for external reference and system integration.',
    `template_name` STRING COMMENT 'Human-readable name of the review template that describes its purpose and use case.',
    `template_type` STRING COMMENT 'Classification of the review template indicating its primary purpose within workforce management (e.g., performance review, competency assessment, credentialing review).',
    `usage_count` STRING COMMENT 'Total number of times this review template has been used to conduct workforce reviews.',
    `version_number` STRING COMMENT 'Version identifier for the review template following semantic versioning to track template evolution and changes over time.',
    CONSTRAINT pk_review_template PRIMARY KEY(`review_template_id`)
) COMMENT 'Master reference table for review_template. Referenced by review_template_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`applicant` (
    `applicant_id` BIGINT COMMENT 'Primary key for applicant',
    `employee_id` BIGINT COMMENT 'Identifier of the hiring manager responsible for the position decision.',
    `applicant_referring_employee_id` BIGINT COMMENT 'Identifier of the recruiter or talent acquisition specialist managing this applicant.',
    `care_site_id` BIGINT COMMENT 'Identifier of the healthcare facility or location where the applicant would work.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department or unit the applicant is applying to join.',
    `referred_by_applicant_id` BIGINT COMMENT 'Self-referencing FK on applicant (referred_by_applicant_id)',
    `job_profile_id` BIGINT COMMENT 'add column workforce_job_profile_id (BIGINT) with FK to workforce.job_profile.job_profile_id - applicants apply for specific job profiles but lack this FK',
    `position_id` BIGINT COMMENT 'add column workforce_position_id (BIGINT) with FK to workforce.position.position_id - applicants apply for specific positions but lack this FK',
    `address_line_1` STRING COMMENT 'Primary street address line for the applicants residence.',
    `address_line_2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number.',
    `alternate_phone_number` STRING COMMENT 'Secondary or alternate contact phone number for the applicant.',
    `application_date` DATE COMMENT 'Date when the applicant submitted their application for employment or credentialing.',
    `application_number` STRING COMMENT 'Externally-known unique application tracking number assigned to the applicant.',
    `application_source` STRING COMMENT 'Channel or source through which the applicant submitted their application.',
    `application_status` STRING COMMENT 'Current lifecycle status of the applicants application in the recruitment workflow.',
    `available_start_date` DATE COMMENT 'Earliest date the applicant is available to begin employment.',
    `background_check_date` DATE COMMENT 'Date when the background check was completed for the applicant.',
    `background_check_status` STRING COMMENT 'Current status of the background check process for the applicant.',
    `board_certified_flag` BOOLEAN COMMENT 'Indicates whether the applicant is board certified in their specialty.',
    `city` STRING COMMENT 'City of the applicants residence.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the applicants country of residence.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the applicant record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Date of birth of the applicant used for age verification and background checks.',
    `degree_field` STRING COMMENT 'Primary field of study or major for the applicants highest degree.',
    `desired_salary` DECIMAL(18,2) COMMENT 'Salary amount requested or expected by the applicant for the position.',
    `drug_screening_date` DATE COMMENT 'Date when the drug screening was conducted for the applicant.',
    `drug_screening_status` STRING COMMENT 'Current status of the drug screening process for the applicant.',
    `eligible_to_work_flag` BOOLEAN COMMENT 'Indicates whether the applicant is legally eligible to work in the country.',
    `email_address` STRING COMMENT 'Primary email address for applicant communication and correspondence.',
    `first_name` STRING COMMENT 'Legal first name of the applicant as provided on application materials.',
    `highest_education_level` STRING COMMENT 'Highest level of education attained by the applicant.',
    `last_name` STRING COMMENT 'Legal last name or surname of the applicant as provided on application materials.',
    `license_expiration_date` DATE COMMENT 'Expiration date of the applicants professional license or certification.',
    `license_number` STRING COMMENT 'Professional license or certification number for clinical applicants.',
    `license_state` STRING COMMENT 'State or jurisdiction that issued the professional license.',
    `middle_name` STRING COMMENT 'Middle name or initial of the applicant.',
    `national_provider_identifier` STRING COMMENT 'National Provider Identifier for healthcare providers applying for clinical positions.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the applicant.',
    `position_applied_for` STRING COMMENT 'Job title or position name that the applicant is applying for.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the applicants residence.',
    `reference_check_status` STRING COMMENT 'Current status of the professional reference verification process.',
    `social_security_number` STRING COMMENT 'Social Security Number of the applicant for tax and employment verification purposes.',
    `specialty` STRING COMMENT 'Primary clinical specialty or area of expertise for clinical applicants.',
    `state_province` STRING COMMENT 'State or province of the applicants residence.',
    `applicant_type` STRING COMMENT 'Classification of the applicant based on the role category they are applying for.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the applicant record was last modified or updated.',
    `work_authorization_type` STRING COMMENT 'Type of work authorization or immigration status for the applicant.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of relevant professional experience in the healthcare field.',
    CONSTRAINT pk_applicant PRIMARY KEY(`applicant_id`)
) COMMENT 'Master reference table for applicant. Referenced by applicant_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Primary key for payroll_run',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit or legal entity for which this payroll run is processed.',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this payroll run for processing.',
    `payroll_calendar_id` BIGINT COMMENT 'Reference to the payroll calendar that defines the schedule and timing for this payroll run.',
    `payroll_created_by_user_employee_id` BIGINT COMMENT 'Reference to the user who initiated or created this payroll run.',
    `reversed_payroll_run_id` BIGINT COMMENT 'Self-referencing FK on payroll_run (reversed_payroll_run_id)',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll run was approved for processing.',
    `batch_number` STRING COMMENT 'External batch identifier used by banking or payment processing systems for this payroll run.',
    `check_date` DATE COMMENT 'The date printed on physical checks or used as the effective date for electronic payments.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll run record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this payroll run.',
    `employee_count` STRING COMMENT 'The total number of employees included in this payroll run.',
    `error_message` STRING COMMENT 'System-generated error message if the payroll run failed or encountered processing issues.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month or quarter) within the fiscal year to which this payroll run is attributed.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this payroll run is attributed for accounting and reporting purposes.',
    `frequency` STRING COMMENT 'The recurring schedule on which this payroll run is processed.',
    `general_ledger_posting_date` DATE COMMENT 'The date on which payroll expenses and liabilities from this run are posted to the general ledger.',
    `initiated_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll run was initiated or created in the system.',
    `is_final_run` BOOLEAN COMMENT 'Indicates whether this is the final payroll run for a pay period or fiscal year, after which no further adjustments are allowed.',
    `is_retroactive` BOOLEAN COMMENT 'Indicates whether this payroll run includes retroactive pay adjustments for prior periods.',
    `notes` STRING COMMENT 'Free-text notes or comments about this payroll run, including special circumstances, exceptions, or processing instructions.',
    `pay_date` DATE COMMENT 'The date on which employees will receive payment for this payroll run.',
    `pay_period_end_date` DATE COMMENT 'The last date of the pay period covered by this payroll run.',
    `pay_period_start_date` DATE COMMENT 'The first date of the pay period covered by this payroll run.',
    `payment_method` STRING COMMENT 'The primary payment method used for disbursing funds to employees in this payroll run.',
    `processing_completed_timestamp` TIMESTAMP COMMENT 'The date and time when payroll calculation and processing was completed for this run.',
    `processing_started_timestamp` TIMESTAMP COMMENT 'The date and time when payroll calculation and processing began for this run.',
    `run_number` STRING COMMENT 'Business identifier for the payroll run, typically formatted as PR-YYYY-NNNNNN for external reference and audit trails.',
    `run_type` STRING COMMENT 'Classification of the payroll run indicating the purpose and processing category.',
    `payroll_run_status` STRING COMMENT 'Current lifecycle status of the payroll run in the processing workflow.',
    `total_deductions` DECIMAL(18,2) COMMENT 'The total amount of all deductions (taxes, benefits, garnishments) withheld from employee pay in this payroll run.',
    `total_employer_benefits` DECIMAL(18,2) COMMENT 'The total amount of employer-paid benefits contributions (health insurance, retirement matching) for this payroll run.',
    `total_employer_taxes` DECIMAL(18,2) COMMENT 'The total amount of employer-paid payroll taxes (FICA, FUTA, SUTA) for this payroll run.',
    `total_gross_pay` DECIMAL(18,2) COMMENT 'The total gross wages for all employees included in this payroll run before any deductions.',
    `total_net_pay` DECIMAL(18,2) COMMENT 'The total net wages paid to all employees in this payroll run after all deductions.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll run record was last modified in the system.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Master reference table for payroll_run. Referenced by payroll_run_id.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` (
    `payroll_calendar_id` BIGINT COMMENT 'Primary key for payroll_calendar',
    `fiscal_period_id` BIGINT COMMENT 'add column finance_fiscal_period_id (BIGINT) with FK to finance.fiscal_period.fiscal_period_id - payroll calendars align with fiscal periods but lack this FK',
    `organization_id` BIGINT COMMENT 'Reference to the organization or business unit to which this payroll calendar applies.',
    `prior_payroll_calendar_id` BIGINT COMMENT 'Self-referencing FK on payroll_calendar (prior_payroll_calendar_id)',
    `approval_status` STRING COMMENT 'Approval status of the payroll calendar indicating whether it has been reviewed and approved for use.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the payroll calendar.',
    `approved_date` DATE COMMENT 'Date on which the payroll calendar was approved.',
    `calendar_code` STRING COMMENT 'Unique business identifier or code for the payroll calendar used in payroll systems and reporting.',
    `calendar_name` STRING COMMENT 'Human-readable name or label for the payroll calendar (e.g., Biweekly 2024, Monthly Nursing Staff).',
    `calendar_type` STRING COMMENT 'Classification of the payroll calendar frequency (weekly, biweekly, semimonthly, monthly, adhoc).',
    `calendar_year` STRING COMMENT 'Calendar year to which this payroll period belongs (e.g., 2024).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll calendar record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which this payroll calendar ceases to be effective. Null indicates an open-ended calendar.',
    `effective_start_date` DATE COMMENT 'Date from which this payroll calendar becomes effective and can be used for payroll processing.',
    `employee_group_code` STRING COMMENT 'Code identifying the employee group or classification to which this payroll calendar applies (e.g., RN, ADMIN, PHYSICIAN).',
    `fiscal_month` STRING COMMENT 'Fiscal month within the fiscal year (1-12) to which this pay period belongs.',
    `fiscal_quarter` STRING COMMENT 'Fiscal quarter within the fiscal year (1-4) to which this pay period belongs.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which this payroll calendar period belongs (e.g., 2024).',
    `holiday_count` STRING COMMENT 'Number of recognized holidays falling within the pay period.',
    `is_adjustment_period` BOOLEAN COMMENT 'Indicates whether this pay period includes payroll adjustments or corrections from prior periods.',
    `is_year_end_period` BOOLEAN COMMENT 'Indicates whether this is the final pay period of the fiscal or calendar year requiring year-end processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this payroll calendar record was last updated or modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about the payroll calendar, including special instructions or exceptions.',
    `pay_date` DATE COMMENT 'Date on which employees are paid for the corresponding pay period.',
    `pay_period_end_date` DATE COMMENT 'Last day of the pay period covered by this payroll calendar entry.',
    `pay_period_number` STRING COMMENT 'Sequential number of the pay period within the calendar year (e.g., 1-26 for biweekly, 1-12 for monthly).',
    `pay_period_start_date` DATE COMMENT 'First day of the pay period covered by this payroll calendar entry.',
    `payroll_processing_date` DATE COMMENT 'Date on which payroll is processed and finalized for the pay period.',
    `payroll_system_code` STRING COMMENT 'Code identifying the payroll system or module that uses this calendar (e.g., WORKDAY, ADP).',
    `payroll_calendar_status` STRING COMMENT 'Current lifecycle status of the payroll calendar indicating whether it is actively used for payroll processing.',
    `timesheet_submission_deadline` DATE COMMENT 'Deadline date by which employees must submit timesheets for the pay period.',
    `total_days_count` STRING COMMENT 'Total number of calendar days in the pay period.',
    `work_days_count` STRING COMMENT 'Number of standard work days within the pay period, excluding weekends and holidays.',
    CONSTRAINT pk_payroll_calendar PRIMARY KEY(`payroll_calendar_id`)
) COMMENT 'Master reference table for payroll_calendar. Referenced by payroll_calendar_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_position_supervisory_org_workforce_org_unit_id` FOREIGN KEY (`position_supervisory_org_workforce_org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_position_workforce_org_unit_id` FOREIGN KEY (`position_workforce_org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ADD CONSTRAINT `fk_workforce_job_profile_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ADD CONSTRAINT `fk_workforce_employment_competency_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_education_program_id` FOREIGN KEY (`education_program_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`education_program`(`education_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ADD CONSTRAINT `fk_workforce_competency_assessment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_swap_source_shift_schedule_id` FOREIGN KEY (`swap_source_shift_schedule_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ADD CONSTRAINT `fk_workforce_time_attendance_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_benefit_plan_id` FOREIGN KEY (`benefit_plan_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_review_template_id` FOREIGN KEY (`review_template_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`review_template`(`review_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_worker_employee_id` FOREIGN KEY (`reviewer_worker_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_applicant_id` FOREIGN KEY (`applicant_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`applicant`(`applicant_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_recruitment_hiring_manager_employee_id` FOREIGN KEY (`recruitment_hiring_manager_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ADD CONSTRAINT `fk_workforce_recruitment_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ADD CONSTRAINT `fk_workforce_osha_incident_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ADD CONSTRAINT `fk_workforce_fte_budget_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ADD CONSTRAINT `fk_workforce_fte_budget_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ADD CONSTRAINT `fk_workforce_workforce_provider_network_participation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ADD CONSTRAINT `fk_workforce_clinical_privilege_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ADD CONSTRAINT `fk_workforce_channel_support_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ADD CONSTRAINT `fk_workforce_position_procedure_authorization_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_superseded_benefit_plan_id` FOREIGN KEY (`superseded_benefit_plan_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`benefit_plan`(`benefit_plan_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ADD CONSTRAINT `fk_workforce_education_program_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ADD CONSTRAINT `fk_workforce_education_program_prerequisite_education_program_id` FOREIGN KEY (`prerequisite_education_program_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`education_program`(`education_program_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_review_created_by_user_employee_id` FOREIGN KEY (`review_created_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_superseded_review_template_id` FOREIGN KEY (`superseded_review_template_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`review_template`(`review_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_applicant_referring_employee_id` FOREIGN KEY (`applicant_referring_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_referred_by_applicant_id` FOREIGN KEY (`referred_by_applicant_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`applicant`(`applicant_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_job_profile_id` FOREIGN KEY (`job_profile_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`job_profile`(`job_profile_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ADD CONSTRAINT `fk_workforce_applicant_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_payroll_calendar_id` FOREIGN KEY (`payroll_calendar_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`payroll_calendar`(`payroll_calendar_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_payroll_created_by_user_employee_id` FOREIGN KEY (`payroll_created_by_user_employee_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_reversed_payroll_run_id` FOREIGN KEY (`reversed_payroll_run_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ADD CONSTRAINT `fk_workforce_payroll_calendar_prior_payroll_calendar_id` FOREIGN KEY (`prior_payroll_calendar_id`) REFERENCES `vibe_healthcare_v1`.`workforce`.`payroll_calendar`(`payroll_calendar_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_healthcare_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `clinician_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|failed|not_required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `background_check_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `bill_rate` SET TAGS ('dbx_business_glossary_term' = 'Contingent Worker Bill Rate');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `bill_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `clinical_role_type` SET TAGS ('dbx_business_glossary_term' = 'Clinical Role Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `cme_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Medical Education (CME) Hours Completed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `cme_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Medical Education (CME) Hours Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `credential_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `credential_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|expired|failed|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Employee Date of Birth');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|terminated|retired|suspended');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|prn|contract|contingent');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `fte_value` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Value');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `fte_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Employee Gender Identity');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|undisclosed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `gender` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Primary License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Professional License Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'Primary License State');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `oig_exclusion_check_date` SET TAGS ('dbx_business_glossary_term' = 'OIG Exclusion Check Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `oig_exclusion_checked` SET TAGS ('dbx_business_glossary_term' = 'Office of Inspector General (OIG) Exclusion Check Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `original_hire_date` SET TAGS ('dbx_business_glossary_term' = 'Original Hire Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `osha_training_current` SET TAGS ('dbx_business_glossary_term' = 'OSHA Training Current Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Contingent Worker Pay Rate');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_business_glossary_term' = 'Employee Personal Email Address');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `personal_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Preferred Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `primary_specialty` SET TAGS ('dbx_business_glossary_term' = 'Primary Clinical Specialty');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `rehire_eligible` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `staffing_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Staffing Agency Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `staffing_agency_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `staffing_agency_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary_resignation|involuntary_termination|retirement|end_of_contract|deceased');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Employee Work Email Address');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Employee Work Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9-s().]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `workday_worker_code` SET TAGS ('dbx_business_glossary_term' = 'Workday HCM Worker ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `workday_worker_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `worker_category` SET TAGS ('dbx_business_glossary_term' = 'Worker Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employee` ALTER COLUMN `worker_category` SET TAGS ('dbx_value_regex' = 'clinical|administrative|support|research|contingent');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Position Department Workforce Org Unit Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `position_supervisory_org_workforce_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Organization ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `position_workforce_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `npi_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Reference Npi Registry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports-To Position ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Position Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `budgeted_fte` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `cme_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Medical Education (CME) Hours Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,15}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Position Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `employment_category` SET TAGS ('dbx_business_glossary_term' = 'Employment Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `employment_category` SET TAGS ('dbx_value_regex' = 'full_time|part_time|prn|casual');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Position End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt|highly_compensated|independent_contractor');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `headcount_count` SET TAGS ('dbx_business_glossary_term' = 'Authorized Headcount Count');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_clinical` SET TAGS ('dbx_business_glossary_term' = 'Clinical Position Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_critical_role` SET TAGS ('dbx_business_glossary_term' = 'Critical Role Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_management` SET TAGS ('dbx_business_glossary_term' = 'Management Position Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_management` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_provider` SET TAGS ('dbx_business_glossary_term' = 'Provider Position Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `is_union_eligible` SET TAGS ('dbx_business_glossary_term' = 'Union Eligibility Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'on_site|remote|hybrid|travel');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `osha_job_hazard_category` SET TAGS ('dbx_business_glossary_term' = 'OSHA Job Hazard Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `osha_job_hazard_category` SET TAGS ('dbx_value_regex' = 'category_1|category_2|category_3');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,10}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `pay_range_max` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Maximum');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `pay_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `pay_range_min` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Minimum');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `pay_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `required_certification` SET TAGS ('dbx_business_glossary_term' = 'Required Certification');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `required_education_level` SET TAGS ('dbx_business_glossary_term' = 'Required Education Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `required_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctoral|professional');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `required_license_type` SET TAGS ('dbx_business_glossary_term' = 'Required License Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|variable|on_call');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'workday|sap|meditech|manual');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `source_system_position_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Position ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|filled|frozen|eliminated|pending_approval');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'regular|temporary|contract|per_diem|traveler|seasonal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union / Bargaining Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,15}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Scope Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `clinical_role_indicator` SET TAGS ('dbx_business_glossary_term' = 'Clinical Role Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `cme_compliance_period_months` SET TAGS ('dbx_business_glossary_term' = 'Continuing Medical Education (CME) Compliance Period (Months)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `cme_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Medical Education (CME) Hours Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `competency_framework_code` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `dea_registration_required` SET TAGS ('dbx_business_glossary_term' = 'DEA Registration Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `drug_screen_required` SET TAGS ('dbx_business_glossary_term' = 'Drug Screen Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'Full-Time|Part-Time|Per Diem|Contract|Temporary|Intern');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Exemption Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'Exempt|Non-Exempt|Highly Compensated|Computer Employee');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `fte_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Value');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `hipaa_access_level` SET TAGS ('dbx_business_glossary_term' = 'HIPAA PHI Access Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `hipaa_access_level` SET TAGS ('dbx_value_regex' = 'No Access|Limited|Standard|Extended|Full');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `job_category` SET TAGS ('dbx_business_glossary_term' = 'Job Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,20}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `job_family_group` SET TAGS ('dbx_business_glossary_term' = 'Job Family Group');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Reviewed Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `licensure_required` SET TAGS ('dbx_business_glossary_term' = 'Licensure Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_business_glossary_term' = 'Management Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_value_regex' = 'Individual Contributor|Manager|Senior Manager|Director|Vice President|Executive');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'High School Diploma|Associate Degree|Bachelors Degree|Masters Degree|Doctoral Degree|Professional Degree');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `npi_required` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI) Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `on_call_required` SET TAGS ('dbx_business_glossary_term' = 'On-Call Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `osha_exposure_category` SET TAGS ('dbx_business_glossary_term' = 'OSHA Bloodborne Pathogen Exposure Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `osha_exposure_category` SET TAGS ('dbx_value_regex' = 'Category I|Category II|Category III');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_range_max` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Maximum');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_range_midpoint` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Midpoint');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_range_midpoint` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_range_min` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Minimum');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_rate_type` SET TAGS ('dbx_value_regex' = 'Salary|Hourly|Daily');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `privileging_required` SET TAGS ('dbx_business_glossary_term' = 'Privileging Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `profile_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Pending|Deprecated');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `remote_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `required_license_types` SET TAGS ('dbx_business_glossary_term' = 'Required License Types');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `rvu_eligible` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Eligible Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'Day|Evening|Night|Rotating|On-Call|Variable');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `travel_required` SET TAGS ('dbx_business_glossary_term' = 'Travel Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `union_eligible` SET TAGS ('dbx_business_glossary_term' = 'Union Eligibility Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`job_profile` ALTER COLUMN `workday_job_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Job Profile ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` SET TAGS ('dbx_subdomain' = 'talent_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `employment_competency_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Competency ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Privilege Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Privilege Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Privilege Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `application_complete_date` SET TAGS ('dbx_business_glossary_term' = 'Application Complete Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `application_decision` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Application Decision');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `application_decision` SET TAGS ('dbx_value_regex' = 'approved|denied|deferred|withdrawn|pending');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `application_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Application Decision Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `application_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `application_type` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Application Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `application_type` SET TAGS ('dbx_value_regex' = 'initial|reappointment|reinstatement|modification|temporary');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `appointment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Staff Appointment Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `appointment_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Staff Appointment Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `cme_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Medical Education (CME) Credit Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `cme_requirement_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Medical Education (CME) Requirement Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `committee_review_date` SET TAGS ('dbx_business_glossary_term' = 'Committee Review Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `competency_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Competency Assessment Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `competency_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Competency Assessment Score');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `competency_type` SET TAGS ('dbx_business_glossary_term' = 'Competency Record Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `competency_type` SET TAGS ('dbx_value_regex' = 'credential|privilege|credentialing_application');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `credential_category` SET TAGS ('dbx_business_glossary_term' = 'Credential Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `credential_number` SET TAGS ('dbx_business_glossary_term' = 'Credential License Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `credential_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `credential_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `credential_status` SET TAGS ('dbx_business_glossary_term' = 'Credential Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `credential_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_renewal|surrendered');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Application Denial Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `denial_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Staff Department Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Issue Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `issuing_country` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `issuing_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `issuing_country` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Issuing State Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `issuing_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `issuing_state` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `malpractice_coverage_verified` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Coverage Verification Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `malpractice_coverage_verified` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `medical_staff_category` SET TAGS ('dbx_business_glossary_term' = 'Medical Staff Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `medical_staff_category` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `medical_staff_category` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `medical_staff_committee` SET TAGS ('dbx_business_glossary_term' = 'Medical Staff Committee');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `medical_staff_committee` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `medical_staff_committee` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `npdb_query_date` SET TAGS ('dbx_business_glossary_term' = 'National Practitioner Data Bank (NPDB) Query Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `npdb_query_result` SET TAGS ('dbx_business_glossary_term' = 'National Practitioner Data Bank (NPDB) Query Result');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `npdb_query_result` SET TAGS ('dbx_value_regex' = 'no_report|report_found|pending');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `npdb_query_result` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `oig_exclusion_check_date` SET TAGS ('dbx_business_glossary_term' = 'Office of Inspector General (OIG) Exclusion Check Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `oig_exclusion_checked` SET TAGS ('dbx_business_glossary_term' = 'Office of Inspector General (OIG) Exclusion Check Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `primary_source_verified` SET TAGS ('dbx_business_glossary_term' = 'Primary Source Verification (PSV) Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `privilege_category` SET TAGS ('dbx_business_glossary_term' = 'Clinical Privilege Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `privilege_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Privilege Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `privilege_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Privilege Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `privilege_grant_date` SET TAGS ('dbx_business_glossary_term' = 'Privilege Grant Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `privilege_procedure_code` SET TAGS ('dbx_business_glossary_term' = 'Privilege Procedure/Service Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `privilege_procedure_name` SET TAGS ('dbx_business_glossary_term' = 'Privilege Procedure/Service Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `privilege_status` SET TAGS ('dbx_business_glossary_term' = 'Clinical Privilege Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `psv_date` SET TAGS ('dbx_business_glossary_term' = 'Primary Source Verification (PSV) Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `psv_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Source Verification (PSV) Method');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `psv_method` SET TAGS ('dbx_value_regex' = 'online_portal|written_confirmation|telephone|third_party_service|automated_feed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Credential Renewal Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `sam_exclusion_checked` SET TAGS ('dbx_business_glossary_term' = 'System for Award Management (SAM) Exclusion Check Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`employment_competency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` SET TAGS ('dbx_subdomain' = 'talent_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `competency_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Assessment ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `education_program_id` SET TAGS ('dbx_business_glossary_term' = 'Education Program ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `administration_route` SET TAGS ('dbx_business_glossary_term' = 'Administration Route');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `administration_route` SET TAGS ('dbx_value_regex' = 'intramuscular|subcutaneous|intradermal|oral|intranasal');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `administration_site` SET TAGS ('dbx_business_glossary_term' = 'Administration Site');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `administration_site` SET TAGS ('dbx_value_regex' = 'left_deltoid|right_deltoid|left_thigh|right_thigh|left_arm|right_arm');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_category` SET TAGS ('dbx_business_glossary_term' = 'Assessment Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_category` SET TAGS ('dbx_value_regex' = 'competency|immunization|health_screening');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|overdue|waived|declined');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `cme_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Medical Education (CME) Credit Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `competency_domain` SET TAGS ('dbx_business_glossary_term' = 'Competency Domain');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `competency_name` SET TAGS ('dbx_business_glossary_term' = 'Competency Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|pending');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `declination_reason` SET TAGS ('dbx_business_glossary_term' = 'Declination Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `fit_test_protocol` SET TAGS ('dbx_business_glossary_term' = 'Fit Test Protocol');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `fit_test_protocol` SET TAGS ('dbx_value_regex' = 'qualitative|quantitative');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `job_role_applicability` SET TAGS ('dbx_business_glossary_term' = 'Job Role Applicability');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `medical_contraindication` SET TAGS ('dbx_business_glossary_term' = 'Medical Contraindication Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `medical_contraindication` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `medical_contraindication` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `n95_respirator_model` SET TAGS ('dbx_business_glossary_term' = 'N95 Respirator Model');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Assessment Outcome');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Passing Score');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `prior_immunity_documented` SET TAGS ('dbx_business_glossary_term' = 'Prior Immunity Documented Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `reassessment_date` SET TAGS ('dbx_business_glossary_term' = 'Reassessment Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `remediation_due_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Due Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `remediation_plan` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `remediation_required` SET TAGS ('dbx_business_glossary_term' = 'Remediation Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_business_glossary_term' = 'Result Interpretation');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `result_interpretation` SET TAGS ('dbx_value_regex' = 'positive|negative|indeterminate|reactive|non_reactive');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `result_value` SET TAGS ('dbx_business_glossary_term' = 'Result Value');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `titer_result` SET TAGS ('dbx_business_glossary_term' = 'Titer Result');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `titer_result` SET TAGS ('dbx_value_regex' = 'immune|non_immune|indeterminate');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `vaccine_dose_number` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Dose Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `vaccine_lot_number` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Lot Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `vaccine_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Vaccine Manufacturer');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `vaccine_ndc` SET TAGS ('dbx_business_glossary_term' = 'Vaccine National Drug Code (NDC)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`competency_assessment` ALTER COLUMN `vaccine_ndc` SET TAGS ('dbx_value_regex' = '^[0-9]{5}-[0-9]{4}-[0-9]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_subdomain' = 'time_payroll');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Clinician Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `swap_source_shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Swap Source Schedule ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `unit_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `unit_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `actual_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `agency_name` SET TAGS ('dbx_business_glossary_term' = 'Agency Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `agency_name` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `approval_datetime` SET TAGS ('dbx_business_glossary_term' = 'Approval Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'scheduled|confirmed|swapped|cancelled|no_show|completed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Minutes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `fte_value` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Value');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_agency_staff` SET TAGS ('dbx_business_glossary_term' = 'Agency Staff Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_agency_staff` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_charge_role` SET TAGS ('dbx_business_glossary_term' = 'Charge Role Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_float_assignment` SET TAGS ('dbx_business_glossary_term' = 'Float Assignment Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `last_updated_datetime` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `nurse_to_patient_ratio` SET TAGS ('dbx_business_glossary_term' = 'Nurse-to-Patient Ratio');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `on_call_response_minutes` SET TAGS ('dbx_business_glossary_term' = 'On-Call Response Time (Minutes)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `patient_census` SET TAGS ('dbx_business_glossary_term' = 'Patient Census');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `pay_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `published_datetime` SET TAGS ('dbx_business_glossary_term' = 'Published Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `required_fte_coverage` SET TAGS ('dbx_business_glossary_term' = 'Required Full-Time Equivalent (FTE) Coverage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `required_fte_coverage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_value_regex' = '^SCH-[0-9]{8,12}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|published|approved|closed|archived');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `scheduled_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_category` SET TAGS ('dbx_business_glossary_term' = 'Shift Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_category` SET TAGS ('dbx_value_regex' = 'regular|overtime|on_call|callback|charge|float');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|on_call|weekend|holiday');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'WORKDAY|EPIC_CADENCE|CERNER|MEDITECH|MANUAL');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`shift_schedule` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` SET TAGS ('dbx_subdomain' = 'time_payroll');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `time_attendance_id` SET TAGS ('dbx_business_glossary_term' = 'Time and Attendance Record ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Time Record Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|corrected|submitted');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `base_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Pay Rate');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `base_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `benefits_deduction` SET TAGS ('dbx_business_glossary_term' = 'Benefits Deduction Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `benefits_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonus Pay Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `bonus_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-In Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-Out Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `correction_reason` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Correction Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `correction_reason` SET TAGS ('dbx_value_regex' = 'missed_punch|system_error|schedule_change|manager_adjustment|employee_request|other');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `flsa_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'FLSA (Fair Labor Standards Act) Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `flsa_exempt` SET TAGS ('dbx_business_glossary_term' = 'FLSA (Fair Labor Standards Act) Exempt Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `garnishment_deduction` SET TAGS ('dbx_business_glossary_term' = 'Garnishment Deduction Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `garnishment_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Pay Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `gross_pay_amount` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'none|pto|fmla|sick|bereavement|jury_duty');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `meal_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Meal Break Deduction Minutes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `missed_punch_count` SET TAGS ('dbx_business_glossary_term' = 'Missed Punch Count');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Pay Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `net_pay_amount` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `on_call_hours` SET TAGS ('dbx_business_glossary_term' = 'On-Call Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `osha_incident_related` SET TAGS ('dbx_business_glossary_term' = 'OSHA Incident Related Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `overtime_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `pay_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `pay_type` SET TAGS ('dbx_value_regex' = 'hourly|salary|per_diem|contract');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'direct_deposit|check|pay_card');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `payroll_run_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_value_regex' = 'not_processed|processing|processed|on_hold|reversed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `regular_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `shift_date` SET TAGS ('dbx_business_glossary_term' = 'Shift Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Pay Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `shift_differential_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|on_call|weekend|holiday');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `time_entry_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|on_call|callback|charge|training');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `timekeeper_corrected` SET TAGS ('dbx_business_glossary_term' = 'Timekeeper Correction Applied Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `total_tax_deduction` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Deduction Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`time_attendance` ALTER COLUMN `total_tax_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'benefits_wellbeing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `aca_affordability_flag` SET TAGS ('dbx_business_glossary_term' = 'ACA Affordability Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `aca_minimum_essential_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'ACA Minimum Essential Coverage (MEC) Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `aca_minimum_essential_coverage_flag` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `aca_minimum_value_flag` SET TAGS ('dbx_business_glossary_term' = 'ACA Minimum Value (MV) Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_election_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Election Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `annual_election_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Beneficiary Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_business_glossary_term' = 'Primary Beneficiary Relationship');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_value_regex' = 'spouse|child|parent|sibling|domestic_partner|other');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Confirmation Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_eligibility_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Carrier Eligibility File Sent Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_group_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Group Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Member ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_member_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Carrier Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'COBRA Eligibility Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_notification_date` SET TAGS ('dbx_business_glossary_term' = 'COBRA Notification Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|family');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `deduction_frequency` SET TAGS ('dbx_business_glossary_term' = 'Deduction Frequency');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `deduction_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Dependent Count');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `disability_benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Disability Benefit Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `disability_benefit_type` SET TAGS ('dbx_value_regex' = 'short_term|long_term');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `disability_benefit_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `disability_benefit_type` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Premium Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_match_rate` SET TAGS ('dbx_business_glossary_term' = 'Employer Match Rate');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_match_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Premium Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_value_regex' = '^ENR-[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'open_enrollment|qualifying_life_event|new_hire|rehire|correction');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|waived|suspended');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `fsa_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Flexible Spending Account (FSA) Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `fsa_plan_type` SET TAGS ('dbx_value_regex' = 'healthcare|dependent_care|limited_purpose');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `hsa_contribution_limit` SET TAGS ('dbx_business_glossary_term' = 'Health Savings Account (HSA) Contribution Limit');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `hsa_contribution_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Life Insurance Coverage Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `open_enrollment_period` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `open_enrollment_period` SET TAGS ('dbx_value_regex' = '^OE-[0-9]{4}(-[0-9]{2})?$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `other_coverage_carrier` SET TAGS ('dbx_business_glossary_term' = 'Other Coverage Carrier Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `other_coverage_carrier` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `pretax_flag` SET TAGS ('dbx_business_glossary_term' = 'Pre-Tax Deduction Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `qualifying_life_event_type` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Life Event (QLE) Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `retirement_contribution_rate` SET TAGS ('dbx_business_glossary_term' = 'Retirement Contribution Rate');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `retirement_contribution_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Benefit Waiver Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'benefits_wellbeing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_end_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_start_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Leave Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `benefits_continuation` SET TAGS ('dbx_business_glossary_term' = 'Benefits Continuation Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `cobra_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'COBRA Notification Sent Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Denial Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `fitness_for_duty_received_date` SET TAGS ('dbx_business_glossary_term' = 'Fitness for Duty Certification Received Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `fitness_for_duty_required` SET TAGS ('dbx_business_glossary_term' = 'Fitness for Duty Certification Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_eligibility_determination_date` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Eligibility Determination Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_eligible` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Eligibility Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_hours_remaining` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Hours Remaining');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_hours_used` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Hours Used');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `hr_notes` SET TAGS ('dbx_business_glossary_term' = 'HR Leave Notes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `hr_notes` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `hr_notes` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `intermittent_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Episode Duration Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `intermittent_frequency` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Frequency');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `intermittent_frequency` SET TAGS ('dbx_value_regex' = 'Daily|Weekly|Monthly|As_Needed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `is_intermittent` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Leave Duration Days');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_year_start_date` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Leave Year Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_expiration_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_expiration_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_received_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certification_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `military_order_number` SET TAGS ('dbx_business_glossary_term' = 'Military Order Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `military_service_branch` SET TAGS ('dbx_business_glossary_term' = 'Military Service Branch');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `notice_provided_date` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Notice Provided Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `pay_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Pay Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `pay_status` SET TAGS ('dbx_value_regex' = 'Paid|Unpaid|Partial_Pay|STD|LTD');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `pto_hours_applied` SET TAGS ('dbx_business_glossary_term' = 'PTO (Paid Time Off) Hours Applied');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^LR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `requested_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `return_to_work_status` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `return_to_work_status` SET TAGS ('dbx_value_regex' = 'Returned|Extended|Separated|Pending|No_Return');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Submission Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `workday_absence_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Absence Management ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`leave_request` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `review_template_id` SET TAGS ('dbx_business_glossary_term' = 'Review Template ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_worker_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Worker ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_worker_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_worker_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `appeal_filed` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Appeal Filed Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Appeal Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'pending|upheld|overturned|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_business_glossary_term' = 'Calibration Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|calibrated|approved');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `career_interest_narrative` SET TAGS ('dbx_business_glossary_term' = 'Career Interest Narrative');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `career_interest_narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `cme_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Medical Education (CME) Hours Completed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `competency_rating` SET TAGS ('dbx_business_glossary_term' = 'Competency Rating');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `competency_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|partially_meets|does_not_meet');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `development_goals_narrative` SET TAGS ('dbx_business_glossary_term' = 'Development Goals Narrative');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `development_goals_narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `discipline_type` SET TAGS ('dbx_business_glossary_term' = 'Progressive Discipline Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `discipline_type` SET TAGS ('dbx_value_regex' = 'none|verbal_warning|written_warning|pip|suspension|termination_for_cause');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_rating` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Rating');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_rating` SET TAGS ('dbx_value_regex' = 'exceeds|meets|partially_meets|does_not_meet');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `is_high_potential` SET TAGS ('dbx_business_glossary_term' = 'High Potential (HiPo) Designation Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `is_high_potential` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_feedback` SET TAGS ('dbx_business_glossary_term' = 'Manager Feedback Narrative');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_feedback` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_feedback` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Manager Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `manager_submission_date` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `mentorship_participant` SET TAGS ('dbx_business_glossary_term' = 'Mentorship Program Participation Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_eligible` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligibility Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percent` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `mobility_preference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Mobility Preference');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `mobility_preference` SET TAGS ('dbx_value_regex' = 'open_to_relocation|local_only|remote_preferred|no_preference');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|partially_meets|does_not_meet|outstanding');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating Score');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `pip_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `pip_outcome` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Outcome');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `pip_outcome` SET TAGS ('dbx_value_regex' = 'successful|unsuccessful|extended|withdrawn');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `pip_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `policy_violation_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Violation Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `promotion_eligible` SET TAGS ('dbx_business_glossary_term' = 'Promotion Eligibility Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `review_meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Review Meeting Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `review_number` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `self_assessment_narrative` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment Narrative');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `self_assessment_narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `source_system_review_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Review ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `succession_plan_included` SET TAGS ('dbx_business_glossary_term' = 'Succession Plan Inclusion Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `succession_plan_included` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `talent_segment` SET TAGS ('dbx_business_glossary_term' = 'Talent Segment Classification');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `talent_segment` SET TAGS ('dbx_value_regex' = 'high_potential|key_contributor|solid_performer|needs_development|at_risk');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`performance_review` ALTER COLUMN `talent_segment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` SET TAGS ('dbx_subdomain' = 'talent_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruitment_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruitment_hiring_manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruitment_hiring_manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruitment_hiring_manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `recruitment_hiring_manager_employee_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Email Address');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Initiation Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_initiated|in_progress|clear|adverse|pending_review|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `badge_issued` SET TAGS ('dbx_business_glossary_term' = 'Employee Badge Issued');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `cost_per_hire` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Hire');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `cost_per_hire` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `drug_screen_status` SET TAGS ('dbx_business_glossary_term' = 'Pre-Employment Drug Screen Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `drug_screen_status` SET TAGS ('dbx_value_regex' = 'not_initiated|pending|negative|positive|cancelled');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|per_diem|contract|temporary|intern');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `fire_safety_training_completed` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Training Completed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `fte_value` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Value');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `hipaa_training_completed` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Portability and Accountability Act (HIPAA) Training Completed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `hire_decision` SET TAGS ('dbx_business_glossary_term' = 'Hire Decision');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `hire_decision` SET TAGS ('dbx_value_regex' = 'hired|not_selected|withdrawn|offer_declined');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `i9_completion_date` SET TAGS ('dbx_business_glossary_term' = 'I-9 Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `i9_verification_status` SET TAGS ('dbx_business_glossary_term' = 'I-9 Employment Eligibility Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `i9_verification_status` SET TAGS ('dbx_value_regex' = 'not_started|pending|completed|reverification_required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `infection_control_training_completed` SET TAGS ('dbx_business_glossary_term' = 'Infection Control Training Completed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `interview_stage` SET TAGS ('dbx_business_glossary_term' = 'Interview Stage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `interview_stage` SET TAGS ('dbx_value_regex' = 'phone_screen|hiring_manager|panel|final|none');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `interview_stage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `is_clinical_position` SET TAGS ('dbx_business_glossary_term' = 'Clinical Position Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `license_verified` SET TAGS ('dbx_business_glossary_term' = 'License Verified Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offer_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offer_status` SET TAGS ('dbx_business_glossary_term' = 'Offer Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offer_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|declined|rescinded|expired');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offered_salary` SET TAGS ('dbx_business_glossary_term' = 'Offered Base Salary');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `offered_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `oig_exclusion_checked` SET TAGS ('dbx_business_glossary_term' = 'Office of Inspector General (OIG) Exclusion Check Completed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `onboarding_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|overdue');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `onboarding_target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Target Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `orientation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Orientation Completion Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `orientation_status` SET TAGS ('dbx_business_glossary_term' = 'New Employee Orientation Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `orientation_status` SET TAGS ('dbx_value_regex' = 'not_scheduled|scheduled|in_progress|completed|waived');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_business_glossary_term' = 'Applicant Pipeline Stage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `pipeline_stage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `policy_acknowledgment_completed` SET TAGS ('dbx_business_glossary_term' = 'Policy Acknowledgment Completed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Job Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `required_license_type` SET TAGS ('dbx_business_glossary_term' = 'Required License Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `requisition_open_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Open Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'draft|open|on_hold|filled|cancelled|closed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `source_of_hire` SET TAGS ('dbx_business_glossary_term' = 'Source of Hire');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `system_access_provisioned` SET TAGS ('dbx_business_glossary_term' = 'System Access Provisioned');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`recruitment` ALTER COLUMN `workday_candidate_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Candidate ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` SET TAGS ('dbx_subdomain' = 'benefits_wellbeing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `osha_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Incident ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `improvement_initiative_id` SET TAGS ('dbx_business_glossary_term' = 'Improvement Initiative Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Injury Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Injury Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Workers Comp Payer Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `bloodborne_pathogen_exposure` SET TAGS ('dbx_business_glossary_term' = 'Bloodborne Pathogen Exposure Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `body_side` SET TAGS ('dbx_business_glossary_term' = 'Body Side');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `body_side` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `days_restricted_duty` SET TAGS ('dbx_business_glossary_term' = 'Days of Restricted Duty or Job Transfer');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `event_source` SET TAGS ('dbx_business_glossary_term' = 'Event Source or Exposure');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `incident_datetime` SET TAGS ('dbx_business_glossary_term' = 'Incident Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Description');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_review|closed|appealed|voided');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `injury_illness_type` SET TAGS ('dbx_business_glossary_term' = 'Injury or Illness Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `injury_illness_type` SET TAGS ('dbx_value_regex' = 'injury|skin_disorder|respiratory_condition|poisoning|hearing_loss|all_other_illness');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `is_fatality` SET TAGS ('dbx_business_glossary_term' = 'Fatality Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `is_hospitalized` SET TAGS ('dbx_business_glossary_term' = 'Inpatient Hospitalization Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `is_osha_recordable` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `is_privacy_case` SET TAGS ('dbx_business_glossary_term' = 'Privacy Case Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `is_work_related` SET TAGS ('dbx_business_glossary_term' = 'Work-Related Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `nature_of_injury` SET TAGS ('dbx_business_glossary_term' = 'Nature of Injury or Illness');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `osha_300_log_entry_date` SET TAGS ('dbx_business_glossary_term' = 'OSHA 300 Log Entry Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `osha_300a_included` SET TAGS ('dbx_business_glossary_term' = 'OSHA 300A Annual Summary Included Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `osha_301_completed` SET TAGS ('dbx_business_glossary_term' = 'OSHA 301 Injury and Illness Incident Report Completed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `osha_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'OSHA Establishment ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `post_exposure_followup_completed` SET TAGS ('dbx_business_glossary_term' = 'Post-Exposure Follow-Up Completed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `ppe_in_use` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) In Use Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `ppe_type` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `reported_datetime` SET TAGS ('dbx_business_glossary_term' = 'Incident Reported Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis Description');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|on_call');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `treating_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Treating Provider Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `treatment_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Treatment Facility Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `treatment_facility_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `treatment_facility_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_business_glossary_term' = 'Witness Names');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`osha_incident` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `fte_budget_id` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Budget ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `fiscal_period_id` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `actual_fte` SET TAGS ('dbx_business_glossary_term' = 'Actual Full-Time Equivalent (FTE) Utilized');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Cost (USD)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `agency_fte` SET TAGS ('dbx_business_glossary_term' = 'Agency/Contract Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `agency_fte` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `benefits_burden_pct` SET TAGS ('dbx_business_glossary_term' = 'Benefits Burden Percentage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `benefits_burden_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'FTE Budget Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budget_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,20}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_business_glossary_term' = 'Budget Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budget_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|superseded');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budget_version` SET TAGS ('dbx_business_glossary_term' = 'Budget Version');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budget_version` SET TAGS ('dbx_value_regex' = 'original|revised|final|forecast');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budgeted_avg_hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Average Hourly Rate (USD)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budgeted_avg_hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budgeted_fte` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Full-Time Equivalent (FTE) Count');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budgeted_hours` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budgeted_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Labor Cost (USD)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budgeted_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budgeted_nonproductive_fte` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Non-Productive Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budgeted_overtime_fte` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Overtime Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `budgeted_productive_fte` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Productive Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,15}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Budget Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|per_diem|contract|agency');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Budget End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_value_regex' = '^(Q[1-4]|P(0[1-9]|1[0-2]))$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `fte_variance` SET TAGS ('dbx_business_glossary_term' = 'FTE Variance');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `is_union_position` SET TAGS ('dbx_business_glossary_term' = 'Is Union Position Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,15}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `job_family` SET TAGS ('dbx_business_glossary_term' = 'Job Family');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `labor_cost_per_apd` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost per Adjusted Patient Day (APD)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `labor_cost_per_apd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `labor_cost_variance` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Variance (USD)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `labor_cost_variance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Budget Notes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,10}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `pay_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `pay_type` SET TAGS ('dbx_value_regex' = 'productive|non_productive|overtime|on_call|agency');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `productivity_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Productivity Target Percentage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `staffing_ratio_target` SET TAGS ('dbx_business_glossary_term' = 'Staffing Ratio Target');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `standard_hours_per_fte` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours per Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,10}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`fte_budget` ALTER COLUMN `vacancy_fte` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `accreditation_program` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Program');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `authorized_headcount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Headcount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `budgeted_fte` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `division_name` SET TAGS ('dbx_business_glossary_term' = 'Division Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Email Address');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `fiscal_year_start_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year Start Month');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Organizational Hierarchy Path');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `is_clinical` SET TAGS ('dbx_business_glossary_term' = 'Is Clinical Unit Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `is_revenue_generating` SET TAGS ('dbx_business_glossary_term' = 'Is Revenue Generating Unit Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `is_supervisory_org` SET TAGS ('dbx_business_glossary_term' = 'Is Supervisory Organization Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|ambulatory|emergency|virtual|administrative');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `osha_establishment_number` SET TAGS ('dbx_business_glossary_term' = 'OSHA Establishment ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Service Line');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `specialty_code` SET TAGS ('dbx_business_glossary_term' = 'Clinical Specialty Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|dissolved');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Subtype');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_value_regex' = 'department|division|service_line|cost_center|supervisory_org|team');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`org_unit` ALTER COLUMN `workday_integration_code` SET TAGS ('dbx_business_glossary_term' = 'Workday Integration ID');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` SET TAGS ('dbx_subdomain' = 'talent_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` SET TAGS ('dbx_association_edges' = 'workforce.employee,insurance.payer');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `workforce_provider_network_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Participation - Provider Network Participation Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Participation - Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `payer_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Network Participation - Payer Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `accepting_new_patients_flag` SET TAGS ('dbx_business_glossary_term' = 'Accepting New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `contract_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `network_participation_status` SET TAGS ('dbx_business_glossary_term' = 'Network Participation Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `network_tier` SET TAGS ('dbx_business_glossary_term' = 'Network Tier Assignment');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `payer_provider_number` SET TAGS ('dbx_business_glossary_term' = 'Payer-Specific Provider Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `reimbursement_rate_schedule` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Rate Schedule');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`workforce_provider_network_participation` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Participation Termination Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('dbx_subdomain' = 'talent_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` SET TAGS ('dbx_association_edges' = 'workforce.employee,reference.cpt_code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `clinical_privilege_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Privilege Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Privilege - Cpt Code Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Clinical Privilege - Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `competency_level` SET TAGS ('dbx_business_glossary_term' = 'Competency Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `granting_committee` SET TAGS ('dbx_business_glossary_term' = 'Granting Committee');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `last_proctoring_date` SET TAGS ('dbx_business_glossary_term' = 'Last Proctoring Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `privilege_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Privilege Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `privilege_grant_date` SET TAGS ('dbx_business_glossary_term' = 'Privilege Grant Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `privilege_status` SET TAGS ('dbx_business_glossary_term' = 'Privilege Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `proctoring_cases_completed` SET TAGS ('dbx_business_glossary_term' = 'Proctoring Cases Completed');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `proctoring_cases_required` SET TAGS ('dbx_business_glossary_term' = 'Proctoring Cases Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Restriction Notes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `supervision_required` SET TAGS ('dbx_business_glossary_term' = 'Supervision Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`clinical_privilege` ALTER COLUMN `volume_requirement` SET TAGS ('dbx_business_glossary_term' = 'Volume Requirement');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('dbx_subdomain' = 'talent_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` SET TAGS ('dbx_association_edges' = 'workforce.employee,interoperability.interface_channel');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `channel_support_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Support Assignment Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Support Assignment - Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `interface_channel_id` SET TAGS ('dbx_business_glossary_term' = 'Channel Support Assignment - Interface Channel Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `escalation_tier` SET TAGS ('dbx_business_glossary_term' = 'Escalation Tier Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Incident Notification Preference');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `on_call_rotation` SET TAGS ('dbx_business_glossary_term' = 'On-Call Rotation Schedule');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `support_role` SET TAGS ('dbx_business_glossary_term' = 'Support Role Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`channel_support_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('dbx_subdomain' = 'workforce_administration');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` SET TAGS ('dbx_association_edges' = 'workforce.position,reference.cpt_code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_procedure_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Position Procedure Authorization Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Position Procedure Authorization - Cpt Code Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Procedure Authorization - Position Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `competency_validation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Competency Validation Frequency');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Record Created Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `credentialing_committee_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Committee Approval Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `minimum_cases_required` SET TAGS ('dbx_business_glossary_term' = 'Minimum Cases Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `supervision_requirement` SET TAGS ('dbx_business_glossary_term' = 'Supervision Requirement');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `training_description` SET TAGS ('dbx_business_glossary_term' = 'Training Description');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `updated_date` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `volume_expectation` SET TAGS ('dbx_business_glossary_term' = 'Volume Expectation');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`position_procedure_authorization` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'benefits_wellbeing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Benefit Plan Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `superseded_benefit_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Policy Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `copay_emergency_room` SET TAGS ('dbx_business_glossary_term' = 'Copay Emergency Room');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `copay_primary_care` SET TAGS ('dbx_business_glossary_term' = 'Copay Primary Care');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `copay_specialist` SET TAGS ('dbx_business_glossary_term' = 'Copay Specialist');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Coverage Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_level` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employer_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employer_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `enrollment_eligibility_rule` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility Rule');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `erisa_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Erisa Plan Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `erisa_plan_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `is_aca_compliant` SET TAGS ('dbx_business_glossary_term' = 'Is Aca Compliant');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `is_cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Cobra Eligible');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `is_fsa_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Fsa Eligible');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `is_hsa_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is Hsa Eligible');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `minimum_value_percentage` SET TAGS ('dbx_business_glossary_term' = 'Minimum Value Percentage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `minimum_value_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `network_type` SET TAGS ('dbx_business_glossary_term' = 'Network Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `open_enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `open_enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out Of Pocket Maximum');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_business_glossary_term' = 'Plan Administrator Email');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Administrator Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_phone` SET TAGS ('dbx_business_glossary_term' = 'Plan Administrator Phone');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_administrator_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_business_glossary_term' = 'Plan Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Plan Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Plan Description');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Url');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Plan Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `summary_plan_description_url` SET TAGS ('dbx_business_glossary_term' = 'Summary Plan Description Url');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `total_premium_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Premium Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`benefit_plan` ALTER COLUMN `waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Waiting Period Days');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` SET TAGS ('dbx_subdomain' = 'talent_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `education_program_id` SET TAGS ('dbx_business_glossary_term' = 'Education Program Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `prerequisite_education_program_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Education Program Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `prerequisite_education_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `accreditation_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Effective Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `accreditation_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `accreditation_number` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `accreditation_status` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `commercial_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Support Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `competency_domain` SET TAGS ('dbx_business_glossary_term' = 'Competency Domain');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Credit Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `credit_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `frequency_requirement` SET TAGS ('dbx_business_glossary_term' = 'Frequency Requirement');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `learning_objectives` SET TAGS ('dbx_business_glossary_term' = 'Learning Objectives');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `maximum_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `prerequisite_requirements` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Requirements');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_director_credentials` SET TAGS ('dbx_business_glossary_term' = 'Program Director Credentials');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_director_name` SET TAGS ('dbx_business_glossary_term' = 'Program Director Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_director_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_director_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `program_url` SET TAGS ('dbx_business_glossary_term' = 'Program Url');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `vendor_provider_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Provider Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`education_program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` SET TAGS ('dbx_subdomain' = 'talent_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_template_id` SET TAGS ('dbx_business_glossary_term' = 'Review Template Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `superseded_review_template_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Review Template Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `superseded_review_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `allows_peer_review` SET TAGS ('dbx_business_glossary_term' = 'Allows Peer Review');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `allows_self_assessment` SET TAGS ('dbx_business_glossary_term' = 'Allows Self Assessment');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `applicable_role_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Role Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `archived_date` SET TAGS ('dbx_business_glossary_term' = 'Archived Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `archived_reason` SET TAGS ('dbx_business_glossary_term' = 'Archived Reason');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `average_completion_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Completion Time Minutes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `average_completion_time_minutes` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `cme_credit_hours` SET TAGS ('dbx_business_glossary_term' = 'Cme Credit Hours');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `cme_eligible` SET TAGS ('dbx_business_glossary_term' = 'Cme Eligible');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `compliance_framework` SET TAGS ('dbx_business_glossary_term' = 'Compliance Framework');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `credentialing_required` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Required');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_template_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `escalation_days_after_due` SET TAGS ('dbx_business_glossary_term' = 'Escalation Days After Due');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `instructions` SET TAGS ('dbx_business_glossary_term' = 'Instructions');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `maximum_score` SET TAGS ('dbx_business_glossary_term' = 'Maximum Score');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `minimum_passing_score` SET TAGS ('dbx_business_glossary_term' = 'Minimum Passing Score');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `notification_days_before_due` SET TAGS ('dbx_business_glossary_term' = 'Notification Days Before Due');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `requires_employee_acknowledgment` SET TAGS ('dbx_business_glossary_term' = 'Requires Employee Acknowledgment');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `requires_manager_approval` SET TAGS ('dbx_business_glossary_term' = 'Requires Manager Approval');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `requires_manager_approval` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_category` SET TAGS ('dbx_business_glossary_term' = 'Review Category');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_period_days` SET TAGS ('dbx_business_glossary_term' = 'Review Period Days');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `scoring_method` SET TAGS ('dbx_business_glossary_term' = 'Scoring Method');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `review_template_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `supports_development_plan` SET TAGS ('dbx_business_glossary_term' = 'Supports Development Plan');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`review_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` SET TAGS ('dbx_subdomain' = 'talent_credentialing');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `applicant_referring_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `applicant_referring_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `applicant_referring_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `care_site_id` SET TAGS ('dbx_business_glossary_term' = 'Care Site Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `referred_by_applicant_id` SET TAGS ('dbx_business_glossary_term' = 'Referred By Applicant Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `referred_by_applicant_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Alternate Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `application_source` SET TAGS ('dbx_business_glossary_term' = 'Application Source');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `available_start_date` SET TAGS ('dbx_business_glossary_term' = 'Available Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `board_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Board Certified Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date Of Birth');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `degree_field` SET TAGS ('dbx_business_glossary_term' = 'Degree Field');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `desired_salary` SET TAGS ('dbx_business_glossary_term' = 'Desired Salary');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `desired_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `drug_screening_date` SET TAGS ('dbx_business_glossary_term' = 'Drug Screening Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `drug_screening_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Screening Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `eligible_to_work_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligible To Work Flag');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_business_glossary_term' = 'Highest Education Level');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'License Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License State');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `national_provider_identifier` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `national_provider_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `national_provider_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `position_applied_for` SET TAGS ('dbx_business_glossary_term' = 'Position Applied For');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `reference_check_status` SET TAGS ('dbx_business_glossary_term' = 'Reference Check Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `social_security_number` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `social_security_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `social_security_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Specialty');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `applicant_type` SET TAGS ('dbx_business_glossary_term' = 'Applicant Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `work_authorization_type` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`applicant` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years Of Experience');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'time_payroll');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Calendar Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `reversed_payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Reversed Payroll Run Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `reversed_payroll_run_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `check_date` SET TAGS ('dbx_business_glossary_term' = 'Check Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `error_message` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `frequency` SET TAGS ('dbx_business_glossary_term' = 'Frequency');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `general_ledger_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Posting Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `initiated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Initiated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `is_final_run` SET TAGS ('dbx_business_glossary_term' = 'Is Final Run');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `is_retroactive` SET TAGS ('dbx_business_glossary_term' = 'Is Retroactive');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `processing_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Completed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `processing_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Started Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_number` SET TAGS ('dbx_business_glossary_term' = 'Run Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `run_type` SET TAGS ('dbx_business_glossary_term' = 'Run Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_benefits` SET TAGS ('dbx_business_glossary_term' = 'Total Employer Benefits');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_taxes` SET TAGS ('dbx_business_glossary_term' = 'Total Employer Taxes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Pay');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Net Pay');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_run` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` SET TAGS ('dbx_subdomain' = 'time_payroll');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `payroll_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Calendar Identifier');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `prior_payroll_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Payroll Calendar Id');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `prior_payroll_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Calendar Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Calendar Name');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `calendar_type` SET TAGS ('dbx_business_glossary_term' = 'Calendar Type');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `calendar_year` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `employee_group_code` SET TAGS ('dbx_business_glossary_term' = 'Employee Group Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `holiday_count` SET TAGS ('dbx_business_glossary_term' = 'Holiday Count');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `is_adjustment_period` SET TAGS ('dbx_business_glossary_term' = 'Is Adjustment Period');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `is_year_end_period` SET TAGS ('dbx_business_glossary_term' = 'Is Year End Period');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `pay_period_number` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Number');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `payroll_processing_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processing Date');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `payroll_system_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll System Code');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `payroll_calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `timesheet_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Submission Deadline');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `total_days_count` SET TAGS ('dbx_business_glossary_term' = 'Total Days Count');
ALTER TABLE `vibe_healthcare_v1`.`workforce`.`payroll_calendar` ALTER COLUMN `work_days_count` SET TAGS ('dbx_business_glossary_term' = 'Work Days Count');
