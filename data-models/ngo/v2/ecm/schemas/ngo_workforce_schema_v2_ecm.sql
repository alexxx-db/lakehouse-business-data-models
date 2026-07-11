-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:48:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`workforce` COMMENT 'SSOT for all staff and human resources data including employee records, payroll, benefits, talent acquisition, performance management, learning and development, and talent retention in Workday HCM. Covers national and international staff, expatriate management, field personnel, HRIS data, and RACI role assignments across programs.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`staff_member` (
    `staff_member_id` BIGINT COMMENT 'Unique surrogate identifier for each staff member record in the Ngo workforce system. Primary key for the staff_member data product, serving as the anchor entity for all workforce transactions across HR sub-domains.',
    `supervisor_staff_member_id` BIGINT COMMENT 'Reference to the staff_member_id of this staff members direct line manager. Enables organizational hierarchy traversal, RACI reporting, performance management workflows, and approval chain configuration in Workday HCM.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The gross annual base salary of the staff member in the contract currency, as recorded in Workday HCM. Used for payroll processing, Budget versus Actual (BvA) reporting, and grant cost allocation under OMB Uniform Guidance 2 CFR 200.',
    `contract_end_date` DATE COMMENT 'The scheduled expiry date of the staff members current employment contract. Null for permanent/open-ended contracts. Used for contract renewal alerts, workforce planning, and grant-funded position management.',
    `contract_start_date` DATE COMMENT 'The effective start date of the staff members current employment contract. May differ from hire_date for staff on renewed or amended contracts. Used for contract lifecycle management and compliance tracking.',
    `contract_type` STRING COMMENT 'The legal nature of the employment arrangement. Determines statutory entitlements, benefits eligibility, payroll treatment, and compliance obligations under local labor law. [ENUM-REF-CANDIDATE: permanent|fixed_term|consultancy|secondment|internship|volunteer_staff — promote to reference product]. Valid values are `permanent|fixed_term|consultancy|secondment|internship|volunteer_staff`',
    `cost_center_code` STRING COMMENT 'The financial cost center code from the Chart of Accounts (CoA) to which the staff members salary and benefits are charged. Enables Budget versus Actual (BvA) reporting and grant fund accounting per OMB Uniform Guidance 2 CFR 200 cost allocation requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the staff member record was first created in the Ngo data platform, in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX). Provides audit trail for data governance and compliance purposes.',
    `date_of_birth` DATE COMMENT 'The staff members date of birth in ISO 8601 format (yyyy-MM-dd). Used for age verification, retirement planning, benefits eligibility, and visa/travel documentation.',
    `department` STRING COMMENT 'The organizational department or division to which the staff member is assigned (e.g., Programs, Finance, MEAL, Logistics, HR, Communications). Used for organizational reporting, budget allocation, and RACI assignments.',
    `duty_station` STRING COMMENT 'The official location where the staff member is assigned to work, typically expressed as a city and country (e.g., Nairobi, KEN; Kabul, AFG). Used for hardship allowance calculation, security risk management, and field operations coordination per OCHA duty station classifications.',
    `duty_station_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the staff members duty station country. Used for geographic workforce analytics, country-level headcount reporting, and compliance with host-country labor laws.. Valid values are `^[A-Z]{3}$`',
    `emergency_contact_name` STRING COMMENT 'The full name of the staff members designated next-of-kin or emergency contact person. Used for critical incident notification, medical emergencies, and death-in-service protocols in field operations.',
    `emergency_contact_phone` STRING COMMENT 'The telephone number of the staff members designated emergency contact in E.164 international format. Used for critical incident notification and next-of-kin communication in field operations.. Valid values are `^+?[1-9]d{1,14}$`',
    `emergency_contact_relationship` STRING COMMENT 'The relationship of the emergency contact to the staff member (e.g., spouse, parent, sibling). Used to contextualize next-of-kin notifications and legal next-of-kin determinations in death-in-service cases.. Valid values are `spouse|parent|sibling|child|friend|other`',
    `employee_number` STRING COMMENT 'The human-readable, organization-assigned employee identification number used in payroll, HR correspondence, and access control systems. Distinct from the surrogate staff_member_id.',
    `employment_status` STRING COMMENT 'Current lifecycle state of the staff members employment at Ngo. Drives access control, payroll processing, and workforce headcount reporting. active = currently employed and working; on_leave = approved absence; suspended = temporarily not working pending investigation; separated = employment ended; probation = within initial probationary period.. Valid values are `active|on_leave|suspended|separated|probation`',
    `employment_type` STRING COMMENT 'Classification of the staff member by geographic and operational deployment category. National staff are locally hired; international staff are deployed from another country; expatriates are on international assignment; field personnel are based in program delivery locations. Drives compensation bands, benefits packages, and NICRA cost allocation.. Valid values are `national_staff|international_staff|expatriate|field_personnel|headquarters`',
    `exit_interview_completed` BOOLEAN COMMENT 'Indicates whether the staff member completed an exit interview prior to or at separation. Used to track organizational learning compliance and ensure knowledge transfer processes are followed per CHS Core Humanitarian Standard accountability requirements.',
    `final_settlement_amount` DECIMAL(18,2) COMMENT 'The total monetary amount paid to the staff member as final settlement upon separation, including any outstanding salary, accrued leave payout, severance, and gratuity as applicable under local labor law and contract terms.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'The proportion of full-time hours this staff member is contracted to work, expressed as a percentage (e.g., 100.00 for full-time, 50.00 for half-time). Used for headcount reporting, grant effort allocation, and Indirect Cost Rate (ICR/NICRA) calculations.',
    `gender` STRING COMMENT 'The staff members self-identified gender. Used for workforce diversity reporting, gender-disaggregated MEL indicators, and compliance with donor reporting requirements (e.g., USAID, DFID gender equity mandates).. Valid values are `male|female|non_binary|prefer_not_to_say`',
    `hire_date` DATE COMMENT 'The official date on which the staff member commenced employment with Ngo, as recorded in Workday HCM. Used for service length calculations, benefits vesting schedules, probation period tracking, and anniversary-based entitlements.',
    `job_grade` STRING COMMENT 'The salary band or grade level assigned to the staff members position within Ngos compensation framework (e.g., G1–G7 for national staff, P1–P5 for international staff following UN-equivalent scales). Drives compensation benchmarking and benefits eligibility.',
    `job_title` STRING COMMENT 'The official job title of the staff member as defined in the organizational job catalogue and reflected in their employment contract. Used for organizational charts, donor reporting, and RACI role assignments across programs.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent update to the staff member record in the Ngo data platform, in ISO 8601 format with timezone offset (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture, data freshness monitoring, and audit compliance.',
    `legal_first_name` STRING COMMENT 'The staff members legal given name as it appears on official government-issued identification documents. Used for payroll, visa, and compliance documentation.',
    `legal_last_name` STRING COMMENT 'The staff members legal family/surname as it appears on official government-issued identification documents. Used for payroll, visa, and compliance documentation.',
    `nationality` STRING COMMENT 'The staff members nationality represented as an ISO 3166-1 alpha-3 country code (e.g., USA, GBR, KEN). Used for expatriate management, work permit tracking, and national vs. international staff classification.. Valid values are `^[A-Z]{3}$`',
    `passport_expiry_date` DATE COMMENT 'The expiry date of the staff members passport. Used to trigger renewal alerts and ensure compliance with international travel and visa requirements for field deployments.',
    `passport_number` STRING COMMENT 'The staff members passport number, required for international travel, visa applications, and expatriate deployment documentation. Stored securely in compliance with data protection regulations.',
    `pay_frequency` STRING COMMENT 'The frequency at which the staff member is paid (e.g., monthly, bi-weekly). Drives payroll cycle scheduling in Workday HCM and cash flow planning for field operations.. Valid values are `monthly|bi_weekly|weekly|semi_monthly`',
    `preferred_name` STRING COMMENT 'The name the staff member prefers to be addressed by in day-to-day operations, which may differ from their legal name. Used in internal communications, email display names, and staff directories.',
    `probation_end_date` DATE COMMENT 'The date on which the staff members probationary period is scheduled to end. Used to trigger performance review workflows and confirm or terminate employment within the probation window.',
    `rehire_eligible` BOOLEAN COMMENT 'Indicates whether the staff member is eligible for rehire at Ngo following separation. Set to false for staff separated due to gross misconduct, fraud, or serious policy violations. Used during talent acquisition screening.',
    `salary_currency` STRING COMMENT 'The ISO 4217 three-letter currency code in which the staff members base salary is denominated (e.g., USD, EUR, KES). Required for multi-currency payroll consolidation and grant financial reporting.. Valid values are `^[A-Z]{3}$`',
    `separation_date` DATE COMMENT 'The effective date on which the staff members employment with Ngo ended. Used for final payroll processing, benefits termination, access revocation, and workforce attrition reporting.',
    `separation_reason` STRING COMMENT 'A free-text narrative describing the specific reason for the staff members separation from Ngo. Complements the separation_type categorical field with contextual detail for HR records, exit documentation, and workforce analytics.',
    `separation_type` STRING COMMENT 'The category of employment separation event for staff members whose employment has ended. Drives final settlement calculations, rehire eligibility determination, and statutory reporting. Values: resignation (voluntary), end_of_contract (fixed-term expiry), redundancy (position eliminated), termination (involuntary dismissal), retirement (age/service-based), death_in_service.. Valid values are `resignation|end_of_contract|redundancy|termination|retirement|death_in_service`',
    `work_email` STRING COMMENT 'The official organizational email address assigned to the staff member. Primary digital contact channel for HR communications, system access provisioning, and donor/partner correspondence.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `work_permit_expiry_date` DATE COMMENT 'The expiry date of the staff members work permit or visa authorization. Used to trigger renewal workflows and ensure continuous legal authorization to work in the duty station country.',
    `work_permit_number` STRING COMMENT 'The work permit or visa authorization number for staff members who require legal authorization to work in their duty station country. Null for staff working in their country of nationality.',
    `work_phone` STRING COMMENT 'The staff members official work telephone number in E.164 international format. Used for operational communications, field coordination, and emergency contact protocols.. Valid values are `^+?[1-9]d{1,14}$`',
    `workday_worker_reference` STRING COMMENT 'The unique worker identifier assigned by Workday HCM, used to cross-reference this record with the source system of record for all HR transactions, payroll, and benefits data.',
    CONSTRAINT pk_staff_member PRIMARY KEY(`staff_member_id`)
) COMMENT 'Core master record for all paid staff at Ngo, including national staff, international staff, expatriates, and field personnel. Captures full employee identity (name, date of birth, nationality, gender), employment classification, contract type, duty station, cost center assignment, emergency contact/next-of-kin details, and HRIS identifiers sourced from Workday HCM. Includes separation lifecycle attributes: separation type (resignation, end of contract, redundancy, termination, retirement, death in service), effective date, exit interview completion, final settlement amount, rehire eligibility, and separation reason narrative. Serves as the SSOT for workforce identity across all HR sub-domains, the anchor entity for all workforce transactions, and the single record of employment lifecycle from hire to separation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique system-generated identifier for an authorized organizational position (headcount slot) within Ngos structure. This is the primary key for the position entity in Workday HCM.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project to which this position is assigned. Enables grant-funded headcount tracking per program and supports RACI role assignments across programs.',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Positions represent authorized headcount slots that should be defined by standardized job profiles. Currently position has job_family, job_function, and job_level as standalone attributes, but these s',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department or cost center to which this position belongs. Used in organizational design, Chart of Accounts (CoA) mapping, and headcount reporting.',
    `reports_to_position_id` BIGINT COMMENT 'Reference to the parent position in the organizational hierarchy to which this position reports. Enables organizational chart construction, span-of-control analysis, and RACI role assignment across programs.',
    `staff_member_id` BIGINT COMMENT 'Reference to the current worker (employee or contractor) filling this position. Null when the position is vacant. Links the position slot to the person record in the workforce domain.',
    `availability_date` DATE COMMENT 'Date from which the position is authorized and available for filling, either through recruitment or internal transfer. Marks the effective start of the headcount slot in the organizational plan.',
    `budgeted_annual_cost` DECIMAL(18,2) COMMENT 'Total budgeted annual cost of the position including salary, benefits, and applicable indirect cost rate (ICR/NICRA), in the salary currency. Used in grant budget justifications, Budget versus Actual (BvA) reporting, and workforce cost planning.',
    `position_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the position within the organizations headcount plan and Workday HCM job catalog. Used in grant proposals, budget submissions, and organizational charts.. Valid values are `^POS-[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was first created in the system, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports audit trail and data lineage requirements.',
    `duty_station` STRING COMMENT 'Geographic location where the position is based, typically expressed as city and country (e.g., Nairobi, KEN). Critical for expatriate management, hardship allowance determination, and field operations staffing.',
    `duty_station_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the position is based. Used for expatriate management, tax compliance, and geographic workforce analytics.. Valid values are `^[A-Z]{3}$`',
    `end_date` DATE COMMENT 'Date on which the position authorization expires or is eliminated. Nullable for permanent positions. For grant-funded positions, typically aligned with the grant period of performance end date.',
    `filled_date` DATE COMMENT 'Date on which the position was most recently filled by an incumbent. Used to calculate time-to-fill metrics and vacancy duration reporting.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Authorized Full-Time Equivalent (FTE) percentage allocated to this position, expressed as a decimal (e.g., 1.00 = full-time, 0.50 = half-time). Used in workforce planning, grant budget justifications, and headcount reporting.',
    `funding_source_type` STRING COMMENT 'Classification of the primary funding source for this position. Grant indicates the position is funded by a specific donor award; core indicates unrestricted organizational funding; split indicates funding from multiple sources; in-kind indicates a contributed position; cost-share indicates a position partially funded as match on a grant.. Valid values are `grant|core|split|in-kind|cost-share`',
    `headcount_plan_year` STRING COMMENT 'Fiscal or calendar year for which this position is authorized in the organizational headcount plan. Used in annual workforce planning cycles and grant budget period alignment.',
    `icr_applicable` BOOLEAN COMMENT 'Indicates whether the Negotiated Indirect Cost Rate Agreement (NICRA) / Indirect Cost Rate (ICR) applies to this positions costs when charged to federal grants. Drives Facilities and Administration (F&A) cost calculations in grant financial management.',
    `is_field_position` BOOLEAN COMMENT 'Indicates whether this position is classified as a field operations position (True) versus a headquarters or support office position (False). Drives hardship allowance eligibility, security protocols, and field operations staffing analytics.',
    `is_supervisory` BOOLEAN COMMENT 'Indicates whether this position carries supervisory or managerial responsibility over other positions (True = supervisory). Used in organizational design, RACI role assignments, and span-of-control analytics.',
    `is_vacant` BOOLEAN COMMENT 'Indicates whether the position currently has no active incumbent (True = vacant, False = filled). Drives recruitment requisition creation and vacancy reporting to donors and boards.',
    `job_description_url` STRING COMMENT 'URL or document management system reference to the official job description document for this position. Provides access to the full scope of work, responsibilities, and qualifications for recruitment and performance management purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was most recently updated, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `max_salary` DECIMAL(18,2) COMMENT 'Maximum base salary authorized for this positions pay grade band, in the local or organizational currency. Used in budget ceiling planning and compensation equity analysis.',
    `min_education_level` STRING COMMENT 'Minimum academic qualification required for this position as defined in the job profile. Used in recruitment requisition creation and candidate screening. [ENUM-REF-CANDIDATE: none|secondary|diploma|bachelor|master|doctorate|professional — promote to reference product]',
    `min_salary` DECIMAL(18,2) COMMENT 'Minimum base salary authorized for this positions pay grade band, in the local or organizational currency. Used in budget planning, grant budget justifications, and compensation equity analysis.',
    `min_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for this position as defined in the job profile. Used in recruitment requisition creation and candidate screening.',
    `pay_grade_band` STRING COMMENT 'Compensation grade band assigned to this position as defined in the organizations salary scale (e.g., G5, P3, NB4). Determines the salary range applicable to the position. Classified as confidential business data.. Valid values are `^[A-Z]{1,3}[0-9]{1,3}$`',
    `raci_role` STRING COMMENT 'Primary Responsible Accountable Consulted Informed (RACI) role designation for this position within program delivery processes. Supports organizational design and program accountability frameworks.. Valid values are `responsible|accountable|consulted|informed`',
    `required_competencies` STRING COMMENT 'Comma-separated list of core competencies required for this position as defined in the Workday HCM competency framework (e.g., Results Orientation, Teamwork, Communication, WASH Technical Skills). Used in performance management and talent acquisition.',
    `required_languages` STRING COMMENT 'Comma-separated list of language proficiency requirements for this position (e.g., English (fluent), French (working), Swahili (basic)). Critical for field operations positions in multilingual humanitarian contexts.',
    `salary_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the salary values associated with this position (e.g., USD, KES, EUR). Required for multi-currency workforce cost reporting and grant budget submissions.. Valid values are `^[A-Z]{3}$`',
    `security_clearance_required` BOOLEAN COMMENT 'Indicates whether this position requires a formal security clearance or background check (True = required). Relevant for positions handling restricted donor data, financial systems, or operating in high-risk field environments.',
    `staff_category` STRING COMMENT 'Classification of the position by staff type. National refers to locally-hired staff; international refers to internationally-recruited staff; expatriate refers to staff deployed from another country; consultant refers to contracted technical advisors; intern refers to learning positions. Drives compensation frameworks, benefits eligibility, and visa/work permit requirements.. Valid values are `national|international|expatriate|consultant|intern`',
    `position_status` STRING COMMENT 'Current lifecycle state of the position headcount slot. Open indicates a vacancy available for recruitment; filled indicates an active incumbent; frozen indicates a position on hold due to budget constraints; eliminated indicates the position has been removed from the headcount plan; proposed indicates pending organizational approval.. Valid values are `open|filled|frozen|eliminated|proposed`',
    `title` STRING COMMENT 'Official job title of the position as defined in the organizational structure and Workday HCM job catalog. Used in recruitment requisitions, offer letters, and donor/grant reporting.',
    `position_type` STRING COMMENT 'Classification of the position by employment arrangement. Permanent indicates an indefinite contract; fixed-term indicates a time-bound contract; temporary indicates a short-term assignment; secondment indicates a position filled by staff from a partner organization; volunteer indicates an unpaid position.. Valid values are `permanent|fixed-term|temporary|secondment|volunteer`',
    `vacancy_reason` STRING COMMENT 'Reason why the position is currently vacant. Used in workforce analytics, turnover reporting, and recruitment planning. [ENUM-REF-CANDIDATE: new_position|resignation|termination|transfer|promotion|retirement|contract_end — promote to reference product]',
    `workday_position_reference` STRING COMMENT 'Native position identifier from the Workday HCM source system. Used for data lineage, system reconciliation, and integration with Workday HCM APIs.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized organizational position (headcount slot) within Ngos structure, distinct from the person filling it. Tracks position title, grade level, FTE allocation, funding source (grant or core), duty station, department, and whether the position is filled or vacant. Includes embedded job profile catalog: job family, job level, job function, competency requirements, minimum qualifications, pay grade band, and career progression path aligned with Workday HCM job catalog. Supports workforce planning, grant-funded headcount tracking, recruitment requisition creation, RACI role assignments, and organizational design.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` (
    `employment_contract_id` BIGINT COMMENT 'Unique system-generated identifier for each employment contract record in Workday HCM. Serves as the primary key for the employment_contract data product in the workforce domain.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: NGOs must track which grant funds each employment contract for cost allocation, donor compliance, and personnel cost charging. Critical for grant-funded position management, financial reporting, and d',
    `job_profile_id` BIGINT COMMENT 'Foreign key linking to workforce.job_profile. Business justification: Employment contracts should reference the standardized job profile catalog to ensure consistency in role definitions, competency requirements, and pay grade alignment. The job_family, job_function, an',
    `position_id` BIGINT COMMENT 'Reference to the organizational position associated with this contract, defining the role, job profile, and reporting structure within the NGOs workforce hierarchy.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member (worker) to whom this employment contract applies. Links to the worker/employee master record in Workday HCM.',
    `amendment_effective_date` DATE COMMENT 'The date from which the most recent contract amendment takes effect. Null for original contracts with no amendments. Used in conjunction with amendment_number to track the timeline of contract changes.',
    `amendment_number` STRING COMMENT 'Sequential integer tracking the number of amendments made to the original employment contract. Zero indicates the original contract; each amendment increments this counter. Enables tracking of contract renewals, salary revisions, duty station changes, and other modifications over the contract lifecycle.',
    `amendment_reason` STRING COMMENT 'The business reason for the most recent contract amendment. Used for HR analytics, audit trails, and workforce planning. [ENUM-REF-CANDIDATE: renewal|salary_revision|duty_station_change|promotion|contract_type_change|scope_change|other — promote to reference product]',
    `approval_date` DATE COMMENT 'The date on which the employment contract was formally approved by the authorized signatory. Used in audit trails and compliance reporting.',
    `approved_by` STRING COMMENT 'The name or identifier of the authorized signatory or approving authority who approved this employment contract. Typically the Country Director, HR Director, or delegated authority per the organizations RACI (Responsible Accountable Consulted Informed) framework.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'The gross base salary payable to the staff member per the contract terms, expressed in the contract currency. Excludes allowances, benefits, and other compensation components. Used in payroll processing, BvA (Budget versus Actual) reporting, and grant cost allocation.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this employment contract record was first created in the system. Corresponds to the MASTER_AGREEMENT RECORD_AUDIT_CREATED category. Used for data lineage, audit trails, and compliance reporting.',
    `duty_station` STRING COMMENT 'The official location (city and country) where the staff member is assigned to perform their duties under this contract. Determines applicable hardship classification, housing allowance, cost-of-living adjustments, and applicable labor law jurisdiction. Standard OCHA/UN terminology for field deployment location.',
    `duty_station_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country of the duty station (e.g., ETH for Ethiopia, SSD for South Sudan, COD for Democratic Republic of Congo). Used for geographic reporting, compliance, and multi-country workforce analytics.. Valid values are `^[A-Z]{3}$`',
    `education_allowance_amount` DECIMAL(18,2) COMMENT 'The annual monetary amount of education allowance provided for dependent children of expatriate staff members. Covers school fees and related educational expenses at the duty station or in the home country. Expressed in the contract currency. Null for non-expatriate staff or staff without eligible dependents.',
    `end_date` DATE COMMENT 'The date on which the employment contract expires or is scheduled to terminate. Null for open-ended contracts. Corresponds to the MASTER_AGREEMENT EFFECTIVE_UNTIL category. Used for contract renewal tracking and workforce planning.',
    `funding_source_code` STRING COMMENT 'The grant, project, or cost center code against which the staff members salary and benefits are charged. Enables grant cost allocation, BvA (Budget versus Actual) reporting, and compliance with donor restrictions. Aligns with the Chart of Accounts (CoA) in SAP S/4HANA and Unit4 ERP.',
    `hardship_allowance_amount` DECIMAL(18,2) COMMENT 'The monthly monetary amount of hardship allowance payable to the expatriate staff member based on their hardship tier and salary grade. Expressed in the contract currency. Null for non-expatriate staff or H-classified duty stations.',
    `hardship_tier` STRING COMMENT 'The UN/ICSC hardship classification tier assigned to the duty station, determining the hardship allowance percentage applicable to the staff members salary. H = headquarters (no hardship); A through E represent increasing levels of hardship, with E being the most difficult duty stations (e.g., active conflict zones). Null for non-expatriate staff.. Valid values are `H|A|B|C|D|E`',
    `home_leave_frequency_months` STRING COMMENT 'The number of months between home leave entitlements for expatriate staff, defining how frequently the staff member is entitled to travel to their home country at organizational expense. Typically 12 or 24 months depending on duty station hardship classification. Null for non-expatriate staff.',
    `housing_allowance_amount` DECIMAL(18,2) COMMENT 'The monthly monetary amount of housing allowance provided to the expatriate staff member at the duty station. Reflects local rental market rates and organizational housing policy. Expressed in the contract currency. Null for non-expatriate staff or staff in NGO-provided accommodation.',
    `icr_rate` DECIMAL(18,2) COMMENT 'The Indirect Cost Rate (ICR) or Facilities and Administration (F&A) rate applicable to this staff members contract for grant cost recovery purposes. Expressed as a decimal (e.g., 0.1500 = 15%). Derived from the organizations NICRA (Negotiated Indirect Cost Rate Agreement) with the US government or equivalent donor agreement.',
    `ingo_salary_scale` STRING COMMENT 'The salary scale framework applied to this contract, particularly relevant for internationally-recruited staff. UN common system applies UN salary tables; organizational_scale uses the NGOs internal scale; national_scale applies host-country national staff scales. Determines applicable grade tables and allowance structures.. Valid values are `un_common_system|organizational_scale|national_scale|icsc_scale|other`',
    `is_expatriate` BOOLEAN COMMENT 'Indicates whether the staff member under this contract is classified as an expatriate (internationally-recruited staff deployed outside their home country). Triggers eligibility for expatriate compensation package components including hardship allowance, housing allowance, education allowance, home leave, and R&R.',
    `labor_law_jurisdiction` STRING COMMENT 'The legal jurisdiction whose labor laws and employment regulations govern this contract (e.g., Kenya, Ethiopia, United Kingdom, United States). Determines statutory entitlements, termination procedures, and compliance obligations. Critical for multi-country NGO operations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this employment contract record was most recently updated in the system. Used for change data capture (CDC) in the Databricks Silver Layer pipeline and audit compliance.',
    `medevac_coverage_level` STRING COMMENT 'The tier of medical evacuation coverage provided under this contract, determining the scope of emergency medical transport and treatment entitlements. Full coverage includes international evacuation to a tertiary care facility; basic covers regional evacuation only. Critical for field staff safety and duty of care compliance.. Valid values are `basic|standard|enhanced|full`',
    `notes` STRING COMMENT 'Free-text field for HR staff to record additional context, special conditions, or exceptions applicable to this employment contract that are not captured in structured fields (e.g., special security arrangements, unique compensation agreements, donor-specific staffing conditions).',
    `notice_period_days` STRING COMMENT 'The number of calendar days of advance notice required by either party to terminate the employment contract. Varies by contract type, seniority, and applicable labor law jurisdiction. Used in workforce planning and HR compliance.',
    `number` STRING COMMENT 'Externally-known unique alphanumeric reference number assigned to the employment contract, used in HR correspondence, legal documentation, and audit trails. Typically formatted as ORG-YEAR-SEQUENCE (e.g., NGO-2024-EMP0042).. Valid values are `^[A-Z]{2,4}-[0-9]{4}-[A-Z0-9]{4,10}$`',
    `probation_end_date` DATE COMMENT 'The date on which the staff members probationary period concludes. During probation, different notice periods and performance review requirements typically apply. Null if no probation period is applicable (e.g., for short-term consultancies).',
    `relocation_allowance_amount` DECIMAL(18,2) COMMENT 'The one-time monetary amount provided to cover relocation costs when the staff member moves to the duty station at the start of the contract. Expressed in the contract currency. Null for locally-recruited national staff or contract renewals without relocation.',
    `rnr_cycle_weeks` STRING COMMENT 'The number of weeks between Rest and Recuperation (R&R) breaks for staff deployed to high-hardship or non-family duty stations. R&R is a mandatory welfare entitlement for staff in difficult operating environments (e.g., every 6, 8, or 12 weeks). Null for staff at H or A hardship-classified duty stations.',
    `salary_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which the base salary and allowances are denominated (e.g., USD, EUR, GBP, KES, ETB). Supports multi-currency compensation management across 50+ country operations.. Valid values are `^[A-Z]{3}$`',
    `salary_frequency` STRING COMMENT 'The frequency at which the base salary is paid to the staff member. Determines payroll cycle alignment and annualization calculations for budget planning and grant reporting.. Valid values are `monthly|bi_weekly|weekly|annual`',
    `salary_grade` STRING COMMENT 'The compensation band or grade level assigned to the position under this contract, as defined in the NGOs salary scale (e.g., UN common system grade G5, P3, or organizational scale Band C). Determines the salary range and step progression applicable to the staff member.',
    `salary_step` STRING COMMENT 'The incremental step within the salary grade assigned to the staff member, reflecting years of experience or merit progression within the grade band (e.g., Step 1, Step 2, Step III). Used in conjunction with salary_grade to determine exact base pay.',
    `staff_category` STRING COMMENT 'Classification of the staff members recruitment category under this contract. International staff are recruited internationally and typically receive expatriate packages; national staff are locally recruited; third-country nationals are neither from the HQ country nor the duty station country. Determines applicable compensation package and entitlements.. Valid values are `international|national|third_country_national|consultant|secondee`',
    `start_date` DATE COMMENT 'The date on which the employment contract becomes effective and the staff members obligations and entitlements commence. Corresponds to the MASTER_AGREEMENT EFFECTIVE_FROM category.',
    `employment_contract_status` STRING COMMENT 'Current lifecycle state of the employment contract. Draft indicates pending approval; active indicates a currently binding agreement; on_hold covers suspension; terminated covers early cessation; expired covers contracts that reached their end date without renewal; amended covers contracts under revision.. Valid values are `draft|active|on_hold|terminated|expired|amended`',
    `termination_date` DATE COMMENT 'The actual date on which the employment contract was terminated, if applicable. Distinct from end_date (scheduled expiry); this captures early terminations, resignations, and dismissals. Null for active contracts.',
    `termination_reason` STRING COMMENT 'The reason for contract termination, used in workforce analytics, exit reporting, and compliance with labor law notification requirements. [ENUM-REF-CANDIDATE: resignation|end_of_contract|redundancy|dismissal|mutual_agreement|death|other — promote to reference product]',
    `employment_contract_type` STRING COMMENT 'Classification of the employment arrangement defining the legal nature of the engagement. Fixed-term contracts have defined end dates; open-ended are indefinite; consultancy covers independent contractors; secondment covers staff loaned from/to partner organizations. [ENUM-REF-CANDIDATE: fixed_term|open_ended|consultancy|secondment|internship|volunteer — promote to reference product]. Valid values are `fixed_term|open_ended|consultancy|secondment|internship|volunteer`',
    `workday_contract_reference` STRING COMMENT 'The native contract or worker agreement identifier from Workday HCM, the system of record for this data product. Used for data lineage, source system reconciliation, and integration with Workday payroll and benefits modules.',
    CONSTRAINT pk_employment_contract PRIMARY KEY(`employment_contract_id`)
) COMMENT 'Formal employment agreement record for each staff member, capturing contract type (fixed-term, open-ended, consultancy, secondment), start and end dates, probation period, notice period, salary grade, base salary, currency, duty station, and applicable labor law jurisdiction. Tracks contract renewals and amendments over time. For internationally-recruited staff, includes full expatriate compensation package: hardship allowance tier and amount, housing allowance, education allowance for dependents, home leave entitlement and frequency, relocation allowance, medical evacuation coverage level, R&R cycle, and applicable INGO salary scale (e.g., UN common system, organizational scale). Supports multi-currency compensation across 50+ country operations. Sourced from Workday HCM.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique surrogate identifier for each organizational unit record in the Ngo hierarchy. Primary key for the org_unit data product in Workday HCM.',
    `parent_org_unit_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediate parent organizational unit, enabling recursive parent-child hierarchy traversal for headcount, payroll, and program staffing rollups. Null for the root/top-level unit.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member designated as the responsible manager or head of this organizational unit, used for accountability and RACI role assignments across programs.',
    `annual_budget_usd` DECIMAL(18,2) COMMENT 'Total approved annual operating budget allocated to this organizational unit in US Dollars, covering both core and grant-funded expenditures. Used for BvA reporting, fund accounting, and financial stewardship in SAP S/4HANA and Unit4 ERP.',
    `city_name` STRING COMMENT 'Name of the city or locality where the organizational units primary office is situated. Used for operational logistics, staff deployment planning, and field operations coordination.',
    `org_unit_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the organizational unit across systems (Workday HCM, SAP S/4HANA Chart of Accounts, Unit4 ERP). Used as the business identifier in cross-system integrations and financial reporting.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `cost_center_code` STRING COMMENT 'Financial cost center code assigned to this organizational unit in the Chart of Accounts (CoA) within SAP S/4HANA and Unit4 ERP. Used for fund accounting, payroll cost allocation, Budget versus Actual (BvA) reporting, and grant financial management.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code indicating the country where this organizational unit is physically located or registered (e.g., KEN for Kenya, SDN for Sudan, USA for United States). Used for geographic reporting and IATI disclosure.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp indicating when this organizational unit record was first created in the source system (Workday HCM) and ingested into the Databricks Lakehouse Silver Layer. Supports audit trail and data lineage requirements.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the primary operating currency of this organizational unit (e.g., USD, EUR, KES). Used for multi-currency financial reporting and fund accounting.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date on which this organizational unit ceased to be operationally effective (dissolution, merger, or restructuring). Null for currently active units. Used for historical headcount and grant financial reporting.',
    `effective_start_date` DATE COMMENT 'Date on which this organizational unit became operationally effective and began appearing in headcount, payroll, and program staffing reports. Supports point-in-time historical analysis.',
    `funding_model` STRING COMMENT 'Indicates how the organizational unit is financially sustained. core = funded from unrestricted/core organizational budget; grant_funded = funded entirely by restricted donor grants; mixed = combination of core and grant funding; self_funded = generates own revenue. Critical for fund accounting and BvA reporting.. Valid values are `core|grant_funded|mixed|self_funded`',
    `gl_account_code` STRING COMMENT 'General Ledger (GL) account code associated with this organizational unit for financial stewardship and fund accounting in SAP S/4HANA. Enables direct linkage between org unit payroll costs and the GL for financial reporting and audit.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `headcount_actual` STRING COMMENT 'Current number of active staff members assigned to this organizational unit as recorded in Workday HCM. Used for real-time workforce reporting, MEL dashboards, and BvA staffing analysis.',
    `headcount_authorized` STRING COMMENT 'Maximum number of staff positions (both national and international) authorized for this organizational unit as per the approved organizational structure and donor-approved staffing plans. Used for workforce planning and grant compliance.',
    `hierarchy_level` STRING COMMENT 'Numeric depth of this organizational unit within the global hierarchy tree (e.g., 1 = Global HQ, 2 = Regional Office, 3 = Country Office, 4 = Area/Field Office, 5 = Program Unit). Enables efficient hierarchical queries and rollup reporting.',
    `hierarchy_path` STRING COMMENT 'Materialized path string representing the full ancestry chain of the organizational unit from root to current node (e.g., /1/5/12/34/). Enables fast subtree queries for headcount and payroll rollups without recursive joins.',
    `iati_org_identifier` STRING COMMENT 'Unique International Aid Transparency Initiative (IATI) organization identifier assigned to this unit for transparent aid reporting and donor disclosure. Required for IATI-compliant activity reporting by USAID, DFID, and other ODA donors.',
    `icr_rate` DECIMAL(18,2) COMMENT 'Negotiated Indirect Cost Rate (NICRA) applicable to this organizational unit, expressed as a decimal (e.g., 0.1500 = 15%). Used for Facilities and Administration (F&A) cost recovery calculations on federal grants and donor-funded projects per OMB Uniform Guidance.',
    `international_staff_count` STRING COMMENT 'Number of international (expatriate) staff currently assigned to this organizational unit. Used for expatriate management reporting, visa/work permit tracking, and INGO staffing ratio compliance.',
    `is_field_office` BOOLEAN COMMENT 'Indicates whether this organizational unit is classified as a field office operating in a humanitarian or development program context (True) versus a non-field administrative or HQ unit (False). Used to apply field-specific HR policies, allowances, and security protocols.',
    `is_hq` BOOLEAN COMMENT 'Indicates whether this organizational unit is the global or regional headquarters (True). Used to distinguish HQ administrative units from field and country offices in hierarchical reporting and governance structures.',
    `mandate_description` STRING COMMENT 'Narrative description of the organizational units mandate, scope of work (SoW), and primary responsibilities within the Ngos Theory of Change (ToC). Used for onboarding, stakeholder engagement, and compliance reporting.',
    `mission_statement` STRING COMMENT 'Formal mission statement specific to this organizational unit, articulating its contribution to the Ngos overall mission and SDG alignment. Used in annual reports, donor communications, and regulatory filings.',
    `org_unit_name` STRING COMMENT 'Full human-readable name of the organizational unit (e.g., East Africa Regional Office, WASH Program Unit – South Sudan, Finance and Administration Department – HQ). Used in all reporting, dashboards, and donor communications.',
    `national_staff_count` STRING COMMENT 'Number of national (locally-hired) staff currently assigned to this organizational unit. Supports localization reporting, donor compliance requirements, and INGO staffing ratio analysis.',
    `office_address` STRING COMMENT 'Physical street address of the organizational units primary office location. Classified as confidential organizational contact data used for operational correspondence, audit, and regulatory filings.',
    `office_email` STRING COMMENT 'Primary email address for the organizational unit used for official correspondence, donor communications, and regulatory filings. Classified as confidential organizational contact data.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `office_phone` STRING COMMENT 'Primary telephone number for the organizational units office. Classified as confidential organizational contact data used for inter-office communications, emergency coordination, and stakeholder engagement.. Valid values are `^+?[0-9s-().]{7,20}$`',
    `program_code` STRING COMMENT 'Code identifying the primary humanitarian or development program this organizational unit is aligned to (e.g., WASH, GBV, PSS, Nutrition). Enables program-level staffing and cost reporting in MEL dashboards and donor reports. Applicable primarily to program_unit type org units.',
    `region_name` STRING COMMENT 'Name of the geographic region or sub-national administrative area where this unit operates (e.g., East Africa, West Africa, Middle East and North Africa, South Asia). Supports regional rollup reporting for MEL dashboards and donor reports.',
    `registration_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the jurisdiction in which this organizational unit is legally registered. May differ from the operational country for country offices registered under host-country law.. Valid values are `^[A-Z]{3}$`',
    `registration_number` STRING COMMENT 'Official legal registration or charity registration number issued by the relevant national regulatory authority (e.g., Charity Commission UK, IRS EIN, national NGO registration body). Required for regulatory compliance filings and donor due diligence.',
    `sap_company_code` STRING COMMENT 'SAP S/4HANA company code associated with this organizational unit for General Ledger (GL), Accounts Payable (AP), Accounts Receivable (AR), and fund accounting integration. Enables cross-system financial reconciliation.. Valid values are `^[A-Z0-9]{1,6}$`',
    `security_level` STRING COMMENT 'UN/UNDSS security phase classification applicable to the location of this organizational unit (Phase 1 = Minimal, Phase 5 = Emergency). Drives staff deployment decisions, field operations protocols, and duty-of-care obligations for expatriate and national staff.. Valid values are `phase1|phase2|phase3|phase4|phase5`',
    `short_name` STRING COMMENT 'Abbreviated or shortened display name for the organizational unit used in dashboards, SitRep headers, and space-constrained reporting contexts (e.g., EA Regional, WASH-SSD).',
    `org_unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. active = operational; inactive = temporarily suspended; pending = awaiting activation; dissolved = permanently closed; merged = absorbed into another unit.. Valid values are `active|inactive|pending|dissolved|merged`',
    `org_unit_type` STRING COMMENT 'Classification of the organizational unit within the global Ngo structure. Drives hierarchical reporting logic and determines applicable governance rules. [ENUM-REF-CANDIDATE: hq_department|regional_office|country_office|area_office|field_office|program_unit|cost_center — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this organizational unit record in the source system (Workday HCM). Used for change data capture (CDC), incremental loads, and audit compliance in the Databricks Lakehouse Silver Layer.',
    `volunteer_count` STRING COMMENT 'Number of active volunteers currently assigned to or managed by this organizational unit, as tracked in Microsoft Dynamics 365 Volunteer Coordination. Used for workforce capacity reporting and donor impact metrics.',
    `workday_org_reference` STRING COMMENT 'Native organization identifier assigned by Workday HCM to this organizational unit. Used as the source system key for data integration, reconciliation, and lineage tracking between Workday HCM and the Databricks Lakehouse Silver Layer.',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit hierarchy for Ngo, representing departments, divisions, country offices, area/field offices, program units, and cost centers in a recursive parent-child structure. Captures unit name, unit type (HQ department, regional office, country office, field office, program unit), parent unit reference, geographic location, responsible manager, funding model (core vs grant), and active status. Enables hierarchical reporting of headcount, payroll costs, and program staffing across the global organization.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`job_profile` (
    `job_profile_id` BIGINT COMMENT 'Unique surrogate identifier for the job profile record in the Ngo HRIS. Primary key for the job_profile data product in the Workday HCM job catalog.',
    `approval_date` DATE COMMENT 'Date on which this job profile was formally approved by the designated HR authority. Required for governance documentation and audit compliance in donor-funded programs.',
    `approved_by` STRING COMMENT 'Name or identifier of the HR authority (e.g., HR Director, Country Director) who approved this job profile for use in Workday HCM. Supports governance, audit trail, and compliance with organizational HR policies.',
    `background_check_level` STRING COMMENT 'Required level of pre-employment background screening for this job profile. child_protection and enhanced checks are mandatory for safeguarding-designated roles and roles with access to vulnerable beneficiaries, per CHS and donor requirements.. Valid values are `standard|enhanced|criminal_record|child_protection|not_required`',
    `job_profile_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the job profile within the Workday HCM job catalog and HRIS classification system. Used in position creation, recruitment requisitions, and cross-system integration (e.g., Unit4 ERP, payroll).. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `competency_framework_code` STRING COMMENT 'Reference code identifying the competency framework applied to this job profile (e.g., CHS competency framework, Ngo internal framework, IASC humanitarian competencies). Links to the competency library in Workday HCM for performance management and talent development.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `core_competencies` STRING COMMENT 'Comma-separated list of core behavioral and technical competencies required for this job profile as defined in the Workday HCM competency library (e.g., Accountability, Communication, Collaboration, Results Orientation, MEAL Proficiency). Used in performance reviews and talent assessments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was first created in the Workday HCM system. Supports audit trail, data lineage, and compliance reporting requirements under OMB Uniform Guidance and FASB ASC 958.',
    `duty_station_type` STRING COMMENT 'Classification of the expected duty station for this job profile. roving indicates the role covers multiple field locations. Drives hardship allowance eligibility, security protocols, and benefits packages for field personnel.. Valid values are `headquarters|country_office|field_office|remote|roving`',
    `effective_date` DATE COMMENT 'Date from which this job profile version became active and available for use in position creation and recruitment in Workday HCM. Supports versioning and historical tracking of job profile changes.',
    `employment_type` STRING COMMENT 'Standard employment type associated with this job profile, indicating the expected contractual arrangement (e.g., full-time permanent, part-time, fixed-term contract, casual, secondment). Drives benefits eligibility and contract template selection in Workday HCM.. Valid values are `full_time|part_time|fixed_term|casual|secondment`',
    `end_date` DATE COMMENT 'Date on which this job profile version was retired or superseded. Null for currently active profiles. Supports effective-dated versioning in Workday HCM and historical workforce analytics.',
    `field_experience_required` BOOLEAN COMMENT 'Indicates whether prior humanitarian field experience (e.g., deployment in conflict zones, disaster response, IDP (Internally Displaced Person) settings) is a mandatory requirement for this job profile. Critical for operational roles in Ngos field programs.',
    `flsa_exemption_status` STRING COMMENT 'Indicates whether the job profile is classified as exempt or non-exempt under the US Fair Labor Standards Act (FLSA) for overtime eligibility purposes. not_applicable for roles outside US jurisdiction. Required for US-based payroll compliance.. Valid values are `exempt|non_exempt|not_applicable`',
    `icr_cost_category` STRING COMMENT 'Classification of the job profiles cost as direct, indirect, or shared for purposes of grant budget allocation and NICRA (Negotiated Indirect Cost Rate Agreement) compliance. Determines how staff costs are charged to grants and reported to donors such as USAID and BHA.. Valid values are `direct|indirect|shared`',
    `is_critical_role` BOOLEAN COMMENT 'Indicates whether this job profile is designated as a critical or key position within Ngos organizational structure. Critical roles are prioritized in succession planning, talent retention programs, and emergency staffing protocols.',
    `is_safeguarding_designated` BOOLEAN COMMENT 'Indicates whether this job profile is designated as a safeguarding role requiring enhanced background checks, child protection clearances, and mandatory safeguarding training. Mandatory for roles working directly with beneficiaries, children, or vulnerable populations.',
    `job_category` STRING COMMENT 'Classification of the job profile by employment category as used in Ngo HR and payroll systems. Distinguishes national staff, international staff (INGO), expatriates, consultants, volunteers, and interns. Drives benefits eligibility, tax treatment, and regulatory compliance reporting.. Valid values are `national_staff|international_staff|expatriate|consultant|volunteer|intern`',
    `job_family_group_name` STRING COMMENT 'The broader job family group that clusters related job families in the Workday HCM hierarchy (e.g., Operations, Finance, Technical Specialists, Leadership). Enables enterprise-level workforce analytics and organizational design.',
    `job_family_name` STRING COMMENT 'The job family grouping to which this profile belongs within the Workday HCM job architecture (e.g., Program Management, Finance and Accounting, Monitoring Evaluation and Learning (MEL), Logistics and Supply Chain, Human Resources). Supports workforce planning and compensation benchmarking.',
    `job_level` STRING COMMENT 'Standardized job level designation indicating seniority and scope of responsibility within the Ngo grading structure (e.g., Entry, Junior, Mid, Senior, Lead, Manager, Director, Executive). Drives pay grade assignment and career pathing. [ENUM-REF-CANDIDATE: entry|junior|mid|senior|lead|manager|director|executive — promote to reference product]',
    `key_responsibilities` STRING COMMENT 'Structured narrative of the primary duties and accountabilities for this job profile. Serves as the basis for position descriptions, performance agreements, and RACI (Responsible Accountable Consulted Informed) role mapping across programs.',
    `language_requirements` STRING COMMENT 'Comma-separated list of language proficiency requirements for this job profile (e.g., English:Fluent, French:Working, Arabic:Basic). Particularly relevant for international and field-based roles in Ngos multi-country operations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this job profile record was most recently updated in the Workday HCM system. Used to detect changes, trigger downstream data pipeline refreshes, and support audit compliance.',
    `leadership_competencies` STRING COMMENT 'Comma-separated list of leadership-specific competencies required for managerial and senior roles in this job profile (e.g., Strategic Thinking, People Development, Change Management, Stakeholder Engagement). Populated only for management-level profiles.',
    `management_level` STRING COMMENT 'Indicates whether the job profile is for an individual contributor or a people manager role, and at what management tier. Used in organizational design, RACI (Responsible Accountable Consulted Informed) role assignments, and leadership development programs.. Valid values are `individual_contributor|team_lead|manager|senior_manager|director|executive`',
    `min_education_level` STRING COMMENT 'Minimum academic qualification required for this job profile (e.g., Bachelors degree, Masters degree). Used as a screening criterion in recruitment and talent acquisition workflows in Workday HCM and Microsoft Dynamics 365. [ENUM-REF-CANDIDATE: none|secondary|diploma|bachelor|master|doctorate|professional_certification — 7 candidates stripped; promote to reference product]',
    `min_years_experience` STRING COMMENT 'Minimum number of years of relevant professional experience required for this job profile. Used as a screening criterion in recruitment and for determining eligibility for internal mobility and promotions.',
    `job_profile_name` STRING COMMENT 'Human-readable title of the job profile as defined in the Workday HCM job catalog (e.g., Field Program Officer, MEAL Coordinator, Finance Manager). Used in recruitment postings, organizational charts, and staff communications.',
    `pay_grade` STRING COMMENT 'The compensation pay grade band assigned to this job profile (e.g., G5, P3, M2). Defines the salary range applicable to positions created from this profile. Confidential as it reveals internal compensation structure. Aligned with Ngos compensation framework and NICRA (Negotiated Indirect Cost Rate Agreement) requirements.. Valid values are `^[A-Z]{1,3}[0-9]{1,3}$`',
    `pay_grade_max_usd` DECIMAL(18,2) COMMENT 'Maximum base salary in US Dollars for the pay grade band associated with this job profile. Used in compensation benchmarking, offer approvals, and grant budget ceiling calculations. Confidential as it reveals internal compensation structure.',
    `pay_grade_midpoint_usd` DECIMAL(18,2) COMMENT 'Midpoint salary in US Dollars for the pay grade band, representing the market reference point for fully competent performance in this job profile. Used in compensation equity analysis and salary benchmarking against sector surveys (e.g., Birches Group, Hay Group).',
    `pay_grade_min_usd` DECIMAL(18,2) COMMENT 'Minimum base salary in US Dollars for the pay grade band associated with this job profile. Used in budget planning, compensation benchmarking, and grant budget preparation. Confidential as it reveals internal compensation structure.',
    `preferred_certifications` STRING COMMENT 'Comma-separated list of desirable but non-mandatory professional certifications for this job profile. Used to differentiate candidates during recruitment and to guide learning and development (L&D) planning in Workday HCM LMS.',
    `program_area` STRING COMMENT 'Primary humanitarian or development program area associated with this job profile (e.g., WASH (Water Sanitation and Hygiene), GBV (Gender-Based Violence), Health, Education, Livelihoods, Nutrition, PSS (Psychosocial Support)). Used for workforce planning and program staffing analytics.',
    `required_certifications` STRING COMMENT 'Comma-separated list of mandatory professional certifications or licenses required for this job profile (e.g., CPA, PMP, CIPS, HEAT Training, SPHERE Certification). Used in recruitment screening and compliance tracking in Workday HCM.',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of UN Sustainable Development Goal (SDG) numbers that this job profile primarily contributes to (e.g., 3,4,6 for Health, Education, WASH roles). Used in donor reporting and IATI (International Aid Transparency Initiative) disclosures.',
    `job_profile_status` STRING COMMENT 'Current lifecycle status of the job profile within the Workday HCM job catalog. active profiles are available for position creation and recruitment; inactive or archived profiles are retired from use.. Valid values are `active|inactive|draft|under_review|archived`',
    `succession_eligibility` BOOLEAN COMMENT 'Indicates whether this job profile is included in Ngos formal succession planning program in Workday HCM. Profiles marked as succession-eligible are tracked for talent pipeline development and leadership continuity.',
    `summary` STRING COMMENT 'Concise narrative summary of the job profiles purpose, primary accountabilities, and organizational context. Used as the opening paragraph in job postings and position descriptions. Aligned with Workday HCM job profile description field.',
    `travel_requirement` STRING COMMENT 'Expected level of travel associated with this job profile. field_based indicates deployment to humanitarian field operations (e.g., IDP camps, disaster response zones). Used in recruitment communications and duty of care planning.. Valid values are `none|occasional|frequent|extensive|field_based`',
    `version_number` STRING COMMENT 'Sequential version number of the job profile, incremented each time the profile is substantively revised (e.g., competency updates, pay grade changes, qualification changes). Supports audit trail and change management in Workday HCM.',
    `workday_job_profile_reference` STRING COMMENT 'The native identifier of this job profile record in the Workday HCM source system. Used for system-of-record traceability, data lineage, and integration with Workday payroll, talent, and learning modules.. Valid values are `^[A-Za-z0-9_-]{1,50}$`',
    CONSTRAINT pk_job_profile PRIMARY KEY(`job_profile_id`)
) COMMENT 'Standardized job profile catalog defining roles within Ngo, including job family, job level, competency requirements, minimum qualifications, and pay grade band. Used as the template for position creation and recruitment. Aligned with Workday HCM job catalog and HRIS classification standards.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique system-generated identifier for each payroll run record in Workday HCM. Serves as the primary key for the payroll_run entity.',
    `cost_center_id` BIGINT COMMENT 'add column cost_center_id (BIGINT) with FK to finance.cost_center.cost_center_id - payroll costs must be allocated to cost centers',
    `fiscal_period_id` BIGINT COMMENT 'add column fiscal_period_id (BIGINT) with FK to finance.fiscal_period.fiscal_period_id - payroll runs occur within specific fiscal periods for accounting purposes',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Tracks which payroll system processed each run. Essential for financial audit trails, donor compliance reporting, system reconciliation, and regulatory requirements. NGOs must demonstrate which certif',
    `approval_status` STRING COMMENT 'The authorization status of the payroll run within the organizations approval workflow. Tracks whether the run has been reviewed and approved by the designated approver (e.g., Finance Director, Country Director) before disbursement. Distinct from run_status which tracks the processing lifecycle.. Valid values are `pending|approved|rejected|on_hold`',
    `approved_by` STRING COMMENT 'The name or employee identifier of the individual who authorized this payroll run. Captured for audit trail and segregation of duties compliance. Required for internal controls and external audit purposes.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time at which the payroll run received final authorization. Provides an immutable audit record of when approval was granted, supporting segregation of duties controls and compliance with OMB Uniform Guidance internal control requirements.',
    `bank_account_reference` STRING COMMENT 'The organizational bank account identifier or reference number from which net pay is disbursed for this payroll run. Not an individual employee account — this is the organizations payroll disbursement account reference used for treasury reconciliation.',
    `calculation_timestamp` TIMESTAMP COMMENT 'The date and time when the payroll calculation was executed in Workday HCM. Marks the business event of gross-to-net computation. Distinct from approved_timestamp and created_timestamp, this captures when the financial figures were computed.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the country of operation for which this payroll run was executed (e.g., KEN, UGA, SSD). Determines applicable labor law, tax regime, and statutory deduction rules. Essential for multi-country NGO payroll operations.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll run record was first created in the system. Serves as the audit creation timestamp for data lineage, compliance, and Silver layer ingestion tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which this payroll run is denominated (e.g., USD, EUR, KES, NGN). Critical for multi-currency NGO operations where national staff may be paid in local currency while international staff are paid in USD or EUR.. Valid values are `^[A-Z]{3}$`',
    `employee_count` STRING COMMENT 'The total number of employees included in this payroll run. Used for headcount reporting, per-capita cost analysis, and validation that all eligible staff were processed. Reconciled against HRIS (Human Resource Information System) active headcount.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'The foreign exchange rate applied to convert the payroll run amounts from the local currency to the organizations functional reporting currency (typically USD). Sourced from the organizations treasury or ERP at the time of payroll processing. Required for consolidated financial reporting and BvA (Budget versus Actual) analysis.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month number within the fiscal year, e.g., 1–12) to which this payroll run is posted in the General Ledger. Supports period-close processes, BvA (Budget versus Actual) reporting, and grant financial management.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which this payroll run falls, as defined by the organizations financial calendar. Used for annual financial reporting, grant budget period tracking, and FASB ASC 958 compliance reporting.',
    `functional_currency_code` STRING COMMENT 'ISO 4217 three-letter code for the organizations functional reporting currency (e.g., USD). Used alongside exchange_rate to express payroll costs in a consistent currency for consolidated financial statements and donor reporting.. Valid values are `^[A-Z]{3}$`',
    `fund_code` STRING COMMENT 'The fund code identifying the restricted or unrestricted fund from which payroll costs are drawn. Supports fund accounting requirements under FASB ASC 958, ensuring donor-restricted funds are used only for their designated purposes.',
    `gl_account_code` STRING COMMENT 'The GL (General Ledger) account code in the CoA (Chart of Accounts) to which the payroll expense is posted. Ensures payroll costs are correctly classified in the financial statements per FASB ASC 958 not-for-profit accounting standards.',
    `grant_code` STRING COMMENT 'The grant identifier to which a portion or all of this payroll runs costs are charged. Enables grant-level labor cost tracking and compliance with donor reporting requirements. May be null for unrestricted payroll runs not tied to a specific grant.',
    `icr_rate` DECIMAL(18,2) COMMENT 'The Indirect Cost Rate (ICR) or F&A (Facilities and Administration) rate applied to direct labor costs in this payroll run, as defined in the organizations NICRA (Negotiated Indirect Cost Rate Agreement). Used to calculate indirect cost recovery charges against grants.',
    `is_retroactive` BOOLEAN COMMENT 'Indicates whether this payroll run includes retroactive pay adjustments for prior pay periods (e.g., backdated salary increases, correction of underpayments). Retroactive runs require special grant cost allocation treatment under OMB Uniform Guidance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll run record was most recently modified. Tracks corrections, status changes, and amendments to the payroll run. Essential for data lineage and change management in the Databricks Silver layer.',
    `legal_entity_code` STRING COMMENT 'The code identifying the legal entity (registered country office or subsidiary) under which this payroll run is processed. Aligns with the organizational structure in SAP S/4HANA and Workday HCM for fund accounting and statutory reporting purposes.',
    `notes` STRING COMMENT 'Free-text field for payroll officers to document special circumstances, exceptions, or explanatory remarks about this payroll run (e.g., reason for off-cycle run, description of corrections made, emergency payment context). Supports audit trail and knowledge transfer.',
    `number` STRING COMMENT 'Externally-known business identifier for the payroll run, typically formatted as PR-YYYY-MM-NNNN (e.g., PR-2024-03-0012). Used in audit trails, finance reconciliation, and donor/grant reporting to reference a specific payroll cycle.. Valid values are `^PR-[0-9]{4}-[0-9]{2}-[0-9]{4}$`',
    `pay_frequency` STRING COMMENT 'The cadence at which employees in this payroll group are paid. Determines the number of pay periods per year and affects annualized salary calculations, benefit proration, and grant budget reporting.. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `pay_period_end_date` DATE COMMENT 'The last calendar date of the pay period covered by this payroll run. Defines the closing boundary of the earnings window. Together with pay_period_start_date, determines the scope of labor costs chargeable to grants and programs.',
    `pay_period_start_date` DATE COMMENT 'The first calendar date of the pay period covered by this payroll run. Defines the beginning of the earnings window for all employees included in the run. Used for time-and-attendance reconciliation and grant cost allocation.',
    `payment_date` DATE COMMENT 'The scheduled or actual date on which net pay is disbursed to employees bank accounts or via alternative payment methods. Used for cash flow planning, bank reconciliation, and compliance with local labor law payment deadlines.',
    `payment_method` STRING COMMENT 'The disbursement method used to pay employees in this payroll run. In humanitarian contexts, mobile money (e.g., M-Pesa) is common for field staff in remote areas. Determines the payment processing channel and reconciliation approach.. Valid values are `bank_transfer|mobile_money|check|cash|prepaid_card`',
    `payroll_group` STRING COMMENT 'Classification of the staff population covered by this payroll run. Distinguishes between national staff (locally hired), international staff (globally mobile), expatriates (expat), volunteers with stipends, and consultants. Drives applicable tax regimes, benefit structures, and compliance reporting requirements.. Valid values are `national_staff|international_staff|expat|volunteer|consultant`',
    `processed_by` STRING COMMENT 'The name or employee identifier of the payroll officer who initiated and processed this payroll run in Workday HCM. Supports RACI (Responsible Accountable Consulted Informed) accountability tracking and audit trail requirements.',
    `program_code` STRING COMMENT 'The program identifier to which payroll costs are allocated, linking staff costs to specific humanitarian or development programs (e.g., WASH, GBV, PSS). Supports program-level financial reporting and MEL (Monitoring Evaluation and Learning) cost analysis.',
    `retroactive_period_start_date` DATE COMMENT 'The start date of the prior period for which retroactive pay adjustments are being made in this payroll run. Populated only when is_retroactive is True. Used to correctly allocate retroactive costs to the appropriate grant and fiscal period.',
    `payroll_run_status` STRING COMMENT 'Current lifecycle state of the payroll run within Workday HCM. Progresses from draft through calculation, approval, and payment. Cancelled status indicates the run was voided before disbursement. Used for workflow control and audit compliance.. Valid values are `draft|in_progress|calculated|approved|paid|cancelled`',
    `total_deductions` DECIMAL(18,2) COMMENT 'The aggregate of all deductions applied across employees in this payroll run, including statutory taxes, social security contributions, health insurance premiums, pension contributions, and voluntary deductions. Reconciled against payroll liabilities in the General Ledger (GL).',
    `total_employer_contributions` DECIMAL(18,2) COMMENT 'The aggregate employer-side payroll costs for this run, including employer social security, pension matching, health insurance, and other statutory employer contributions. Represents the full labor cost burden beyond gross pay, critical for grant budget management and F&A (Facilities and Administration) cost allocation.',
    `total_gross_pay` DECIMAL(18,2) COMMENT 'The aggregate gross earnings for all employees included in this payroll run before any deductions. Includes base salary, allowances, overtime, and other earnings components. Used for BvA (Budget versus Actual) reporting, grant cost allocation, and financial stewardship.',
    `total_net_pay` DECIMAL(18,2) COMMENT 'The aggregate net amount disbursed to all employees in this payroll run after all deductions. Equals total_gross_pay minus total_deductions. Used for cash disbursement planning, bank transfer reconciliation, and treasury management.',
    `total_tax_withheld` DECIMAL(18,2) COMMENT 'The aggregate income tax and statutory levies withheld from employee earnings in this payroll run. Reported to tax authorities and reconciled against payroll tax liability accounts in the CoA (Chart of Accounts). Supports compliance with IRS and local tax authority reporting.',
    `payroll_run_type` STRING COMMENT 'Categorizes the nature of the payroll run. Regular runs follow the standard pay schedule; off-cycle runs address missed payments; supplemental runs cover bonuses or allowances; correction runs fix prior errors; final runs process termination pay. Determines processing rules and audit requirements.. Valid values are `regular|off_cycle|supplemental|correction|final`',
    `workday_run_reference` STRING COMMENT 'The native identifier assigned to this payroll run by Workday HCM, the system of record. Enables traceability back to the source system for audit, reconciliation, and support purposes. Distinct from the Silver layer surrogate key payroll_run_id.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Payroll processing cycle record capturing each payroll run executed in Workday HCM, including pay period start and end dates, payroll group (national staff, international staff, expat), run status, total gross pay, total deductions, total net pay, currency, and approval status. Serves as the header record for payroll transactions.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`payslip` (
    `payslip_id` BIGINT COMMENT 'Unique surrogate identifier for each individual payslip record in the Workday HCM payroll system. Serves as the primary key for the payslip data product in the Databricks Silver Layer.',
    `original_payslip_id` BIGINT COMMENT 'Reference to the original payslip record that this corrected or reversed payslip supersedes. Null for standard payslips; populated only when is_correction is True, enabling full audit trail of payroll corrections.',
    `payroll_run_id` BIGINT COMMENT 'Reference to the payroll run batch under which this payslip was processed. Enables traceability of individual payslips back to the parent payroll run for audit and reconciliation purposes.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member for whom this payslip was generated. Links to the employee master record in Workday HCM HRIS.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the payroll run containing this payslip was formally approved in the Workday HCM approval workflow. Provides an auditable approval event timestamp for statutory and donor compliance.',
    `approved_by` STRING COMMENT 'Name or identifier of the authorising manager or finance officer who approved this payroll run in the Workday HCM approval chain. Supports RACI accountability documentation and donor audit requirements.',
    `bank_account_reference` STRING COMMENT 'Masked or tokenised reference to the employees bank account details used for payment disbursement. Full account details are stored securely in Workday HCM; only a reference token is retained in the Silver Layer for audit traceability without exposing PCI-sensitive data.',
    `cost_center_code` STRING COMMENT 'Chart of Accounts (CoA) cost center code to which the employees payroll costs are primarily allocated. Supports Budget vs Actual (BvA) reporting and fund accounting in SAP S/4HANA and Unit4 ERP.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the duty station where the employee is based and where payroll is processed. Determines applicable labour law, tax jurisdiction, statutory deduction rules, and local currency for multi-country NGO operations across 50+ countries.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payslip record was first created in the Workday HCM system and ingested into the Databricks Silver Layer. Provides the audit creation timestamp for data lineage and compliance tracking.',
    `employer_pension_contribution` DECIMAL(18,2) COMMENT 'Employers contribution to the employees pension or provident fund for the pay period. Recorded separately from employee deductions for total employment cost reporting and grant cost allocation under OMB Uniform Guidance.',
    `employer_social_security` DECIMAL(18,2) COMMENT 'Employers statutory social security or national insurance contribution associated with this payslip. Not deducted from employee pay but recorded for total employment cost reporting, BvA grant cost allocation, and NICRA indirect cost rate calculations.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Foreign exchange rate applied to convert local currency salary amounts to the payment currency at the time of payroll processing. Critical for multi-currency reconciliation and donor financial reporting.',
    `expat_allowance` DECIMAL(18,2) COMMENT 'Allowance specific to internationally-recruited expatriate staff, covering relocation, cost-of-living differentials, and international assignment premiums. Applicable only to staff in the expat payroll group.',
    `field_allowance` DECIMAL(18,2) COMMENT 'Allowance paid to staff working in active field operations, remote areas, or humanitarian response zones. Distinct from hardship allowance; compensates for operational field conditions and mobility requirements.',
    `gl_journal_reference` STRING COMMENT 'Reference number of the General Ledger journal entry posted in SAP S/4HANA or Unit4 ERP for this payslips payroll costs. Enables reconciliation between payroll records and the fund accounting general ledger.',
    `grant_code` STRING COMMENT 'Identifier of the grant or funding source to which this payroll cost is charged. Enables donor-specific payroll cost allocation for BvA reporting, USAID/DFID/CERF grant compliance, and NICRA indirect cost rate calculations.',
    `gross_salary` DECIMAL(18,2) COMMENT 'Total gross salary amount in local currency before any deductions, representing the employees base contractual pay for the pay period. Forms the basis for all statutory deduction calculations and BvA payroll cost reporting.',
    `hardship_allowance` DECIMAL(18,2) COMMENT 'Additional allowance paid to staff deployed in hardship or non-family duty stations as classified by UN/INGO hardship classification frameworks. Compensates for difficult living conditions in humanitarian field operations.',
    `housing_allowance` DECIMAL(18,2) COMMENT 'Monetary allowance paid to the employee to cover accommodation costs, commonly provided to international and expat staff in high-cost or insecure duty stations. Taxability varies by country and employment contract type.',
    `income_tax_deduction` DECIMAL(18,2) COMMENT 'Statutory income tax withheld from the employees gross pay in accordance with the applicable national tax legislation of the duty station country. Reported to tax authorities and included in statutory payroll filings.',
    `is_correction` BOOLEAN COMMENT 'Indicates whether this payslip is a corrected reissue of a previously reversed payslip. When True, the original_payslip_id field references the superseded payslip for audit trail continuity.',
    `is_off_cycle` BOOLEAN COMMENT 'Indicates whether this payslip was generated as part of an off-cycle payroll run (e.g., for a new hire mid-period, a termination payment, or a correction) rather than the standard scheduled payroll cycle.',
    `local_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the local currency in which the employees salary components are denominated and calculated. Supports multi-currency payroll operations across 50+ countries.. Valid values are `^[A-Z]{3}$`',
    `net_pay_local` DECIMAL(18,2) COMMENT 'Final take-home pay amount in local currency after all statutory and voluntary deductions have been subtracted from gross pay and allowances. Represents the amount the employee is entitled to receive for the pay period.',
    `net_pay_payment_currency` DECIMAL(18,2) COMMENT 'Net pay amount converted to the payment currency using the applicable exchange rate. Represents the actual amount disbursed to the employees bank account. May equal net_pay_local when local and payment currencies are the same.',
    `number` STRING COMMENT 'Externally-visible, human-readable unique reference number for this payslip, typically formatted as PSL-{COUNTRY}-{YEAR}-{MONTH}-{SEQUENCE}. Used in employee communications, statutory filings, and donor audit documentation.. Valid values are `^PSL-[A-Z]{2,4}-[0-9]{4}-[0-9]{2}-[0-9]{6}$`',
    `pay_period_end_date` DATE COMMENT 'The last calendar date of the payroll period covered by this payslip. Together with pay_period_start_date defines the exact payroll cycle window for statutory and donor reporting.',
    `pay_period_start_date` DATE COMMENT 'The first calendar date of the payroll period covered by this payslip. Used for Budget vs Actual (BvA) payroll cost allocation to grants and programs.',
    `payment_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code of the currency in which net pay is actually disbursed to the employee. May differ from local_currency_code for expatriate staff paid in USD or EUR regardless of duty station.. Valid values are `^[A-Z]{3}$`',
    `payment_date` DATE COMMENT 'The actual date on which net pay was disbursed to the employees bank account or via the designated payment method. Represents the principal business event date for this transaction.',
    `payment_method` STRING COMMENT 'Method by which net pay is disbursed to the employee. Bank transfer is standard for most staff; cash and mobile money are used in remote field locations with limited banking infrastructure, common in humanitarian operations.. Valid values are `bank_transfer|cash|mobile_money|cheque`',
    `payroll_group` STRING COMMENT 'Classification of the staff members employment category for payroll processing purposes. Determines applicable pay scales, allowances, tax treatment, and statutory deduction rules. National staff follow local labour law; international and expat staff follow INGO compensation frameworks.. Valid values are `national|international|expat|consultant`',
    `payroll_run_sequence` STRING COMMENT 'Sequential run number within the payroll period (e.g., 1 for the primary run, 2 for a supplemental or correction run). Distinguishes regular payroll runs from off-cycle or adjustment runs.',
    `pension_deduction` DECIMAL(18,2) COMMENT 'Employee contribution to pension or provident fund deducted from gross pay. Includes both mandatory statutory pension contributions and voluntary supplementary pension scheme contributions where applicable.',
    `program_code` STRING COMMENT 'Identifier of the humanitarian or development program to which this payroll cost is allocated. Supports program-level cost tracking for MEL reporting, LogFrame financial monitoring, and donor accountability.',
    `run_status` STRING COMMENT 'Current lifecycle state of the payroll run associated with this payslip. Tracks the workflow from initial calculation through approval, payment disbursement, and any reversals required for corrections.. Valid values are `draft|calculated|approved|paid|reversed|cancelled`',
    `social_security_deduction` DECIMAL(18,2) COMMENT 'Statutory social security or national insurance contribution deducted from the employees pay as required by local labour law. Varies by country and employment type; may be zero for certain expat staff under bilateral social security agreements.',
    `payslip_status` STRING COMMENT 'Current lifecycle state of this individual payslip record. Distinguishes between payslips that have been generated and issued to the employee versus those that have been reversed or superseded by a corrected payslip.. Valid values are `generated|issued|reversed|corrected`',
    `total_allowances` DECIMAL(18,2) COMMENT 'Sum of all allowance components (housing, hardship, field, expat, transport, and any other applicable allowances) for the pay period in local currency. Used as a subtotal in payslip presentation and BvA reporting.',
    `total_statutory_deductions` DECIMAL(18,2) COMMENT 'Sum of all mandatory statutory deductions (income tax, social security, pension) for the pay period. Used as a subtotal in payslip presentation and for statutory remittance reconciliation.',
    `transport_allowance` DECIMAL(18,2) COMMENT 'Allowance paid to cover employee commuting or field transportation costs. Commonly provided to national staff in urban and peri-urban duty stations as part of the total compensation package.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this payslip record was last modified in the source system or Silver Layer. Tracks corrections, status changes, and reprocessing events for data lineage and audit purposes.',
    `voluntary_deductions` DECIMAL(18,2) COMMENT 'Total of all employee-elected voluntary deductions for the pay period, including staff association fees, health insurance premiums, loan repayments, savings scheme contributions, and other authorised deductions.',
    CONSTRAINT pk_payslip PRIMARY KEY(`payslip_id`)
) COMMENT 'Individual payslip record for each staff member per payroll cycle, serving as SSOT for both payroll run processing (pay period start/end dates, payroll group — national/international/expat, run sequence number, run status, batch approval, total run aggregates) and individual pay details (gross salary, allowances — housing/hardship/field/expat, statutory deductions — income tax/social security/pension, voluntary deductions, net pay in local and payment currencies). Multi-currency supported for international operations across 50+ countries. Includes payment method, bank details reference, and payroll run approval chain. Supports BvA (Budget vs Actual) payroll cost allocation to grants and programs, donor audit requirements, and statutory payroll reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Unique surrogate identifier for each benefit enrollment record in the Workday HCM Benefits module. Serves as the primary key for this Silver Layer data product.',
    `benefit_plan_id` BIGINT COMMENT 'Reference to the benefit plan catalog entry that the staff member is enrolled in. Links to the benefit plan master record defining plan name, provider, type, and eligibility rules.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member enrolled in this benefit plan. Links to the workforce employee master record in Workday HCM.',
    `approval_date` DATE COMMENT 'The date on which the benefit enrollment was formally approved by the authorized HR officer in Workday HCM. Part of the enrollment lifecycle audit trail.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the HR officer or manager who approved this benefit enrollment in Workday HCM. Supports RACI accountability and audit trail requirements.',
    `beneficiary_name` STRING COMMENT 'Full name of the designated beneficiary for life insurance or pension death benefit plans. Populated for life insurance and pension plan types. Sensitive PII requiring restricted access.',
    `beneficiary_relationship` STRING COMMENT 'Relationship of the designated beneficiary to the enrolled staff member for life insurance or pension death benefit purposes (e.g., spouse, child, parent).. Valid values are `spouse|child|parent|sibling|other`',
    `cobra_eligible` BOOLEAN COMMENT 'Indicates whether the staff member is eligible for continuation of health coverage under COBRA (Consolidated Omnibus Budget Reconciliation Act) or equivalent continuation provisions upon termination of employment. Applicable primarily for US-based staff.',
    `contribution_currency` STRING COMMENT 'ISO 4217 three-letter currency code in which employee and employer contributions are denominated (e.g., USD, GBP, EUR). Critical for multi-currency NGO operations across field offices.. Valid values are `^[A-Z]{3}$`',
    `contribution_frequency` STRING COMMENT 'The pay period frequency at which employee and employer contributions are deducted and remitted. Aligns with the payroll cycle configured in Workday HCM.. Valid values are `monthly|bi_weekly|weekly|annual`',
    `cost_center_code` STRING COMMENT 'Chart of Accounts (CoA) cost center to which the employer benefit contribution is charged. Enables grant-level and program-level benefit cost allocation in SAP S/4HANA and Unit4 ERP.',
    `coverage_tier` STRING COMMENT 'The coverage level selected by the staff member, indicating whether the plan covers the employee alone or extends to dependents. Drives cost-sharing calculations and dependent eligibility.. Valid values are `employee_only|employee_plus_spouse|employee_plus_children|employee_plus_family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this benefit enrollment record was first created in Workday HCM, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Establishes the audit creation trail for compliance and data governance.',
    `benefit_enrollment_date` DATE COMMENT 'The calendar date on which the staff member formally enrolled in the benefit plan, as recorded in Workday HCM. Represents the business event date of enrollment action.',
    `dependent_count` STRING COMMENT 'Number of dependents (spouse, children, or other eligible family members) covered under this enrollment. Drives coverage tier classification and premium calculation.',
    `duty_station_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the staff members duty station at time of enrollment. Determines eligibility for international vs. national staff benefit plans and medical evacuation entitlements.. Valid values are `^[A-Z]{3}$`',
    `duty_station_hardship_level` STRING COMMENT 'UN/OCHA hardship classification of the duty station (H=Headquarters, A through E indicating increasing hardship). Determines eligibility for R&R (Rest and Recuperation) entitlements and hazard pay benefit components.. Valid values are `H|A|B|C|D|E`',
    `effective_end_date` DATE COMMENT 'The date on which benefit coverage ends for this enrollment record. Null for open-ended active enrollments. Populated upon termination, resignation, contract end, or plan year close.',
    `effective_start_date` DATE COMMENT 'The date on which benefit coverage becomes active and the staff member is entitled to use the plan. May differ from enrollment_date due to waiting periods or plan cycle start rules.',
    `eligibility_rule_code` STRING COMMENT 'Code referencing the eligibility rule set in Workday HCM that governs which staff categories qualify for this plan (e.g., INTL-STAFF-ONLY, NAT-STAFF-PENSION, ALL-STAFF-HEALTH). Supports automated eligibility validation.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'The monetary amount contributed by the staff member per pay period toward the benefit plan premium or pension. Used in payroll deduction processing and Budget versus Actual (BvA) reporting.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'The monetary amount contributed by the organization per pay period toward the benefit plan premium or pension on behalf of the staff member. Included in Facilities and Administration (F&A) cost calculations and grant budget reporting.',
    `event_type` STRING COMMENT 'The qualifying business event that triggered this enrollment record in Workday HCM. Determines eligibility windows and audit trail for compliance. Life events include marriage, birth, adoption, and loss of other coverage.. Valid values are `new_hire|open_enrollment|life_event|rehire|transfer|correction`',
    `grant_code` STRING COMMENT 'Grant or award identifier to which the employer benefit contribution is allocated, supporting donor-restricted fund accounting and indirect cost rate (ICR/NICRA) compliance reporting.',
    `is_dependent_coverage` BOOLEAN COMMENT 'Indicates whether this enrollment includes coverage for one or more dependents beyond the enrolled staff member. True when coverage_tier extends beyond employee-only.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this benefit enrollment record in Workday HCM, in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for incremental data pipeline processing and audit compliance.',
    `life_insurance_coverage_amount` DECIMAL(18,2) COMMENT 'The face value or sum assured of the life insurance benefit plan in the contribution currency. Populated only for life insurance plan type enrollments. Used for beneficiary payout calculations.',
    `medevac_coverage_zone` STRING COMMENT 'Geographic zone or region to which the staff member is entitled to be medically evacuated under the medical evacuation benefit plan (e.g., Regional Hub, Home Country, Nearest Adequate Facility). Applicable for international and field staff.',
    `notes` STRING COMMENT 'Free-text field for HR staff to record additional context, exceptions, or special circumstances related to this benefit enrollment (e.g., retroactive adjustments, special eligibility waivers, field office exceptions).',
    `open_enrollment_period` STRING COMMENT 'Identifier or label for the open enrollment window during which this enrollment was submitted (e.g., OE-2024-Q4). Supports audit and reconciliation of annual benefit elections.',
    `pension_contribution_rate_pct` DECIMAL(18,2) COMMENT 'The percentage of the staff members gross salary contributed to the pension plan per pay period (combined employee and employer rate). Applicable for pension plan type enrollments. Used in NICRA indirect cost rate calculations.',
    `plan_provider` STRING COMMENT 'Name of the external insurance carrier, pension fund administrator, or service provider delivering the benefit plan (e.g., Cigna Global, AXA International, CIGNA Expatriate Benefits).',
    `plan_provider_policy_number` STRING COMMENT 'The policy or contract number issued by the benefit plan provider to the organization. Used for claims processing and provider reconciliation.',
    `plan_type` STRING COMMENT 'Category of benefit plan covering the enrollment. Includes health insurance, life insurance, pension/retirement, medical evacuation (medevac), and Rest and Recuperation (R&R) entitlements applicable to humanitarian field staff. [ENUM-REF-CANDIDATE: health_insurance|life_insurance|pension|medical_evacuation|rest_and_recuperation|disability — promote to reference product]. Valid values are `health_insurance|life_insurance|pension|medical_evacuation|rest_and_recuperation`',
    `plan_year` STRING COMMENT 'The four-digit calendar or fiscal year of the benefit plan cycle to which this enrollment belongs (e.g., 2024). Used for annual open enrollment reconciliation and FASB ASC 958 period reporting.. Valid values are `^[0-9]{4}$`',
    `rr_cycle_days` STRING COMMENT 'Number of days in the Rest and Recuperation (R&R) entitlement cycle for this enrollment, applicable to field staff in hardship locations. Determined by duty station hardship level per OCHA/organizational policy.',
    `staff_category` STRING COMMENT 'Classification of the staff member at time of enrollment, determining eligibility for specific benefit plans. National staff, international staff, and expatriates typically have distinct benefit entitlements in NGO/INGO operations.. Valid values are `national|international|expatriate|consultant`',
    `benefit_enrollment_status` STRING COMMENT 'Current lifecycle state of the benefit enrollment record. Active indicates current coverage; Pending indicates awaiting approval or effective date; Terminated indicates coverage has ended; Waived indicates the employee opted out; On Leave indicates coverage maintained during approved leave; Suspended indicates temporarily paused.. Valid values are `active|pending|terminated|waived|on_leave|suspended`',
    `termination_reason` STRING COMMENT 'Reason code for the end of this benefit enrollment. Populated when enrollment_status transitions to terminated. Supports HR analytics and compliance audit trails. [ENUM-REF-CANDIDATE: resignation|contract_end|termination|retirement|death|transfer|plan_discontinuation|other — promote to reference product]',
    `waiting_period_days` STRING COMMENT 'Number of calendar days between the enrollment date and the effective start date during which the staff member is not yet eligible to claim benefits. Defined by the plans eligibility rules.',
    `waiver_reason` STRING COMMENT 'Free-text or coded reason provided by the staff member when opting out (waiving) a benefit plan. Populated only when enrollment_status is waived. Examples: covered by spouse plan, covered by government scheme.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'Record of a staff members enrollment in a specific benefit plan, serving as SSOT for both the benefit plan catalog (plan name, provider, plan type, eligibility criteria for national vs international staff, coverage structure, cost model, effective dates) and individual enrollment instances (coverage tier, enrollment date, effective date, end date, employee contribution, employer contribution, dependent coverage). Covers health insurance, life insurance, pension, medical evacuation, and R&R (Rest and Recuperation) entitlements. Plan catalog entries have header-level attributes; enrollments are line-level records per staff member per plan. Sourced from Workday HCM Benefits module.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` (
    `benefit_plan_id` BIGINT COMMENT 'Unique system-generated identifier for each benefit plan record in the Workday HCM Benefits module. Serves as the primary key for the benefit_plan entity.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Links benefit plans to their administration platform (Workday, SAP, local HRIS). Required for enrollment processing, vendor integration management, data migration planning, and system-specific configu',
    `staff_member_id` BIGINT COMMENT 'add column staff_member_id (BIGINT) with FK to workforce.staff_member.staff_member_id - benefit plans need an HR owner/administrator',
    `annual_coverage_limit_usd` DECIMAL(18,2) COMMENT 'Maximum total benefit payout or coverage amount per enrolled staff member per plan year, expressed in US Dollars. Used for financial liability estimation and BvA (Budget versus Actual) reporting in Unit4 ERP.',
    `benefit_plan_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the benefit plan across HR and payroll systems (e.g., HLTH-INTL-01, PENSION-NAT-02). Used for cross-system reconciliation with SAP S/4HANA payroll and Unit4 ERP.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `contribution_frequency` STRING COMMENT 'Frequency at which employer and employee contributions are made or deducted for this benefit plan (e.g., monthly, bi-weekly). Aligns with payroll cycle configuration in Workday HCM and SAP S/4HANA.. Valid values are `monthly|bi_weekly|weekly|annual|quarterly`',
    `cost_center_code` STRING COMMENT 'Cost center code in SAP S/4HANA or Unit4 ERP to which benefit plan costs are allocated. Supports program-level cost tracking and indirect cost rate (ICR/NICRA) calculations for donor reporting.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code identifying the country for which this benefit plan is applicable when geographic_scope is country_specific (e.g., KEN, ETH, SSD). Null for global or regional plans.. Valid values are `^[A-Z]{3}$`',
    `coverage_description` STRING COMMENT 'Narrative description of the benefits and services covered under this plan, including key inclusions and exclusions (e.g., inpatient/outpatient care, emergency evacuation, dental, maternity, pre-existing conditions). Sourced from the providers Summary of Benefits document.',
    `coverage_tier` STRING COMMENT 'Defines the coverage scope of the plan in terms of dependents included (e.g., individual only, individual plus spouse, full family). Determines premium cost structure and payroll deduction amounts.. Valid values are `individual|individual_plus_spouse|family|employee_plus_children`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code in which the plans financial terms (premiums, contributions, limits) are denominated (e.g., USD, EUR, GBP). Supports multi-currency operations across Ngos country offices.. Valid values are `^[A-Z]{3}$`',
    `deductible_amount_usd` DECIMAL(18,2) COMMENT 'The amount an enrolled staff member must pay out-of-pocket before the benefit plan begins covering costs, expressed in US Dollars. Relevant for health insurance and medical evacuation plans.',
    `dependent_coverage_allowed` BOOLEAN COMMENT 'Indicates whether enrolled staff members may extend coverage under this plan to eligible dependents (spouse, children). Drives dependent enrollment workflows in Workday HCM.',
    `document_url` STRING COMMENT 'URL or document management system path to the official plan document, Summary of Benefits, or provider contract. Enables HR staff and auditors to access the authoritative plan terms for compliance verification.',
    `effective_end_date` DATE COMMENT 'The date on which the benefit plan ceases to be available for enrollment or active coverage. Nullable for open-ended plans. When populated, triggers off-boarding of enrolled staff in Workday HCM.',
    `effective_start_date` DATE COMMENT 'The date from which the benefit plan becomes binding and available for staff enrollment. Used to determine plan applicability during open enrollment periods and new hire onboarding.',
    `employee_contribution_amount_usd` DECIMAL(18,2) COMMENT 'Fixed monetary amount deducted from the enrolled staff members salary per contribution period, expressed in USD. Used when the employee contribution is a flat amount rather than a percentage.',
    `employee_contribution_pct` DECIMAL(18,2) COMMENT 'Percentage of the total benefit plan premium or contribution deducted from the enrolled staff members salary. Complements employer_contribution_pct to total 100% of the plan cost.',
    `employer_contribution_amount_usd` DECIMAL(18,2) COMMENT 'Fixed monetary amount contributed by Ngo per enrolled staff member per contribution period, expressed in USD. Used when the employer contribution is a flat amount rather than a percentage. Feeds into payroll and grant F&A (Facilities and Administration) cost calculations.',
    `employer_contribution_pct` DECIMAL(18,2) COMMENT 'Percentage of the total benefit plan premium or contribution that Ngo (the employer) pays on behalf of the enrolled staff member. Used for payroll cost allocation and grant budget charging in SAP S/4HANA and Unit4 ERP.',
    `employment_type_eligibility` STRING COMMENT 'Specifies which employment contract types are eligible for this benefit plan (e.g., full_time permanent, part_time, fixed_term contract, or all). Drives automated eligibility checks during onboarding in Workday HCM.. Valid values are `full_time|part_time|fixed_term|all`',
    `enrollment_type` STRING COMMENT 'Indicates whether enrollment in this plan is automatic (all eligible staff are enrolled by default), voluntary (staff opt in), or mandatory (required by law or policy). Drives Workday HCM enrollment workflow logic.. Valid values are `automatic|voluntary|mandatory`',
    `geographic_scope` STRING COMMENT 'Indicates whether the benefit plan applies globally across all Ngo country offices, regionally, or is restricted to a specific country of operation. Supports multi-country INGO benefit administration.. Valid values are `global|regional|country_specific`',
    `gl_account_code` STRING COMMENT 'The General Ledger (GL) account code in SAP S/4HANA or Unit4 ERP to which employer benefit contributions for this plan are charged. Enables accurate fund accounting, grant cost allocation, and BvA (Budget versus Actual) reporting.',
    `hardship_location_applicable` BOOLEAN COMMENT 'Indicates whether this benefit plan is specifically designed for or applicable to staff deployed in hardship or non-family duty stations (e.g., conflict zones, remote field locations). Relevant for MedEvac, R&R, and hazard pay benefit plans.',
    `is_grant_chargeable` BOOLEAN COMMENT 'Indicates whether the employers contribution to this benefit plan can be directly charged to donor grants as an allowable cost under OMB Uniform Guidance 2 CFR 200. Affects grant budget preparation and financial reporting to donors such as USAID and BHA.',
    `is_medevac_included` BOOLEAN COMMENT 'Indicates whether medical evacuation (MedEvac) coverage is included within this benefit plan. Critical for field personnel and expatriate staff operating in high-risk humanitarian contexts. Aligns with Sphere and CHS duty-of-care standards.',
    `is_rnr_included` BOOLEAN COMMENT 'Indicates whether Rest and Recuperation (R&R) entitlements are included in this benefit plan. R&R is a mandatory staff welfare provision for personnel deployed in hardship or non-family duty stations per INGO HR policy.',
    `last_reviewed_date` DATE COMMENT 'Date on which the benefit plan was last formally reviewed by HR leadership or the benefits committee for adequacy, cost, and compliance. Supports governance and audit trail requirements.',
    `max_dependents_covered` STRING COMMENT 'Maximum number of dependents that can be enrolled under a single staff members benefit plan coverage. Null or zero indicates no dependent coverage or unlimited dependents per plan rules.',
    `minimum_service_months` STRING COMMENT 'Minimum number of months of continuous service an employee must complete before becoming eligible to enroll in this benefit plan. A value of 0 indicates immediate eligibility upon hire.',
    `benefit_plan_name` STRING COMMENT 'Full human-readable name of the benefit plan as displayed to staff and HR administrators (e.g., International Staff Health Insurance Scheme, National Staff Pension Plan, Group Life Insurance – Field Personnel).',
    `next_renewal_date` DATE COMMENT 'Date on which the benefit plan contract with the provider is due for renewal or renegotiation. Triggers procurement and HR review workflows to ensure continuity of staff coverage.',
    `notes` STRING COMMENT 'Free-text field for HR administrators to capture additional context, special conditions, exceptions, or administrative notes related to the benefit plan that are not captured in structured fields.',
    `open_enrollment_end_date` DATE COMMENT 'The date on which the annual open enrollment window closes. Staff who do not act before this date are subject to default enrollment rules or waiver of coverage for the plan year.',
    `open_enrollment_start_date` DATE COMMENT 'The date on which the annual open enrollment window opens, allowing eligible staff to enroll in, modify, or waive coverage for the upcoming plan year. Managed in Workday HCM Benefits enrollment events.',
    `provider_name` STRING COMMENT 'Name of the external insurance company, pension fund administrator, or benefit service provider underwriting or administering this plan (e.g., Cigna Global Health, AXA Assistance, Allianz Care).',
    `provider_policy_number` STRING COMMENT 'The policy or contract reference number issued by the benefit provider to Ngo. Used for claims processing, renewals, and regulatory filings. Classified as confidential due to contractual sensitivity.',
    `regulatory_compliance_reference` STRING COMMENT 'Reference to the specific regulatory framework, local labor law, or donor compliance requirement that mandates or governs this benefit plan (e.g., Kenya Employment Act 2007, IRS 501(c)(3), OMB 2 CFR 200, DFID Supplier Standards). Supports compliance reporting and audit readiness.',
    `rnr_frequency_days` STRING COMMENT 'Number of days between each R&R entitlement cycle for staff covered under this plan (e.g., every 60 days for hardship locations). Applicable only when is_rnr_included is True.',
    `staff_category_eligibility` STRING COMMENT 'Defines which staff category is eligible to enroll in this benefit plan. Distinguishes between national staff (locally hired), international staff (expatriates/INGOs), or both. Critical for INGO compliance and equitable HR policy under CHS.. Valid values are `national_staff|international_staff|both|expatriate|volunteer`',
    `benefit_plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan indicating whether it is available for enrollment, suspended, or retired. Drives eligibility logic in Workday HCM and payroll deduction processing in SAP S/4HANA.. Valid values are `active|inactive|pending|suspended|terminated`',
    `benefit_plan_type` STRING COMMENT 'Categorical classification of the benefit plan by its primary benefit category as administered in Workday HCM (e.g., health_insurance, pension, group_life_insurance, medical_evacuation, rest_and_recuperation). [ENUM-REF-CANDIDATE: health_insurance|pension|group_life_insurance|medical_evacuation|rest_and_recuperation|disability|dental|vision|other — promote to reference product]',
    `waiting_period_days` STRING COMMENT 'Number of days after enrollment before coverage becomes effective for the enrolled staff member. A value of 0 indicates immediate coverage upon enrollment. Common for health insurance and pension plans.',
    `year_start_month` STRING COMMENT 'The calendar month (1–12) in which the benefit plan year begins. Determines open enrollment windows, annual coverage resets, and financial year-end accruals in SAP S/4HANA and Unit4 ERP.',
    CONSTRAINT pk_benefit_plan PRIMARY KEY(`benefit_plan_id`)
) COMMENT 'Catalog of benefit plans offered by Ngo to staff, including health insurance schemes, pension plans, group life insurance, medical evacuation coverage, and R&R (Rest and Recuperation) entitlements. Captures plan name, provider, eligibility criteria (national vs international staff), coverage details, and cost structure.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` (
    `recruitment_requisition_id` BIGINT COMMENT 'Unique system-generated identifier for the recruitment requisition record in Workday HCM. Serves as the primary key for all downstream joins and audit trails. Entity role: TRANSACTION_HEADER.',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding award that will finance this position. Required for donor compliance, budget-versus-actual (BvA) tracking, and Negotiated Indirect Cost Rate Agreement (NICRA) reporting under OMB Uniform Guidance 2 CFR 200.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program that this position will support. Enables program-level workforce planning and ensures alignment with program design and Theory of Change (ToC) staffing requirements.',
    `job_profile_id` BIGINT COMMENT 'Reference to the standardized job profile in Workday HCM defining the role family, competency requirements, and compensation grade associated with this requisition.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department or cost center within Ngo that is requesting the hire. Used for headcount reporting, budget allocation, and workforce analytics.',
    `position_id` BIGINT COMMENT 'Reference to the approved position in the organizational structure that this requisition is intended to fill. Links to the position management module in Workday HCM for headcount control and workforce planning.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member designated as the hiring manager responsible for defining requirements, participating in interviews, and making the final selection decision. Maps to PARTY_REFERENCE category for TRANSACTION_HEADER role.',
    `tertiary_recruitment_recruiter_staff_member_id` BIGINT COMMENT 'Reference to the HR staff member assigned as the primary recruiter responsible for managing the end-to-end recruitment process for this requisition in Workday HCM.',
    `actual_fill_date` DATE COMMENT 'The date on which the requisition was formally closed as filled, i.e., when an offer was accepted by the selected candidate. Used to calculate time-to-fill metrics and assess recruitment efficiency against targets.',
    `application_deadline` DATE COMMENT 'The closing date for candidate applications as advertised in the job posting. After this date, new applications are typically not accepted unless the requisition is extended. Supports candidate pipeline management and posting compliance.',
    `approval_date` DATE COMMENT 'Date on which the final approval was granted for the requisition. Used to measure approval cycle time and to establish the official start of the active recruitment period.',
    `approval_status` STRING COMMENT 'Current state of the requisition within the organizational approval chain. pending = awaiting review; approved = all required approvals obtained; rejected = denied by an approver; escalated = routed to a higher authority due to exception or delay. Approval chain typically includes hiring manager, HR business partner, finance, and country director.. Valid values are `pending|approved|rejected|escalated`',
    `budgeted_annual_salary` DECIMAL(18,2) COMMENT 'The approved annual salary budget for this position in the organizational base currency. Used for budget-versus-actual (BvA) tracking, grant budget compliance, and workforce cost forecasting. Confidential financial data.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation for why the requisition was cancelled or closed without being filled. Populated only when requisition_status is cancelled or closed. Common reasons include funding loss, program restructuring, or position elimination. Supports workforce planning retrospectives.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the requisition record was first created in Workday HCM, regardless of approval or opening status. Used for audit trail and data lineage. Maps to RECORD_AUDIT_CREATED category for TRANSACTION_HEADER role.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the budgeted salary amount (e.g., USD, EUR, KES). Required for multi-currency workforce cost consolidation and donor financial reporting.. Valid values are `^[A-Z]{3}$`',
    `duty_station` STRING COMMENT 'The primary geographic location where the recruited staff member will be based, expressed as a city or field office name (e.g., Nairobi, Juba Field Office). Used for hardship allowance determination, security risk classification, and GIS-based workforce mapping.',
    `duty_station_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the recruited position will be based (e.g., KEN, SSD, ETH). Supports country-level workforce analytics, visa and work permit tracking, and IATI geographic reporting.. Valid values are `^[A-Z]{3}$`',
    `education_level_required` STRING COMMENT 'Minimum academic qualification required for the position: certificate, diploma, bachelors, masters, phd, or none. Used for candidate screening and workforce capability gap analysis.. Valid values are `certificate|diploma|bachelors|masters|phd|none`',
    `employment_type` STRING COMMENT 'Nature of the employment arrangement being recruited for: full_time = permanent or open-ended; part_time = reduced hours; fixed_term = time-bound contract; consultancy = individual contractor engagement; volunteer = unpaid service. Affects contract template, benefits eligibility, and payroll setup.. Valid values are `full_time|part_time|fixed_term|consultancy|volunteer`',
    `funding_confirmed` BOOLEAN COMMENT 'Indicates whether the funding source for this position has been confirmed and budget availability verified prior to opening the requisition. True = funding confirmed; False = pending funding confirmation. Critical control for grant-funded positions to prevent unauthorized commitments.',
    `funding_source_type` STRING COMMENT 'Classification of the funding mechanism supporting this position: grant = donor-restricted award; core_funds = unrestricted organizational funds; cost_share = matching contribution required by donor; bridge_funding = temporary internal funding pending grant confirmation; multi_donor = split across multiple grants. Affects budget coding and NICRA applicability.. Valid values are `grant|core_funds|cost_share|bridge_funding|multi_donor`',
    `gender_marker` STRING COMMENT 'Indicates any gender preference or affirmative action target for this position as part of Ngos gender equity and diversity commitments: open = no preference; female_preferred = women strongly encouraged to apply; male_preferred = men strongly encouraged to apply (rare, context-specific). Supports gender-disaggregated workforce reporting to donors and IASC gender accountability frameworks.. Valid values are `open|female_preferred|male_preferred`',
    `headcount_type` STRING COMMENT 'Indicates whether this requisition is for a backfill of a vacated position, a newly created position, a replacement for a terminated employee, or a surge addition for emergency response. Drives workforce planning analytics and budget impact assessment.. Valid values are `backfill|new_position|replacement|surge_addition`',
    `is_emergency_surge` BOOLEAN COMMENT 'Indicates whether this requisition was triggered by an emergency humanitarian response requiring rapid deployment (surge recruitment). True = emergency surge; False = standard recruitment. When True, expedited approval workflows and compressed time-to-fill targets apply per CHS and SPHERE standards.',
    `job_posting_date` DATE COMMENT 'Date on which the job advertisement was first published on external or internal channels. Used to calculate time-to-post (from requisition opening to posting) and to manage posting expiry dates per platform requirements.',
    `job_title` STRING COMMENT 'The specific job title for the position being recruited, as it will appear in job postings and the employment contract. May differ from the standardized job profile name to reflect local context or donor-specific naming conventions.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the requisition record in Workday HCM. Supports change detection, incremental ETL loads, and audit compliance. Maps to RECORD_AUDIT_UPDATED category for TRANSACTION_HEADER role.',
    `minimum_experience_years` STRING COMMENT 'The minimum number of years of relevant professional experience required for the position as specified in the job description. Used for candidate screening, competency benchmarking, and workforce capability analytics.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or exceptions related to this requisition (e.g., donor-specific hiring restrictions, language requirements, security context notes). Captured by the HR business partner or hiring manager in Workday HCM.',
    `number` STRING COMMENT 'Externally visible, human-readable requisition reference number assigned by Workday HCM at creation (e.g., REQ-2024-000123). Used in all communications with hiring managers, HR business partners, and candidates. Maps to BUSINESS_IDENTIFIER category for TRANSACTION_HEADER role.. Valid values are `^REQ-[0-9]{4}-[0-9]{6}$`',
    `number_of_openings` STRING COMMENT 'The total number of identical positions to be filled under this single requisition. Values greater than 1 are common for surge recruitment (e.g., hiring 10 community health workers for a WASH response). Drives candidate pipeline sizing and recruiter workload planning.',
    `opened_date` DATE COMMENT 'Calendar date on which the requisition was formally opened and made available for sourcing. Represents the principal business event date for time-to-fill calculations and workforce planning analytics. Maps to BUSINESS_EVENT_TIMESTAMP category for TRANSACTION_HEADER role.',
    `positions_filled_count` STRING COMMENT 'Running count of the number of openings that have been successfully filled under this requisition. Compared against number_of_openings to determine requisition completion. Supports partial-fill tracking for multi-opening surge requisitions.',
    `recruitment_type` STRING COMMENT 'Classification of the recruitment approach: internal = open only to current staff; external = open to the public; emergency_surge = rapid deployment for humanitarian response; rehire = former employee returning; secondment = staff loaned from a partner organization. Drives sourcing channel selection and time-to-fill targets.. Valid values are `internal|external|emergency_surge|rehire|secondment`',
    `salary_grade` STRING COMMENT 'The compensation band or grade level assigned to this position as defined in the organizational salary scale (e.g., Grade 7, Band C, P3). Confidential business data used for budget planning, equity analysis, and offer management. Not disclosed externally.',
    `security_clearance_required` BOOLEAN COMMENT 'Indicates whether the position requires a background check or security clearance prior to onboarding. True = clearance required; False = not required. Relevant for positions in conflict-affected areas, positions handling restricted donor data, or roles with fiduciary responsibilities.',
    `sourcing_channels` STRING COMMENT 'Comma-separated list of recruitment sourcing channels activated for this requisition (e.g., internal_posting, reliefweb, un_jobs, linkedin, devex, ngo_network). Supports sourcing effectiveness analytics and cost-per-hire reporting. [ENUM-REF-CANDIDATE: internal_posting|reliefweb|un_jobs|linkedin|devex|ngo_network|referral|direct_outreach — promote to reference product]',
    `staff_category` STRING COMMENT 'Classification of the staff type being recruited: national_staff = Host Country National (HCN) employed locally; international_staff = globally recruited; expatriate = staff deployed outside home country; hcn = Host Country National; tcn = Third Country National. Determines compensation framework, visa requirements, and NICRA cost allocation. [ENUM-REF-CANDIDATE: national_staff|international_staff|expatriate|hcn|tcn|regional — promote to reference product]. Valid values are `national_staff|international_staff|expatriate|hcn|tcn`',
    `recruitment_requisition_status` STRING COMMENT 'Current workflow lifecycle state of the requisition within Workday HCM. Drives downstream actions: draft = not yet submitted for approval; open = actively recruiting; on_hold = paused pending funding or approvals; filled = candidate selected and offer accepted; cancelled = withdrawn before fill; closed = administratively closed. Maps to LIFECYCLE_STATUS category.. Valid values are `draft|open|on_hold|filled|cancelled|closed`',
    `target_fill_date` DATE COMMENT 'The deadline by which the requisition must be filled, distinct from the target start date. Drives recruiter workload prioritization and escalation triggers. For emergency surge requisitions, this date is typically within 72 hours of opening.',
    `target_start_date` DATE COMMENT 'The desired date by which the recruited candidate should be onboarded and operational. Used for workforce planning, program staffing gap analysis, and time-to-fill KPI measurement. May be adjusted based on recruitment progress.',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days elapsed from the requisition opened_date to the actual_fill_date. Populated once the requisition is filled. Key KPI for recruitment efficiency, benchmarked against organizational targets and humanitarian surge standards (e.g., 72-hour surge fill target).',
    CONSTRAINT pk_recruitment_requisition PRIMARY KEY(`recruitment_requisition_id`)
) COMMENT 'Talent acquisition request record initiated when a position needs to be filled or a new position is created, capturing requisition number, linked position, hiring manager, target start date, recruitment type (internal, external, emergency surge), funding source confirmation, approval chain status, sourcing channels (internal posting, external job boards, UN job network, ReliefWeb), and time-to-fill tracking. Supports Ngos workforce planning and rapid surge recruitment for emergency responses.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`job_application` (
    `job_application_id` BIGINT COMMENT 'Unique system-generated identifier for each job application record in the Workday HCM recruitment module. Serves as the primary key for the job_application data product.',
    `candidate_id` BIGINT COMMENT 'Reference to the candidate (applicant) master record containing personal profile, contact details, and employment history. Enables tracking of a single individual across multiple applications.',
    `funding_source_id` BIGINT COMMENT 'Reference to the grant or funding source that will cover the salary and benefits of this position. Required for donor compliance, cost allocation, and BvA reporting in Unit4 ERP.',
    `intervention_id` BIGINT COMMENT 'Reference to the organisational program or project to which the position is assigned. Links workforce planning to program delivery and MEL frameworks.',
    `staff_member_id` BIGINT COMMENT 'Reference to the HR staff member or recruiter responsible for managing this application through the pipeline. Used for recruiter workload reporting and RACI accountability tracking.',
    `recruitment_requisition_id` BIGINT COMMENT 'Reference to the job requisition (open position) against which this application was submitted. Links the candidate pipeline to the approved headcount request.',
    `background_check_status` STRING COMMENT 'Status of the pre-employment background screening (criminal record, sanctions list, sexual exploitation and abuse registry checks). Mandatory for roles involving direct contact with beneficiaries under CHS and USAID partner vetting requirements.. Valid values are `not_required|pending|in_progress|cleared|failed|waived`',
    `candidate_type` STRING COMMENT 'Classifies whether the applicant is an external candidate, an internal staff member applying for a different role, a former employee (rehire), or a contractor being converted to staff. Affects onboarding workflow and background check requirements.. Valid values are `external|internal|rehire|contractor_conversion`',
    `cover_letter_reference` STRING COMMENT 'Storage path or document management system reference pointing to the candidates submitted cover letter. Supports recruiter review and competency-based screening.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp recording when the job application record was first created in Workday HCM. Supports audit trail, data lineage, and compliance with GDPR Article 5 accountability principle.',
    `cv_document_reference` STRING COMMENT 'Storage path or document management system reference (e.g., SharePoint URL, S3 URI) pointing to the candidates submitted CV or resume. Enables recruiters to retrieve the document without storing binary content in the lakehouse.',
    `job_application_date` DATE COMMENT 'Calendar date on which the candidate formally submitted the application. Used for time-to-hire calculations, pipeline aging analysis, and compliance reporting under OMB Uniform Guidance 2 CFR 200 equal-opportunity requirements.',
    `disability_disclosure` STRING COMMENT 'Whether the candidate has voluntarily disclosed a disability for the purpose of reasonable accommodation requests and equal-opportunity monitoring. Collected under GDPR Article 9 explicit consent and UK Equality Act 2010 requirements.. Valid values are `disclosed|not_disclosed|prefer_not_to_say`',
    `duty_station` STRING COMMENT 'Geographic location (city, country, or field office) where the role will be based. Critical for hardship allowance calculations, security risk assessment, and field operations staffing under OCHA and SPHERE standards.',
    `duty_station_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the duty station where the position is located. Supports geographic workforce analytics, visa/work permit tracking, and donor country-of-operation reporting.. Valid values are `^[A-Z]{3}$`',
    `gender_self_identified` STRING COMMENT 'Gender as self-reported by the candidate on the application form. Collected for equal-opportunity monitoring, gender-disaggregated workforce reporting, and donor diversity requirements (e.g., USAID Gender Policy, DFID Development Assistance Committee DAC gender markers).. Valid values are `male|female|non_binary|prefer_not_to_say|other`',
    `grant_funded_position` BOOLEAN COMMENT 'Indicates whether the position being applied for is funded by a specific donor grant rather than core/unrestricted organisational funds. Affects allowability review under OMB Uniform Guidance 2 CFR 200 and NICRA cost allocation.',
    `highest_education_level` STRING COMMENT 'Highest academic qualification attained by the candidate as declared on the application. Used for minimum qualification screening and workforce capability analytics. [ENUM-REF-CANDIDATE: secondary|bachelor|postgraduate_diploma|master|doctorate|professional_certification|other — 7 candidates stripped; promote to reference product]',
    `hiring_decision` STRING COMMENT 'Final hiring decision made by the selection committee for this application. Reserve list indicates the candidate was strong but the position was filled; they may be contacted for future vacancies.. Valid values are `selected|not_selected|reserve_list|pending`',
    `interview_date` DATE COMMENT 'Date on which the primary (or most recent) interview was conducted. Used for time-to-interview SLA tracking and scheduling analytics.',
    `interview_panel_notes` STRING COMMENT 'Free-text summary of interview panel observations, competency ratings, and recommendation rationale. Stored for audit, grievance, and equal-opportunity compliance purposes. Access restricted to HR and hiring managers.',
    `interview_score` DECIMAL(18,2) COMMENT 'Aggregate numeric score (0–100) from the structured interview panel, combining scores across competency dimensions. Supports merit-based selection and equal-opportunity compliance documentation.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages the candidate is proficient in, as declared on the application. Critical for field operations roles requiring local language capability and for INGO multi-country deployments.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the job application record in Workday HCM. Used for incremental data pipeline processing and change data capture in the Databricks Silver layer.',
    `nationality_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the candidates nationality. Required for work permit eligibility assessment, expatriate management, and national/international staff classification.. Valid values are `^[A-Z]{3}$`',
    `number` STRING COMMENT 'Human-readable, externally communicated reference number assigned to the application at submission (e.g., APP-2024-000123). Used in candidate correspondence, offer letters, and audit trails.. Valid values are `^APP-[0-9]{4}-[0-9]{6}$`',
    `offer_accepted_date` DATE COMMENT 'Date on which the candidate formally accepted the employment offer. Triggers onboarding workflow initiation in Workday HCM and Microsoft Dynamics 365.',
    `offer_extended_date` DATE COMMENT 'Date on which a formal employment offer was extended to the selected candidate. Used for time-to-offer KPI measurement and offer acceptance rate analytics.',
    `position_title` STRING COMMENT 'Official job title of the position being applied for as defined in the approved job requisition. Used in offer letters, employment contracts, and HRIS records.',
    `proposed_salary` DECIMAL(18,2) COMMENT 'Gross annual or monthly salary amount proposed in the offer letter, in the local or contract currency. Used for budget-versus-actual (BvA) analysis and grant-funded position cost allocation.',
    `proposed_start_date` DATE COMMENT 'Agreed or proposed date on which the candidate is expected to commence employment. Used for workforce planning, field deployment scheduling, and grant-funded position activation.',
    `reference_check_status` STRING COMMENT 'Current status of the professional reference verification process for this application. Reference checks are mandatory for senior and field security roles in most INGO HR policies.. Valid values are `not_started|in_progress|completed|waived|failed`',
    `rejection_reason` STRING COMMENT 'Standardised reason code or description explaining why the application was not progressed or the candidate was not selected. Required for equal-opportunity reporting and candidate feedback under CHS accountability standards. [ENUM-REF-CANDIDATE: overqualified|underqualified|failed_assessment|failed_interview|failed_background_check|position_cancelled|better_candidate_selected|withdrew|other — promote to reference product]',
    `safeguarding_check_status` STRING COMMENT 'Status of the safeguarding and child protection vetting check. Required for all roles with access to vulnerable populations including children, IDPs, and PoCs under CHS, SPHERE, and donor safeguarding policies.. Valid values are `not_required|pending|cleared|failed|waived`',
    `salary_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the proposed salary amount (e.g., USD, EUR, GBP, KES). Required for multi-currency payroll and donor financial reporting.. Valid values are `^[A-Z]{3}$`',
    `salary_grade` STRING COMMENT 'Compensation band or grade level assigned to the position (e.g., G5, P3, Band C). Aligns with the organisations pay scale framework and UN Common System salary grades for international staff.',
    `screening_score` DECIMAL(18,2) COMMENT 'Numeric score (0–100) assigned during the initial CV/application screening phase, reflecting how well the candidate meets the minimum qualifications and desirable criteria defined in the job requisition. Used for shortlisting decisions.',
    `source_channel` STRING COMMENT 'Channel or platform through which the candidate discovered and submitted the application. Supports sourcing effectiveness analysis and cost-per-hire reporting. ReliefWeb and UN Jobs are primary channels for INGO/NGO recruitment. [ENUM-REF-CANDIDATE: careers_portal|referral|linkedin|ngo_job_board|un_jobs|reliefweb|internal_transfer|recruitment_agency|walk_in|other — promote to reference product]',
    `staff_category` STRING COMMENT 'Workforce classification of the position being applied for. Distinguishes national staff, international staff, expatriates, consultants, and volunteers — critical for INGO payroll, tax treaty compliance, and donor reporting on staffing costs.. Valid values are `national_staff|international_staff|expatriate|consultant|volunteer`',
    `stage` STRING COMMENT 'Current stage of the candidate in the recruitment pipeline workflow (e.g., Applied, Screening, Assessment, Interview, Reference Check, Offer, Onboarding, Withdrawn, Rejected). Drives pipeline funnel analytics and recruiter workload dashboards. [ENUM-REF-CANDIDATE: Applied|Screening|Assessment|Interview|Reference Check|Offer|Onboarding|Withdrawn|Rejected — promote to reference product]',
    `stage_outcome` STRING COMMENT 'Result of the most recently completed pipeline stage for this application. Indicates whether the candidate advanced, was eliminated, withdrew, or is awaiting a decision at the current stage.. Valid values are `passed|failed|withdrawn|pending|on_hold|waived`',
    `job_application_status` STRING COMMENT 'Overall lifecycle status of the application record. Distinct from application_stage (which tracks pipeline position); this field reflects the terminal or current disposition of the entire application.. Valid values are `active|offer_extended|hired|rejected|withdrawn|on_hold`',
    `timestamp` TIMESTAMP COMMENT 'Precise date and time (with timezone offset) at which the application was received by the system. Supports SLA measurement, duplicate detection, and audit compliance.',
    `written_assessment_score` DECIMAL(18,2) COMMENT 'Numeric score (0–100) from a written technical or competency-based assessment administered to shortlisted candidates. Common in NGO recruitment for programme, finance, and MEL roles.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of relevant professional experience declared by the candidate on the application form. Used for minimum qualification screening and competency benchmarking.',
    CONSTRAINT pk_job_application PRIMARY KEY(`job_application_id`)
) COMMENT 'Candidate application record linked to a recruitment requisition, capturing applicant identity, application date, source channel, CV/resume reference, cover letter, application stage, stage outcome, interview scores, and final hiring decision. Tracks the full candidate pipeline from application to offer for both internal and external candidates.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique system-generated identifier for the performance review record. Primary key for the performance_review data product in the Workday HCM-sourced workforce domain.',
    `award_id` BIGINT COMMENT 'Reference to the primary grant funding the employees position during the review period. Supports donor-funded staff performance reporting requirements under USAID, DFID, CERF, and OMB Uniform Guidance 2 CFR 200.',
    `calibration_session_id` BIGINT COMMENT 'Reference to the talent calibration session in which this reviews rating was discussed and validated against peer employees. Ensures rating consistency and fairness across the organization.',
    `intervention_id` BIGINT COMMENT 'Reference to the primary humanitarian or development program to which the employee was assigned during the review period. Links performance outcomes to program results for RBM and donor reporting.',
    `performance_improvement_plan_id` BIGINT COMMENT 'Reference to the associated Performance Improvement Plan (PIP) record if one was initiated as a result of this review. Null if no PIP was required.',
    `position_id` BIGINT COMMENT 'Reference to the organizational position held by the employee at the time of the review, capturing role context for benchmarking and talent analytics.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member (reviewee) who is the subject of this performance review. Links to the employee master record in Workday HCM.',
    `review_template_id` BIGINT COMMENT 'Reference to the standardized performance review template used for this appraisal cycle, defining the competency framework, rating scales, and objective categories applied.',
    `reviewer_staff_member_id` BIGINT COMMENT 'Reference to the staff member (manager or designated reviewer) who conducted and submitted this performance review. Supports Results-Based Management (RBM) accountability chains.',
    `accountability_rating` STRING COMMENT 'Rating assessing the employees demonstrated accountability to affected populations and beneficiaries, a core CHS and HAP requirement for all humanitarian staff. Reflects adherence to feedback mechanisms and complaint handling.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `collaboration_rating` STRING COMMENT 'Rating for the collaboration and partnership competency, assessing the employees effectiveness in working across teams, with partner organizations (CSOs, CBOs, INGOs), and with beneficiary communities.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `competency_rating_score` DECIMAL(18,2) COMMENT 'Composite numeric score reflecting the employees average rating across all behavioral competencies assessed in the review (e.g., leadership, collaboration, accountability, humanitarian principles). Supports talent development analytics.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the performance review record was first created in the system (Workday HCM or the Databricks Silver Layer ingestion). Supports audit trail and data lineage requirements.',
    `cycle_type` STRING COMMENT 'Classification of the performance review cycle that this appraisal belongs to. Distinguishes annual appraisals, mid-year check-ins, probationary reviews, end-of-contract assessments, and ad hoc reviews triggered by specific events.. Valid values are `annual|mid_year|probation|end_of_contract|ad_hoc`',
    `development_recommendations` STRING COMMENT 'Structured recommendations from the reviewer for the employees professional development, including suggested training, mentoring, stretch assignments, or Learning Management System (LMS) courses to address identified gaps.',
    `due_date` DATE COMMENT 'The deadline by which the performance review must be completed and submitted by the reviewer. Used for HR compliance tracking and manager accountability reporting.',
    `duty_station` STRING COMMENT 'The geographic location (country, city, or field base) where the employee was deployed during the review period. Critical for field operations context, hardship allowance eligibility, and OCHA/USAID/BHA donor reporting.',
    `duty_station_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the country where the employee was stationed during the review period. Enables geographic workforce analytics and cross-country performance benchmarking.. Valid values are `^[A-Z]{3}$`',
    `employee_acknowledged` BOOLEAN COMMENT 'Indicates whether the employee has formally acknowledged the performance review in Workday HCM. Required for HR audit compliance and CHS accountability to affected populations standards.',
    `employee_acknowledged_date` DATE COMMENT 'The date on which the reviewed employee formally acknowledged receipt and review of their performance appraisal in Workday HCM. Required for HAP and CHS accountability compliance.',
    `employee_comments` STRING COMMENT 'Free-text comments submitted by the employee at the time of acknowledgment, capturing their response to the review outcome, including any disagreements, additional context, or commitments for the next period.',
    `employee_disagreement_flag` BOOLEAN COMMENT 'Indicates whether the employee formally disputed or disagreed with the performance review outcome. Triggers the HR grievance and appeals process in accordance with organizational HR policy and CHS accountability standards.',
    `employee_self_assessment` STRING COMMENT 'Free-text self-assessment narrative submitted by the employee prior to the review meeting, documenting their own perspective on achievements, challenges, and development needs during the review period.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when the performance review record was most recently modified in the system. Tracks the full edit history for audit compliance and data quality monitoring in the Databricks Silver Layer.',
    `leadership_rating` STRING COMMENT 'Rating for the leadership competency dimension, assessing the employees ability to guide teams, make decisions under pressure, and drive program outcomes in humanitarian field contexts.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `meeting_date` DATE COMMENT 'The date on which the formal performance review discussion meeting took place between the reviewer and the employee. Distinct from the submission date; required for CHS accountability documentation.',
    `next_review_date` DATE COMMENT 'The planned date for the employees next performance review or check-in, as agreed during the current review meeting. Supports proactive HR scheduling and talent management planning.',
    `number` STRING COMMENT 'Externally-visible, human-readable business identifier for the performance review record (e.g., PR-2024-000123). Used in HR correspondence, audit trails, and donor-funded program compliance reporting.. Valid values are `^PR-[0-9]{4}-[0-9]{6}$`',
    `objective_achievement_score` DECIMAL(18,2) COMMENT 'Composite percentage score (0–100) reflecting the degree to which the employee achieved their defined performance objectives during the review period. Derived from individual objective ratings in Workday HCM and used in RBM and LogFrame reporting.',
    `overall_rating` STRING COMMENT 'The holistic performance rating assigned to the employee for the review period, reflecting the reviewers consolidated assessment across all competencies and objectives. Drives talent retention, promotion, and RBM reporting decisions.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score corresponding to the overall performance rating on the configured rating scale (e.g., 1.00–5.00). Enables quantitative talent analytics, benchmarking, and Results-Based Management (RBM) reporting.',
    `period_end_date` DATE COMMENT 'The last day of the performance period being evaluated in this review. Together with review_period_start_date, defines the full appraisal window.',
    `period_start_date` DATE COMMENT 'The first day of the performance period being evaluated in this review. Defines the temporal boundary for objective achievement and behavioral observation.',
    `pip_required` BOOLEAN COMMENT 'Indicates whether a formal Performance Improvement Plan (PIP) has been recommended or initiated as a result of this review, typically triggered by an unsatisfactory or needs_improvement overall rating.',
    `promotion_recommendation` BOOLEAN COMMENT 'Indicates whether the reviewer recommends the employee for promotion or advancement to a higher grade or responsibility level based on this review cycles performance outcomes.',
    `rating_scale_version` STRING COMMENT 'Version identifier of the performance rating scale applied in this review (e.g., v2.1-2024). Ensures historical comparability as rating scales evolve over time.',
    `retention_risk_flag` BOOLEAN COMMENT 'Indicates whether the reviewer or HR has flagged this employee as at risk of leaving the organization, enabling proactive talent retention interventions. Supports NGO workforce stability in high-turnover humanitarian contexts.',
    `reviewer_narrative` STRING COMMENT 'Free-text qualitative narrative provided by the reviewer summarizing the employees performance, key achievements, areas for improvement, and behavioral observations during the review period. Confidential HR record.',
    `staff_category` STRING COMMENT 'Classification of the employees staff category at the time of the review. Distinguishes national staff, international staff, expatriates, consultants, and volunteers, which affects applicable HR policies, review templates, and donor reporting requirements.. Valid values are `national_staff|international_staff|expatriate|consultant|volunteer`',
    `performance_review_status` STRING COMMENT 'Current lifecycle state of the performance review workflow in Workday HCM. Tracks progression from draft through manager completion to employee acknowledgment and final closure.. Valid values are `draft|in_progress|pending_acknowledgment|completed|cancelled`',
    `submitted_date` DATE COMMENT 'The date on which the reviewer formally submitted the completed performance review in Workday HCM. Used to measure timeliness compliance against the review due date.',
    `technical_skills_rating` STRING COMMENT 'Rating for the employees technical competency relevant to their functional role (e.g., MEAL methodology, WASH engineering, GBV case management, financial stewardship, ICT4D). Supports targeted learning and development planning.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `values_alignment_rating` STRING COMMENT 'Rating assessing the degree to which the employee demonstrates alignment with the NGOs core organizational values and humanitarian principles (e.g., humanity, neutrality, impartiality, accountability). Critical for CHS compliance and organizational culture.. Valid values are `exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Formal performance appraisal record for a staff member covering a defined review period. Captures review cycle (annual, mid-year, probation), overall rating, competency ratings, objective achievement scores, reviewer identity, reviewee acknowledgment, and development recommendations. Supports Ngos talent retention and results-based management (RBM) culture.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` (
    `learning_enrollment_id` BIGINT COMMENT 'Unique system-generated identifier for each learning enrollment record. Serves as the primary key for the learning_enrollment data product in Workday HCM Learning module.',
    `intervention_id` BIGINT COMMENT 'Reference to the organizational program or project to which this training is linked. Enables allocation of training costs and capacity building efforts to specific grants or programs for donor reporting and Budget versus Actual (BvA) analysis.',
    `learning_course_id` BIGINT COMMENT 'Reference to the course catalog header record defining the learning activity. Links the enrollment line to the course master record containing title, provider, and content details.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member enrolled in the learning activity. Corresponds to the Workday Worker record for national staff, international staff, or expatriate personnel.',
    `actual_hours_spent` DECIMAL(18,2) COMMENT 'Actual number of hours the staff member spent on the course, as recorded in the Learning Management System (LMS). May differ from duration_hours for self-paced or blended courses. Used for staff capacity building analytics.',
    `attempt_number` STRING COMMENT 'Sequential number indicating which attempt this enrollment record represents for the staff member on this course. A value of 1 indicates the first attempt; values greater than 1 indicate retakes following a failed or incomplete prior attempt.',
    `certificate_number` STRING COMMENT 'Unique identifier of the certificate issued to the staff member upon successful course completion. Used for verification and audit purposes. Null if no certificate was issued.',
    `certification_expiry_date` DATE COMMENT 'Date on which the issued certification expires and the staff member must recertify. Applicable for time-bound certifications such as first aid, security, PSEA refreshers, and safeguarding. Null if the certification does not expire.',
    `completion_date` DATE COMMENT 'Date on which the staff member completed all required course activities. Null if the course has not yet been completed. Used for compliance reporting and certification issuance.',
    `completion_evidence_url` STRING COMMENT 'URL or document reference path to the digital evidence of course completion, such as a scanned certificate, attendance register, or e-learning completion screenshot stored in the document management system. Supports audit and compliance verification.',
    `cost_center_code` STRING COMMENT 'Chart of Accounts (CoA) cost center code to which the training cost is allocated in the General Ledger (GL). Supports fund accounting and grant financial management in SAP S/4HANA and Unit4 ERP.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the training was physically delivered. Used for geographic analysis of staff capacity building investments and field operations training coverage. Null for fully virtual or e-learning courses.. Valid values are `^[A-Z]{3}$`',
    `course_category` STRING COMMENT 'High-level classification of the course content area. Compliance covers mandatory regulatory courses (PSEA, CHS, safeguarding); technical_skills covers programmatic and operational competencies; leadership_development covers management and supervisory training; field_operations covers WASH, GBV response, NFI distribution, and humanitarian field protocols. [ENUM-REF-CANDIDATE: compliance|technical_skills|leadership_development|field_operations|safeguarding|security|health_safety|other — promote to reference product]',
    `course_title` STRING COMMENT 'Full descriptive title of the learning course or training activity as defined in the course catalog. Examples: Prevention of Sexual Exploitation and Abuse (PSEA) Awareness, Core Humanitarian Standard (CHS) Orientation, Field Security Management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for audit trail and data lineage in the Databricks Lakehouse silver layer.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the training_cost amount. Supports multi-currency operations across field offices in different countries.. Valid values are `^[A-Z]{3}$`',
    `learning_enrollment_date` DATE COMMENT 'Calendar date on which the staff member was registered or enrolled in the learning activity. Used for mandatory training deadline monitoring and compliance tracking.',
    `delivery_mode` STRING COMMENT 'Method by which the course content is delivered to the learner. e_learning: online self-paced modules; instructor_led: classroom or in-person facilitated; blended: combination of online and in-person; on_the_job: practical field-based learning; webinar: live virtual instructor-led; self_study: reading materials or independent study.. Valid values are `e_learning|instructor_led|blended|on_the_job|webinar|self_study`',
    `department_name` STRING COMMENT 'Name of the organizational department or unit to which the staff member belongs at the time of enrollment. Used for departmental training compliance reporting and capacity building analytics.',
    `due_date` DATE COMMENT 'Deadline by which the staff member must complete the course to remain compliant. Critical for mandatory compliance courses such as PSEA, CHS, safeguarding, and security training. Drives automated deadline monitoring and escalation workflows.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total number of hours required to complete the course as defined in the course catalog. Used for workforce capacity planning, learning hours reporting, and donor compliance reporting on staff development investments.',
    `is_certified` BOOLEAN COMMENT 'Indicates whether a formal certificate of completion or competency was issued to the staff member upon successful completion of the course. True when a certificate has been generated and recorded.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this course is a mandatory compliance requirement for the staff member. True for courses such as PSEA, CHS, safeguarding, security, and donor-mandated training. False for optional or elective learning activities.',
    `job_profile` STRING COMMENT 'Workday HCM job profile or role title of the staff member at the time of enrollment. Used to assess training coverage by role and to link mandatory training requirements to specific job profiles (e.g., Field Officer, Program Manager, Finance Officer).',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the enrollment record. Follows ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for incremental data loading, change data capture, and audit trail maintenance in the silver layer.',
    `pass_fail_status` STRING COMMENT 'Outcome of the staff members assessment or evaluation for the course. pass: met the minimum passing threshold; fail: did not meet the minimum threshold; not_applicable: no formal assessment required for this course type; pending_assessment: course completed but assessment result not yet recorded.. Valid values are `pass|fail|not_applicable|pending_assessment`',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum percentage score required to achieve a passing result for the course assessment. Defined at the course catalog level and copied to the enrollment for historical accuracy. Null if no scored assessment applies.',
    `provider_name` STRING COMMENT 'Name of the organization or individual responsible for delivering the course content. May be an internal team (e.g., HR, MEL unit), an external training provider, a UN agency, or an INGO partner. Examples: OCHA Training Unit, RedR International, Internal HR Learning Team.',
    `provider_type` STRING COMMENT 'Classification of the training provider. internal: delivered by the organizations own staff; external: commercial or independent training company; un_agency: United Nations body (e.g., OCHA, UNICEF); ingo_partner: another International Non-Governmental Organization (INGO); government: national or local government authority; academic: university or research institution.. Valid values are `internal|external|un_agency|ingo_partner|government|academic`',
    `required_frequency` STRING COMMENT 'Frequency at which the staff member is required to complete or refresh this course. once: one-time onboarding requirement; annual: yearly renewal (e.g., PSEA, security); biennial: every two years; quarterly: every three months; as_needed: triggered by role change or incident.. Valid values are `once|annual|biennial|quarterly|as_needed`',
    `score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the staff member on the course assessment or final evaluation, expressed as a percentage (0.00–100.00). Null if no formal scored assessment exists for the course.',
    `source` STRING COMMENT 'Indicates how the enrollment was initiated. self_enrolled: staff member registered independently; manager_assigned: direct supervisor assigned the course; hr_assigned: Human Resources (HR) team assigned as part of onboarding or compliance cycle; system_auto: automatically assigned by Workday HCM based on role or policy; donor_required: mandated by a donor or grant agreement.. Valid values are `self_enrolled|manager_assigned|hr_assigned|system_auto|donor_required`',
    `staff_type` STRING COMMENT 'Classification of the enrolled staff members employment category at the time of enrollment. Supports disaggregated reporting on training coverage across national staff, international staff, expatriates, volunteers, consultants, and interns as required by donor and regulatory reporting.. Valid values are `national_staff|international_staff|expatriate|volunteer|consultant|intern`',
    `start_date` DATE COMMENT 'Date on which the staff member began engaging with the course content. Distinct from enrollment_date; used to measure time-to-start and learning engagement metrics.',
    `learning_enrollment_status` STRING COMMENT 'Current lifecycle status of the staff members enrollment in the course. enrolled: registered but not yet started; in_progress: actively engaged in the course; completed: finished with pass or fail outcome; withdrawn: removed before completion; waived: exempted from mandatory requirement by authorized approver.. Valid values are `enrolled|in_progress|completed|failed|withdrawn|waived`',
    `training_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for the staff members enrollment in this training activity, in the organizations functional currency. Includes registration fees, materials, and direct delivery costs. Used for Budget versus Actual (BvA) reporting and grant financial management.',
    `training_location` STRING COMMENT 'Physical location or virtual platform where the training was delivered. For in-person training, records the city, country, or field office name. For virtual delivery, records the platform name (e.g., Zoom, Workday Learning, Moodle LMS). Null for fully self-paced e-learning.',
    `waiver_approved_by` STRING COMMENT 'Name or identifier of the authorized person who approved the training waiver. Required for audit trail and compliance accountability when a mandatory course is waived. Null for non-waived enrollments.',
    `waiver_reason` STRING COMMENT 'Documented justification for waiving a mandatory training requirement for this staff member. Required when enrollment_status is waived. Must be approved by an authorized HR or compliance officer. Null for non-waived enrollments.',
    CONSTRAINT pk_learning_enrollment PRIMARY KEY(`learning_enrollment_id`)
) COMMENT 'Record of a staff members enrollment in a learning or training activity, serving as SSOT for both the course catalog (course code, title, delivery mode, duration, provider, required frequency, content category) and individual enrollment instances (enrollment date, completion date, pass/fail status, certification issued, expiry date). Course catalog entries are header-level reference records; enrollments are line-level records per staff member per course. Covers mandatory compliance courses (PSEA, CHS, security, safeguarding), technical skills, leadership development, and field operations training. Supports compliance training tracking, mandatory training deadline monitoring, and staff capacity building.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`learning_course` (
    `learning_course_id` BIGINT COMMENT 'Unique surrogate identifier for each learning and development course record in the Workday HCM Learning module. Serves as the primary key for the learning_course data product.',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Identifies which LMS hosts each course. Essential for user access provisioning, course migration planning, vendor contract management, and integration with HR systems. Replaces denormalized platform_n',
    `org_unit_id` BIGINT COMMENT 'add column org_unit_id (BIGINT) with FK to workforce.org_unit.org_unit_id - learning courses are owned/managed by specific organizational units',
    `available_from_date` DATE COMMENT 'Date from which the course becomes available for enrollment in the Workday HCM Learning catalog. Used for scheduling new course launches, onboarding cohort planning, and compliance deadline management.',
    `available_until_date` DATE COMMENT 'Date after which the course is no longer available for new enrollments. Null for courses with no planned end date. Used to manage course retirement and transition to updated versions in the Workday HCM Learning catalog.',
    `certificate_validity_months` STRING COMMENT 'Number of months for which the course completion certificate or credential remains valid before recertification is required. Null if the certificate does not expire. Used to calculate recertification due dates and compliance status in Workday HCM.',
    `learning_course_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying the course in the Workday HCM Learning catalog and referenced in staff communications, compliance registers, and donor reporting (e.g., PSEA-001, CHS-FOUND-02). Serves as the BUSINESS_IDENTIFIER for this MASTER_RESOURCE entity.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `competency_framework` STRING COMMENT 'Name of the competency framework or standard to which this course is aligned (e.g., CHS Core Commitments, SPHERE Minimum Standards, IASC Gender Handbook, Ngo Internal Competency Framework, USAID CDCS). Enables skills gap analysis and results-based management (RBM) reporting.',
    `cost_per_learner` DECIMAL(18,2) COMMENT 'Estimated or actual cost in USD to deliver this course to one learner, including licensing, facilitation, materials, and platform fees. Used for budget planning, Budget versus Actual (BvA) analysis, and indirect cost rate (ICR/NICRA) calculations under OMB Uniform Guidance 2 CFR 200.',
    `cpe_credits` DECIMAL(18,2) COMMENT 'Number of Continuing Professional Education (CPE) or Continuing Education Unit (CEU) credits awarded upon successful completion of this course. Used for professional development tracking and external accreditation reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the course record was first created in the Workday HCM Learning system or the Databricks Silver Layer. Supports audit trail, data lineage, and compliance record-keeping requirements under OMB Uniform Guidance 2 CFR 200.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the cost_per_learner amount (e.g., USD, EUR, GBP). Defaults to USD for USAID-funded programs. Required for multi-currency financial reporting under SAP S/4HANA and OMB Uniform Guidance.. Valid values are `^[A-Z]{3}$`',
    `delivery_mode` STRING COMMENT 'Method by which the course content is delivered to learners. e_learning is self-paced online; classroom is in-person instructor-led; blended combines online and in-person; virtual_instructor_led is live online facilitation; on_the_job is practical field-based learning. Captured in Workday HCM Learning as the course format.. Valid values are `e_learning|classroom|blended|virtual_instructor_led|on_the_job|coaching`',
    `learning_course_description` STRING COMMENT 'Full narrative description of the course content, learning objectives, and intended outcomes as displayed in the Workday HCM Learning catalog. Helps staff and managers understand the course scope before enrollment.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total estimated time in hours required to complete the course, including all modules, assessments, and practical exercises. Used for staff workload planning, compliance tracking, and donor reporting on training investment. Serves as the principal MEASUREMENT_OR_VALUE for this MASTER_RESOURCE entity.',
    `external_accreditation` STRING COMMENT 'Name of the external body or standard that accredits or endorses this course (e.g., Sphere Association, CHS Alliance, ACNM, PMI, UNHCR). Null if the course is not externally accredited. Used for professional development reporting and donor compliance.',
    `fund_source` STRING COMMENT 'Classification of the funding source for this course, aligned to Ngos fund accounting structure. restricted_grant indicates the course is funded by a specific donor grant with reporting obligations; unrestricted indicates organizational core funding. Used for fund accounting in SAP S/4HANA and donor compliance reporting.. Valid values are `unrestricted|restricted_grant|donor_designated|internal_capacity_building`',
    `has_assessment` BOOLEAN COMMENT 'Indicates whether the course includes a formal assessment, quiz, or competency test that learners must pass to receive credit or certification. Drives pass/fail tracking in Workday HCM and compliance verification for mandatory courses.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this course is mandatory for all applicable staff at Ngo. Mandatory courses include PSEA, CHS, security awareness, and safeguarding as required by donors (USAID, DFID/FCDO), the Core Humanitarian Standard Alliance, and Ngos internal compliance policy. Drives automated assignment and compliance tracking in Workday HCM.',
    `issues_certificate` BOOLEAN COMMENT 'Indicates whether successful completion of this course results in the issuance of a formal certificate or credential to the learner. Relevant for professional development tracking, donor reporting, and staff file management.',
    `language` STRING COMMENT 'Primary language in which the course content is delivered, expressed as an ISO 639-1 two-letter or ISO 639-2 three-letter language code (e.g., en, fr, ar, es, sw). Critical for field staff accessibility in multilingual humanitarian operations.. Valid values are `^[a-z]{2,3}(-[A-Z]{2})?$`',
    `last_reviewed_date` DATE COMMENT 'Date on which the course content was last reviewed for accuracy, policy alignment, and relevance by the course owner or subject matter expert. Mandatory compliance courses (PSEA, CHS, safeguarding) must be reviewed at least annually per CHS Alliance and donor requirements.',
    `max_enrollment` STRING COMMENT 'Maximum number of learners that can be enrolled in a single offering or session of this course. Applicable primarily to classroom and virtual instructor-led delivery modes. Null for self-paced e-learning with unlimited capacity. Used for session scheduling and waitlist management.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next content review of this course. Drives content governance workflows and ensures mandatory compliance courses remain current with evolving CHS, PSEA, and donor policy requirements.',
    `owner` STRING COMMENT 'Name or identifier of the internal team or role responsible for maintaining and updating this course (e.g., Global L&D Team, HR Business Partner - Field Operations, Safeguarding Unit). Used for content governance, RACI assignment, and accountability tracking.',
    `passing_score` DECIMAL(18,2) COMMENT 'Minimum percentage score (0–100) required for a learner to pass the course assessment and receive completion credit. Applicable only when has_assessment is True. Used for compliance verification and certification issuance in Workday HCM.',
    `prerequisite_course_codes` STRING COMMENT 'Comma-separated list of course codes that must be completed before a learner can enroll in this course (e.g., PSEA-001,CHS-FOUND-01). Supports learning pathway design and enrollment eligibility enforcement in Workday HCM.',
    `provider_name` STRING COMMENT 'Name of the organization or internal unit responsible for developing and/or delivering the course (e.g., Ngo Internal L&D Team, UNHCR Learning, Sphere Association, RedR, Coursera for Nonprofits). Used for vendor management, cost allocation, and quality assurance.',
    `provider_type` STRING COMMENT 'Classification of the course provider by organizational type. Distinguishes internally developed courses from those sourced from UN agencies, peer INGOs, academic institutions, or commercial vendors. Used for procurement compliance under OMB Uniform Guidance 2 CFR 200 and donor reporting.. Valid values are `internal|external_ngo|un_agency|academic|commercial|government`',
    `recurrence_frequency` STRING COMMENT 'Required frequency at which staff must retake or recertify this course. once applies to foundational onboarding courses; annual applies to PSEA, security, and safeguarding refreshers; biennial applies to CHS and some technical courses. Drives recertification scheduling and compliance deadline tracking in Workday HCM.. Valid values are `once|annual|biennial|quarterly|as_needed`',
    `scorm_compliant` BOOLEAN COMMENT 'Indicates whether the e-learning course package is compliant with the Sharable Content Object Reference Model (SCORM) standard, enabling interoperability with Workday HCM and other SCORM-compatible LMS platforms. Relevant for e-learning and blended delivery modes.',
    `sdg_alignment` STRING COMMENT 'United Nations Sustainable Development Goal(s) to which this course contributes (e.g., SDG 3 Good Health, SDG 4 Quality Education, SDG 5 Gender Equality). Used for IATI reporting, donor narrative reporting, and organizational impact measurement aligned to the 2030 Agenda.',
    `short_description` STRING COMMENT 'Brief summary of the course (maximum 255 characters) used in catalog listings, automated assignment notifications, and mobile LMS displays. Complements the full description for space-constrained interfaces.',
    `staff_category` STRING COMMENT 'Specific staff employment category for which this course is applicable or required. Distinguishes between national staff, international/expatriate staff, volunteers, and contractors, reflecting Ngos workforce structure and donor compliance requirements. [ENUM-REF-CANDIDATE: all_staff|national_staff|international_staff|expatriate|volunteer|contractor|management — promote to reference product]',
    `learning_course_status` STRING COMMENT 'Current lifecycle status of the course in the Workday HCM Learning catalog. active means available for enrollment; draft means under development; archived means retired from active use but retained for historical records. Serves as the LIFECYCLE_STATUS for this MASTER_RESOURCE entity.. Valid values are `active|inactive|draft|archived|under_review`',
    `subject_area` STRING COMMENT 'Thematic subject area or competency domain the course addresses, aligned to Ngos learning taxonomy (e.g., Safeguarding, WASH, GBV Prevention, Financial Stewardship, MEL, Security Management, ICT4D, Leadership). Used for catalog browsing, skills gap analysis, and MEL reporting. Secondary CLASSIFICATION_OR_TYPE for this MASTER_RESOURCE entity.',
    `tags` STRING COMMENT 'Comma-separated keyword tags associated with the course for search and discovery in the Workday HCM Learning catalog (e.g., PSEA,safeguarding,mandatory,field_staff,GBV). Enhances catalog searchability and supports learning pathway recommendations.',
    `target_audience` STRING COMMENT 'Description of the intended staff population for this course (e.g., All Staff, Field Officers, Senior Management, Finance Staff, Community Health Workers, Expatriate Staff). Used for automated assignment rules in Workday HCM and workforce capability planning.',
    `title` STRING COMMENT 'Full human-readable title of the learning course as displayed in the Workday HCM Learning catalog and staff-facing portals (e.g., Prevention of Sexual Exploitation and Abuse (PSEA) Foundations, Core Humanitarian Standard (CHS) Awareness). Serves as the IDENTITY_LABEL for this MASTER_RESOURCE entity.',
    `learning_course_type` STRING COMMENT 'High-level classification of the course by its primary purpose within Ngos workforce development framework. mandatory_compliance covers PSEA, CHS, safeguarding, and security courses required by donors and regulators; technical_skills covers programmatic and operational competencies; field_operations covers WASH, GBV response, and humanitarian response protocols. Serves as the primary CLASSIFICATION_OR_TYPE for this MASTER_RESOURCE entity. [ENUM-REF-CANDIDATE: mandatory_compliance|technical_skills|leadership_development|field_operations|onboarding|health_safety|other — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the course record was most recently modified in the Workday HCM Learning system or the Databricks Silver Layer. Used for change tracking, incremental data loads, and audit compliance.',
    `url` STRING COMMENT 'Direct URL link to the course in the hosting LMS or external platform. Enables staff to access the course directly from HR portals, intranet pages, and automated assignment notifications.. Valid values are `^https?://.+`',
    `version_effective_date` DATE COMMENT 'Date from which the current version of the course content is effective and available for enrollment. Used to determine whether staff completions on prior versions remain valid for compliance purposes.',
    `version_number` STRING COMMENT 'Version identifier of the course content (e.g., 1.0, 2.3, 3.0.1). Tracks content revisions to ensure staff complete the most current version, particularly for mandatory compliance courses subject to policy updates (PSEA, CHS, safeguarding).. Valid values are `^d+.d+(.d+)?$`',
    CONSTRAINT pk_learning_course PRIMARY KEY(`learning_course_id`)
) COMMENT 'Catalog of learning and development courses available to Ngo staff, including mandatory compliance courses (PSEA, CHS, security, safeguarding), technical skills courses, leadership development, and field operations training. Captures course code, title, delivery mode (e-learning, classroom, blended), duration, provider, and required frequency.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique system-generated identifier for each leave request record in the Workday HCM system. Serves as the primary key for the leave_request data product.',
    `staff_member_id` BIGINT COMMENT 'Reference to the manager or HR officer responsible for approving or rejecting this leave request. Supports RACI role assignments and delegation of authority tracking.',
    `primary_leave_staff_member_id` BIGINT COMMENT 'Reference to the staff member submitting the leave request. Links to the employee master record in Workday HCM covering national staff, international staff, and expatriate personnel.',
    `actual_days_taken` DECIMAL(18,2) COMMENT 'Number of working days actually taken by the staff member. Populated upon return from leave and used to update leave balance entitlements. Supports half-day precision.',
    `actual_end_date` DATE COMMENT 'The actual date on which the staff member returned from leave. May differ from requested_end_date due to early return, extension, or operational recall.',
    `actual_start_date` DATE COMMENT 'The actual date on which the staff member commenced their approved leave. May differ from requested_start_date due to operational adjustments or late approvals.',
    `approval_status` STRING COMMENT 'Current workflow state of the leave request lifecycle in Workday HCM. Tracks progression from initial submission through managerial review to final decision or cancellation.. Valid values are `draft|pending|approved|rejected|cancelled|withdrawn`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the approver made the final approval or rejection decision on the leave request. Null if the request is still pending or in draft state.',
    `approver_comments` STRING COMMENT 'Free-text notes entered by the approving manager or HR officer when approving, rejecting, or modifying the leave request. Supports audit trail and communication.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the leave request was cancelled or withdrawn, either by the employee or by HR. Null if the request was not cancelled.',
    `carry_forward_days` DECIMAL(18,2) COMMENT 'Number of unused leave days carried forward from the previous leave year that are being applied to this request. Subject to organizational carry-forward policy limits.',
    `contract_type` STRING COMMENT 'The type of employment contract held by the staff member at the time of the leave request. Affects leave entitlement calculations and eligibility for certain leave types such as maternity/paternity.. Valid values are `fixed_term|open_ended|short_term|secondment|internship`',
    `cost_center_code` STRING COMMENT 'The organizational cost center code to which the staff members leave cost is charged. Used for fund accounting, grant financial management, and Budget versus Actual (BvA) reporting in SAP S/4HANA and Unit4 ERP.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the leave request record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `duty_station_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the staff members duty station at the time of the leave request. Determines applicable leave policy, public holiday calendar, and R&R eligibility for field staff.. Valid values are `^[A-Z]{3}$`',
    `emergency_contact_available` BOOLEAN COMMENT 'Indicates whether the staff member has confirmed they can be reached in an emergency during their leave period. Particularly relevant for field staff and humanitarian response contexts.',
    `entitlement_days` DECIMAL(18,2) COMMENT 'Total number of days the staff member is entitled to for the applicable leave type in the current leave year, as defined by their contract, grade, and duty station policy.',
    `handover_completed` BOOLEAN COMMENT 'Indicates whether the staff member has completed a formal handover of duties and responsibilities before commencing leave. Critical for field operations continuity and program delivery.',
    `is_retroactive` BOOLEAN COMMENT 'Indicates whether this leave request was submitted after the leave period had already commenced or concluded (retroactive entry). Flags exceptions for HR compliance review and audit.',
    `is_rnr_eligible` BOOLEAN COMMENT 'Indicates whether the staff member is eligible for Rest and Recuperation (R&R) leave based on their duty station hardship classification. True for staff posted to hardship or non-family duty stations per OCHA/UNDSS security phase criteria.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the leave request record, including status changes, date amendments, or approver updates.',
    `leave_balance_after` DECIMAL(18,2) COMMENT 'The staff members remaining leave balance (in days) for the applicable leave type after the leave has been taken and confirmed. Updated upon return from leave.',
    `leave_balance_before` DECIMAL(18,2) COMMENT 'The staff members available leave balance (in days) for the applicable leave type at the time the request was submitted. Enables entitlement validation and balance tracking.',
    `leave_destination_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the staff member will spend their leave. Required for R&R and annual leave for international/expatriate staff for security tracking and travel authorization.. Valid values are `^[A-Z]{3}$`',
    `leave_reason` STRING COMMENT 'Free-text description of the reason provided by the staff member for the leave request. May contain sensitive personal information (e.g., medical, family). Classified as confidential.',
    `leave_type` STRING COMMENT 'Classification of the leave being requested. Covers standard humanitarian workforce leave categories: Annual (vacation), Sick, Maternity/Paternity, Rest and Recuperation (R&R) for field staff, Compassionate (bereavement/family emergency), and Time Off In Lieu (TOIL) for overtime compensation.. Valid values are `annual|sick|maternity_paternity|rest_and_recuperation|compassionate|time_off_in_lieu`',
    `leave_year` STRING COMMENT 'The calendar or fiscal year to which this leave request applies (e.g., 2024). Used for annual entitlement tracking, carry-forward calculations, and year-end reporting.',
    `medical_certificate_received` BOOLEAN COMMENT 'Indicates whether the required medical certificate has been received and verified by HR. Relevant for sick leave requests where documentation is mandatory per organizational policy.',
    `medical_certificate_required` BOOLEAN COMMENT 'Indicates whether a medical certificate is required for this leave request based on leave type and duration policy (e.g., sick leave exceeding 3 consecutive days). Drives compliance workflow in Workday HCM.',
    `number` STRING COMMENT 'Externally visible, human-readable reference number assigned to the leave request (e.g., LR-2024-000123). Used in correspondence, approvals, and audit trails.. Valid values are `^LR-[0-9]{4}-[0-9]{6}$`',
    `program_code` STRING COMMENT 'Code identifying the program or project to which the staff members time is allocated during the leave period. Supports grant financial management and indirect cost rate (ICR/NICRA) calculations.',
    `rejection_reason` STRING COMMENT 'Structured or free-text reason provided by the approver when rejecting a leave request. Required for rejected requests to support employee relations and grievance management.',
    `requested_days` DECIMAL(18,2) COMMENT 'Number of working days requested for the leave period, as submitted by the employee. Supports half-day increments (e.g., 0.5). Excludes weekends and public holidays per the applicable country calendar.',
    `requested_end_date` DATE COMMENT 'The date the staff member has requested their leave to end (inclusive). Combined with requested_start_date to determine the requested duration.',
    `requested_start_date` DATE COMMENT 'The date the staff member has requested their leave to begin. Used for scheduling, coverage planning, and field rotation management.',
    `rnr_cycle_days` STRING COMMENT 'The number of days between R&R breaks applicable to the staff members duty station (e.g., 42 days, 56 days, 84 days). Determined by the hardship classification of the duty station.',
    `security_clearance_confirmed` BOOLEAN COMMENT 'Indicates whether the staff members travel to the leave destination has been cleared by the security team. Required for international staff and field personnel traveling to or from high-risk areas.',
    `staff_category` STRING COMMENT 'Classification of the staff members employment category at the time of the leave request. Determines applicable leave policy, entitlement rules, and R&R eligibility. National staff, international staff, and expatriates may have different leave frameworks.. Valid values are `national|international|expatriate|consultant|volunteer`',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when the staff member formally submitted the leave request in Workday HCM. Serves as the principal business event timestamp for the transaction lifecycle.',
    `supporting_document_ref` STRING COMMENT 'Reference number or file path to supporting documentation attached to the leave request (e.g., medical certificate for sick leave, death certificate for compassionate leave). Stored in the document management system.',
    `toil_hours_accrued` DECIMAL(18,2) COMMENT 'Number of overtime hours accrued by the staff member that are being converted to Time Off In Lieu (TOIL). Applicable only for TOIL leave type requests. Supports overtime compensation tracking.',
    `workday_leave_request_reference` STRING COMMENT 'The native leave request identifier from the Workday HCM source system. Enables traceability back to the system of record for reconciliation and audit purposes.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Staff leave request and approval record capturing leave type (annual, sick, maternity/paternity, R&R, compassionate, TOIL), requested start date, end date, number of days, approval status, approver, and actual dates taken. Tracks leave balances and entitlements per staff member and supports field rotation and R&R scheduling for humanitarian staff.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` (
    `workforce_staff_assignment_id` BIGINT COMMENT 'Unique system-generated identifier for each staff assignment record in Workday HCM. Serves as the primary key for the staff_assignment data product.',
    `award_id` BIGINT COMMENT 'Reference to the grant funding this assignment. Used for donor-compliant effort reporting and payroll cost allocation to the correct funding source per OMB Uniform Guidance 2 CFR 200.',
    `country_office_id` BIGINT COMMENT 'Reference to the geographic duty station or field office where the staff member is deployed for this assignment. Supports field operations tracking and hardship/hazard pay calculations.',
    `intervention_id` BIGINT COMMENT 'Reference to the humanitarian or development program to which the staff member is assigned. Enables program-level workforce planning and MEL accountability mapping.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Staff assignments to programs, projects, or grants should reference the organizational unit for proper cost allocation, reporting hierarchy, and matrix management visibility. While staff_assignment ha',
    `position_id` BIGINT COMMENT 'Reference to the organizational position or job profile associated with this assignment in Workday HCM. Determines the role title, grade, and compensation band applicable to the assignment.',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member record in the workforce master data. Links the assignment to the individual employee or contractor being assigned.',
    `project_site_id` BIGINT COMMENT 'Reference to the specific project or sub-component within a program to which the staff member is assigned. Supports project-level cost allocation and effort reporting.',
    `tertiary_workforce_approved_by_staff_member_id` BIGINT COMMENT 'Reference to the staff member (typically HR manager or program director) who approved this assignment in Workday HCM. Supports authorization audit trails and accountability documentation.',
    `approved_date` DATE COMMENT 'The date on which the staff assignment was formally approved through the Workday HCM business process workflow. Marks the transition from draft to active status and establishes the authorization audit trail.',
    `workforce_staff_assignment_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this staff assignment, used in donor reports, effort certification forms, and cross-system references (e.g., ASN-2024-WASH-001). Sourced from Workday HCM assignment reference number.. Valid values are `^ASN-[A-Z0-9]{4,12}$`',
    `contract_type` STRING COMMENT 'The type of employment contract governing this assignment. Determines applicable labor law protections, benefits eligibility, and termination procedures. fixed_term indicates a time-bound contract; open_ended indicates indefinite employment; short_term indicates assignments under 6 months.. Valid values are `fixed_term|open_ended|short_term|consultancy|secondment`',
    `cost_center_code` STRING COMMENT 'The organizational cost center code in the Chart of Accounts (CoA) to which this assignments payroll costs are allocated. Supports fund accounting, Budget versus Actual (BvA) reporting, and indirect cost rate (ICR/NICRA) calculations.. Valid values are `^CC-[A-Z0-9]{3,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this staff assignment record was first created in the data platform (Silver Layer). Supports audit trail, data lineage, and compliance with record-keeping requirements under OMB Uniform Guidance and IATI transparency standards.',
    `duty_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the staff member is deployed for this assignment (e.g., SSD for South Sudan, HTI for Haiti). Used for hardship classification, tax treaty application, and OCHA country-level reporting.. Valid values are `^[A-Z]{3}$`',
    `effort_certification_required` BOOLEAN COMMENT 'Indicates whether this assignment requires periodic effort certification by the staff member or supervisor (True), as mandated for federally-funded grants under OMB Uniform Guidance 2 CFR 200 §200.430. Drives the effort certification workflow in the GMS.',
    `effort_percent` DECIMAL(18,2) COMMENT 'The percentage of the staff members total working time allocated to this specific assignment, expressed as a decimal percentage (e.g., 50.00 for 50%). Must sum to 100% across all active assignments for a staff member. Critical for donor-compliant effort reporting and payroll cost allocation to grants per OMB Uniform Guidance 2 CFR 200 §200.430.',
    `end_date` DATE COMMENT 'The date on which the staff members assignment concludes. Nullable for open-ended assignments. Used to determine assignment duration, payroll allocation periods, and grant charge eligibility windows.',
    `fte_equivalent` DECIMAL(18,2) COMMENT 'The full-time equivalent value of this assignment, calculated as effort_percent / 100. For example, a 50% assignment equals 0.50 FTE. Used for workforce capacity planning, budget forecasting, and donor reporting on staffing levels.',
    `funding_source_type` STRING COMMENT 'Classification of the funding source underwriting this assignment. Determines applicable compliance requirements: federal_grant triggers OMB Uniform Guidance; bilateral_donor (e.g., USAID, DFID) triggers donor-specific reporting; cost_share indicates matching contribution. [ENUM-REF-CANDIDATE: federal_grant|private_grant|bilateral_donor|multilateral_donor|unrestricted_funds|cost_share — promote to reference product]. Valid values are `federal_grant|private_grant|bilateral_donor|multilateral_donor|unrestricted_funds|cost_share`',
    `grant_code` STRING COMMENT 'The donor-assigned grant or award code to which payroll costs for this assignment are charged. Used in the Chart of Accounts (CoA) for fund accounting and donor financial reporting. Aligns with the grant identifier in SAP S/4HANA and Unit4 ERP.. Valid values are `^[A-Z0-9-]{3,30}$`',
    `hardship_level` STRING COMMENT 'The UN/ICSC hardship classification level for the duty station of this assignment (A=normal; B=some hardship; C=hardship; D=extreme hardship; E=unaccompanied). Determines hardship allowance entitlements and R&R (Rest and Recuperation) schedules for international and expatriate staff.. Valid values are `A|B|C|D|E`',
    `is_cost_shared` BOOLEAN COMMENT 'Indicates whether the payroll costs for this assignment are shared across multiple grants or funding sources (True). When True, the effort_percent and grant_code fields define the primary allocation, and supplementary cost-share records exist for the remaining allocation.',
    `is_field_deployment` BOOLEAN COMMENT 'Indicates whether this assignment involves deployment to a field or humanitarian response location (True) as opposed to a headquarters or regional office posting (False). Used to trigger field-specific HR policies, security protocols, and allowance calculations.',
    `is_surge_deployment` BOOLEAN COMMENT 'Indicates whether this assignment is classified as a surge deployment in response to an acute humanitarian emergency (True). Surge deployments trigger expedited onboarding, emergency per diem rates, and OCHA SitRep staffing reporting.',
    `job_grade` STRING COMMENT 'The salary grade or band associated with this assignment, as defined in the organizations compensation framework. Used for budget planning, equity analysis, and donor reporting on staffing costs.',
    `job_title` STRING COMMENT 'The official job title of the staff member for this specific assignment, as recorded in Workday HCM. May differ from the staff members base position title if the assignment involves a temporary role upgrade or acting capacity.',
    `last_effort_certified_date` DATE COMMENT 'The date on which the most recent effort certification was completed and approved for this assignment. Used to track compliance with periodic effort reporting requirements under OMB Uniform Guidance and donor agreements.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or operational notes related to this staff assignment. May include information on acting capacity, special donor conditions, or field-specific requirements not captured in structured fields.',
    `raci_role` STRING COMMENT 'The RACI role assigned to the staff member for this program or project assignment. responsible indicates the person doing the work; accountable indicates the person ultimately answerable for outcomes; consulted indicates subject matter experts providing input; informed indicates stakeholders kept up to date. Supports accountability matrices and governance documentation.. Valid values are `responsible|accountable|consulted|informed`',
    `safeguarding_training_completed` BOOLEAN COMMENT 'Indicates whether the staff member has completed mandatory safeguarding and protection training prior to or during this assignment (True). Required by CHS Alliance Core Humanitarian Standard and donor compliance frameworks for all field deployments.',
    `security_clearance_level` STRING COMMENT 'The security clearance level required and held by the staff member for this assignment. Relevant for assignments in conflict-affected or high-security environments. classified indicates government-level clearance for assignments with bilateral donors such as USAID or DFID.. Valid values are `none|basic|enhanced|classified`',
    `staff_category` STRING COMMENT 'Classification of the staff members employment category for this assignment. Determines applicable HR policies, compensation structures, tax treatment, and donor reporting requirements. expatriate indicates internationally-recruited staff deployed outside home country; national_staff indicates locally-recruited personnel.. Valid values are `national_staff|international_staff|expatriate|consultant|volunteer|intern`',
    `start_date` DATE COMMENT 'The date on which the staff members assignment to the program, project, or field operation begins. Used for payroll cost allocation period calculations and effort reporting compliance.',
    `workforce_staff_assignment_status` STRING COMMENT 'Current lifecycle state of the staff assignment record. draft indicates pending approval; active indicates currently deployed; on_hold indicates temporarily suspended; completed indicates successfully concluded; cancelled indicates terminated before completion.. Valid values are `draft|active|on_hold|completed|cancelled`',
    `tdy_purpose` STRING COMMENT 'Description of the business purpose for a Temporary Duty (TDY) assignment, such as emergency response support, capacity building mission, or program assessment. Required for TDY travel authorization and donor reporting. Applicable only when assignment_type = tdy.',
    `workforce_staff_assignment_type` STRING COMMENT 'Classification of the nature of the staff assignment. primary indicates the main assignment; secondary indicates a concurrent partial assignment; surge_deployment indicates emergency response deployment; tdy (Temporary Duty) indicates short-term field deployment; secondment indicates inter-agency placement; consultant indicates contracted technical assistance.. Valid values are `primary|secondary|surge_deployment|tdy|secondment|consultant`',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this staff assignment record was most recently modified in the data platform. Used for change tracking, incremental data loads, and audit compliance.',
    `workday_assignment_ref` STRING COMMENT 'The source system reference identifier for this assignment record in Workday HCM. Enables traceability back to the system of record for reconciliation, audit, and data lineage purposes.',
    CONSTRAINT pk_workforce_staff_assignment PRIMARY KEY(`workforce_staff_assignment_id`)
) COMMENT 'Record of a staff members assignment to a specific program, project, grant, or field operation, capturing assignment type (primary, secondary, surge deployment, TDY/temporary duty), percentage of time allocated, funding source (grant code), duty station, start date, end date, and RACI role (Responsible, Accountable, Consulted, Informed). Enables time-based payroll cost allocation to grants, supports donor-compliant effort reporting, and tracks RACI role assignments across programs for accountability matrices.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`expat_package` (
    `expat_package_id` BIGINT COMMENT 'Unique system-generated identifier for the expatriate compensation and benefits package record. Primary key for this entity.',
    `award_id` BIGINT COMMENT 'Foreign key linking to grant.award. Business justification: NGOs track which grant funds expatriate packages (housing, hardship, relocation allowances) for cost allocation and donor reporting on international staff costs. Essential for grant budget management ',
    `employment_contract_id` BIGINT COMMENT 'Foreign key linking to workforce.employment_contract. Business justification: Expatriate packages are contractual obligations tied to specific employment contracts. The package terms (hardship allowances, home leave entitlements, R&R cycles, housing provisions) are negotiated a',
    `position_id` BIGINT COMMENT 'Reference to the organizational position associated with this expatriate package, used to determine applicable salary scale and allowance tiers.',
    `staff_member_id` BIGINT COMMENT 'Reference to the internationally-recruited staff member to whom this expatriate package applies. Links to the employee master record in Workday HCM.',
    `approval_date` DATE COMMENT 'Date on which the expatriate package was formally approved by the authorized approver. Used for compliance documentation and audit purposes.',
    `approval_status` STRING COMMENT 'Current approval workflow status of the expatriate package. pending indicates awaiting review; approved indicates authorized by HR and finance; rejected indicates not approved; under_review indicates additional scrutiny required.. Valid values are `pending|approved|rejected|under_review`',
    `assignment_end_date` DATE COMMENT 'Date on which the expatriates international assignment and this compensation package are scheduled to end. Nullable for open-ended assignments. Drives repatriation planning and benefit cessation.',
    `assignment_start_date` DATE COMMENT 'Date on which the expatriates international assignment and this compensation package become effective. Marks the beginning of entitlement to expatriate benefits.',
    `base_salary_amount` DECIMAL(18,2) COMMENT 'Annual gross base salary for the expatriate staff member in the package currency, exclusive of allowances and benefits. Used for BvA (Budget versus Actual) reporting and grant financial management.',
    `expat_package_code` STRING COMMENT 'Externally-known alphanumeric code uniquely identifying this expatriate package record, used in HR correspondence, payroll systems, and audit documentation.. Valid values are `^EXP-[A-Z0-9]{4,12}$`',
    `cost_center_code` STRING COMMENT 'GL (General Ledger) cost center code to which the expatriate package costs are charged in the fund accounting system. Enables BvA (Budget versus Actual) reporting and grant financial management.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this expatriate package record was first created in the data platform. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which the expatriate package amounts are denominated (e.g., USD, EUR, GBP). Governs all monetary fields in this record.. Valid values are `^[A-Z]{3}$`',
    `dependents_covered` BOOLEAN COMMENT 'Indicates whether the health insurance and applicable benefits under this package extend to the expatriates eligible dependents (spouse/partner and children) accompanying them to the duty station.',
    `duty_station_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the expatriate is deployed and this package is applicable. Drives hardship tier, cost-of-living adjustments, and applicable allowances.. Valid values are `^[A-Z]{3}$`',
    `duty_station_name` STRING COMMENT 'Name of the specific duty station or field office location where the expatriate is posted (e.g., Nairobi, Juba, Kabul). Used for operational reporting and SitRep (Situation Report) alignment.',
    `education_allowance_amount` DECIMAL(18,2) COMMENT 'Annual monetary value of the education allowance for dependent children of the expatriate, covering school fees and related educational costs. Applicable only when the expatriate has eligible dependents accompanying them to the duty station.',
    `effective_from_date` DATE COMMENT 'Date from which this specific version of the expatriate package is binding and in effect. May differ from assignment_start_date when a package is revised mid-assignment.',
    `effective_to_date` DATE COMMENT 'Date on which this specific version of the expatriate package ceases to be in effect. Nullable for the current active version. Supports bi-temporal tracking of package changes.',
    `employer_pension_contribution_pct` DECIMAL(18,2) COMMENT 'Percentage of base salary contributed by the organization to the expatriates pension or retirement savings scheme. Used for total compensation costing and grant budget allocation.',
    `grant_code` STRING COMMENT 'Code of the grant or funding source against which this expatriate package cost is allocated. Supports donor reporting, IATI (International Aid Transparency Initiative) compliance, and grant financial management.',
    `hardship_allowance_amount` DECIMAL(18,2) COMMENT 'Annual monetary value of the hardship allowance payable to the expatriate, calculated based on the hardship_allowance_tier and base salary. Compensates staff for difficult living and working conditions at the duty station.',
    `hardship_allowance_tier` STRING COMMENT 'UN/ICSC-aligned hardship classification tier for the duty station, ranging from H (headquarters/no hardship) through A–E (increasing hardship levels). Determines the hardship allowance percentage applied to base salary.. Valid values are `H|A|B|C|D|E`',
    `health_insurance_plan` STRING COMMENT 'Name or code of the international health insurance plan covering the expatriate and eligible dependents, typically provided through a group scheme (e.g., Cigna Global, Aetna International, BUPA International).',
    `home_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the expatriates home country, used for home leave travel entitlement, tax equalization, and repatriation planning.. Valid values are `^[A-Z]{3}$`',
    `home_leave_cycle_months` STRING COMMENT 'Duration in months of the home leave cycle, i.e., how frequently the expatriate is entitled to take home leave (e.g., every 12 or 24 months). Determines the frequency of home leave travel entitlement.',
    `home_leave_entitlement_days` STRING COMMENT 'Number of paid home leave days the expatriate is entitled to per leave cycle, allowing return to their home country for rest and family contact. Distinct from annual leave and R&R (Rest and Recuperation) leave.',
    `housing_allowance_amount` DECIMAL(18,2) COMMENT 'Annual monetary value of the housing allowance provided to the expatriate to cover accommodation costs at the duty station. May be paid directly or as a cash allowance depending on organizational policy.',
    `housing_provision_type` STRING COMMENT 'Method by which housing is provided to the expatriate: cash_allowance means a monetary payment; org_provided means the organization arranges and pays for accommodation directly; shared_accommodation means staff share organization-managed housing; not_applicable for cases where housing is not part of the package.. Valid values are `cash_allowance|org_provided|shared_accommodation|not_applicable`',
    `icr_rate_pct` DECIMAL(18,2) COMMENT 'The ICR (Indirect Cost Rate) or F&A (Facilities and Administration) rate applied to this expatriate package for grant cost recovery purposes, as defined in the organizations NICRA (Negotiated Indirect Cost Rate Agreement) with the US government or equivalent donor agreement.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this expatriate package record was most recently modified in the data platform. Supports change tracking, bi-temporal analysis, and compliance auditing.',
    `max_eligible_dependents` STRING COMMENT 'Maximum number of dependent children eligible for the education allowance under this package, as defined by organizational policy and applicable salary scale rules.',
    `medevac_coverage_level` STRING COMMENT 'Level of medical evacuation coverage included in the expatriate package. basic covers emergency evacuation to nearest adequate facility; standard includes regional evacuation; enhanced includes international evacuation; critical_care includes full repatriation with specialist care.. Valid values are `basic|standard|enhanced|critical_care`',
    `pension_scheme` STRING COMMENT 'Name or code of the pension or retirement savings scheme applicable to the expatriate under this package (e.g., UN Joint Staff Pension Fund, organizational defined contribution plan). Governs employer and employee contribution rates.',
    `relocation_allowance_amount` DECIMAL(18,2) COMMENT 'One-time monetary allowance provided to the expatriate to cover costs associated with relocating to the duty station, including shipping of personal effects, travel, and settling-in expenses.',
    `repatriation_allowance_amount` DECIMAL(18,2) COMMENT 'One-time monetary allowance provided to the expatriate upon end of assignment to cover costs of returning to their home country, including shipping and travel expenses.',
    `rnr_cycle_days` STRING COMMENT 'Number of days in the R&R (Rest and Recuperation) cycle applicable to this package. Defines how frequently the expatriate is entitled to R&R breaks from hardship duty stations. Typically 6, 8, or 12 weeks depending on hardship tier.',
    `salary_grade` STRING COMMENT 'The grade or band within the applicable salary scale assigned to this expatriate position (e.g., P3, G6, Band D). Determines base salary range and step progression.',
    `salary_scale` STRING COMMENT 'The applicable salary scale framework governing base compensation for this expatriate, e.g., UN Common System, organizational scale, ICSC (International Civil Service Commission) scale, or donor-mandated scale. [ENUM-REF-CANDIDATE: un_common_system|organizational_scale|icsc_scale|ngo_network_scale|donor_mandated — promote to reference product]',
    `salary_step` STRING COMMENT 'The step within the salary grade reflecting years of experience and incremental progression (e.g., Step 1, Step 5). Used in conjunction with salary_grade to determine exact base salary.',
    `expat_package_status` STRING COMMENT 'Current lifecycle state of the expatriate package. draft indicates pending approval; active indicates currently in effect; suspended indicates temporarily paused; terminated indicates ended before natural expiry; expired indicates reached end date.. Valid values are `draft|active|suspended|terminated|expired`',
    `tax_equalization_applicable` BOOLEAN COMMENT 'Indicates whether a tax equalization policy applies to this expatriate package, ensuring the staff member pays no more or less tax than they would in their home country. Common for internationally-recruited staff on global mobility assignments.',
    `tax_equalization_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the home country used as the reference jurisdiction for tax equalization calculations. Determines the hypothetical tax liability benchmark.. Valid values are `^[A-Z]{3}$`',
    `expat_package_type` STRING COMMENT 'Classification of the expatriate package by deployment context. standard applies to normal international postings; hardship applies to high-risk or difficult duty stations; emergency applies to rapid-onset humanitarian response deployments; transitional applies to staff in between postings.. Valid values are `standard|hardship|emergency|transitional`',
    `workday_package_reference` STRING COMMENT 'Source system identifier for this expatriate package record in Workday HCM, used for data lineage, reconciliation, and integration with the HRIS (Human Resource Information System).',
    CONSTRAINT pk_expat_package PRIMARY KEY(`expat_package_id`)
) COMMENT 'Expatriate compensation and benefits package record for internationally-recruited staff, capturing hardship allowance tier, housing allowance, education allowance for dependents, home leave entitlement, relocation allowance, medical evacuation coverage level, and applicable INGO salary scale (e.g., UN common system, organizational scale). Distinct from national staff compensation.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` (
    `disciplinary_case_id` BIGINT COMMENT 'Unique system-generated identifier for the disciplinary, grievance, or safeguarding investigation case record in the Workday HCM and case management system.',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Disciplinary cases are often compliance incidents (fraud, misconduct, safeguarding violations requiring donor/regulatory reporting). Links HR disciplinary process to compliance incident management for',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who is the subject of the disciplinary or safeguarding case. Links to the employee master record in Workday HCM.',
    `safeguarding_incident_id` BIGINT COMMENT 'add column safeguarding_incident_id (BIGINT) with FK to safeguarding.safeguarding_incident.safeguarding_incident_id - disciplinary cases often originate from safeguarding incidents and this critical link is missing',
    `tertiary_disciplinary_investigator_staff_member_id` BIGINT COMMENT 'Reference to the staff member or external investigator assigned as the lead investigator for the case. May be an internal HR/legal officer or an externally contracted investigator for PSEA/SEA cases.',
    `appeal_date` DATE COMMENT 'The date on which the subject employee formally lodged an appeal against the investigation outcome or sanction. Null if no appeal was filed.',
    `appeal_resolution_date` DATE COMMENT 'The date on which the appeal was formally resolved and a final determination was communicated to the subject employee. Null if no appeal was filed or appeal is still pending.',
    `appeal_status` STRING COMMENT 'Current status of any appeal lodged by the subject employee against the investigation outcome or sanction applied. Tracks whether an appeal has been filed, is pending review, or has been resolved.. Valid values are `not_appealed|appeal_pending|appeal_upheld|appeal_dismissed|appeal_withdrawn`',
    `authority_referral_date` DATE COMMENT 'The date on which the case was formally referred to external law enforcement or regulatory authorities. Null if no referral was made.',
    `beneficiary_involved` BOOLEAN COMMENT 'Flag indicating whether the alleged incident involved a program beneficiary, Person of Concern (PoC), or Internally Displaced Person (IDP) as a victim or witness. Cases involving beneficiaries trigger heightened safeguarding protocols and mandatory PSEA reporting.',
    `charity_commission_reported` BOOLEAN COMMENT 'Flag indicating whether this case was reported to the Charity Commission (UK) as a Serious Incident, as required for registered UK charities when incidents involve significant harm, financial loss, or reputational risk.',
    `chs_commitment_reference` STRING COMMENT 'The specific CHS (Core Humanitarian Standard) commitment number(s) relevant to this case, used for CHS verification and accountability reporting. Typically Commitment 5 (Complaints and Feedback) or Commitment 6 (Coordination).',
    `closed_date` DATE COMMENT 'The date on which the disciplinary case was formally closed, including completion of any sanctions, appeals, or referrals. Distinct from investigation_end_date as post-investigation actions may extend the case.',
    `complainant_type` STRING COMMENT 'Classification of how the complaint or allegation was submitted, indicating whether the complainant is anonymous, named, self-referred, a third party, or referred by management. Informs confidentiality protocols and investigation approach.. Valid values are `anonymous|named|self_referral|third_party|management_referral`',
    `confidentiality_level` STRING COMMENT 'The designated confidentiality classification of this case record, determining access controls and information sharing protocols. PSEA/SEA cases are typically strictly confidential with access limited to named individuals.. Valid values are `strictly_confidential|confidential|restricted`',
    `contract_type` STRING COMMENT 'The type of employment contract held by the subject employee at the time of the case. Determines applicable disciplinary procedures, notice periods, and legal obligations.. Valid values are `permanent|fixed_term|consultancy|secondment|volunteer`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this disciplinary case record was first created in the data platform. Used for audit trail and data lineage purposes.',
    `donor_report_reference` STRING COMMENT 'The reference number or tracking code assigned by the donor or funding body upon receipt of the mandatory incident report. Used for cross-referencing with grant management and compliance records.',
    `donor_report_submitted_date` DATE COMMENT 'The date on which the mandatory donor incident report was submitted to the relevant funding body. Null if no donor report is required or has not yet been submitted. Used to track compliance with donor reporting deadlines.',
    `duty_station_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the duty station where the subject employee was deployed at the time of the alleged incident. Used for geographic analysis of safeguarding trends and country-level compliance reporting.. Valid values are `^[A-Z]{3}$`',
    `incident_date` DATE COMMENT 'The date on which the alleged misconduct, violation, or incident is reported to have occurred. May differ from the case opened date if there was a reporting delay.',
    `investigation_end_date` DATE COMMENT 'The date on which the formal investigation was concluded and findings were documented. Used to calculate investigation duration and compliance with timeliness standards.',
    `investigation_findings_summary` STRING COMMENT 'A concise narrative summary of the key findings from the investigation, documenting evidence reviewed, witness accounts, and the basis for the investigation outcome determination.',
    `investigation_outcome` STRING COMMENT 'The formal finding of the investigation indicating whether the allegation was substantiated (proven), unsubstantiated (not proven), inconclusive (insufficient evidence), withdrawn by complainant, or closed with no further action.. Valid values are `substantiated|unsubstantiated|inconclusive|withdrawn|no_further_action`',
    `investigation_start_date` DATE COMMENT 'The date on which the formal investigation commenced, following case registration and initial triage. Used to measure investigation timeliness against CHS and donor-mandated SLA targets.',
    `irs_form_990_reportable` BOOLEAN COMMENT 'Flag indicating whether this disciplinary case involves a matter that must be disclosed on IRS Form 990 (e.g., diversion of assets, fraud, or governance failures) for US-registered 501(c)(3) organizations.',
    `is_external_investigator` BOOLEAN COMMENT 'Flag indicating whether the investigation was conducted by an external independent investigator rather than internal HR or legal staff. External investigators are typically required for PSEA/SEA cases or senior staff misconduct.',
    `is_mandatory_donor_report_required` BOOLEAN COMMENT 'Flag indicating whether this case triggers a mandatory donor incident reporting obligation to a funding body such as USAID (BHA), DFID, CERF, or other institutional donors per grant agreement terms.',
    `is_psea_case` BOOLEAN COMMENT 'Flag indicating whether this case involves a Prevention of Sexual Exploitation and Abuse (PSEA) or Sexual Exploitation and Abuse (SEA) allegation, triggering mandatory donor incident reporting obligations under USAID, DFID, and OCHA protocols.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this disciplinary case record was most recently modified in the data platform. Supports change tracking, audit compliance, and incremental data pipeline processing.',
    `opened_date` DATE COMMENT 'The date on which the formal disciplinary or safeguarding case was officially opened and registered in the case management system. This is the principal business event date for the case lifecycle.',
    `priority` STRING COMMENT 'The priority level assigned to the case at intake, reflecting urgency of investigation based on severity of allegation, vulnerability of parties involved, and operational risk. Critical priority cases (e.g., PSEA involving beneficiaries) require immediate escalation.. Valid values are `critical|high|medium|low`',
    `program_code` STRING COMMENT 'The program or project code associated with the duty station or operational context in which the incident occurred. Used to link disciplinary cases to program accountability and MEL (Monitoring Evaluation and Learning) reporting.',
    `reference_number` STRING COMMENT 'Externally-known unique alphanumeric reference code assigned to the disciplinary case at initiation, used in all correspondence, donor incident reports, and regulatory filings. Format: [ORG_CODE]-DISC-[YEAR]-[SEQUENCE].. Valid values are `^[A-Z]{2,6}-DISC-[0-9]{4}-[0-9]{4,6}$`',
    `referred_to_authorities` BOOLEAN COMMENT 'Flag indicating whether the case was referred to external law enforcement, national authorities, or regulatory bodies (e.g., Charity Commission UK, IRS, local police) as part of the disciplinary outcome.',
    `sanction_applied` STRING COMMENT 'The disciplinary sanction or corrective action applied to the subject employee following a substantiated investigation outcome. Null if outcome is unsubstantiated or inconclusive. [ENUM-REF-CANDIDATE: verbal_warning|written_warning|final_written_warning|suspension|termination|referral_to_authorities|demotion|mandatory_training|no_sanction — promote to reference product]. Valid values are `verbal_warning|written_warning|final_written_warning|suspension|termination|referral_to_authorities`',
    `staff_category` STRING COMMENT 'Employment category of the subject employee at the time of the case, distinguishing between international staff, national staff, expatriates, consultants, volunteers, and interns. Affects applicable HR policies and legal jurisdiction.. Valid values are `international_staff|national_staff|expatriate|consultant|volunteer|intern`',
    `disciplinary_case_status` STRING COMMENT 'Current lifecycle state of the disciplinary case workflow, from initial opening through investigation, outcome determination, appeal, and final closure.. Valid values are `open|under_investigation|pending_outcome|closed|appealed|referred_to_authorities`',
    `summary` STRING COMMENT 'A concise narrative description of the allegation or complaint, capturing the nature of the incident, parties involved, and context. Restricted to authorized HR, legal, and senior management personnel.',
    `suspension_end_date` DATE COMMENT 'The date on which the employee suspension ended, either through reinstatement, termination, or case resolution. Null when no suspension was applied.',
    `suspension_start_date` DATE COMMENT 'The date on which a precautionary or punitive suspension of the subject employee commenced, if applicable. Null when no suspension was applied.',
    `disciplinary_case_type` STRING COMMENT 'Classification of the disciplinary case by the nature of the alleged violation. PSEA/SEA (Prevention of Sexual Exploitation and Abuse) violations are subject to mandatory donor reporting under USAID and DFID requirements. [ENUM-REF-CANDIDATE: misconduct|psea_sea_violation|fraud|harassment|bullying|performance|whistleblower_retaliation|conflict_of_interest|data_breach — promote to reference product]. Valid values are `misconduct|psea_sea_violation|fraud|harassment|bullying|performance`',
    `workday_case_reference` STRING COMMENT 'The source system identifier for this disciplinary case record in Workday HCM, used for data lineage, reconciliation, and integration with the HRIS system of record.',
    CONSTRAINT pk_disciplinary_case PRIMARY KEY(`disciplinary_case_id`)
) COMMENT 'Record of a formal disciplinary, grievance, or safeguarding investigation case involving a staff member. Captures case type (misconduct, PSEA/SEA violation, fraud, harassment, bullying, performance), case reference number, complainant type (anonymous, named, self-referral), investigation start and end dates, investigator assignment, investigation outcome, sanctions applied (warning, suspension, termination, referral to authorities), appeal status, and case closure date. Supports CHS (Core Humanitarian Standard) accountability obligations, IASC safeguarding compliance, and mandatory donor incident reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`separation_event` (
    `separation_event_id` BIGINT COMMENT 'Unique system-generated identifier for each staff separation event record in Workday HCM. Primary key for the separation_event data product.',
    `user_account_id` BIGINT COMMENT 'Foreign key linking to technology.user_account. Business justification: Links separation events to deprovisioned user accounts. Security and compliance requirement for audit trails, access control verification, and demonstrating timely account deactivation. Critical for d',
    `position_id` BIGINT COMMENT 'Reference to the organizational position being vacated as a result of this separation event, used for workforce planning and backfill tracking.',
    `primary_separation_staff_member_id` BIGINT COMMENT 'Reference to the staff member who is separating from Ngo. Links to the employee master record in Workday HCM.',
    `separation_staff_member_id` BIGINT COMMENT 'add column staff_member_id (BIGINT) with FK to workforce.staff_member.staff_member_id - separation_event already has this but verify; the table must also link to safeguarding outcomes',
    `staff_member_id` BIGINT COMMENT '',
    `disciplinary_outcome_id` BIGINT COMMENT '',
    `approval_date` DATE COMMENT 'The date on which the separation event was formally approved by the authorized HR approver in Workday HCM.',
    `asset_return_completed` BOOLEAN COMMENT 'Indicates whether the departing staff member has returned all Ngo assets (laptop, phone, ID card, vehicle keys, field equipment) prior to or on the effective separation date.',
    `contract_type` STRING COMMENT 'The type of employment contract held by the staff member at the time of separation. Determines applicable notice periods, severance entitlements, and end-of-service benefit calculations.. Valid values are `fixed_term|open_ended|consultancy|secondment|volunteer`',
    `cost_center_code` STRING COMMENT 'The financial cost center code associated with the staff members position at the time of separation. Used for allocating separation costs (severance, PILON) to the correct budget line in SAP S/4HANA fund accounting.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the separation event record was first created in the system. Supports audit trail, data lineage, and Silver layer ingestion tracking in the Databricks Lakehouse.',
    `department_code` STRING COMMENT 'The organizational department or cost center code to which the staff member was assigned at the time of separation. Used for departmental attrition reporting and budget impact analysis.',
    `duty_station_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the duty station where the staff member was deployed at the time of separation. Supports geographic attrition analysis and repatriation cost tracking for international staff.. Valid values are `^[A-Z]{3}$`',
    `effective_date` DATE COMMENT 'The official date on which the staff members employment with Ngo ends. Used as the principal business event date for payroll cutoff, benefit termination, access revocation, and regulatory reporting.',
    `exit_interview_conducted_by` STRING COMMENT 'Name or role of the HR staff member or manager who conducted the exit interview. Supports accountability tracking for the offboarding process.',
    `exit_interview_date` DATE COMMENT 'The date on which the exit interview was conducted with the departing staff member. Null if exit interview was not completed or not required.',
    `exit_interview_status` STRING COMMENT 'Tracks the completion status of the exit interview process for the departing staff member. Exit interview data feeds talent retention analysis and MEL (Monitoring Evaluation and Learning) workforce indicators.. Valid values are `not_required|pending|scheduled|completed|declined`',
    `final_settlement_amount` DECIMAL(18,2) COMMENT 'The total gross monetary amount paid to the staff member as part of the final settlement, including severance pay, payment in lieu of notice (PILON), accrued leave encashment, and end-of-service gratuity. Expressed in the settlement currency.',
    `grant_code` STRING COMMENT 'The grant or funding source code against which the staff members salary was charged at the time of separation. Required for donor reporting on staff costs and compliance with grant closeout procedures under OMB Uniform Guidance.',
    `is_notice_served_in_full` BOOLEAN COMMENT 'Indicates whether the staff member served the full contractually required notice period. False triggers calculation of payment in lieu of notice (PILON) in final settlement.',
    `job_grade` STRING COMMENT 'The salary grade or band of the staff member at the time of separation. Used for attrition analysis by grade level and benchmarking against sector compensation standards.',
    `job_title` STRING COMMENT 'The official job title held by the staff member at the time of separation. Preserved as a historical snapshot for workforce attrition analysis by role and grade.',
    `knowledge_transfer_completed` BOOLEAN COMMENT 'Indicates whether the departing staff member completed the required knowledge transfer and handover activities prior to their last working date. Supports program continuity and field operations risk management.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the separation event record was most recently modified in the system. Used for incremental data pipeline processing and change data capture in the Databricks Lakehouse Silver layer.',
    `last_working_date` DATE COMMENT 'The actual final day the staff member performed work duties at Ngo. May differ from effective_date when garden leave or paid notice is applied.',
    `leave_encashment_days` DECIMAL(18,2) COMMENT 'The number of accrued but unused annual leave days encashed as part of the final settlement. Feeds into the leave encashment payment calculation and leave liability reporting.',
    `notice_period_days_required` STRING COMMENT 'The contractually required notice period in calendar days as stipulated in the staff members employment contract or Ngo HR policy.',
    `notice_period_days_served` STRING COMMENT 'The actual number of calendar days of notice served by the separating staff member or Ngo. Used to determine if notice was served in full or if payment in lieu of notice (PILON) applies.',
    `notification_date` DATE COMMENT 'The date on which the staff member or Ngo formally notified the other party of the intended separation. Used to calculate notice period served and assess contractual compliance.',
    `original_hire_date` DATE COMMENT 'The date on which the staff member was first hired by Ngo. Preserved as a historical snapshot on the separation record for service length calculations and end-of-service benefit determination.',
    `primary_departure_reason` STRING COMMENT 'The staff members self-reported primary reason for leaving Ngo as captured during the exit interview. Confidential narrative used for talent retention analysis and workforce strategy. [ENUM-REF-CANDIDATE: compensation|career_growth|management|workload|security|relocation|family|health|better_opportunity|end_of_funding|other — promote to reference product]',
    `rehire_eligibility` STRING COMMENT 'Indicates whether the former staff member is eligible for future re-employment at Ngo. Ineligible status is typically set for terminations due to misconduct, safeguarding violations, or fraud. Critical for talent acquisition screening.. Valid values are `eligible|ineligible|eligible_with_conditions`',
    `rehire_ineligibility_reason` STRING COMMENT 'Confidential narrative reason explaining why a former staff member has been flagged as ineligible for rehire. Populated only when rehire_eligibility is ineligible or eligible_with_conditions. Supports safeguarding due diligence.',
    `repatriation_destination_country` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country to which the international staff member is being repatriated upon separation. Used for travel cost estimation and logistics planning.. Valid values are `^[A-Z]{3}$`',
    `repatriation_entitlement` BOOLEAN COMMENT 'Indicates whether the separating staff member is entitled to repatriation support (travel, shipment of personal effects) under Ngos international staff policy. Applicable primarily to expatriate and international staff categories.',
    `safeguarding_clearance_status` STRING COMMENT 'Indicates the safeguarding clearance status of the staff member at the time of separation. Ensures compliance with CHS Core Humanitarian Standard obligations and prevents re-employment of individuals with unresolved safeguarding concerns.. Valid values are `cleared|pending_investigation|under_investigation|not_cleared`',
    `separation_reason_code` STRING COMMENT 'Granular reason code for the separation as configured in Workday HCM (e.g., VOL-BETTER-OPPORTUNITY, VOL-PERSONAL, INV-MISCONDUCT, INV-PERFORMANCE). Supports detailed attrition root-cause analysis and donor/grant reporting on workforce stability. [ENUM-REF-CANDIDATE: vol_better_opportunity|vol_personal|vol_relocation|inv_misconduct|inv_performance|inv_redundancy|eoc_project_end|eoc_funding_end|retirement_age|death_in_service — promote to reference product]',
    `separation_status` STRING COMMENT 'Current workflow state of the separation business process in Workday HCM. Tracks whether the offboarding process has been initiated, is in progress, approved by HR, completed, or cancelled.. Valid values are `initiated|in_progress|approved|completed|cancelled`',
    `separation_type` STRING COMMENT 'Classification of the reason for the staff members departure from Ngo. Drives attrition analytics, legal obligations, and final settlement calculations. Values: resignation, end_of_contract, redundancy, termination, retirement, death_in_service.. Valid values are `resignation|end_of_contract|redundancy|termination|retirement|death_in_service`',
    `settlement_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the currency in which the final settlement amount is denominated. Supports multi-currency financial reporting in SAP S/4HANA.. Valid values are `^[A-Z]{3}$`',
    `severance_pay_amount` DECIMAL(18,2) COMMENT 'The gross severance pay component of the final settlement, calculated based on years of service and applicable HR policy or statutory requirements. Distinct from PILON and leave encashment components.',
    `staff_category` STRING COMMENT 'Classification of the separating staff members employment category at the time of separation. Drives differential separation entitlements, repatriation obligations, and attrition reporting by staff tier.. Valid values are `international|national|local|volunteer|consultant`',
    `system_access_revoked` BOOLEAN COMMENT 'Indicates whether all IT system access (email, ERP, CRM, HRIS, field data systems) has been revoked for the departing staff member. Critical for information security compliance and data protection obligations.',
    `workday_termination_reference` STRING COMMENT 'The native business process instance identifier assigned by Workday HCM for the termination event, used for system-of-record traceability and reconciliation.',
    `years_of_service` DECIMAL(18,2) COMMENT 'Total length of continuous service with Ngo at the time of separation, expressed in years with decimal precision. Used to calculate end-of-service gratuity, severance entitlements, and long-service recognition.',
    CONSTRAINT pk_separation_event PRIMARY KEY(`separation_event_id`)
) COMMENT 'Record of a staff members separation from Ngo, capturing separation type (resignation, end of contract, redundancy, termination, retirement, death in service), effective date, notice period served, exit interview completion, final settlement amount, and rehire eligibility. Supports workforce attrition analysis and talent retention tracking.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` (
    `staff_certification_id` BIGINT COMMENT 'Unique system-generated identifier for each staff certification record in the Workday HCM system. Primary key for the staff_certification data product.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Certifications fulfill specific compliance obligations (mandatory safeguarding training, professional licenses, donor-required credentials). Enables tracking which obligations are satisfied by which c',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who holds this certification. Links to the workforce staff/employee master record in Workday HCM.',
    `attempt_number` STRING COMMENT 'The sequential attempt number for this certification, where a staff member may have taken the certification examination or training multiple times. Supports tracking of re-certification attempts.',
    `staff_certification_code` STRING COMMENT 'Standardized short code or reference number for the certification type, used for classification and reporting (e.g., HEAT, PSEA-101, CHS-CERT, SAFEGUARD-CLR).',
    `cost_amount` DECIMAL(18,2) COMMENT 'The monetary cost incurred by the organization for the staff member to obtain this certification, including training fees, examination fees, and associated costs. Used for budget tracking and donor cost allocation.',
    `cost_center_code` STRING COMMENT 'The organizational cost center code to which the certification cost is charged. Aligns with the Chart of Accounts (CoA) in SAP S/4HANA or Unit4 ERP for fund accounting and grant cost allocation.',
    `cost_currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for the certification cost amount (e.g., USD, GBP, EUR). Required for multi-currency financial reporting.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was first created in the system. Supports audit trail and data lineage requirements.',
    `document_received_date` DATE COMMENT 'The date on which the physical or digital copy of the certification document was received by the HR department for filing and verification.',
    `document_ref` STRING COMMENT 'Reference path, URL, or document management system identifier pointing to the scanned copy or digital file of the certification document stored in the organizations document repository.',
    `donor_requirement_ref` STRING COMMENT 'Reference code or name of the donor agreement, grant, or compliance framework that mandates this certification (e.g., USAID-APS-2023-001, BHA-PSEA-MANDATORY). Populated only when is_donor_required is True.',
    `duty_station_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the staff members duty station at the time the certification was obtained or is required. Supports country-specific compliance and field deployment eligibility checks.. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'The date on which the certification, license, or clearance expires and is no longer valid. Null if the certification has no expiry (e.g., lifetime accreditation). Critical for field deployment eligibility checks.',
    `grant_code` STRING COMMENT 'The grant or award code against which the certification cost is charged, where training is funded by a specific donor grant. Supports donor compliance reporting and BvA (Budget versus Actual) tracking.',
    `is_donor_required` BOOLEAN COMMENT 'Indicates whether this certification is mandated by a specific donor or grant agreement as a condition of staff deployment on funded programs (e.g., USAID BHA mandatory training requirements, DFID safeguarding certifications).',
    `is_field_deployment_required` BOOLEAN COMMENT 'Indicates whether this certification is specifically required for field deployment eligibility (e.g., HEAT training, medical fitness certificate, security clearance). Drives automated deployment eligibility checks in field operations.',
    `is_pass` BOOLEAN COMMENT 'Indicates whether the staff member passed the certification assessment or examination. True = passed; False = failed or did not meet the required standard.',
    `is_role_required` BOOLEAN COMMENT 'Indicates whether this certification is a mandatory requirement for the staff members current position or role. True = required for role; False = voluntary or supplementary. Used in field deployment eligibility checks and compliance reporting.',
    `issue_date` DATE COMMENT 'The date on which the certification, license, or clearance was officially issued or awarded by the issuing body.',
    `issuing_body` STRING COMMENT 'Name of the organization, authority, or institution that issued the certification or license (e.g., USAID Bureau for Humanitarian Assistance, Sphere Association, National Medical Council, DVLA, CHS Alliance).',
    `issuing_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country in which the certification was issued. Relevant for statutory licenses and country-specific clearances.. Valid values are `^[A-Z]{3}$`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this certification record was most recently modified. Supports change tracking, audit compliance, and Silver Layer incremental processing in the Databricks Lakehouse.',
    `staff_certification_name` STRING COMMENT 'Full official name of the professional certification, license, or mandatory clearance (e.g., Hostile Environment and First Aid Training, SPHERE Humanitarian Standards Certificate, USAID Mandatory Reporting Training, Driving License Class B).',
    `notes` STRING COMMENT 'Free-text field for HR officers to record additional context, exceptions, waiver justifications, or operational notes related to this certification record.',
    `number` STRING COMMENT 'The unique certificate or license number assigned by the issuing body. Used for verification and compliance audits. Treated as confidential business data.',
    `reminder_sent_date` DATE COMMENT 'The date on which the most recent automated renewal reminder notification was sent to the staff member and/or their line manager via the HRIS or notification system.',
    `renewal_due_date` DATE COMMENT 'The date by which the staff member must initiate or complete the renewal process to maintain continuous validity of the certification. May precede the expiry date to allow processing lead time.',
    `renewal_status` STRING COMMENT 'Current status of the certification renewal process. Tracks whether renewal is not yet due, currently in progress, submitted for review, successfully renewed, lapsed due to non-renewal, or formally waived.. Valid values are `not_due|in_progress|submitted|renewed|lapsed|waived`',
    `score_or_grade` STRING COMMENT 'The score, grade, or result achieved by the staff member in the certification examination or assessment (e.g., Pass, Distinction, 87%, Competent). Null if the certification is pass/fail without a graded result.',
    `staff_category` STRING COMMENT 'Classification of the staff members employment category at the time of certification. Relevant for determining applicable certification requirements and compliance obligations by staff type.. Valid values are `national_staff|international_staff|expatriate|consultant|volunteer`',
    `staff_certification_status` STRING COMMENT 'Current lifecycle status of the certification record. Indicates whether the certification is currently active and valid, expired, suspended by the issuing body, revoked, or pending verification of submitted documents.. Valid values are `active|expired|suspended|revoked|pending_verification`',
    `training_completion_date` DATE COMMENT 'The date on which the staff member completed the training course or examination that led to the award of this certification. May differ from the official issue date.',
    `training_delivery_mode` STRING COMMENT 'The modality through which the training leading to this certification was delivered. Supports ICT4D (Information and Communication Technology for Development) analytics and LMS reporting.. Valid values are `in_person|online|blended|on_the_job|simulation`',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Total number of hours of training completed to obtain this certification. Used for workforce learning and development reporting and donor compliance reporting on staff capacity building.',
    `training_location_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code of the country where the training was conducted. Relevant for field-based and in-country training programs.. Valid values are `^[A-Z]{3}$`',
    `training_provider` STRING COMMENT 'Name of the training institution, course provider, or delivery organization through which the staff member obtained the certification (e.g., RedR UK, Insecurity Insight, Johns Hopkins Bloomberg School of Public Health). Distinct from the issuing body for accredited programs.',
    `staff_certification_type` STRING COMMENT 'Category of the certification or clearance. Classifies whether it is a professional accreditation, a mandatory organizational clearance, a statutory license, a medical fitness certificate, a security clearance, or a safeguarding compliance credential. [ENUM-REF-CANDIDATE: professional_accreditation|mandatory_clearance|license|medical_fitness|security_clearance|safeguarding|driving|language_proficiency — promote to reference product]. Valid values are `professional_accreditation|mandatory_clearance|license|medical_fitness|security_clearance|safeguarding`',
    `verification_date` DATE COMMENT 'The date on which the certification was verified as authentic by the HR or compliance team. Null if verification has not yet been completed.',
    `verification_status` STRING COMMENT 'Status of the organizations verification of the certifications authenticity with the issuing body. Unverified = document received but not yet checked; Verified = confirmed authentic; Verification_failed = could not be confirmed; Not_required = verification waived per policy.. Valid values are `unverified|verified|verification_failed|not_required`',
    `verified_by` STRING COMMENT 'Name or identifier of the HR officer or compliance staff member who verified the authenticity of the certification document.',
    `workday_credential_reference` STRING COMMENT 'The native credential/certification record identifier from Workday HCM, used for system-of-record traceability and reconciliation with the source HRIS.',
    CONSTRAINT pk_staff_certification PRIMARY KEY(`staff_certification_id`)
) COMMENT 'Record of professional certifications, licenses, and mandatory clearances held by a staff member, including certification name, issuing body, issue date, expiry date, renewal status, and whether the certification is required for the current role (e.g., security clearance, medical fitness certificate, driving license, professional accreditation). Supports field deployment eligibility checks.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`timesheet` (
    `timesheet_id` BIGINT COMMENT 'Unique identifier for the timesheet record. Primary key.',
    `amended_timesheet_id` BIGINT COMMENT 'Self-referencing FK on timesheet (amended_timesheet_id)',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member who approved this timesheet. Typically the employees direct supervisor or program manager with budget authority.',
    `award_id` BIGINT COMMENT 'Reference to the primary grant or funding source to which these hours are charged. Critical for donor-compliant cost allocation and Budget versus Actual (BvA) reporting.',
    `intervention_id` BIGINT COMMENT 'Reference to the program under which the work was performed. Supports program-level cost tracking and Monitoring Evaluation and Learning (MEL) reporting.',
    `payroll_run_id` BIGINT COMMENT 'Reference to the payroll run in which these hours were processed for payment. Links timesheet to payroll for reconciliation and audit.',
    `primary_timesheet_staff_member_id` BIGINT COMMENT 'Reference to the staff member who submitted this timesheet. Links to the staff_member product.',
    `project_site_id` BIGINT COMMENT 'Reference to the specific project or activity within a program to which time is allocated. Enables project-level cost tracking and Results-Based Management (RBM).',
    `activity_description` STRING COMMENT 'Free-text description of the work activities performed during the reported time. Provides narrative context for audit and program management review.',
    `approval_date` DATE COMMENT 'The date when the timesheet was approved by the authorized approver. Null if not yet approved.',
    `approval_timestamp` TIMESTAMP COMMENT 'The precise date and time when the timesheet was approved. Critical for audit compliance and payroll cutoff determination.',
    `approver_comments` STRING COMMENT 'Optional comments or notes provided by the approver during the approval process. Used for clarifications, conditions, or audit trail documentation.',
    `contract_type` STRING COMMENT 'Type of employment contract under which the work was performed. Affects eligibility for overtime, TOIL, and other benefits.. Valid values are `permanent|fixed_term|temporary|consultant|volunteer`',
    `cost_center_code` STRING COMMENT 'Financial accounting code representing the organizational unit or department responsible for the cost. Used for general ledger posting and budget control.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this timesheet record was first created in the system. Used for audit trail and data lineage tracking.',
    `duty_station_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code representing the country where the work was performed. Critical for field operations tracking and hardship allowance calculation.',
    `duty_station_name` STRING COMMENT 'Name of the duty station or field office where the work was performed. Used for geographic reporting and field operations management.',
    `effort_certification_required` BOOLEAN COMMENT 'Indicates whether this timesheet entry requires formal effort certification per donor requirements. True for US federal grants and other donors requiring periodic effort certification.',
    `effort_certified_date` DATE COMMENT 'The date when the employee formally certified that the reported effort allocation is accurate. Required for compliance with federal grant regulations.',
    `effort_percent` DECIMAL(18,2) COMMENT 'Percentage of total work effort allocated to this grant or project for the reporting period. Sum of effort_percent across all grants for a given period should equal 100% for cost-shared positions.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which the labor cost will be posted. Typically represents salary or personnel expense categories.',
    `grant_code` STRING COMMENT 'Business identifier for the grant to which time is charged. Used for financial reporting and grant management system integration.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours worked on the specified work_date. Includes regular hours, overtime, and any other compensable time.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether the hours are billable to a donor or grant. True for direct program work, false for indirect or administrative activities.',
    `is_cost_shared` BOOLEAN COMMENT 'Indicates whether this timesheet entry represents a cost-shared position where a single employees time is funded by multiple grants. True if multiple grants fund this position.',
    `is_field_deployment` BOOLEAN COMMENT 'Indicates whether the work was performed during a field deployment or surge assignment. True for field-based work, false for headquarters or remote work.',
    `is_grant_chargeable` BOOLEAN COMMENT 'Indicates whether the hours can be charged to a specific grant. True for allowable direct costs, false for unallowable or indirect costs.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this timesheet record was most recently modified. Used for change tracking and audit compliance.',
    `number` STRING COMMENT 'Human-readable business identifier for the timesheet, typically formatted as TS-YYYY-NNNN or similar convention.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours worked beyond the standard working hours, eligible for overtime compensation per labor law and employment contract terms.',
    `period_end_date` DATE COMMENT 'The last date of the time reporting period covered by this timesheet. Must be greater than or equal to period_start_date.',
    `period_start_date` DATE COMMENT 'The first date of the time reporting period covered by this timesheet. Typically aligned with payroll cycles (weekly, bi-weekly, or monthly).',
    `program_code` STRING COMMENT 'Business identifier for the program. Used for cross-system reporting and program performance tracking.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of standard working hours within the employees normal schedule. Typically up to 8 hours per day or 40 hours per week for full-time staff.',
    `rejection_date` DATE COMMENT 'The date when the timesheet was rejected by the approver. Null if not rejected.',
    `rejection_reason` STRING COMMENT 'Free-text explanation provided by the approver for why the timesheet was rejected. Required when timesheet_status is rejected.',
    `staff_category` STRING COMMENT 'Classification of the staff member for this timesheet entry. Determines applicable labor policies, compensation rules, and donor reporting requirements.. Valid values are `national|international|consultant|volunteer`',
    `timesheet_status` STRING COMMENT 'Current lifecycle status of the timesheet in the approval workflow. Determines whether hours are eligible for payroll processing and grant charging.. Valid values are `draft|submitted|approved|rejected|cancelled|under_review`',
    `submission_date` DATE COMMENT 'The date when the employee submitted the timesheet for approval. Null if timesheet is still in draft status.',
    `submission_timestamp` TIMESTAMP COMMENT 'The precise date and time when the employee submitted the timesheet for approval. Used for audit trail and SLA tracking.',
    `toil_hours_accrued` DECIMAL(18,2) COMMENT 'Number of hours accrued as Time Off In Lieu for field staff working in hardship locations. Alternative to overtime pay, allowing compensatory time off.',
    `work_date` DATE COMMENT 'The specific calendar date on which the work hours were performed. Must fall within the period_start_date and period_end_date range.',
    `work_location_type` STRING COMMENT 'Classification of where the work was physically performed. Used for remote work tracking, field allowance eligibility, and operational reporting.. Valid values are `office|field|remote|home`',
    `workday_timesheet_reference` STRING COMMENT 'External identifier from Workday HCM system for this timesheet record. Used for system reconciliation and audit trail.',
    CONSTRAINT pk_timesheet PRIMARY KEY(`timesheet_id`)
) COMMENT 'Time tracking record for staff members capturing hours worked per day, project/grant allocation of time, overtime, and approval status. Essential for donor-compliant cost allocation where multiple grants fund a single position, and for tracking field staff working hours in hardship locations with TOIL (Time Off In Lieu) accrual. Supports BvA reporting and audit-ready grant charging.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`candidate` (
    `candidate_id` BIGINT COMMENT 'Primary key for candidate',
    `staff_member_id` BIGINT COMMENT 'Reference to the hiring manager responsible for the final hiring decision.',
    `candidate_referring_staff_member_id` BIGINT COMMENT 'Reference to the recruiter or talent acquisition specialist managing this candidate.',
    `recruitment_requisition_id` BIGINT COMMENT 'Reference to the specific job requisition or opening the candidate applied for.',
    `referred_by_candidate_id` BIGINT COMMENT 'Self-referencing FK on candidate (referred_by_candidate_id)',
    `referring_staff_member_id` BIGINT COMMENT '',
    `address_line_1` STRING COMMENT 'Primary street address line for the candidates residence.',
    `address_line_2` STRING COMMENT 'Secondary address line for apartment, suite, or unit number.',
    `alternate_phone_number` STRING COMMENT 'Secondary or alternate contact phone number for the candidate.',
    `application_date` DATE COMMENT 'The date when the candidate submitted their application.',
    `application_number` STRING COMMENT 'Externally-visible unique application reference number assigned to the candidate when they apply.',
    `available_start_date` DATE COMMENT 'The earliest date the candidate is available to begin employment.',
    `city` STRING COMMENT 'City or municipality of the candidates residence.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the candidates residence.',
    `cover_letter_file_path` STRING COMMENT 'Storage location or URI of the candidates cover letter document.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this candidate record was first created in the system.',
    `current_employer` STRING COMMENT 'Name of the organization where the candidate is currently employed.',
    `current_job_title` STRING COMMENT 'The candidates current job title or role at their present employer.',
    `date_of_birth` DATE COMMENT 'The candidates date of birth.',
    `disability_status` STRING COMMENT 'Voluntary disclosure of disability status for accommodation and diversity reporting purposes.',
    `diversity_self_identification` STRING COMMENT 'Voluntary self-identification information for diversity and inclusion tracking, collected in compliance with equal opportunity regulations.',
    `email_address` STRING COMMENT 'Primary email address for candidate communication and correspondence.',
    `expected_salary_amount` DECIMAL(18,2) COMMENT 'The salary amount the candidate expects or requests for the position.',
    `expected_salary_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the expected salary amount.',
    `first_name` STRING COMMENT 'The given or first name of the candidate.',
    `highest_education_level` STRING COMMENT 'The highest level of formal education attained by the candidate.',
    `interview_scheduled_date` DATE COMMENT 'The date when the candidates interview is scheduled or was last scheduled.',
    `last_name` STRING COMMENT 'The family or surname of the candidate.',
    `linkedin_profile_url` STRING COMMENT 'URL to the candidates LinkedIn professional profile.',
    `middle_name` STRING COMMENT 'The middle name or initial of the candidate, if provided.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this candidate record was last updated or modified.',
    `nationality` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the candidates nationality or citizenship.',
    `notes` STRING COMMENT 'Internal notes and comments about the candidate, interview feedback, or assessment observations.',
    `notice_period_days` STRING COMMENT 'Number of days of notice the candidate must provide to their current employer before leaving.',
    `offer_accepted_date` DATE COMMENT 'The date when the candidate accepted the job offer.',
    `offer_extended_date` DATE COMMENT 'The date when a job offer was extended to the candidate.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the candidate.',
    `position_applied_for` STRING COMMENT 'The job title or position name that the candidate applied for.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the candidates residence.',
    `preferred_name` STRING COMMENT 'The name the candidate prefers to be called, if different from legal name.',
    `referral_source` STRING COMMENT 'Name or identifier of the person or entity who referred the candidate, if applicable.',
    `rejection_date` DATE COMMENT 'The date when the candidate was rejected or declined for the position.',
    `rejection_reason` STRING COMMENT 'Internal notes or reason code explaining why the candidate was not selected.',
    `resume_file_path` STRING COMMENT 'Storage location or URI of the candidates resume or curriculum vitae document.',
    `screening_completed_date` DATE COMMENT 'The date when initial candidate screening was completed.',
    `source_channel` STRING COMMENT 'The channel or medium through which the candidate was sourced or applied.',
    `state_province` STRING COMMENT 'State, province, or region of the candidates residence.',
    `candidate_status` STRING COMMENT 'Current stage of the candidate in the recruitment lifecycle.',
    `candidate_type` STRING COMMENT 'Classification of the candidate based on their source or relationship to the organization.',
    `veteran_status` STRING COMMENT 'Indicates whether the candidate is a military veteran, collected for diversity reporting.',
    `willing_to_relocate` BOOLEAN COMMENT 'Indicates whether the candidate is willing to relocate for the position.',
    `withdrawal_date` DATE COMMENT 'The date when the candidate withdrew their application.',
    `withdrawal_reason` STRING COMMENT 'Reason provided by the candidate for withdrawing their application.',
    `work_authorization_status` STRING COMMENT 'The candidates legal authorization to work in the target country or region.',
    `years_of_experience` DECIMAL(18,2) COMMENT 'Total years of relevant professional work experience reported by the candidate.',
    CONSTRAINT pk_candidate PRIMARY KEY(`candidate_id`)
) COMMENT 'Master reference table for candidate. Referenced by candidate_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`review_template` (
    `review_template_id` BIGINT COMMENT 'Primary key for review_template',
    `competency_framework_id` BIGINT COMMENT 'Reference to the competency framework used in this review template for assessing staff capabilities and behaviors.',
    `derived_from_review_template_id` BIGINT COMMENT 'Self-referencing FK on review_template (derived_from_review_template_id)',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit or department for which this review template is designed or restricted.',
    `rating_scale_id` BIGINT COMMENT 'Reference to the rating scale used in this review template for scoring performance dimensions (e.g., 1-5 scale, exceeds/meets/below expectations).',
    `staff_member_id` BIGINT COMMENT 'Reference to the employee who created this review template record.',
    `review_created_by_staff_member_id` BIGINT COMMENT 'Reference to the HR staff member or manager who owns and maintains this review template.',
    `review_last_modified_by_employee_staff_member_id` BIGINT COMMENT 'Reference to the employee who most recently modified this review template record.',
    `creator_staff_member_id` BIGINT COMMENT '',
    `allows_customization` BOOLEAN COMMENT 'Indicates whether managers or HR can customize sections or questions when using this template for individual reviews.',
    `approval_levels` STRING COMMENT 'Number of approval levels required in the review workflow (e.g., 1 for manager only, 2 for manager and director, 3 for manager, director, and HR).',
    `approval_workflow_required` BOOLEAN COMMENT 'Indicates whether reviews using this template require formal approval workflow through multiple organizational levels.',
    `review_template_code` STRING COMMENT 'Unique business identifier code for the review template used for external reference and system integration.',
    `created_date` DATE COMMENT 'Date when the review template record was first created in the system.',
    `review_template_description` STRING COMMENT 'Detailed description of the review template purpose, scope, and intended use cases within the performance management framework.',
    `effective_end_date` DATE COMMENT 'Date when the review template is no longer active or available for new reviews. Nullable for templates with indefinite validity.',
    `effective_start_date` DATE COMMENT 'Date when the review template becomes active and available for use in performance review cycles.',
    `includes_development_plan` BOOLEAN COMMENT 'Indicates whether the review template includes a development plan section for identifying learning and growth opportunities.',
    `includes_goal_setting` BOOLEAN COMMENT 'Indicates whether the review template includes a goal-setting component for establishing future performance objectives.',
    `includes_manager_assessment` BOOLEAN COMMENT 'Indicates whether the review template includes a manager assessment component where the direct supervisor evaluates the employee.',
    `includes_peer_feedback` BOOLEAN COMMENT 'Indicates whether the review template includes peer feedback from colleagues at the same organizational level.',
    `includes_self_assessment` BOOLEAN COMMENT 'Indicates whether the review template includes a self-assessment component where the employee evaluates their own performance.',
    `includes_upward_feedback` BOOLEAN COMMENT 'Indicates whether the review template includes upward feedback where subordinates evaluate their manager.',
    `is_default_template` BOOLEAN COMMENT 'Indicates whether this is the default review template for its category or staff type.',
    `is_multilingual` BOOLEAN COMMENT 'Indicates whether the review template is available in multiple languages to support diverse international staff.',
    `language_code` STRING COMMENT 'ISO 639-3 three-letter language code indicating the primary language of the review template content.',
    `last_modified_date` DATE COMMENT 'Date when the review template record was most recently updated or modified.',
    `last_used_date` DATE COMMENT 'Date when this review template was most recently used to initiate a performance review.',
    `maximum_review_duration_days` STRING COMMENT 'Maximum number of days allowed to complete a review using this template before it is considered overdue.',
    `minimum_review_duration_days` STRING COMMENT 'Minimum number of days required to complete a review using this template from initiation to finalization.',
    `review_template_name` STRING COMMENT 'Human-readable name of the review template (e.g., Annual Performance Review, Probation Review, 360 Feedback).',
    `notes` STRING COMMENT 'Additional notes, instructions, or guidance for HR staff and managers using this review template.',
    `question_count` STRING COMMENT 'Total number of questions or assessment items in the review template.',
    `requires_calibration` BOOLEAN COMMENT 'Indicates whether reviews using this template require calibration sessions to ensure consistency and fairness across the organization.',
    `review_cycle_type` STRING COMMENT 'Frequency or timing pattern for which this review template is designed (annual, semi-annual, quarterly, monthly, ad-hoc, continuous feedback).',
    `section_count` STRING COMMENT 'Total number of sections or components in the review template structure.',
    `review_template_status` STRING COMMENT 'Current lifecycle status of the review template indicating whether it is available for use in performance management processes.',
    `target_job_level` STRING COMMENT 'Job level or grade range for which this review template is designed (e.g., entry-level, mid-level, senior, executive, director). [ENUM-REF-CANDIDATE: entry_level|mid_level|senior|manager|director|executive|c_suite|individual_contributor — promote to reference product]',
    `target_staff_category` STRING COMMENT 'Staff classification or category for which this review template is intended (e.g., national staff, international staff, field personnel, headquarters staff, volunteers, consultants). [ENUM-REF-CANDIDATE: national_staff|international_staff|field_personnel|headquarters_staff|volunteers|consultants|expatriates|local_hires — promote to reference product]',
    `review_template_type` STRING COMMENT 'Classification of the review template by purpose (performance, probation, 360 feedback, competency assessment, project review, exit interview, onboarding review).',
    `usage_count` STRING COMMENT 'Total number of times this review template has been used to create performance reviews.',
    `version_number` STRING COMMENT 'Version identifier for the review template to track revisions and changes over time (e.g., 1.0, 2.1, 3.0).',
    CONSTRAINT pk_review_template PRIMARY KEY(`review_template_id`)
) COMMENT 'Master reference table for review_template. Referenced by review_template_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` (
    `performance_improvement_plan_id` BIGINT COMMENT 'Primary key for performance_improvement_plan',
    `user_account_id` BIGINT COMMENT 'Identifier of the system user who created the performance improvement plan record.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the HR business partner supporting the performance improvement plan process.',
    `performance_manager_staff_member_id` BIGINT COMMENT 'Identifier of the manager or supervisor responsible for overseeing the performance improvement plan.',
    `performance_modified_by_user_user_account_id` BIGINT COMMENT 'Identifier of the system user who last modified the performance improvement plan record.',
    `performance_previous_pip_performance_improvement_plan_id` BIGINT COMMENT 'Identifier of any prior performance improvement plan for the same employee, establishing historical context.',
    `performance_subject_staff_member_id` BIGINT COMMENT 'Identifier of the employee subject to the performance improvement plan.',
    `primary_extended_performance_improvement_plan_id` BIGINT COMMENT 'Self-referencing FK on performance_improvement_plan (extended_performance_improvement_plan_id)',
    `disciplinary_case_id` BIGINT COMMENT 'Identifier linking to any formal disciplinary action record associated with this performance improvement plan.',
    `supervisor_staff_member_id` BIGINT COMMENT '',
    `completion_date` DATE COMMENT 'Actual date when the performance improvement plan was completed or concluded.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicator of whether the plan contains highly sensitive information requiring restricted access beyond standard HR confidentiality.',
    `consequences_if_unsuccessful` STRING COMMENT 'Description of the employment consequences if the employee fails to meet the plan objectives, such as demotion, reassignment, or termination.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance improvement plan record was first created in the system.',
    `duration_days` STRING COMMENT 'Total number of calendar days allocated for the performance improvement plan period.',
    `employee_acknowledgement_date` DATE COMMENT 'Date when the employee formally acknowledged receipt and understanding of the performance improvement plan.',
    `employee_acknowledgement_signature` STRING COMMENT 'Digital signature or confirmation indicator that the employee has acknowledged the plan.',
    `end_date` DATE COMMENT 'Scheduled date when the performance improvement plan period concludes and final evaluation occurs.',
    `extension_count` STRING COMMENT 'Number of times the performance improvement plan period has been extended beyond the original end date.',
    `hr_approval_date` DATE COMMENT 'Date when the HR department reviewed and approved the performance improvement plan.',
    `improvement_objectives` STRING COMMENT 'Specific, measurable objectives and goals the employee must achieve during the plan period.',
    `issue_description` STRING COMMENT 'Detailed narrative description of the specific performance issues and deficiencies being addressed.',
    `last_extension_date` DATE COMMENT 'Date when the most recent extension to the plan period was granted.',
    `legal_review_date` DATE COMMENT 'Date when the legal department completed their review of the performance improvement plan.',
    `legal_review_required` BOOLEAN COMMENT 'Indicator of whether the plan requires legal department review due to potential employment law implications.',
    `manager_signature` STRING COMMENT 'Digital signature or confirmation indicator from the manager approving and initiating the plan.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance improvement plan record was last modified or updated.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next progress review meeting or checkpoint.',
    `number` STRING COMMENT 'Externally-known unique business identifier for the performance improvement plan, used for reference and tracking.',
    `outcome` STRING COMMENT 'Final outcome classification of the performance improvement plan upon completion or termination.',
    `outcome_notes` STRING COMMENT 'Detailed notes and commentary regarding the final outcome, achievements, and any remaining concerns.',
    `performance_issue_category` STRING COMMENT 'Primary category of performance deficiency that triggered the improvement plan.',
    `review_frequency` STRING COMMENT 'Scheduled frequency of progress review meetings between employee and manager during the plan period.',
    `severity_level` STRING COMMENT 'Severity classification of the performance issues being addressed by the plan.',
    `start_date` DATE COMMENT 'Date when the performance improvement plan officially begins and becomes effective.',
    `performance_improvement_plan_status` STRING COMMENT 'Current lifecycle status of the performance improvement plan.',
    `success_criteria` STRING COMMENT 'Detailed criteria and metrics that will be used to evaluate successful completion of the plan.',
    `support_resources` STRING COMMENT 'Description of training, coaching, mentoring, or other resources provided to support the employee during the improvement period.',
    `performance_improvement_plan_type` STRING COMMENT 'Classification of the performance improvement plan indicating the formality and severity level.',
    CONSTRAINT pk_performance_improvement_plan PRIMARY KEY(`performance_improvement_plan_id`)
) COMMENT 'Master reference table for performance_improvement_plan. Referenced by pip_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` (
    `calibration_session_id` BIGINT COMMENT 'Primary key for calibration_session',
    `staff_member_id` BIGINT COMMENT 'Reference to the employee who created the calibration session record in the system.',
    `calibration_facilitator_staff_member_id` BIGINT COMMENT 'Reference to the employee who facilitates or leads the calibration session, typically an HR business partner or senior manager.',
    `calibration_last_modified_by_employee_staff_member_id` BIGINT COMMENT 'Reference to the employee who most recently modified the calibration session record.',
    `followup_calibration_session_id` BIGINT COMMENT 'Self-referencing FK on calibration_session (followup_calibration_session_id)',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit (department, division, program, or field office) for which this calibration session is conducted.',
    `rating_scale_id` BIGINT COMMENT 'Reference to the performance rating scale used during this calibration session for standardizing evaluations.',
    `review_cycle_id` BIGINT COMMENT 'Reference to the performance review cycle to which this calibration session belongs.',
    `facilitator_staff_member_id` BIGINT COMMENT '',
    `actual_end_time` TIMESTAMP COMMENT 'The actual date and time when the calibration session concluded.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual date and time when the calibration session began, which may differ from the scheduled start time.',
    `agenda` STRING COMMENT 'Detailed agenda outlining the topics, employees, and discussion points to be covered during the calibration session.',
    `approval_date` DATE COMMENT 'The date on which the calibration session outcomes were formally approved.',
    `approval_required` BOOLEAN COMMENT 'Indicates whether the calibration session outcomes require formal approval from senior leadership or HR before finalization.',
    `calibration_methodology` STRING COMMENT 'The approach or methodology used to conduct the calibration session, determining how ratings are normalized and aligned across the organization.',
    `calibration_session_code` STRING COMMENT 'Business identifier for the calibration session, typically following a standardized format for external reference and reporting.',
    `comments` STRING COMMENT 'Free-text field for capturing additional context, observations, or administrative notes about the calibration session.',
    `confidentiality_level` STRING COMMENT 'Data classification level for the calibration session, reflecting the sensitivity of performance discussions and talent decisions.',
    `consensus_achieved` BOOLEAN COMMENT 'Indicates whether full consensus was achieved among all participants regarding the final calibrated ratings and talent decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when the calibration session record was first created in the system.',
    `decisions_summary` STRING COMMENT 'Summary of key decisions made during the calibration session, including rating changes, promotion recommendations, and development actions.',
    `employee_count_reviewed` STRING COMMENT 'Total number of employees whose performance ratings, compensation, or talent status are reviewed during this calibration session.',
    `follow_up_date` DATE COMMENT 'The scheduled date for any follow-up calibration session or action items resulting from this session.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional follow-up sessions or actions are required to complete the calibration process.',
    `forced_distribution_applied` BOOLEAN COMMENT 'Indicates whether a forced distribution curve (e.g., bell curve) was applied to performance ratings during this calibration session.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the calibration session record is currently active in the system or has been archived.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when the calibration session record was most recently updated.',
    `location` STRING COMMENT 'Physical or virtual location where the calibration session is held (e.g., conference room, office location, or virtual meeting platform).',
    `meeting_link` STRING COMMENT 'URL or access link for virtual calibration sessions conducted via video conferencing platforms.',
    `calibration_session_name` STRING COMMENT 'Descriptive name of the calibration session, typically indicating the review cycle, department, or organizational unit being calibrated.',
    `notes` STRING COMMENT 'Confidential notes and key discussion points captured during the calibration session, including rationale for rating adjustments and talent decisions.',
    `participant_count` STRING COMMENT 'Total number of participants (managers, HR representatives, and other stakeholders) attending the calibration session.',
    `rating_changes_count` STRING COMMENT 'Total number of performance rating adjustments made during the calibration session to ensure consistency and fairness.',
    `recording_available` BOOLEAN COMMENT 'Indicates whether an audio or video recording of the calibration session is available for reference or compliance purposes.',
    `recording_storage_location` STRING COMMENT 'File path or storage location reference for the session recording, if available.',
    `scheduled_date` DATE COMMENT 'The date on which the calibration session is scheduled to occur.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise date and time when the calibration session is scheduled to end.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the calibration session is scheduled to begin.',
    `calibration_session_status` STRING COMMENT 'Current lifecycle state of the calibration session, tracking its progression from planning through completion.',
    `target_distribution_percentages` STRING COMMENT 'The target percentage distribution for each performance rating category (e.g., 10% exceeds, 70% meets, 20% below), stored as a structured string.',
    `calibration_session_type` STRING COMMENT 'Classification of the calibration session based on its purpose within the performance management and talent lifecycle.',
    `unnamed_model` BIGINT COMMENT 'Reference to the employee (typically senior leader or HR director) responsible for approving the calibration session outcomes.',
    CONSTRAINT pk_calibration_session PRIMARY KEY(`calibration_session_id`)
) COMMENT 'Master reference table for calibration_session. Referenced by calibration_session_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` (
    `competency_framework_id` BIGINT COMMENT 'Primary key for competency_framework',
    `org_unit_id` BIGINT COMMENT 'add column org_unit_id (BIGINT) with FK to workforce.org_unit.org_unit_id - competency_framework only has a self-ref and one inbound from review_template; frameworks are owned by organizational units',
    `superseded_competency_framework_id` BIGINT COMMENT 'Self-referencing FK on competency_framework (superseded_competency_framework_id)',
    `approval_date` DATE COMMENT 'The date on which this competency framework was formally approved by the appropriate governance body or executive authority.',
    `approved_by` STRING COMMENT 'The name or title of the individual or governance body that formally approved this competency framework for organizational use.',
    `available_translations` STRING COMMENT 'Comma-separated list of ISO 639-3 language codes for which translated versions of this competency framework are available to support multilingual staff populations.',
    `competency_framework_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the competency framework for system integration and reporting purposes.',
    `competency_category_count` STRING COMMENT 'The number of high-level competency categories or clusters used to organize competencies within this framework.',
    `competency_count` STRING COMMENT 'The total number of distinct competencies defined within this framework.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this competency framework record was first created in the system.',
    `competency_framework_description` STRING COMMENT 'Detailed narrative description of the competency framework including its purpose, intended audience, key competency areas covered, and how it supports organizational talent management objectives.',
    `document_repository_path` STRING COMMENT 'File path or document management system location where the full competency framework documentation, guides, and supporting materials are stored.',
    `effective_end_date` DATE COMMENT 'The date on which this competency framework is scheduled to be retired or replaced. Null if the framework is open-ended.',
    `effective_start_date` DATE COMMENT 'The date on which this competency framework became or will become effective and available for use in talent management processes.',
    `external_url` STRING COMMENT 'URL link to external documentation, detailed framework guides, or online resources providing additional information about this competency framework.',
    `geographic_applicability` STRING COMMENT 'Description of the geographic regions, countries, or operational contexts where this competency framework is applicable and in use.',
    `industry_alignment` STRING COMMENT 'Description of how this competency framework aligns with nonprofit sector standards, humanitarian industry best practices, or international development competency models.',
    `integration_with_hris` BOOLEAN COMMENT 'Boolean flag indicating whether this competency framework is integrated with the organizations HRIS (e.g., Workday HCM) for automated competency tracking and reporting.',
    `integration_with_lms` BOOLEAN COMMENT 'Boolean flag indicating whether this competency framework is integrated with the organizations Learning Management System for competency-based learning path assignment and tracking.',
    `language` STRING COMMENT 'The primary language in which this competency framework is authored and maintained, using ISO 639-3 three-letter language codes (e.g., ENG for English, FRA for French, SPA for Spanish).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this competency framework record was most recently updated or modified.',
    `last_review_date` DATE COMMENT 'The date on which this competency framework was most recently reviewed for accuracy, relevance, and completeness.',
    `competency_framework_name` STRING COMMENT 'The official name of the competency framework used to define and assess staff capabilities and skills.',
    `next_review_date` DATE COMMENT 'The date on which the next scheduled review of this competency framework is planned to occur.',
    `notes` STRING COMMENT 'Additional free-text notes, comments, or contextual information about this competency framework for internal reference and knowledge management.',
    `owner_department` STRING COMMENT 'The department or organizational unit responsible for maintaining and governing this competency framework (typically Human Resources, Learning and Development, or Talent Management).',
    `owner_role` STRING COMMENT 'The job title or role of the individual accountable for this competency framework (e.g., Chief Human Resources Officer, Head of Talent Development).',
    `proficiency_levels_count` STRING COMMENT 'The total number of proficiency or mastery levels defined within this competency framework (e.g., 3-level, 5-level, 7-level scale).',
    `proficiency_scale_description` STRING COMMENT 'Textual description of the proficiency scale used in this framework, including level names and progression criteria (e.g., Beginner, Intermediate, Advanced, Expert, Master).',
    `purpose` STRING COMMENT 'Statement articulating the strategic purpose and business rationale for this competency framework, including how it aligns with organizational mission and workforce development goals.',
    `regulatory_compliance_notes` STRING COMMENT 'Notes on how this competency framework supports compliance with labor laws, professional certification requirements, or donor-mandated workforce standards.',
    `review_frequency_months` STRING COMMENT 'The standard interval in months at which this competency framework is reviewed and updated to ensure continued relevance and alignment with organizational needs.',
    `scope` STRING COMMENT 'The organizational scope to which this competency framework applies: global across all operations, regional, country-specific, program-specific, department-level, or role-specific.',
    `source_standard` STRING COMMENT 'The external competency standard, industry model, or professional body framework upon which this competency framework is based or adapted from (e.g., SHRM, ILO, CHS, sector-specific models).',
    `competency_framework_status` STRING COMMENT 'Current lifecycle status of the competency framework indicating whether it is in draft development, actively in use, under review for updates, deprecated and being phased out, or archived for historical reference.',
    `supports_performance_management` BOOLEAN COMMENT 'Boolean flag indicating whether this competency framework is integrated into performance appraisal and performance management processes.',
    `supports_recruitment` BOOLEAN COMMENT 'Boolean flag indicating whether this competency framework is used in talent acquisition processes for job profiling, candidate assessment, and selection decisions.',
    `supports_succession_planning` BOOLEAN COMMENT 'Boolean flag indicating whether this competency framework is used to support succession planning and talent pipeline development activities.',
    `target_audience` STRING COMMENT 'Description of the staff populations, roles, or job families for which this competency framework is designed and applicable.',
    `competency_framework_type` STRING COMMENT 'Classification of the competency framework by its primary focus area: technical skills, behavioral competencies, leadership capabilities, functional expertise, core organizational competencies, or specialized domain knowledge.',
    `usage_count` STRING COMMENT 'The number of active staff members, roles, or job profiles currently associated with or assessed against this competency framework.',
    `version` STRING COMMENT 'Version number of the competency framework following semantic versioning to track revisions and updates over time.',
    CONSTRAINT pk_competency_framework PRIMARY KEY(`competency_framework_id`)
) COMMENT 'Master reference table for competency_framework. Referenced by competency_framework_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` (
    `rating_scale_id` BIGINT COMMENT 'Primary key for rating_scale',
    `org_unit_id` BIGINT COMMENT 'add column org_unit_id (BIGINT) with FK to workforce.org_unit.org_unit_id - rating_scale only has a self-ref and inbound refs; needs organizational ownership context',
    `superseded_rating_scale_id` BIGINT COMMENT 'Self-referencing FK on rating_scale (superseded_rating_scale_id)',
    `allows_decimal_points` BOOLEAN COMMENT 'Indicates whether the rating scale permits decimal values (e.g., 3.75 on a 1-5 scale) for precise scoring.',
    `allows_half_points` BOOLEAN COMMENT 'Indicates whether the rating scale permits half-point increments (e.g., 3.5 on a 1-5 scale) for more granular assessments.',
    `applicable_to_job_levels` STRING COMMENT 'Comma-separated list of job levels or grades this rating scale applies to (e.g., entry_level, mid_level, senior_level, executive).',
    `applicable_to_staff_types` STRING COMMENT 'Comma-separated list of staff categories this rating scale applies to (e.g., national_staff, international_staff, field_personnel, headquarters_staff, volunteers).',
    `approval_date` DATE COMMENT 'The date on which this rating scale was officially approved for use.',
    `approval_status` STRING COMMENT 'Current approval state of the rating scale within the organizational governance process.',
    `approved_by` STRING COMMENT 'Name or identifier of the person or committee who approved this rating scale for organizational use.',
    `rating_scale_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the rating scale for system integration and reporting (e.g., PERF-5PT, COMP-4LVL).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this rating scale record was first created in the system.',
    `rating_scale_description` STRING COMMENT 'Detailed explanation of the rating scales purpose, usage context, and interpretation guidelines for managers and employees.',
    `display_order` STRING COMMENT 'Numeric value controlling the sort order when multiple rating scales are presented to users in the Human Resources Information System (HRIS).',
    `distribution_percentages` STRING COMMENT 'If forced distribution applies, specifies the required percentage distribution across rating levels (e.g., 10% top, 20% high, 40% middle, 20% low, 10% bottom).',
    `effective_end_date` DATE COMMENT 'The date after which this rating scale is no longer active. Null indicates the scale is currently in use with no planned retirement date.',
    `effective_start_date` DATE COMMENT 'The date from which this rating scale becomes active and available for use in performance reviews and assessments.',
    `increment_value` DECIMAL(18,2) COMMENT 'The step or increment between rating values (e.g., 1.0 for integer scales, 0.5 for half-point scales, 0.1 for decimal scales).',
    `interpretation_guide` STRING COMMENT 'Guidance text explaining how to interpret and apply each rating level, including behavioral anchors or performance indicators for each point on the scale.',
    `is_default_scale` BOOLEAN COMMENT 'Indicates whether this is the default rating scale to be used when no specific scale is selected for a performance review or assessment.',
    `is_forced_distribution` BOOLEAN COMMENT 'Indicates whether this rating scale requires forced distribution (e.g., bell curve ranking where only a certain percentage of employees can receive top ratings).',
    `is_manager_assessment_enabled` BOOLEAN COMMENT 'Indicates whether managers can use this rating scale to assess their direct reports.',
    `is_peer_assessment_enabled` BOOLEAN COMMENT 'Indicates whether this rating scale can be used for peer-to-peer assessments in 360-degree feedback processes.',
    `is_self_assessment_enabled` BOOLEAN COMMENT 'Indicates whether employees can use this rating scale to perform self-assessments as part of the performance review process.',
    `language_code` STRING COMMENT 'ISO 639-1 two-letter language code indicating the primary language in which this rating scale is defined (e.g., en for English, fr for French, es for Spanish).',
    `last_modified_by` STRING COMMENT 'Identifier or name of the user who last modified this rating scale record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this rating scale record was most recently updated.',
    `maximum_value` DECIMAL(18,2) COMMENT 'The highest numeric value on the rating scale (e.g., 5 for a 1-5 scale, 100 for a 0-100 scale).',
    `minimum_value` DECIMAL(18,2) COMMENT 'The lowest numeric value on the rating scale (e.g., 1 for a 1-5 scale, 0 for a 0-100 scale).',
    `rating_scale_name` STRING COMMENT 'The business name of the rating scale (e.g., 5-Point Performance Scale, Competency Assessment Scale, 360 Feedback Scale).',
    `number_of_levels` STRING COMMENT 'Total count of distinct rating levels or points on the scale (e.g., 5 for a 5-point scale, 4 for a 4-level competency scale).',
    `rating_scale_status` STRING COMMENT 'Current lifecycle status of the rating scale, indicating whether it is available for use in performance reviews and assessments.',
    `rating_scale_type` STRING COMMENT 'The category or purpose of the rating scale, indicating what dimension of workforce performance or capability it measures.',
    `usage_context` STRING COMMENT 'Description of the specific HR processes and contexts where this rating scale is used (e.g., annual performance review, 360-degree feedback, probation assessment, promotion evaluation).',
    `version_number` STRING COMMENT 'Version identifier for the rating scale, used to track revisions and updates over time (e.g., v1.0, v2.1).',
    `created_by` STRING COMMENT 'Identifier or name of the user who created this rating scale record.',
    CONSTRAINT pk_rating_scale PRIMARY KEY(`rating_scale_id`)
) COMMENT 'Master reference table for rating_scale. Referenced by rating_scale_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` (
    `review_cycle_id` BIGINT COMMENT 'Primary key for review_cycle',
    `employee_group_id` BIGINT COMMENT 'Reference to the employee group or classification (e.g., national staff, international staff, field personnel, headquarters staff) to which this review cycle applies.',
    `org_unit_id` BIGINT COMMENT 'Reference to the specific department or functional area for which this review cycle is scoped, if applicable.',
    `prior_review_cycle_id` BIGINT COMMENT 'Self-referencing FK on review_cycle (prior_review_cycle_id)',
    `rating_scale_id` BIGINT COMMENT 'Reference to the rating scale or performance grading system used for evaluations in this cycle (e.g., 1-5 scale, exceeds/meets/below expectations).',
    `review_closed_by_user_id` BIGINT COMMENT 'Reference to the user or administrator who officially closed this review cycle in the system.',
    `review_created_by_user_id` BIGINT COMMENT 'Reference to the user or administrator who created this review cycle record in the system.',
    `review_modified_by_user_id` BIGINT COMMENT 'Reference to the user or administrator who last modified this review cycle record in the system.',
    `review_org_unit_id` BIGINT COMMENT 'add column org_unit_id (BIGINT) with FK to workforce.org_unit.org_unit_id - review_cycle only has a self-ref and inbound refs; cycles are scoped to organizational units',
    `review_organization_id` BIGINT COMMENT 'Reference to the organizational unit or entity for which this review cycle applies (e.g., global organization, regional office, country program).',
    `review_template_id` BIGINT COMMENT 'Reference to the performance review template or form that defines the structure, competencies, and rating scales used in this cycle.',
    `staff_member_id` BIGINT COMMENT 'Reference to the Human Resources staff member or administrator who is responsible for managing and overseeing this review cycle.',
    `user_account_id` BIGINT COMMENT 'Reference to the senior leader or Human Resources executive who approved this review cycle for launch.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this review cycle was officially approved by senior leadership or Human Resources leadership to proceed.',
    `calibration_date` DATE COMMENT 'The date when leadership conducts calibration sessions to ensure consistency and fairness across performance ratings.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when this review cycle was officially closed and finalized, after which no further changes are permitted.',
    `review_cycle_code` STRING COMMENT 'Externally-known unique code or identifier for the review cycle used in reporting and system integration (e.g., APR-2024, MYR-Q2-2024).',
    `completed_review_count` STRING COMMENT 'The number of performance reviews that have been completed and finalized within this review cycle.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'The percentage of eligible employees who have completed their performance reviews within this cycle, calculated as (completed_review_count / eligible_employee_count) * 100.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this review cycle record was first created in the system.',
    `review_cycle_description` STRING COMMENT 'Detailed description of the review cycle including its purpose, scope, special instructions, and any unique considerations for participants.',
    `eligible_employee_count` STRING COMMENT 'The total number of employees who are eligible to participate in this review cycle based on the defined criteria.',
    `end_date` DATE COMMENT 'The date when the review cycle officially ends and no further submissions or updates are accepted.',
    `feedback_delivery_due_date` DATE COMMENT 'The deadline by which managers must deliver final performance feedback and ratings to employees in one-on-one meetings.',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this review cycle is aligned for budgeting, compensation planning, and organizational reporting purposes.',
    `instructions_url` STRING COMMENT 'Web link to detailed instructions, guidelines, or training materials for employees and managers participating in this review cycle.',
    `is_360_feedback_enabled` BOOLEAN COMMENT 'Indicates whether this review cycle includes 360-degree feedback from peers, direct reports, and other stakeholders in addition to manager evaluation.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this review cycle is currently active (true) or has been deactivated or archived (false).',
    `is_compensation_linked` BOOLEAN COMMENT 'Indicates whether the outcomes of this review cycle are directly linked to compensation decisions such as merit increases, bonuses, or promotions.',
    `is_goal_setting_enabled` BOOLEAN COMMENT 'Indicates whether this review cycle includes goal setting or objective definition as part of the performance management process.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether participation in this review cycle is mandatory for all eligible employees (true) or optional (false).',
    `manager_review_due_date` DATE COMMENT 'The deadline by which managers must complete their evaluation and feedback for direct reports.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this review cycle record was last modified or updated in the system.',
    `review_cycle_name` STRING COMMENT 'Human-readable name or title of the review cycle (e.g., Annual Performance Review 2024, Mid-Year Check-In Q2 2024).',
    `notes` STRING COMMENT 'Additional notes, comments, or observations about this review cycle for internal Human Resources reference and documentation purposes.',
    `notification_enabled` BOOLEAN COMMENT 'Indicates whether automated email or system notifications are enabled for this review cycle to remind participants of upcoming deadlines.',
    `review_period_end_date` DATE COMMENT 'The end date of the performance period being evaluated (e.g., December 31, 2024 for an annual review covering calendar year 2024).',
    `review_period_start_date` DATE COMMENT 'The start date of the performance period being evaluated (e.g., January 1, 2024 for an annual review covering calendar year 2024).',
    `self_assessment_due_date` DATE COMMENT 'The deadline by which employees must complete their self-assessment portion of the review.',
    `start_date` DATE COMMENT 'The date when the review cycle officially begins and becomes active for staff participation.',
    `review_cycle_status` STRING COMMENT 'Current lifecycle status of the review cycle indicating its operational state (draft, scheduled, active, in progress, completed, closed, cancelled).',
    `review_cycle_type` STRING COMMENT 'Classification of the review cycle indicating its purpose and frequency (e.g., annual performance review, mid-year check-in, probationary review, project-based review, ad-hoc review, quarterly review).',
    CONSTRAINT pk_review_cycle PRIMARY KEY(`review_cycle_id`)
) COMMENT 'Master reference table for review_cycle. Referenced by review_cycle_id.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`workforce`.`employee_group` (
    `employee_group_id` BIGINT COMMENT 'Primary key for employee_group',
    `parent_group_id` BIGINT COMMENT 'Self-referencing identifier for the parent employee group, enabling hierarchical grouping (e.g., All Field Staff → National Field Staff → Community Health Workers).',
    `parent_employee_group_id` BIGINT COMMENT 'Self-referencing FK on employee_group (parent_employee_group_id)',
    `benefit_eligibility_tier` STRING COMMENT 'Benefit entitlement tier assigned to this employee group, governing which benefit plans (health insurance, pension, housing allowance, R&R) are available to group members.',
    `collective_bargaining_applicable` BOOLEAN COMMENT 'Indicates whether the terms and conditions of employment for this group are governed by a collective bargaining agreement (CBA) with a recognized trade union.',
    `compensation_basis` STRING COMMENT 'Basis on which compensation is calculated and paid for members of this employee group (e.g., monthly salary for regular staff, daily rate for consultants, stipend for interns).',
    `contract_template_code` STRING COMMENT 'Code referencing the standard employment contract template used for staff in this group. Ensures consistent contractual terms and legal compliance per employment category.',
    `cost_recovery_rate` DECIMAL(18,2) COMMENT 'Indirect cost recovery rate (overhead rate) applied to staff costs for this employee group when charging to donor grants and projects. Expressed as a decimal fraction (e.g., 0.15 = 15%).',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this employee group record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code in which compensation is denominated and paid for this employee group (e.g., USD for international staff, local currency for national staff).',
    `employee_group_description` STRING COMMENT 'Narrative description of the employee group, including its purpose, scope, and any special HR policy considerations applicable to members of this group.',
    `donor_reporting_category` STRING COMMENT 'Category used when reporting staff costs to donors. Determines how staff in this group appear in financial reports, budget narratives, and audit documentation.',
    `duty_station_type` STRING COMMENT 'Classification of the typical duty station for this employee group, affecting hardship allowances, security protocols, and R&R entitlements.',
    `effective_date` DATE COMMENT 'Date from which this employee group definition becomes effective and can be used for staff assignments and payroll processing.',
    `employment_category` STRING COMMENT 'Categorization of the employment arrangement within the group, distinguishing regular/permanent staff from fixed-term, casual, part-time, or project-based engagements. Determines contract templates and statutory entitlements.',
    `expiry_date` DATE COMMENT 'Date on which this employee group definition expires and is no longer available for new assignments. Null for open-ended groups.',
    `external_reference_code` STRING COMMENT 'Code used to identify this employee group in external systems such as government labor registries, pension fund administrators, or third-party payroll processors.',
    `fte_equivalent` DECIMAL(18,2) COMMENT 'Full-Time Equivalent ratio for this employee group (e.g., 1.0 for full-time, 0.5 for half-time). Used in workforce planning, budget allocation, and donor reporting.',
    `group_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the employee group, used in payroll, HRIS integrations, and reporting (e.g., NATL_STAFF, EXPAT, INTERN, VOLUNTEER_STAFF).',
    `group_name` STRING COMMENT 'Full descriptive name of the employee group as displayed in HR systems and reports (e.g., National Staff, International Staff, Expatriate, Consultant, Intern).',
    `group_type` STRING COMMENT 'Broad classification of the employee group indicating the nature of the employment relationship and residency status. Drives benefit eligibility, payroll rules, and compliance requirements. [ENUM-REF-CANDIDATE: national_staff|international_staff|expatriate|consultant|intern|volunteer_staff|secondee — promote to reference product]',
    `hardship_allowance_eligible` BOOLEAN COMMENT 'Indicates whether members of this employee group are eligible for hardship or hazard allowances based on duty station classification.',
    `headcount_cap` STRING COMMENT 'Maximum authorized headcount for this employee group as approved in the organizational staffing plan. Used for workforce planning and budget control. Null if uncapped.',
    `is_field_staff` BOOLEAN COMMENT 'Indicates whether this employee group is classified as field-based staff, triggering field-specific HR policies, security protocols, and allowances.',
    `is_program_staff` BOOLEAN COMMENT 'Indicates whether this employee group is classified as program/technical staff (as opposed to support/administrative staff), relevant for donor cost allocation and RACI assignments.',
    `leave_policy_code` STRING COMMENT 'Reference code for the leave policy applicable to this employee group, governing annual leave, sick leave, R&R (Rest and Recuperation), and emergency leave entitlements.',
    `mandatory_training_profile` STRING COMMENT 'Code referencing the mandatory training curriculum profile assigned to this employee group (e.g., safeguarding, security awareness, code of conduct, data protection).',
    `medical_evacuation_eligible` BOOLEAN COMMENT 'Indicates whether members of this employee group are covered under the organizations medical evacuation policy, typically applicable to international and field-based staff.',
    `notice_period_days` STRING COMMENT 'Standard notice period in calendar days required for resignation or termination for staff in this employee group, as defined in the applicable contract template.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether members of this employee group are eligible for overtime compensation. Senior management and certain professional categories are typically exempt.',
    `payroll_category` STRING COMMENT 'Payroll processing category assigned to this employee group, determining which payroll run, currency, and tax regime applies. Critical for multi-currency NGO payroll operations.',
    `pension_scheme_code` STRING COMMENT 'Code identifying the pension or provident fund scheme applicable to this employee group (e.g., UNDP pension, national provident fund, private pension plan).',
    `performance_review_cycle_code` STRING COMMENT 'Code identifying the performance review cycle applicable to this employee group (e.g., annual, semi-annual, probationary). Drives automated review scheduling in the HRIS.',
    `probation_period_days` STRING COMMENT 'Standard probationary period in calendar days applicable to new hires in this employee group before confirmation of employment.',
    `r_and_r_eligible` BOOLEAN COMMENT 'Indicates whether members of this employee group are entitled to Rest and Recuperation (R&R) breaks, typically applicable to staff in hardship or non-family duty stations.',
    `recruitment_source_type` STRING COMMENT 'Typical recruitment source for this employee group, used in talent acquisition planning and diversity reporting.',
    `relocation_support_eligible` BOOLEAN COMMENT 'Indicates whether members of this employee group are entitled to relocation assistance (travel, shipping, settling-in allowance) upon assignment or transfer.',
    `safeguarding_check_required` BOOLEAN COMMENT 'Indicates whether members of this employee group must undergo safeguarding (PSEA/child protection) background checks as a condition of employment or deployment.',
    `salary_scale_code` STRING COMMENT 'Reference code for the salary scale or grade structure applicable to this employee group (e.g., UN salary scale, NGO national salary scale, consultant rate card).',
    `security_clearance_required` BOOLEAN COMMENT 'Indicates whether members of this employee group require a security clearance or background check prior to deployment, particularly for field operations in conflict-affected areas.',
    `social_security_applicable` BOOLEAN COMMENT 'Indicates whether members of this employee group are subject to host-country social security contributions. Typically false for expatriate staff covered under home-country schemes.',
    `sort_order` STRING COMMENT 'Numeric value controlling the display order of employee groups in HR system dropdowns, reports, and dashboards.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Standard contracted working hours per week for members of this employee group, used for FTE (Full-Time Equivalent) calculations and payroll processing.',
    `employee_group_status` STRING COMMENT 'Current lifecycle status of the employee group record. Active groups are available for assignment; inactive groups are suspended from new assignments; archived groups are retained for historical reference only.',
    `tax_treatment` STRING COMMENT 'Tax treatment applicable to compensation for members of this employee group. Expatriate and diplomatic staff may have different tax obligations than national staff.',
    `union_membership_applicable` BOOLEAN COMMENT 'Indicates whether members of this employee group are eligible or required to be members of a trade union or staff association under applicable labor law.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when this employee group record was last modified in the system.',
    `visa_sponsorship_required` BOOLEAN COMMENT 'Indicates whether the organization is required to sponsor work visas or permits for members of this employee group, applicable to international and expatriate staff.',
    `work_schedule_type` STRING COMMENT 'Standard work schedule arrangement for this employee group, determining standard working hours, shift patterns, and time-tracking requirements.',
    CONSTRAINT pk_employee_group PRIMARY KEY(`employee_group_id`)
) COMMENT 'Master reference table for employee_group. Referenced by employee_group_id.';

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
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ADD CONSTRAINT `fk_workforce_benefit_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
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
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ADD CONSTRAINT `fk_workforce_learning_course_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
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
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ADD CONSTRAINT `fk_workforce_disciplinary_case_tertiary_disciplinary_investigator_staff_member_id` FOREIGN KEY (`tertiary_disciplinary_investigator_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ADD CONSTRAINT `fk_workforce_separation_event_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ADD CONSTRAINT `fk_workforce_separation_event_primary_separation_staff_member_id` FOREIGN KEY (`primary_separation_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ADD CONSTRAINT `fk_workforce_separation_event_separation_staff_member_id` FOREIGN KEY (`separation_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ADD CONSTRAINT `fk_workforce_separation_event_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ADD CONSTRAINT `fk_workforce_staff_certification_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_amended_timesheet_id` FOREIGN KEY (`amended_timesheet_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`timesheet`(`timesheet_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_primary_timesheet_staff_member_id` FOREIGN KEY (`primary_timesheet_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_candidate_referring_staff_member_id` FOREIGN KEY (`candidate_referring_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_recruitment_requisition_id` FOREIGN KEY (`recruitment_requisition_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`recruitment_requisition`(`recruitment_requisition_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_referred_by_candidate_id` FOREIGN KEY (`referred_by_candidate_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`candidate`(`candidate_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ADD CONSTRAINT `fk_workforce_candidate_referring_staff_member_id` FOREIGN KEY (`referring_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_competency_framework_id` FOREIGN KEY (`competency_framework_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`competency_framework`(`competency_framework_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_derived_from_review_template_id` FOREIGN KEY (`derived_from_review_template_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`review_template`(`review_template_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_rating_scale_id` FOREIGN KEY (`rating_scale_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`rating_scale`(`rating_scale_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_review_created_by_staff_member_id` FOREIGN KEY (`review_created_by_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_review_last_modified_by_employee_staff_member_id` FOREIGN KEY (`review_last_modified_by_employee_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ADD CONSTRAINT `fk_workforce_review_template_creator_staff_member_id` FOREIGN KEY (`creator_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ADD CONSTRAINT `fk_workforce_performance_improvement_plan_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ADD CONSTRAINT `fk_workforce_performance_improvement_plan_performance_manager_staff_member_id` FOREIGN KEY (`performance_manager_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ADD CONSTRAINT `fk_workforce_performance_improvement_plan_performance_previous_pip_performance_improvement_plan_id` FOREIGN KEY (`performance_previous_pip_performance_improvement_plan_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`performance_improvement_plan`(`performance_improvement_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ADD CONSTRAINT `fk_workforce_performance_improvement_plan_performance_subject_staff_member_id` FOREIGN KEY (`performance_subject_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ADD CONSTRAINT `fk_workforce_performance_improvement_plan_primary_extended_performance_improvement_plan_id` FOREIGN KEY (`primary_extended_performance_improvement_plan_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`performance_improvement_plan`(`performance_improvement_plan_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ADD CONSTRAINT `fk_workforce_performance_improvement_plan_disciplinary_case_id` FOREIGN KEY (`disciplinary_case_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`disciplinary_case`(`disciplinary_case_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ADD CONSTRAINT `fk_workforce_performance_improvement_plan_supervisor_staff_member_id` FOREIGN KEY (`supervisor_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_calibration_facilitator_staff_member_id` FOREIGN KEY (`calibration_facilitator_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_calibration_last_modified_by_employee_staff_member_id` FOREIGN KEY (`calibration_last_modified_by_employee_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_followup_calibration_session_id` FOREIGN KEY (`followup_calibration_session_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`calibration_session`(`calibration_session_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_rating_scale_id` FOREIGN KEY (`rating_scale_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`rating_scale`(`rating_scale_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_review_cycle_id` FOREIGN KEY (`review_cycle_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`review_cycle`(`review_cycle_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ADD CONSTRAINT `fk_workforce_calibration_session_facilitator_staff_member_id` FOREIGN KEY (`facilitator_staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ADD CONSTRAINT `fk_workforce_competency_framework_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ADD CONSTRAINT `fk_workforce_competency_framework_superseded_competency_framework_id` FOREIGN KEY (`superseded_competency_framework_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`competency_framework`(`competency_framework_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ADD CONSTRAINT `fk_workforce_rating_scale_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ADD CONSTRAINT `fk_workforce_rating_scale_superseded_rating_scale_id` FOREIGN KEY (`superseded_rating_scale_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`rating_scale`(`rating_scale_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_employee_group_id` FOREIGN KEY (`employee_group_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`employee_group`(`employee_group_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_prior_review_cycle_id` FOREIGN KEY (`prior_review_cycle_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`review_cycle`(`review_cycle_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_rating_scale_id` FOREIGN KEY (`rating_scale_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`rating_scale`(`rating_scale_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_review_org_unit_id` FOREIGN KEY (`review_org_unit_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_review_organization_id` FOREIGN KEY (`review_organization_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_review_template_id` FOREIGN KEY (`review_template_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`review_template`(`review_template_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ADD CONSTRAINT `fk_workforce_review_cycle_staff_member_id` FOREIGN KEY (`staff_member_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`staff_member`(`staff_member_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` ADD CONSTRAINT `fk_workforce_employee_group_parent_group_id` FOREIGN KEY (`parent_group_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`employee_group`(`employee_group_id`);
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` ADD CONSTRAINT `fk_workforce_employee_group_parent_employee_group_id` FOREIGN KEY (`parent_employee_group_id`) REFERENCES `vibe_ngo_v1`.`workforce`.`employee_group`(`employee_group_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_ngo_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` SET TAGS ('dbx_subdomain' = 'staff_management');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `supervisor_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `supervisor_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `supervisor_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed_term|consultancy|secondment|internship|volunteer_staff');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `duty_station` SET TAGS ('dbx_business_glossary_term' = 'Duty Station');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Full Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_value_regex' = 'spouse|parent|sibling|child|friend|other');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `employee_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `employee_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|suspended|separated|probation');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expatriate|field_personnel|headquarters');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `exit_interview_completed` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `gender` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `gender` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `job_grade` SET TAGS ('dbx_business_glossary_term' = 'Job Grade');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `job_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_business_glossary_term' = 'Legal First Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `legal_first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Last Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `legal_last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality (ISO 3166-1 Alpha-3 Country Code)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `nationality` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `nationality` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Passport Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `passport_expiry_date` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `passport_number` SET TAGS ('dbx_business_glossary_term' = 'Passport Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `passport_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `passport_number` SET TAGS ('dbx_pii_passport' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi_weekly|weekly|semi_monthly');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `rehire_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency (ISO 4217)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `salary_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `salary_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `separation_date` SET TAGS ('dbx_business_glossary_term' = 'Separation Effective Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `separation_reason` SET TAGS ('dbx_business_glossary_term' = 'Separation Reason Narrative');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `separation_type` SET TAGS ('dbx_business_glossary_term' = 'Separation Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `separation_type` SET TAGS ('dbx_value_regex' = 'resignation|end_of_contract|redundancy|termination|retirement|death_in_service');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_email` SET TAGS ('dbx_business_glossary_term' = 'Work Email Address');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_permit_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Work Permit Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_permit_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number (E.164 Format)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_phone` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `workday_worker_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Human Resource Information System (HRIS) Worker ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `workday_worker_reference` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_member` ALTER COLUMN `workday_worker_reference` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'staff_management');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports-To Position ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Incumbent Worker ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `availability_date` SET TAGS ('dbx_business_glossary_term' = 'Position Availability Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `budgeted_annual_cost` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Annual Cost');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `budgeted_annual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^POS-[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `duty_station` SET TAGS ('dbx_business_glossary_term' = 'Duty Station');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Position End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `filled_date` SET TAGS ('dbx_business_glossary_term' = 'Position Filled Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_value_regex' = 'grant|core|split|in-kind|cost-share');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `headcount_plan_year` SET TAGS ('dbx_business_glossary_term' = 'Headcount Plan Year');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `icr_applicable` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR) Applicable Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `is_field_position` SET TAGS ('dbx_business_glossary_term' = 'Field Position Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `is_supervisory` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Position Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `is_vacant` SET TAGS ('dbx_business_glossary_term' = 'Position Vacancy Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `job_description_url` SET TAGS ('dbx_business_glossary_term' = 'Job Description URL');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `max_salary` SET TAGS ('dbx_business_glossary_term' = 'Maximum Salary');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `max_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `max_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `min_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `min_salary` SET TAGS ('dbx_business_glossary_term' = 'Minimum Salary');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `min_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `min_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `min_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `pay_grade_band` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Band');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `pay_grade_band` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,3}[0-9]{1,3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `pay_grade_band` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `raci_role` SET TAGS ('dbx_business_glossary_term' = 'Responsible Accountable Consulted Informed (RACI) Role');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `raci_role` SET TAGS ('dbx_value_regex' = 'responsible|accountable|consulted|informed');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `required_competencies` SET TAGS ('dbx_business_glossary_term' = 'Required Competencies');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `required_languages` SET TAGS ('dbx_business_glossary_term' = 'Required Languages');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `required_languages` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `security_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Required Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'national|international|expatriate|consultant|intern');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|filled|frozen|eliminated|proposed');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed-term|temporary|secondment|volunteer');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `vacancy_reason` SET TAGS ('dbx_business_glossary_term' = 'Vacancy Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`position` ALTER COLUMN `workday_position_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday HCM Position ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` SET TAGS ('dbx_subdomain' = 'staff_management');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `amendment_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Effective Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `amendment_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Contract Approved By');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `duty_station` SET TAGS ('dbx_business_glossary_term' = 'Duty Station');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `education_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Education Allowance Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `education_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `education_allowance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `funding_source_code` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `hardship_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Hardship Allowance Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `hardship_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `hardship_allowance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `hardship_tier` SET TAGS ('dbx_business_glossary_term' = 'Hardship Allowance Tier');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `hardship_tier` SET TAGS ('dbx_value_regex' = 'H|A|B|C|D|E');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `home_leave_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Home Leave Frequency (Months)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Housing Allowance Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `icr_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `icr_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `ingo_salary_scale` SET TAGS ('dbx_business_glossary_term' = 'International Non-Governmental Organization (INGO) Salary Scale');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `ingo_salary_scale` SET TAGS ('dbx_value_regex' = 'un_common_system|organizational_scale|national_scale|icsc_scale|other');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `ingo_salary_scale` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `ingo_salary_scale` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `is_expatriate` SET TAGS ('dbx_business_glossary_term' = 'Expatriate Staff Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `labor_law_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Labor Law Jurisdiction');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `medevac_coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Medical Evacuation (MEDEVAC) Coverage Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `medevac_coverage_level` SET TAGS ('dbx_value_regex' = 'basic|standard|enhanced|full');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `medevac_coverage_level` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period (Days)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{4}-[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `probation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Probation Period End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `relocation_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Relocation Allowance Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `relocation_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `relocation_allowance_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `rnr_cycle_weeks` SET TAGS ('dbx_business_glossary_term' = 'Rest and Recuperation (R&R) Cycle (Weeks)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_frequency` SET TAGS ('dbx_business_glossary_term' = 'Salary Payment Frequency');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi_weekly|weekly|annual');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_frequency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_frequency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_step` SET TAGS ('dbx_business_glossary_term' = 'Salary Step');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_step` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `salary_step` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'international|national|third_country_national|consultant|secondee');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `employment_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `employment_contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|on_hold|terminated|expired|amended');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `employment_contract_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `employment_contract_type` SET TAGS ('dbx_value_regex' = 'fixed_term|open_ended|consultancy|secondment|internship|volunteer');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employment_contract` ALTER COLUMN `workday_contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday HCM Contract Reference ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'staff_management');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Manager ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `annual_budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget (USD)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `annual_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `city_name` SET TAGS ('dbx_business_glossary_term' = 'City Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `city_name` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `funding_model` SET TAGS ('dbx_business_glossary_term' = 'Funding Model');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `funding_model` SET TAGS ('dbx_value_regex' = 'core|grant_funded|mixed|self_funded');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_authorized` SET TAGS ('dbx_business_glossary_term' = 'Authorized Headcount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `iati_org_identifier` SET TAGS ('dbx_business_glossary_term' = 'International Aid Transparency Initiative (IATI) Organization Identifier');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `icr_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `icr_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `international_staff_count` SET TAGS ('dbx_business_glossary_term' = 'International Staff Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `is_field_office` SET TAGS ('dbx_business_glossary_term' = 'Is Field Office Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `is_hq` SET TAGS ('dbx_business_glossary_term' = 'Is Headquarters Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `mandate_description` SET TAGS ('dbx_business_glossary_term' = 'Mandate Description');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `mission_statement` SET TAGS ('dbx_business_glossary_term' = 'Unit Mission Statement');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `national_staff_count` SET TAGS ('dbx_business_glossary_term' = 'National Staff Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_address` SET TAGS ('dbx_business_glossary_term' = 'Office Address');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_email` SET TAGS ('dbx_business_glossary_term' = 'Office Email Address');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_phone` SET TAGS ('dbx_business_glossary_term' = 'Office Phone Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9s-().]{7,20}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `office_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `region_name` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `region_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `registration_country_code` SET TAGS ('dbx_business_glossary_term' = 'Registration Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `registration_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `registration_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Registration Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `sap_company_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Company Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `sap_company_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Phase Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'phase1|phase2|phase3|phase4|phase5');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `short_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|dissolved|merged');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `volunteer_count` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`org_unit` ALTER COLUMN `workday_org_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Organization ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` SET TAGS ('dbx_subdomain' = 'staff_management');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `background_check_level` SET TAGS ('dbx_business_glossary_term' = 'Background Check Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `background_check_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|criminal_record|child_protection|not_required');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `competency_framework_code` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `competency_framework_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `core_competencies` SET TAGS ('dbx_business_glossary_term' = 'Core Competencies');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `duty_station_type` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `duty_station_type` SET TAGS ('dbx_value_regex' = 'headquarters|country_office|field_office|remote|roving');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|fixed_term|casual|secondment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `field_experience_required` SET TAGS ('dbx_business_glossary_term' = 'Field Experience Required');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `flsa_exemption_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Exemption Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `flsa_exemption_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `icr_cost_category` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR) Cost Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `icr_cost_category` SET TAGS ('dbx_value_regex' = 'direct|indirect|shared');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `is_critical_role` SET TAGS ('dbx_business_glossary_term' = 'Is Critical Role');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `is_safeguarding_designated` SET TAGS ('dbx_business_glossary_term' = 'Is Safeguarding Designated Role');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_category` SET TAGS ('dbx_business_glossary_term' = 'Job Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_category` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expatriate|consultant|volunteer|intern');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_family_group_name` SET TAGS ('dbx_business_glossary_term' = 'Job Family Group Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_family_group_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_family_name` SET TAGS ('dbx_business_glossary_term' = 'Job Family Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_family_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_family_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_level` SET TAGS ('dbx_business_glossary_term' = 'Job Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `key_responsibilities` SET TAGS ('dbx_business_glossary_term' = 'Key Responsibilities');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `language_requirements` SET TAGS ('dbx_business_glossary_term' = 'Language Requirements');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `language_requirements` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `leadership_competencies` SET TAGS ('dbx_business_glossary_term' = 'Leadership Competencies');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_business_glossary_term' = 'Management Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_value_regex' = 'individual_contributor|team_lead|manager|senior_manager|director|executive');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `management_level` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `min_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `min_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_name` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z]{1,3}[0-9]{1,3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_max_usd` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Maximum (USD)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_max_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_midpoint_usd` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Midpoint (USD)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_midpoint_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_min_usd` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade Minimum (USD)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `pay_grade_min_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `preferred_certifications` SET TAGS ('dbx_business_glossary_term' = 'Preferred Certifications');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `program_area` SET TAGS ('dbx_business_glossary_term' = 'Program Area');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `job_profile_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|under_review|archived');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `succession_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Succession Eligibility');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Job Profile Summary');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `travel_requirement` SET TAGS ('dbx_value_regex' = 'none|occasional|frequent|extensive|field_based');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `workday_job_profile_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday HCM Job Profile ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_profile` ALTER COLUMN `workday_job_profile_reference` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_-]{1,50}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|on_hold');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Reference');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Functional Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `functional_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `fund_code` SET TAGS ('dbx_business_glossary_term' = 'Fund Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `grant_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `icr_rate` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `is_retroactive` SET TAGS ('dbx_business_glossary_term' = 'Is Retroactive Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `legal_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{4}-[0-9]{2}-[0-9]{4}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|mobile_money|check|cash|prepaid_card');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_group` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_group` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expat|volunteer|consultant');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `processed_by` SET TAGS ('dbx_business_glossary_term' = 'Processed By');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `retroactive_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|calculated|approved|paid|cancelled');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Deductions');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_contributions` SET TAGS ('dbx_business_glossary_term' = 'Total Employer Contributions');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_contributions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Pay');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Net Pay');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_tax_withheld` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Withheld');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_tax_withheld` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_type` SET TAGS ('dbx_value_regex' = 'regular|off_cycle|supplemental|correction|final');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payroll_run` ALTER COLUMN `workday_run_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Run ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `payslip_id` SET TAGS ('dbx_business_glossary_term' = 'Payslip ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `original_payslip_id` SET TAGS ('dbx_business_glossary_term' = 'Original Payslip ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Reference');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `bank_account_reference` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `employer_pension_contribution` SET TAGS ('dbx_business_glossary_term' = 'Employer Pension Contribution');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `employer_pension_contribution` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `employer_social_security` SET TAGS ('dbx_business_glossary_term' = 'Employer Social Security Contribution');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `employer_social_security` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `employer_social_security` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `expat_allowance` SET TAGS ('dbx_business_glossary_term' = 'Expatriate (Expat) Allowance');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `expat_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `expat_allowance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `field_allowance` SET TAGS ('dbx_business_glossary_term' = 'Field Allowance');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `field_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `field_allowance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `gl_journal_reference` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Journal Reference');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `grant_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `gross_salary` SET TAGS ('dbx_business_glossary_term' = 'Gross Salary');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `gross_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `gross_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `hardship_allowance` SET TAGS ('dbx_business_glossary_term' = 'Hardship Allowance');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `hardship_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `hardship_allowance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `housing_allowance` SET TAGS ('dbx_business_glossary_term' = 'Housing Allowance');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `housing_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `housing_allowance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `income_tax_deduction` SET TAGS ('dbx_business_glossary_term' = 'Income Tax Deduction');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `income_tax_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `income_tax_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `is_correction` SET TAGS ('dbx_business_glossary_term' = 'Payslip Correction Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `is_off_cycle` SET TAGS ('dbx_business_glossary_term' = 'Off-Cycle Payroll Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Local Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `local_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `net_pay_local` SET TAGS ('dbx_business_glossary_term' = 'Net Pay (Local Currency)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `net_pay_local` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `net_pay_local` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `net_pay_payment_currency` SET TAGS ('dbx_business_glossary_term' = 'Net Pay (Payment Currency)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `net_pay_payment_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `net_pay_payment_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Payslip Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^PSL-[A-Z]{2,4}-[0-9]{4}-[0-9]{2}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `pay_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `pay_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `payment_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bank_transfer|cash|mobile_money|cheque');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `payroll_group` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `payroll_group` SET TAGS ('dbx_value_regex' = 'national|international|expat|consultant');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `payroll_run_sequence` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Sequence Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `pension_deduction` SET TAGS ('dbx_business_glossary_term' = 'Pension Deduction');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `pension_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `pension_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `run_status` SET TAGS ('dbx_value_regex' = 'draft|calculated|approved|paid|reversed|cancelled');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `social_security_deduction` SET TAGS ('dbx_business_glossary_term' = 'Social Security Deduction');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `social_security_deduction` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `social_security_deduction` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `payslip_status` SET TAGS ('dbx_business_glossary_term' = 'Payslip Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `payslip_status` SET TAGS ('dbx_value_regex' = 'generated|issued|reversed|corrected');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `total_allowances` SET TAGS ('dbx_business_glossary_term' = 'Total Allowances');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `total_allowances` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `total_allowances` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `total_statutory_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Statutory Deductions');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `total_statutory_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `total_statutory_deductions` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `transport_allowance` SET TAGS ('dbx_business_glossary_term' = 'Transport Allowance');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `transport_allowance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `transport_allowance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `voluntary_deductions` SET TAGS ('dbx_business_glossary_term' = 'Voluntary Deductions');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `voluntary_deductions` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`payslip` ALTER COLUMN `voluntary_deductions` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Enrollment ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Approval Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Approved By');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Beneficiary Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Relationship');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_relationship` SET TAGS ('dbx_value_regex' = 'spouse|child|parent|sibling|other');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `cobra_eligible` SET TAGS ('dbx_business_glossary_term' = 'COBRA Continuation Eligibility Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_currency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi_weekly|weekly|annual');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_plus_spouse|employee_plus_children|employee_plus_family');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `duty_station_hardship_level` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Hardship Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `duty_station_hardship_level` SET TAGS ('dbx_value_regex' = 'H|A|B|C|D|E');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `eligibility_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Event Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'new_hire|open_enrollment|life_event|rehire|transfer|correction');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `grant_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `is_dependent_coverage` SET TAGS ('dbx_business_glossary_term' = 'Dependent Coverage Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `is_dependent_coverage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Life Insurance Coverage Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `life_insurance_coverage_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `medevac_coverage_zone` SET TAGS ('dbx_business_glossary_term' = 'Medical Evacuation (Medevac) Coverage Zone');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `medevac_coverage_zone` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `open_enrollment_period` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Period');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `pension_contribution_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Pension Contribution Rate Percentage');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `pension_contribution_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_provider` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Provider');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_provider_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Plan Provider Policy Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_provider_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'health_insurance|life_insurance|pension|medical_evacuation|rest_and_recuperation');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `plan_year` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `rr_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Rest and Recuperation (R&R) Cycle Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'national|international|expatriate|consultant');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|waived|on_leave|suspended');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Benefit Waiting Period Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Benefit Waiver Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Admin System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `annual_coverage_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Coverage Limit (USD)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `annual_coverage_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `annual_coverage_limit_usd` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Benefit Contribution Frequency');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi_weekly|weekly|annual|quarterly');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_description` SET TAGS ('dbx_business_glossary_term' = 'Benefit Coverage Description');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_description` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Benefit Coverage Tier');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'individual|individual_plus_spouse|family|employee_plus_children');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `deductible_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Deductible Amount (USD)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `deductible_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `dependent_coverage_allowed` SET TAGS ('dbx_business_glossary_term' = 'Dependent Coverage Allowed Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `dependent_coverage_allowed` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Document URL');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employee_contribution_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount (USD)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employee_contribution_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employee_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Percentage');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employee_contribution_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employer_contribution_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount (USD)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employer_contribution_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employer_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Percentage');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employer_contribution_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employment_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Employment Type Eligibility');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `employment_type_eligibility` SET TAGS ('dbx_value_regex' = 'full_time|part_time|fixed_term|all');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Enrollment Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'automatic|voluntary|mandatory');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Geographic Scope');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `geographic_scope` SET TAGS ('dbx_value_regex' = 'global|regional|country_specific');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `hardship_location_applicable` SET TAGS ('dbx_business_glossary_term' = 'Hardship Location Applicable Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `is_grant_chargeable` SET TAGS ('dbx_business_glossary_term' = 'Grant Chargeable Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `is_medevac_included` SET TAGS ('dbx_business_glossary_term' = 'Medical Evacuation (MedEvac) Included Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `is_rnr_included` SET TAGS ('dbx_business_glossary_term' = 'Rest and Recuperation (R&R) Entitlement Included Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Last Reviewed Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `max_dependents_covered` SET TAGS ('dbx_business_glossary_term' = 'Maximum Dependents Covered');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `minimum_service_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Service Months for Eligibility');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `next_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Next Renewal Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `open_enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `open_enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Open Enrollment Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Provider Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `provider_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `provider_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Provider Policy Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `provider_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `regulatory_compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Reference');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `rnr_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Rest and Recuperation (R&R) Frequency in Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `staff_category_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Staff Category Eligibility');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `staff_category_eligibility` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|both|expatriate|volunteer');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `benefit_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Benefit Waiting Period in Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`benefit_plan` ALTER COLUMN `year_start_month` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Year Start Month');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Job Profile ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_recruiter_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter Employee ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_recruiter_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `tertiary_recruitment_recruiter_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `actual_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Fill Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `application_deadline` SET TAGS ('dbx_business_glossary_term' = 'Application Deadline');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|escalated');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Annual Salary');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `duty_station` SET TAGS ('dbx_business_glossary_term' = 'Duty Station');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `education_level_required` SET TAGS ('dbx_business_glossary_term' = 'Required Education Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `education_level_required` SET TAGS ('dbx_value_regex' = 'certificate|diploma|bachelors|masters|phd|none');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|fixed_term|consultancy|volunteer');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `funding_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Funding Confirmed Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_value_regex' = 'grant|core_funds|cost_share|bridge_funding|multi_donor');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `gender_marker` SET TAGS ('dbx_business_glossary_term' = 'Gender Marker');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `gender_marker` SET TAGS ('dbx_value_regex' = 'open|female_preferred|male_preferred');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `gender_marker` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `gender_marker` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `gender_marker` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `headcount_type` SET TAGS ('dbx_business_glossary_term' = 'Headcount Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `headcount_type` SET TAGS ('dbx_value_regex' = 'backfill|new_position|replacement|surge_addition');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `is_emergency_surge` SET TAGS ('dbx_business_glossary_term' = 'Emergency Surge Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Job Posting Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `minimum_experience_years` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience Years');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `number_of_openings` SET TAGS ('dbx_business_glossary_term' = 'Number of Openings');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Opened Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `positions_filled_count` SET TAGS ('dbx_business_glossary_term' = 'Positions Filled Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_type` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_type` SET TAGS ('dbx_value_regex' = 'internal|external|emergency_surge|rehire|secondment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `salary_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `security_clearance_required` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Required Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `sourcing_channels` SET TAGS ('dbx_business_glossary_term' = 'Sourcing Channels');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expatriate|hcn|tcn');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `recruitment_requisition_status` SET TAGS ('dbx_value_regex' = 'draft|open|on_hold|filled|cancelled|closed');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `target_fill_date` SET TAGS ('dbx_business_glossary_term' = 'Target Fill Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`recruitment_requisition` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `job_application_id` SET TAGS ('dbx_business_glossary_term' = 'Job Application ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `funding_source_id` SET TAGS ('dbx_business_glossary_term' = 'Funding Source ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Recruiter ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Requisition ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|cleared|failed|waived');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `candidate_type` SET TAGS ('dbx_business_glossary_term' = 'Candidate Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `candidate_type` SET TAGS ('dbx_value_regex' = 'external|internal|rehire|contractor_conversion');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `cover_letter_reference` SET TAGS ('dbx_business_glossary_term' = 'Cover Letter Document Reference');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `cover_letter_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `cv_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Curriculum Vitae (CV) / Resume Document Reference');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `cv_document_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `job_application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `disability_disclosure` SET TAGS ('dbx_business_glossary_term' = 'Disability Disclosure Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `disability_disclosure` SET TAGS ('dbx_value_regex' = 'disclosed|not_disclosed|prefer_not_to_say');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `disability_disclosure` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `disability_disclosure` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `duty_station` SET TAGS ('dbx_business_glossary_term' = 'Duty Station');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `gender_self_identified` SET TAGS ('dbx_business_glossary_term' = 'Self-Identified Gender');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `gender_self_identified` SET TAGS ('dbx_value_regex' = 'male|female|non_binary|prefer_not_to_say|other');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `gender_self_identified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `gender_self_identified` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `grant_funded_position` SET TAGS ('dbx_business_glossary_term' = 'Grant-Funded Position Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_business_glossary_term' = 'Highest Education Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `hiring_decision` SET TAGS ('dbx_business_glossary_term' = 'Hiring Decision');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `hiring_decision` SET TAGS ('dbx_value_regex' = 'selected|not_selected|reserve_list|pending');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `interview_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `interview_panel_notes` SET TAGS ('dbx_business_glossary_term' = 'Interview Panel Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `interview_panel_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `interview_score` SET TAGS ('dbx_business_glossary_term' = 'Interview Score');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `interview_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_business_glossary_term' = 'Nationality Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `nationality_country_code` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Application Reference Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^APP-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `offer_extended_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `position_title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `proposed_salary` SET TAGS ('dbx_business_glossary_term' = 'Proposed Salary');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `proposed_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `proposed_salary` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `proposed_start_date` SET TAGS ('dbx_business_glossary_term' = 'Proposed Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `reference_check_status` SET TAGS ('dbx_business_glossary_term' = 'Reference Check Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `reference_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|waived|failed');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `safeguarding_check_status` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Check Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `safeguarding_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|cleared|failed|waived');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Salary Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `salary_currency_code` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `salary_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `salary_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `screening_score` SET TAGS ('dbx_business_glossary_term' = 'Screening Score');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `screening_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Application Source Channel');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expatriate|consultant|volunteer');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Application Pipeline Stage');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `stage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `stage_outcome` SET TAGS ('dbx_business_glossary_term' = 'Stage Outcome');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `stage_outcome` SET TAGS ('dbx_value_regex' = 'passed|failed|withdrawn|pending|on_hold|waived');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `stage_outcome` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `job_application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Lifecycle Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `job_application_status` SET TAGS ('dbx_value_regex' = 'active|offer_extended|hired|rejected|withdrawn|on_hold');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `written_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Written Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `written_assessment_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`job_application` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years of Relevant Experience');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'performance_learning');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `calibration_session_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Session ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_improvement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `review_template_id` SET TAGS ('dbx_business_glossary_term' = 'Review Template ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `accountability_rating` SET TAGS ('dbx_business_glossary_term' = 'Accountability to Affected Populations Rating');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `accountability_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `collaboration_rating` SET TAGS ('dbx_business_glossary_term' = 'Collaboration Competency Rating');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `collaboration_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `competency_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Competency Rating Score');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `cycle_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probation|end_of_contract|ad_hoc');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `development_recommendations` SET TAGS ('dbx_business_glossary_term' = 'Development Recommendations');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `development_recommendations` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `duty_station` SET TAGS ('dbx_business_glossary_term' = 'Duty Station');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledged` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledged_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Review Comments');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_disagreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Employee Disagreement Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_disagreement_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_business_glossary_term' = 'Employee Self-Assessment Narrative');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_self_assessment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Competency Rating');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `meeting_date` SET TAGS ('dbx_business_glossary_term' = 'Review Meeting Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Review Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^PR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `objective_achievement_score` SET TAGS ('dbx_business_glossary_term' = 'Objective Achievement Score');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating Score');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `pip_required` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Required Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `pip_required` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommendation Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommendation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `rating_scale_version` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Version');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `retention_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Retention Risk Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `retention_risk_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_narrative` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Narrative Comments');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_narrative` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expatriate|consultant|volunteer');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|pending_acknowledgment|completed|cancelled');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Review Submitted Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `technical_skills_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Skills Competency Rating');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `technical_skills_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `values_alignment_rating` SET TAGS ('dbx_business_glossary_term' = 'Organizational Values Alignment Rating');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_review` ALTER COLUMN `values_alignment_rating` SET TAGS ('dbx_value_regex' = 'exceptional|exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` SET TAGS ('dbx_subdomain' = 'performance_learning');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `learning_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Enrollment ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Course ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `actual_hours_spent` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Spent');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Course Completion Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `completion_evidence_url` SET TAGS ('dbx_business_glossary_term' = 'Completion Evidence URL');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Training Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `learning_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Delivery Mode');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'e_learning|instructor_led|blended|on_the_job|webinar|self_study');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `department_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Training Due Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Course Duration (Hours)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `is_certified` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `job_profile` SET TAGS ('dbx_business_glossary_term' = 'Job Profile');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable|pending_assessment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `provider_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = 'internal|external|un_agency|ingo_partner|government|academic');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `required_frequency` SET TAGS ('dbx_business_glossary_term' = 'Required Training Frequency');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `required_frequency` SET TAGS ('dbx_value_regex' = 'once|annual|biennial|quarterly|as_needed');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'self_enrolled|manager_assigned|hr_assigned|system_auto|donor_required');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `staff_type` SET TAGS ('dbx_business_glossary_term' = 'Staff Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `staff_type` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expatriate|volunteer|consultant|intern');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Course Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `learning_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `learning_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|in_progress|completed|failed|withdrawn|waived');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `training_cost` SET TAGS ('dbx_business_glossary_term' = 'Training Cost');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `training_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `waiver_approved_by` SET TAGS ('dbx_business_glossary_term' = 'Waiver Approved By');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` SET TAGS ('dbx_subdomain' = 'performance_learning');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Course ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Hosting System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `available_from_date` SET TAGS ('dbx_business_glossary_term' = 'Course Availability Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `available_until_date` SET TAGS ('dbx_business_glossary_term' = 'Course Availability End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `certificate_validity_months` SET TAGS ('dbx_business_glossary_term' = 'Certificate Validity Period (Months)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `learning_course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `learning_course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `competency_framework` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Alignment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `cost_per_learner` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Learner');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `cost_per_learner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `cpe_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Professional Education (CPE) Credits');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Course Delivery Mode');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `delivery_mode` SET TAGS ('dbx_value_regex' = 'e_learning|classroom|blended|virtual_instructor_led|on_the_job|coaching');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `learning_course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Course Duration (Hours)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `external_accreditation` SET TAGS ('dbx_business_glossary_term' = 'External Accreditation Body');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `fund_source` SET TAGS ('dbx_business_glossary_term' = 'Course Fund Source');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `fund_source` SET TAGS ('dbx_value_regex' = 'unrestricted|restricted_grant|donor_designated|internal_capacity_building');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `has_assessment` SET TAGS ('dbx_business_glossary_term' = 'Assessment Included Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Course Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `issues_certificate` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issuance Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Course Language');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[a-z]{2,3}(-[A-Z]{2})?$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `language` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `last_reviewed_date` SET TAGS ('dbx_business_glossary_term' = 'Course Last Reviewed Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `max_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment Capacity');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Course Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `owner` SET TAGS ('dbx_business_glossary_term' = 'Course Owner');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Course Passing Score');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `prerequisite_course_codes` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Course Codes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Course Provider Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `provider_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Course Provider Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `provider_type` SET TAGS ('dbx_value_regex' = 'internal|external_ngo|un_agency|academic|commercial|government');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_business_glossary_term' = 'Course Recurrence Frequency');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `recurrence_frequency` SET TAGS ('dbx_value_regex' = 'once|annual|biennial|quarterly|as_needed');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `scorm_compliant` SET TAGS ('dbx_business_glossary_term' = 'SCORM Compliance Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `short_description` SET TAGS ('dbx_business_glossary_term' = 'Course Short Description');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Applicable Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `learning_course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `learning_course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived|under_review');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `subject_area` SET TAGS ('dbx_business_glossary_term' = 'Course Subject Area');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `tags` SET TAGS ('dbx_business_glossary_term' = 'Course Tags');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Course Target Audience');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `learning_course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Course URL');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `url` SET TAGS ('dbx_value_regex' = '^https?://.+');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `version_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Course Version Effective Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Course Version Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`learning_course` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^d+.d+(.d+)?$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `actual_days_taken` SET TAGS ('dbx_business_glossary_term' = 'Actual Leave Days Taken');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Leave End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Leave Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|rejected|cancelled|withdrawn');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `approver_comments` SET TAGS ('dbx_business_glossary_term' = 'Approver Comments');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Cancellation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `carry_forward_days` SET TAGS ('dbx_business_glossary_term' = 'Carry Forward Leave Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fixed_term|open_ended|short_term|secondment|internship');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `emergency_contact_available` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Available Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `emergency_contact_available` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `entitlement_days` SET TAGS ('dbx_business_glossary_term' = 'Annual Leave Entitlement Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `handover_completed` SET TAGS ('dbx_business_glossary_term' = 'Handover Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `is_retroactive` SET TAGS ('dbx_business_glossary_term' = 'Retroactive Leave Request Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `is_rnr_eligible` SET TAGS ('dbx_business_glossary_term' = 'Rest and Recuperation (R&R) Eligibility Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance After Request');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Leave Balance Before Request');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_destination_country` SET TAGS ('dbx_business_glossary_term' = 'Leave Destination Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_destination_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'annual|sick|maternity_paternity|rest_and_recuperation|compassionate|time_off_in_lieu');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_year` SET TAGS ('dbx_business_glossary_term' = 'Leave Year');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_received` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Received Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_received` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_received` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_received` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Required Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `medical_certificate_required` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^LR-[0-9]{4}-[0-9]{6}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Leave Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `requested_days` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `requested_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Leave Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `rnr_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Rest and Recuperation (R&R) Cycle Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `security_clearance_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Confirmed Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'national|international|expatriate|consultant|volunteer');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Submission Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `supporting_document_ref` SET TAGS ('dbx_business_glossary_term' = 'Supporting Document Reference');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `toil_hours_accrued` SET TAGS ('dbx_business_glossary_term' = 'Time Off In Lieu (TOIL) Hours Accrued');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`leave_request` ALTER COLUMN `workday_leave_request_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Leave Request System ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` SET TAGS ('dbx_subdomain' = 'staff_management');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `workforce_staff_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Assignment ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Duty Station ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `tertiary_workforce_approved_by_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `tertiary_workforce_approved_by_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `tertiary_workforce_approved_by_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Approved Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `workforce_staff_assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Assignment Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `workforce_staff_assignment_code` SET TAGS ('dbx_value_regex' = '^ASN-[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fixed_term|open_ended|short_term|consultancy|secondment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^CC-[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `duty_country_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `duty_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `effort_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Effort Certification Required Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `effort_percent` SET TAGS ('dbx_business_glossary_term' = 'Effort Percentage');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `fte_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_business_glossary_term' = 'Funding Source Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `funding_source_type` SET TAGS ('dbx_value_regex' = 'federal_grant|private_grant|bilateral_donor|multilateral_donor|unrestricted_funds|cost_share');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `grant_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `grant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,30}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `hardship_level` SET TAGS ('dbx_business_glossary_term' = 'Hardship Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `hardship_level` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `is_cost_shared` SET TAGS ('dbx_business_glossary_term' = 'Cost Share Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `is_field_deployment` SET TAGS ('dbx_business_glossary_term' = 'Field Deployment Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `is_surge_deployment` SET TAGS ('dbx_business_glossary_term' = 'Surge Deployment Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `job_grade` SET TAGS ('dbx_business_glossary_term' = 'Job Grade');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `last_effort_certified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Effort Certification Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `raci_role` SET TAGS ('dbx_business_glossary_term' = 'RACI (Responsible Accountable Consulted Informed) Role');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `raci_role` SET TAGS ('dbx_value_regex' = 'responsible|accountable|consulted|informed');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `safeguarding_training_completed` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Training Completed Indicator');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|enhanced|classified');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expatriate|consultant|volunteer|intern');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `workforce_staff_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `workforce_staff_assignment_status` SET TAGS ('dbx_value_regex' = 'draft|active|on_hold|completed|cancelled');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `tdy_purpose` SET TAGS ('dbx_business_glossary_term' = 'Temporary Duty (TDY) Purpose');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `workforce_staff_assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `workforce_staff_assignment_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|surge_deployment|tdy|secondment|consultant');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`workforce_staff_assignment` ALTER COLUMN `workday_assignment_ref` SET TAGS ('dbx_business_glossary_term' = 'Workday HCM Assignment Reference');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` SET TAGS ('dbx_subdomain' = 'staff_management');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `expat_package_id` SET TAGS ('dbx_business_glossary_term' = 'Expatriate Package ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Award Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `employment_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Employment Contract Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Salary Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `base_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `expat_package_code` SET TAGS ('dbx_business_glossary_term' = 'Expatriate Package Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `expat_package_code` SET TAGS ('dbx_value_regex' = '^EXP-[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `expat_package_code` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `dependents_covered` SET TAGS ('dbx_business_glossary_term' = 'Dependents Covered');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `duty_station_name` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `duty_station_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `education_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Education Allowance Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `education_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Package Effective From Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Package Effective To Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `employer_pension_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Employer Pension Contribution Percentage');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `employer_pension_contribution_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `grant_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `hardship_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Hardship Allowance Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `hardship_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `hardship_allowance_tier` SET TAGS ('dbx_business_glossary_term' = 'Hardship Allowance Tier');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `hardship_allowance_tier` SET TAGS ('dbx_value_regex' = 'H|A|B|C|D|E');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `health_insurance_plan` SET TAGS ('dbx_business_glossary_term' = 'Health Insurance Plan');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `health_insurance_plan` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `health_insurance_plan` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `home_country` SET TAGS ('dbx_business_glossary_term' = 'Home Country');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `home_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `home_leave_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Home Leave Cycle Months');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `home_leave_entitlement_days` SET TAGS ('dbx_business_glossary_term' = 'Home Leave Entitlement Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Housing Allowance Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `housing_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `housing_provision_type` SET TAGS ('dbx_business_glossary_term' = 'Housing Provision Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `housing_provision_type` SET TAGS ('dbx_value_regex' = 'cash_allowance|org_provided|shared_accommodation|not_applicable');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `icr_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Indirect Cost Rate (ICR) Percentage');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `icr_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `max_eligible_dependents` SET TAGS ('dbx_business_glossary_term' = 'Maximum Eligible Dependents');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `medevac_coverage_level` SET TAGS ('dbx_business_glossary_term' = 'Medical Evacuation (MEDEVAC) Coverage Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `medevac_coverage_level` SET TAGS ('dbx_value_regex' = 'basic|standard|enhanced|critical_care');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `medevac_coverage_level` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `pension_scheme` SET TAGS ('dbx_business_glossary_term' = 'Pension Scheme');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `relocation_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Relocation Allowance Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `relocation_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `repatriation_allowance_amount` SET TAGS ('dbx_business_glossary_term' = 'Repatriation Allowance Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `repatriation_allowance_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `rnr_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Rest and Recuperation (R&R) Cycle Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `salary_grade` SET TAGS ('dbx_business_glossary_term' = 'Salary Grade');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `salary_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `salary_grade` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `salary_scale` SET TAGS ('dbx_business_glossary_term' = 'INGO Salary Scale');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `salary_scale` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `salary_scale` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `salary_step` SET TAGS ('dbx_business_glossary_term' = 'Salary Step');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `salary_step` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `salary_step` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `expat_package_status` SET TAGS ('dbx_business_glossary_term' = 'Expatriate Package Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `expat_package_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|terminated|expired');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `expat_package_status` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `tax_equalization_applicable` SET TAGS ('dbx_business_glossary_term' = 'Tax Equalization Applicable');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `tax_equalization_country` SET TAGS ('dbx_business_glossary_term' = 'Tax Equalization Home Country');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `tax_equalization_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `expat_package_type` SET TAGS ('dbx_business_glossary_term' = 'Expatriate Package Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `expat_package_type` SET TAGS ('dbx_value_regex' = 'standard|hardship|emergency|transitional');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `expat_package_type` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `workday_package_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Package ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`expat_package` ALTER COLUMN `workday_package_reference` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `disciplinary_case_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Case ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `tertiary_disciplinary_investigator_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Investigator ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `tertiary_disciplinary_investigator_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `tertiary_disciplinary_investigator_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `appeal_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `appeal_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `appeal_resolution_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Appeal Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `appeal_status` SET TAGS ('dbx_value_regex' = 'not_appealed|appeal_pending|appeal_upheld|appeal_dismissed|appeal_withdrawn');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `appeal_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `authority_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Authority Referral Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `authority_referral_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `beneficiary_involved` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Involved Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `beneficiary_involved` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `charity_commission_reported` SET TAGS ('dbx_business_glossary_term' = 'Charity Commission Serious Incident Reported Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `charity_commission_reported` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `chs_commitment_reference` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Commitment Reference');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closed Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `closed_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `complainant_type` SET TAGS ('dbx_business_glossary_term' = 'Complainant Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `complainant_type` SET TAGS ('dbx_value_regex' = 'anonymous|named|self_referral|third_party|management_referral');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `complainant_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'strictly_confidential|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed_term|consultancy|secondment|volunteer');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `donor_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Donor Incident Report Reference');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `donor_report_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `donor_report_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Donor Incident Report Submitted Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `donor_report_submitted_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `incident_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `investigation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `investigation_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `investigation_findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Investigation Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `investigation_findings_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_business_glossary_term' = 'Investigation Outcome');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_value_regex' = 'substantiated|unsubstantiated|inconclusive|withdrawn|no_further_action');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `investigation_outcome` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `irs_form_990_reportable` SET TAGS ('dbx_business_glossary_term' = 'IRS Form 990 Reportable Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `irs_form_990_reportable` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `is_external_investigator` SET TAGS ('dbx_business_glossary_term' = 'Is External Investigator Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `is_mandatory_donor_report_required` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Donor Incident Report Required Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `is_mandatory_donor_report_required` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `is_psea_case` SET TAGS ('dbx_business_glossary_term' = 'Is Prevention of Sexual Exploitation and Abuse (PSEA) Case Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `is_psea_case` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `opened_date` SET TAGS ('dbx_business_glossary_term' = 'Case Opened Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `opened_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `priority` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `reference_number` SET TAGS ('dbx_business_glossary_term' = 'Case Reference Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-DISC-[0-9]{4}-[0-9]{4,6}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `reference_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `referred_to_authorities` SET TAGS ('dbx_business_glossary_term' = 'Referred to Authorities Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `referred_to_authorities` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `sanction_applied` SET TAGS ('dbx_business_glossary_term' = 'Sanction Applied');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `sanction_applied` SET TAGS ('dbx_value_regex' = 'verbal_warning|written_warning|final_written_warning|suspension|termination|referral_to_authorities');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `sanction_applied` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'international_staff|national_staff|expatriate|consultant|volunteer|intern');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `disciplinary_case_status` SET TAGS ('dbx_business_glossary_term' = 'Case Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `disciplinary_case_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|pending_outcome|closed|appealed|referred_to_authorities');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `disciplinary_case_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `summary` SET TAGS ('dbx_business_glossary_term' = 'Case Summary');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `disciplinary_case_type` SET TAGS ('dbx_business_glossary_term' = 'Case Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `disciplinary_case_type` SET TAGS ('dbx_value_regex' = 'misconduct|psea_sea_violation|fraud|harassment|bullying|performance');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `disciplinary_case_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`disciplinary_case` ALTER COLUMN `workday_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday HCM Case ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `separation_event_id` SET TAGS ('dbx_business_glossary_term' = 'Separation Event ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Deprovisioned User Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `primary_separation_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `primary_separation_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `primary_separation_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `separation_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `separation_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Separation Approval Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `asset_return_completed` SET TAGS ('dbx_business_glossary_term' = 'Asset Return Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fixed_term|open_ended|consultancy|secondment|volunteer');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `duty_station_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Separation Effective Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `exit_interview_conducted_by` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Conducted By');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `exit_interview_date` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `exit_interview_status` SET TAGS ('dbx_business_glossary_term' = 'Exit Interview Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `exit_interview_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|scheduled|completed|declined');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Settlement Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `final_settlement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `grant_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `is_notice_served_in_full` SET TAGS ('dbx_business_glossary_term' = 'Notice Served in Full Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `job_grade` SET TAGS ('dbx_business_glossary_term' = 'Job Grade at Separation');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title at Separation');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `knowledge_transfer_completed` SET TAGS ('dbx_business_glossary_term' = 'Knowledge Transfer Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `last_working_date` SET TAGS ('dbx_business_glossary_term' = 'Last Working Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `leave_encashment_days` SET TAGS ('dbx_business_glossary_term' = 'Leave Encashment Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `notice_period_days_required` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days Required');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `notice_period_days_served` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days Served');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Separation Notification Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `original_hire_date` SET TAGS ('dbx_business_glossary_term' = 'Original Hire Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `primary_departure_reason` SET TAGS ('dbx_business_glossary_term' = 'Primary Departure Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `primary_departure_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `rehire_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Rehire Eligibility');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `rehire_eligibility` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|eligible_with_conditions');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `rehire_ineligibility_reason` SET TAGS ('dbx_business_glossary_term' = 'Rehire Ineligibility Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `rehire_ineligibility_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `repatriation_destination_country` SET TAGS ('dbx_business_glossary_term' = 'Repatriation Destination Country');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `repatriation_destination_country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `repatriation_entitlement` SET TAGS ('dbx_business_glossary_term' = 'Repatriation Entitlement Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `safeguarding_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Clearance Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `safeguarding_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending_investigation|under_investigation|not_cleared');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `separation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Separation Reason Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `separation_status` SET TAGS ('dbx_business_glossary_term' = 'Separation Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `separation_status` SET TAGS ('dbx_value_regex' = 'initiated|in_progress|approved|completed|cancelled');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `separation_type` SET TAGS ('dbx_business_glossary_term' = 'Separation Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `separation_type` SET TAGS ('dbx_value_regex' = 'resignation|end_of_contract|redundancy|termination|retirement|death_in_service');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `severance_pay_amount` SET TAGS ('dbx_business_glossary_term' = 'Severance Pay Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `severance_pay_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `severance_pay_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'international|national|local|volunteer|consultant');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `system_access_revoked` SET TAGS ('dbx_business_glossary_term' = 'System Access Revoked Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `workday_termination_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Termination ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`separation_event` ALTER COLUMN `years_of_service` SET TAGS ('dbx_business_glossary_term' = 'Years of Service');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` SET TAGS ('dbx_subdomain' = 'staff_management');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_certification_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Certification ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_certification_code` SET TAGS ('dbx_business_glossary_term' = 'Certification Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Certification Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `document_received_date` SET TAGS ('dbx_business_glossary_term' = 'Document Received Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `document_ref` SET TAGS ('dbx_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `donor_requirement_ref` SET TAGS ('dbx_business_glossary_term' = 'Donor Requirement Reference');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `grant_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `is_donor_required` SET TAGS ('dbx_business_glossary_term' = 'Is Donor Required Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `is_field_deployment_required` SET TAGS ('dbx_business_glossary_term' = 'Is Field Deployment Required Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `is_pass` SET TAGS ('dbx_business_glossary_term' = 'Is Pass Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `is_role_required` SET TAGS ('dbx_business_glossary_term' = 'Is Role Required Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_certification_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `reminder_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Reminder Sent Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Due Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'not_due|in_progress|submitted|renewed|lapsed|waived');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `score_or_grade` SET TAGS ('dbx_business_glossary_term' = 'Score or Grade');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'national_staff|international_staff|expatriate|consultant|volunteer');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_verification');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `training_delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Mode');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `training_delivery_mode` SET TAGS ('dbx_value_regex' = 'in_person|online|blended|on_the_job|simulation');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration Hours');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `training_location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Training Location Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `training_location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `staff_certification_type` SET TAGS ('dbx_value_regex' = 'professional_accreditation|mandatory_clearance|license|medical_fitness|security_clearance|safeguarding');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|verification_failed|not_required');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`staff_certification` ALTER COLUMN `workday_credential_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Credential ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` SET TAGS ('dbx_subdomain' = 'payroll_benefits');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Timesheet ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `amended_timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Amended Timesheet Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `amended_timesheet_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `primary_timesheet_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `primary_timesheet_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `primary_timesheet_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `approver_comments` SET TAGS ('dbx_business_glossary_term' = 'Approver Comments');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'permanent|fixed_term|temporary|consultant|volunteer');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `duty_station_country_code` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `duty_station_name` SET TAGS ('dbx_business_glossary_term' = 'Duty Station Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `duty_station_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `effort_certification_required` SET TAGS ('dbx_business_glossary_term' = 'Effort Certification Required');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `effort_certified_date` SET TAGS ('dbx_business_glossary_term' = 'Effort Certified Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `effort_percent` SET TAGS ('dbx_business_glossary_term' = 'Effort Percent');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `grant_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `is_billable` SET TAGS ('dbx_business_glossary_term' = 'Is Billable');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `is_cost_shared` SET TAGS ('dbx_business_glossary_term' = 'Is Cost Shared');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `is_field_deployment` SET TAGS ('dbx_business_glossary_term' = 'Is Field Deployment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `is_grant_chargeable` SET TAGS ('dbx_business_glossary_term' = 'Is Grant Chargeable');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `staff_category` SET TAGS ('dbx_business_glossary_term' = 'Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `staff_category` SET TAGS ('dbx_value_regex' = 'national|international|consultant|volunteer');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `timesheet_status` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `timesheet_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled|under_review');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `toil_hours_accrued` SET TAGS ('dbx_business_glossary_term' = 'Time Off In Lieu (TOIL) Hours Accrued');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'office|field|remote|home');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`timesheet` ALTER COLUMN `workday_timesheet_reference` SET TAGS ('dbx_business_glossary_term' = 'Workday Timesheet ID');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Candidate Identifier');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `candidate_referring_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `candidate_referring_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `candidate_referring_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `recruitment_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `referred_by_candidate_id` SET TAGS ('dbx_business_glossary_term' = 'Referred By Candidate Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `referred_by_candidate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `referring_staff_member_id` SET TAGS ('dbx_renamed_from' = 'staff_member_id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_business_glossary_term' = 'Alternate Phone Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `alternate_phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `available_start_date` SET TAGS ('dbx_business_glossary_term' = 'Available Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `cover_letter_file_path` SET TAGS ('dbx_business_glossary_term' = 'Cover Letter File Path');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `cover_letter_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `cover_letter_file_path` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `current_employer` SET TAGS ('dbx_business_glossary_term' = 'Current Employer');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `current_employer` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `current_job_title` SET TAGS ('dbx_business_glossary_term' = 'Current Job Title');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `current_job_title` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date Of Birth');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `disability_status` SET TAGS ('dbx_business_glossary_term' = 'Disability Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `disability_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `disability_status` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `diversity_self_identification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Self Identification');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `diversity_self_identification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `diversity_self_identification` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `expected_salary_amount` SET TAGS ('dbx_business_glossary_term' = 'Expected Salary Amount');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `expected_salary_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `expected_salary_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `expected_salary_currency` SET TAGS ('dbx_business_glossary_term' = 'Expected Salary Currency');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `expected_salary_currency` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `expected_salary_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `highest_education_level` SET TAGS ('dbx_business_glossary_term' = 'Highest Education Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `interview_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Scheduled Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_business_glossary_term' = 'Linkedin Profile Url');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `linkedin_profile_url` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Nationality');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `nationality` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `nationality` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `offer_accepted_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Accepted Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `offer_extended_date` SET TAGS ('dbx_business_glossary_term' = 'Offer Extended Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `position_applied_for` SET TAGS ('dbx_business_glossary_term' = 'Position Applied For');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `referral_source` SET TAGS ('dbx_business_glossary_term' = 'Referral Source');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `rejection_date` SET TAGS ('dbx_business_glossary_term' = 'Rejection Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `resume_file_path` SET TAGS ('dbx_business_glossary_term' = 'Resume File Path');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `resume_file_path` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `resume_file_path` SET TAGS ('dbx_pii_contact' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `screening_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Completed Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `source_channel` SET TAGS ('dbx_business_glossary_term' = 'Source Channel');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `candidate_status` SET TAGS ('dbx_business_glossary_term' = 'Candidate Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `candidate_type` SET TAGS ('dbx_business_glossary_term' = 'Candidate Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_business_glossary_term' = 'Veteran Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `veteran_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `willing_to_relocate` SET TAGS ('dbx_business_glossary_term' = 'Willing To Relocate');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`candidate` ALTER COLUMN `years_of_experience` SET TAGS ('dbx_business_glossary_term' = 'Years Of Experience');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` SET TAGS ('dbx_subdomain' = 'performance_learning');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_template_id` SET TAGS ('dbx_business_glossary_term' = 'Review Template Identifier');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `competency_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `derived_from_review_template_id` SET TAGS ('dbx_business_glossary_term' = 'Derived From Review Template Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `derived_from_review_template_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Unit Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `rating_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_created_by_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_created_by_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_created_by_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_last_modified_by_employee_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_last_modified_by_employee_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_last_modified_by_employee_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `creator_staff_member_id` SET TAGS ('dbx_renamed_from' = 'staff_member_id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `allows_customization` SET TAGS ('dbx_business_glossary_term' = 'Allows Customization');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `approval_levels` SET TAGS ('dbx_business_glossary_term' = 'Approval Levels');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `approval_workflow_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow Required');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_template_code` SET TAGS ('dbx_business_glossary_term' = 'Template Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Created Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_template_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `includes_development_plan` SET TAGS ('dbx_business_glossary_term' = 'Includes Development Plan');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `includes_goal_setting` SET TAGS ('dbx_business_glossary_term' = 'Includes Goal Setting');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `includes_manager_assessment` SET TAGS ('dbx_business_glossary_term' = 'Includes Manager Assessment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `includes_manager_assessment` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `includes_peer_feedback` SET TAGS ('dbx_business_glossary_term' = 'Includes Peer Feedback');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `includes_self_assessment` SET TAGS ('dbx_business_glossary_term' = 'Includes Self Assessment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `includes_upward_feedback` SET TAGS ('dbx_business_glossary_term' = 'Includes Upward Feedback');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `is_default_template` SET TAGS ('dbx_business_glossary_term' = 'Is Default Template');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `is_multilingual` SET TAGS ('dbx_business_glossary_term' = 'Is Multilingual');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `last_used_date` SET TAGS ('dbx_business_glossary_term' = 'Last Used Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `maximum_review_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Maximum Review Duration Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `minimum_review_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Minimum Review Duration Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_template_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `question_count` SET TAGS ('dbx_business_glossary_term' = 'Question Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `requires_calibration` SET TAGS ('dbx_business_glossary_term' = 'Requires Calibration');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `section_count` SET TAGS ('dbx_business_glossary_term' = 'Section Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_template_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `target_job_level` SET TAGS ('dbx_business_glossary_term' = 'Target Job Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `target_staff_category` SET TAGS ('dbx_business_glossary_term' = 'Target Staff Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `review_template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `usage_count` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_template` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` SET TAGS ('dbx_subdomain' = 'performance_learning');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `performance_improvement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan Identifier');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'User Account Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Hr Business Partner Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `performance_manager_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `performance_manager_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `performance_manager_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `performance_modified_by_user_user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User User Account Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `performance_previous_pip_performance_improvement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Pip Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `performance_subject_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `performance_subject_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `performance_subject_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `primary_extended_performance_improvement_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Extended Performance Improvement Plan Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `primary_extended_performance_improvement_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `disciplinary_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Disciplinary Action Disciplinary Case Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `supervisor_staff_member_id` SET TAGS ('dbx_renamed_from' = 'staff_member_id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `consequences_if_unsuccessful` SET TAGS ('dbx_business_glossary_term' = 'Consequences If Unsuccessful');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Duration Days');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `employee_acknowledgement_signature` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Signature');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `employee_acknowledgement_signature` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `extension_count` SET TAGS ('dbx_business_glossary_term' = 'Extension Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `hr_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Hr Approval Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `improvement_objectives` SET TAGS ('dbx_business_glossary_term' = 'Improvement Objectives');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `last_extension_date` SET TAGS ('dbx_business_glossary_term' = 'Last Extension Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `legal_review_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `legal_review_required` SET TAGS ('dbx_business_glossary_term' = 'Legal Review Required');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `manager_signature` SET TAGS ('dbx_business_glossary_term' = 'Manager Signature');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `manager_signature` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Plan Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Outcome');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Outcome Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `performance_issue_category` SET TAGS ('dbx_business_glossary_term' = 'Performance Issue Category');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `performance_improvement_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `success_criteria` SET TAGS ('dbx_business_glossary_term' = 'Success Criteria');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `support_resources` SET TAGS ('dbx_business_glossary_term' = 'Support Resources');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`performance_improvement_plan` ALTER COLUMN `performance_improvement_plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` SET TAGS ('dbx_subdomain' = 'performance_learning');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_session_id` SET TAGS ('dbx_business_glossary_term' = 'Calibration Session Identifier');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_facilitator_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_facilitator_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_facilitator_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_last_modified_by_employee_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee Staff Member Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_last_modified_by_employee_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_last_modified_by_employee_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `followup_calibration_session_id` SET TAGS ('dbx_business_glossary_term' = 'Followup Calibration Session Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `followup_calibration_session_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `rating_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `facilitator_staff_member_id` SET TAGS ('dbx_renamed_from' = 'staff_member_id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `agenda` SET TAGS ('dbx_business_glossary_term' = 'Agenda');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `agenda` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `approval_required` SET TAGS ('dbx_business_glossary_term' = 'Approval Required');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calibration Methodology');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_session_code` SET TAGS ('dbx_business_glossary_term' = 'Session Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `consensus_achieved` SET TAGS ('dbx_business_glossary_term' = 'Consensus Achieved');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `decisions_summary` SET TAGS ('dbx_business_glossary_term' = 'Decisions Summary');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `decisions_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `employee_count_reviewed` SET TAGS ('dbx_business_glossary_term' = 'Employee Count Reviewed');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Required');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `forced_distribution_applied` SET TAGS ('dbx_business_glossary_term' = 'Forced Distribution Applied');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `meeting_link` SET TAGS ('dbx_business_glossary_term' = 'Meeting Link');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_session_name` SET TAGS ('dbx_business_glossary_term' = 'Session Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_session_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Session Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `rating_changes_count` SET TAGS ('dbx_business_glossary_term' = 'Rating Changes Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `recording_available` SET TAGS ('dbx_business_glossary_term' = 'Session Recording Available');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `recording_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Recording Storage Location');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `recording_storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `recording_storage_location` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_session_status` SET TAGS ('dbx_business_glossary_term' = 'Session Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `target_distribution_percentages` SET TAGS ('dbx_business_glossary_term' = 'Target Distribution Percentages');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `target_distribution_percentages` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`calibration_session` ALTER COLUMN `calibration_session_type` SET TAGS ('dbx_business_glossary_term' = 'Session Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` SET TAGS ('dbx_subdomain' = 'performance_learning');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `competency_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Competency Framework Identifier');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `superseded_competency_framework_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Competency Framework Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `superseded_competency_framework_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `available_translations` SET TAGS ('dbx_business_glossary_term' = 'Available Translations');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `competency_framework_code` SET TAGS ('dbx_business_glossary_term' = 'Framework Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `competency_category_count` SET TAGS ('dbx_business_glossary_term' = 'Competency Category Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `competency_count` SET TAGS ('dbx_business_glossary_term' = 'Competency Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `competency_framework_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `document_repository_path` SET TAGS ('dbx_business_glossary_term' = 'Document Repository Path');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `external_url` SET TAGS ('dbx_business_glossary_term' = 'External Url');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `geographic_applicability` SET TAGS ('dbx_business_glossary_term' = 'Geographic Applicability');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `industry_alignment` SET TAGS ('dbx_business_glossary_term' = 'Industry Alignment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `integration_with_hris` SET TAGS ('dbx_business_glossary_term' = 'Integration With Hris');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `integration_with_lms` SET TAGS ('dbx_business_glossary_term' = 'Integration With Lms');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `language` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `competency_framework_name` SET TAGS ('dbx_business_glossary_term' = 'Framework Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `competency_framework_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `owner_role` SET TAGS ('dbx_business_glossary_term' = 'Owner Role');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `proficiency_levels_count` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Levels Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `proficiency_scale_description` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Scale Description');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Purpose');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `regulatory_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency Months');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Framework Scope');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `source_standard` SET TAGS ('dbx_business_glossary_term' = 'Source Standard');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `competency_framework_status` SET TAGS ('dbx_business_glossary_term' = 'Framework Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `supports_performance_management` SET TAGS ('dbx_business_glossary_term' = 'Supports Performance Management');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `supports_performance_management` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `supports_recruitment` SET TAGS ('dbx_business_glossary_term' = 'Supports Recruitment');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `supports_succession_planning` SET TAGS ('dbx_business_glossary_term' = 'Supports Succession Planning');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `competency_framework_type` SET TAGS ('dbx_business_glossary_term' = 'Framework Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `usage_count` SET TAGS ('dbx_business_glossary_term' = 'Usage Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `usage_count` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`competency_framework` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Framework Version');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` SET TAGS ('dbx_subdomain' = 'performance_learning');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `rating_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Identifier');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `superseded_rating_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Rating Scale Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `superseded_rating_scale_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `allows_decimal_points` SET TAGS ('dbx_business_glossary_term' = 'Allows Decimal Points');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `allows_half_points` SET TAGS ('dbx_business_glossary_term' = 'Allows Half Points');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `applicable_to_job_levels` SET TAGS ('dbx_business_glossary_term' = 'Applicable To Job Levels');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `applicable_to_staff_types` SET TAGS ('dbx_business_glossary_term' = 'Applicable To Staff Types');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `rating_scale_code` SET TAGS ('dbx_business_glossary_term' = 'Scale Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `rating_scale_description` SET TAGS ('dbx_business_glossary_term' = 'Scale Description');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `display_order` SET TAGS ('dbx_business_glossary_term' = 'Display Order');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `distribution_percentages` SET TAGS ('dbx_business_glossary_term' = 'Distribution Percentages');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `distribution_percentages` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `increment_value` SET TAGS ('dbx_business_glossary_term' = 'Increment Value');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `interpretation_guide` SET TAGS ('dbx_business_glossary_term' = 'Scale Interpretation Guide');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `is_default_scale` SET TAGS ('dbx_business_glossary_term' = 'Is Default Scale');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `is_forced_distribution` SET TAGS ('dbx_business_glossary_term' = 'Is Forced Distribution');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `is_manager_assessment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Is Manager Assessment Enabled');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `is_manager_assessment_enabled` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `is_peer_assessment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Is Peer Assessment Enabled');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `is_self_assessment_enabled` SET TAGS ('dbx_business_glossary_term' = 'Is Self Assessment Enabled');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `maximum_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Value');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `minimum_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Value');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `rating_scale_name` SET TAGS ('dbx_business_glossary_term' = 'Scale Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `rating_scale_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `number_of_levels` SET TAGS ('dbx_business_glossary_term' = 'Number Of Levels');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `rating_scale_status` SET TAGS ('dbx_business_glossary_term' = 'Scale Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `rating_scale_type` SET TAGS ('dbx_business_glossary_term' = 'Scale Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `usage_context` SET TAGS ('dbx_business_glossary_term' = 'Usage Context');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `usage_context` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`rating_scale` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` SET TAGS ('dbx_subdomain' = 'performance_learning');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle Identifier');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `employee_group_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Group Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_source_attribute' = 'org_unit_id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `prior_review_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Review Cycle Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `prior_review_cycle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `rating_scale_id` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_closed_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By User Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_closed_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_closed_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_created_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_created_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_created_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_modified_by_user_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_modified_by_user_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_modified_by_user_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_organization_id` SET TAGS ('dbx_business_glossary_term' = 'Organization Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_template_id` SET TAGS ('dbx_business_glossary_term' = 'Review Template Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Cycle Owner Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Id');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `user_account_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `user_account_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Cycle Code');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `completed_review_count` SET TAGS ('dbx_business_glossary_term' = 'Completed Review Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `eligible_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Eligible Employee Count');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `feedback_delivery_due_date` SET TAGS ('dbx_business_glossary_term' = 'Feedback Delivery Due Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `instructions_url` SET TAGS ('dbx_business_glossary_term' = 'Instructions Url');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `is_360_feedback_enabled` SET TAGS ('dbx_business_glossary_term' = 'Is 360 Feedback Enabled');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `is_compensation_linked` SET TAGS ('dbx_business_glossary_term' = 'Is Compensation Linked');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `is_compensation_linked` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `is_compensation_linked` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `is_goal_setting_enabled` SET TAGS ('dbx_business_glossary_term' = 'Is Goal Setting Enabled');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `manager_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Manager Review Due Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `manager_review_due_date` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Cycle Name');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_cycle_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `notification_enabled` SET TAGS ('dbx_business_glossary_term' = 'Notification Enabled');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `self_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Self Assessment Due Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Cycle Status');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`review_cycle` ALTER COLUMN `review_cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Cycle Type');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` SET TAGS ('dbx_subdomain' = 'performance_learning');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` ALTER COLUMN `employee_group_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Group Identifier');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` ALTER COLUMN `parent_employee_group_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` ALTER COLUMN `compensation_basis` SET TAGS ('dbx_classification' = 'confidential');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` ALTER COLUMN `compensation_basis` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` ALTER COLUMN `group_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` ALTER COLUMN `medical_evacuation_eligible` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` ALTER COLUMN `salary_scale_code` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` ALTER COLUMN `salary_scale_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` ALTER COLUMN `social_security_applicable` SET TAGS ('dbx_classification' = 'restricted');
ALTER TABLE `vibe_ngo_v1`.`workforce`.`employee_group` ALTER COLUMN `social_security_applicable` SET TAGS ('dbx_pii' = 'true');
