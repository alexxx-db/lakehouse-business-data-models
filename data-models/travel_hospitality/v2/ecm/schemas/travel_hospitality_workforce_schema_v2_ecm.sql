-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:50:48

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`workforce` COMMENT 'Human capital management for hospitality operations including employee profiles, scheduling, labor management, payroll, benefits, talent acquisition, performance management, and learning and development. Integrates with Oracle HCM Cloud and SAP S/4HANA HCM. Tracks labor cost as percentage of revenue, CPOR labor components, and compliance with OSHA and ADA workforce regulations. Supports USALI labor cost reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` (
    `learning_course_id` BIGINT COMMENT 'Unique identifier for the learning course. Primary key.',
    `category_id` BIGINT COMMENT 'add column category_id (BIGINT) with FK to procurement.category.category_id - learning courses need taxonomy/category classification.',
    `obligation_id` BIGINT COMMENT 'add column compliance_obligation_id (BIGINT) with FK to compliance.obligation.obligation_id - many learning courses fulfil specific compliance obligations.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Training courses implement compliance policies (harassment prevention, data privacy, safety). Compliance officers must track which courses satisfy which policy requirements for audit evidence and regu',
    `prerequisite_course_learning_course_id` BIGINT COMMENT 'Reference to another learning course that must be completed before this course can be taken. Null if no prerequisite exists.',
    `property_id` BIGINT COMMENT 'FK connection added per structural fix',
    `accreditation_body` STRING COMMENT 'Name of the professional or regulatory body that accredits or certifies this course. Examples include OSHA, state health departments, American Hotel and Lodging Educational Institute (AHLEI), Court of Master Sommeliers. Null if course is not externally accredited.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether learners must complete a graded assessment or examination to pass the course. True for courses with tests, false for attendance-only or participation-based courses.',
    `certificate_template_code` STRING COMMENT 'Identifier for the certificate template used to generate completion certificates for this course. Links to document generation system. Null if course does not issue certificates.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether successful completion of this course results in a professional certification or license being issued. True for courses like food handler certification, TIPS alcohol service, CPR, OSHA 10/30, sommelier certification, spa therapy licenses.',
    `compliance_requirement_flag` BOOLEAN COMMENT 'Indicates whether this course fulfills a regulatory or legal compliance requirement such as OSHA mandatory training, food safety certification, ADA training, or other jurisdiction-specific requirements.',
    `content_version` STRING COMMENT 'Version number of the course content. Incremented when course materials are updated to reflect regulatory changes, brand standard updates, or content improvements.. Valid values are `^[0-9]+.[0-9]+$`',
    `continuing_education_credits` DECIMAL(18,2) COMMENT 'Number of continuing education units or credits awarded upon course completion. Used for professional development tracking and license renewal requirements. Null if course does not award CEUs.',
    `cost_per_learner` DECIMAL(18,2) COMMENT 'Cost to deliver the course per individual learner. Includes instructor fees, materials, platform fees, and external vendor costs. Used for training budget planning and CPOR (Cost Per Occupied Room) labor component analysis.',
    `course_category` STRING COMMENT 'Primary classification of the course type. Compliance courses are mandatory regulatory training, skills courses develop job-specific competencies, leadership courses develop management capabilities, brand standards ensure consistent guest experience, food safety covers ISO 22000 requirements, OSHA covers workplace safety, ADA covers accessibility compliance. [ENUM-REF-CANDIDATE: compliance|skills|leadership|brand_standards|food_safety|osha|ada — 7 candidates stripped; promote to reference product]',
    `course_code` STRING COMMENT 'Unique business identifier for the course used in catalogs and learning management systems. Typically alphanumeric code assigned by training department.. Valid values are `^[A-Z0-9]{4,12}$`',
    `course_description` STRING COMMENT 'Detailed description of the course content, learning objectives, and outcomes. Provides employees with understanding of what they will learn.',
    `course_status` STRING COMMENT 'Current lifecycle status of the course. Active courses are available for enrollment, inactive courses are temporarily unavailable, under development courses are being created, retired courses are no longer offered, suspended courses are on hold pending review.. Valid values are `active|inactive|under_development|retired|suspended`',
    `course_title` STRING COMMENT 'Full name of the learning course as displayed to employees and managers.',
    `course_type` STRING COMMENT 'Indicates whether the course is mandatory for specific roles, optional for employee development, recommended by management, or required for professional certification.. Valid values are `mandatory|optional|recommended|certification`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the course record was first created in the learning management system.',
    `delivery_method` STRING COMMENT 'Method by which the course content is delivered to learners. Instructor-led is in-person classroom, online is self-paced eLearning, blended combines multiple methods, on-the-job is practical training during work, virtual classroom is live remote instruction.. Valid values are `instructor_led|online|blended|on_the_job|virtual_classroom`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the course in hours. Used for scheduling, labor planning, and compliance tracking. Supports OSHA 10-hour and 30-hour certification requirements.',
    `effective_end_date` DATE COMMENT 'Date when the course is no longer available for new enrollments. Null for courses with no planned end date. Used when courses are being phased out or replaced.',
    `effective_start_date` DATE COMMENT 'Date when the course becomes available for enrollment and delivery. Used for scheduling new course launches and regulatory compliance effective dates.',
    `enrollment_capacity` STRING COMMENT 'Maximum number of learners that can be enrolled in a single offering of the course. Relevant for instructor-led and virtual classroom courses. Null for unlimited capacity online courses.',
    `language_code` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the primary language in which the course is delivered. Examples: ENG (English), SPA (Spanish), FRA (French).. Valid values are `^[A-Z]{3}$`',
    `last_content_update_date` DATE COMMENT 'Date when the course content was last revised or updated. Critical for ensuring compliance training reflects current regulations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the course record was last updated. Tracks any changes to course metadata, content version, status, or configuration.',
    `max_attempts` STRING COMMENT 'Maximum number of attempts allowed for course completion or assessment. Null if unlimited attempts are permitted.',
    `passing_score` DECIMAL(18,2) COMMENT 'Minimum score percentage required to successfully complete the course. Null if course does not have a scored assessment.',
    `regulatory_body` STRING COMMENT 'Name of the government or regulatory agency that mandates this training. Examples: OSHA, FDA, state health department, fire marshal. Null if course is not mandated by a regulatory body.',
    `target_audience` STRING COMMENT 'Description of the intended audience for the course, such as specific job roles, departments, or employee levels. Examples: front desk agents, housekeeping supervisors, F&B managers, all property staff.',
    `validity_period_days` STRING COMMENT 'Number of days the course completion remains valid before recertification is required. Critical for compliance courses like food handler certification, OSHA training, and CPR certification. Null if course completion does not expire.',
    `vendor_name` STRING COMMENT 'Name of external training provider or vendor delivering the course. Null for internally developed courses.',
    CONSTRAINT pk_learning_course PRIMARY KEY(`learning_course_id`)
) COMMENT 'Learning and development management including course catalog, employee training enrollments, completion tracking, and professional certification records for hotel staff. Covers course definitions (compliance, skills, leadership, brand standards, food safety, OSHA, ADA), delivery methods, and passing requirements. Includes enrollment/completion records with scores, certificates, and expiry dates. Tracks professional certifications and licenses (food handler, TIPS, CPR, OSHA 10/30, sommelier, spa license) with issuing authority, certification number, validity period, and renewal status. Supports OSHA mandatory training compliance, food safety certification (ISO 22000), brand standards training, ADA/regulatory credential verification, and license expiry alerting.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` (
    `workforce_benefit_plan_id` BIGINT COMMENT 'Unique identifier for the benefit plan. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Benefit costs must be allocated to cost centers for full-burden labor costing in USALI statements, departmental P&L analysis, and accurate calculation of total compensation costs per department - requ',
    `ownership_entity_id` BIGINT COMMENT 'add column ownership_entity_id (BIGINT) with FK to property.ownership_entity.ownership_entity_id - benefit plans are sponsored at the legal/ownership entity level for HR compliance.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property or corporate entity offering this benefit plan. Links to property master data for multi-property benefit plan administration.',
    `aca_compliant_flag` BOOLEAN COMMENT 'Indicates whether the benefit plan meets ACA minimum essential coverage and affordability requirements. True if compliant, False otherwise.',
    `carrier_name` STRING COMMENT 'Name of the insurance carrier or provider administering the benefit plan (e.g., Blue Cross, Aetna, Fidelity).',
    `carrier_policy_number` STRING COMMENT 'Policy or contract number assigned by the insurance carrier for this benefit plan.',
    `cobra_eligible_flag` BOOLEAN COMMENT 'Indicates whether the benefit plan is eligible for COBRA continuation coverage after employment termination. True if eligible, False otherwise.',
    `coinsurance_percentage` DECIMAL(18,2) COMMENT 'Percentage of covered costs the employee pays after meeting the deductible (e.g., 20% coinsurance means employee pays 20%, carrier pays 80%).',
    `contribution_frequency` STRING COMMENT 'Frequency at which employee and employer contributions are deducted or paid (e.g., biweekly, monthly).. Valid values are `weekly|biweekly|semimonthly|monthly|annual`',
    `copay_amount` DECIMAL(18,2) COMMENT 'Fixed dollar amount the employee pays for specific services (e.g., $25 copay for doctor visit, $10 copay for generic prescription).',
    `coverage_amount` DECIMAL(18,2) COMMENT 'Total coverage or benefit amount provided by the plan (e.g., $50,000 life insurance coverage, $500,000 disability coverage).',
    `coverage_tier` STRING COMMENT 'Level of coverage provided by the plan, indicating who is covered (employee only, employee plus dependents, family).. Valid values are `employee_only|employee_spouse|employee_children|employee_family`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit plan record was first created in the system. Audit trail for plan setup.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for contribution amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Annual deductible amount the employee must pay before the insurance carrier begins coverage. Applicable to health, dental, and vision plans.',
    `dependent_coverage_allowed_flag` BOOLEAN COMMENT 'Indicates whether the benefit plan allows coverage for employee dependents (spouse, children). True if dependents can be covered, False otherwise.',
    `effective_end_date` DATE COMMENT 'Date when the benefit plan expires or is terminated. Nullable for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when the benefit plan becomes active and available for employee enrollment. Plan year start date.',
    `eligibility_criteria` STRING COMMENT 'Description of the eligibility requirements for employees to enroll in this benefit plan (e.g., full-time status, 90-day waiting period, job grade).',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount the employee contributes per pay period toward the benefit plan premium or cost.',
    `employer_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount the employer contributes per pay period toward the benefit plan premium or cost. Used for total compensation cost tracking per USALI.',
    `enrollment_period_end_date` DATE COMMENT 'End date of the open enrollment period. Employees must complete enrollment actions by this date.',
    `enrollment_period_start_date` DATE COMMENT 'Start date of the open enrollment period when employees can elect or change their benefit plan selections.',
    `life_event_enrollment_allowed_flag` BOOLEAN COMMENT 'Indicates whether employees can enroll or make changes to this benefit plan outside of open enrollment due to qualifying life events (marriage, birth, adoption). True if allowed, False otherwise.',
    `maximum_dependent_age` STRING COMMENT 'Maximum age at which a dependent child can remain covered under the benefit plan (e.g., 26 per ACA for health plans).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the benefit plan record was last modified. Audit trail for plan changes and updates.',
    `out_of_pocket_maximum` DECIMAL(18,2) COMMENT 'Maximum amount the employee will pay out-of-pocket for covered services in a plan year. After this limit, the carrier pays 100%.',
    `plan_code` STRING COMMENT 'Externally-known unique code for the benefit plan used across systems and communications. Business identifier for the plan.. Valid values are `^[A-Z0-9]{4,20}$`',
    `plan_description` STRING COMMENT 'Detailed description of the benefit plan including coverage details, exclusions, and key features provided to employees.',
    `plan_document_url` STRING COMMENT 'URL or file path to the official plan document, summary plan description (SPD), or benefits guide for employee reference.',
    `plan_name` STRING COMMENT 'Full descriptive name of the benefit plan as displayed to employees and in HR systems.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the benefit plan. Indicates whether the plan is available for enrollment and active for coverage.. Valid values are `active|inactive|pending|suspended|terminated`',
    `plan_type` STRING COMMENT 'Category of benefit plan. Classifies the plan into major benefit types offered to hospitality employees. [ENUM-REF-CANDIDATE: health|dental|vision|life_insurance|disability|retirement_401k|employee_assistance_program|hotel_rate_discount|flexible_spending_account|health_savings_account — 10 candidates stripped; promote to reference product]',
    `plan_year` STRING COMMENT 'Calendar year or fiscal year for which the benefit plan is active (e.g., 2024).',
    `waiting_period_days` STRING COMMENT 'Number of days an employee must wait after hire date before becoming eligible to enroll in the benefit plan.',
    CONSTRAINT pk_workforce_benefit_plan PRIMARY KEY(`workforce_benefit_plan_id`)
) COMMENT 'Master catalog of employee benefit plans and individual enrollment records across hotel properties. Covers plan definitions (health, dental, vision, 401k, life insurance, EAP, hotel rate discounts) with carrier, coverage tiers, contribution rates, eligibility criteria, and enrollment periods. Includes employee enrollment records: elected plans, coverage dates, contribution amounts, dependent count, enrollment source (open enrollment, life event, new hire), and enrollment status. Supports ACA compliance reporting, total compensation cost tracking per USALI, and Oracle HCM Cloud Benefits integration.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` (
    `compensation_plan_id` BIGINT COMMENT 'Unique identifier for the compensation plan definition. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compensation plans define which cost center absorbs the labor expense for budgeting, headcount planning, and labor cost variance analysis - essential for accurate departmental budget allocation and fu',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Compensation plans are defined for positions (job families, pay grades, FLSA classifications). Position is the authoritative source for job family and pay grade definitions. The compensation_plan tabl',
    `employee_id` BIGINT COMMENT 'Employee ID of the HR or compensation leader who approved this plan. Null if not yet approved.',
    `approval_status` STRING COMMENT 'Approval workflow status for this compensation plan: draft (being created), pending_approval (submitted for review), approved (authorized for use), rejected (not approved).. Valid values are `draft|pending_approval|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this compensation plan was approved. Null if not yet approved.',
    `benefits_package_code` STRING COMMENT 'Code identifying the standard benefits package associated with this compensation plan (health, dental, retirement, etc.).. Valid values are `^[A-Z0-9]{2,8}$`',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates whether employees under this plan are eligible for discretionary or performance-based bonuses (True/False).',
    `brand_segment` STRING COMMENT 'Hotel brand segment to which this compensation plan applies: luxury, premium, select_service, extended_stay, resort, or all (applicable across all segments).. Valid values are `luxury|premium|select_service|extended_stay|resort|all`',
    `commission_eligible` BOOLEAN COMMENT 'Indicates whether employees under this plan are eligible for commission-based compensation (True/False). Typical for sales and revenue-generating roles.',
    `commission_rate_percentage` DECIMAL(18,2) COMMENT 'Standard commission rate as a percentage of sales or revenue (e.g., 5.00 for 5%). Null if not commission eligible.',
    `compa_ratio_target` DECIMAL(18,2) COMMENT 'Target compa-ratio for employees in this plan (actual pay divided by midpoint). Typically 1.00 (100%) for market-competitive positioning.',
    `compensation_plan_status` STRING COMMENT 'Current lifecycle status of the compensation plan: active (in use), inactive (temporarily suspended), pending (awaiting approval), obsolete (retired).. Valid values are `active|inactive|pending|obsolete`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this compensation plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this plan (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `compensation_plan_description` STRING COMMENT 'Detailed description of the compensation plan, including eligibility criteria, special provisions, and business rationale.',
    `effective_end_date` DATE COMMENT 'Date when this compensation plan is no longer effective. Null for open-ended plans.',
    `effective_start_date` DATE COMMENT 'Date when this compensation plan becomes effective and can be assigned to employees.',
    `flsa_status` STRING COMMENT 'FLSA classification: exempt (not eligible for overtime) or non_exempt (eligible for overtime pay). Critical for compliance and labor cost forecasting.. Valid values are `exempt|non_exempt`',
    `is_unionized` BOOLEAN COMMENT 'Indicates whether this compensation plan is subject to collective bargaining agreements (True/False).',
    `market_pricing_date` DATE COMMENT 'Date of the market pricing data used to establish or update this compensation plan.',
    `market_pricing_source` STRING COMMENT 'External compensation survey or benchmarking source used to establish pay ranges (e.g., Mercer, Willis Towers Watson, Salary.com).',
    `maximum_rate` DECIMAL(18,2) COMMENT 'Maximum pay rate for this plan, representing the ceiling for this grade. Used for pay equity and budget planning.',
    `merit_increase_cycle` STRING COMMENT 'Frequency of merit increase reviews for this plan: annual, biannual, quarterly, or none.. Valid values are `annual|biannual|quarterly|none`',
    `merit_increase_eligible` BOOLEAN COMMENT 'Indicates whether employees under this plan are eligible for annual merit increases based on performance (True/False).',
    `midpoint_rate` DECIMAL(18,2) COMMENT 'Midpoint or target pay rate for this plan, representing the market-competitive rate for fully competent performance.',
    `minimum_rate` DECIMAL(18,2) COMMENT 'Minimum pay rate for this plan (hourly rate for hourly plans, annual salary for salaried plans). Used for pay equity and compliance analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this compensation plan record was last modified.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether employees under this plan are eligible for overtime compensation (True/False). Aligns with FLSA status.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Null if not overtime eligible.',
    `pay_frequency` STRING COMMENT 'Frequency at which employees under this plan are paid (weekly, biweekly, semimonthly, monthly).. Valid values are `weekly|biweekly|semimonthly|monthly`',
    `plan_code` STRING COMMENT 'Business identifier code for the compensation plan, used across HR systems and reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `plan_name` STRING COMMENT 'Full descriptive name of the compensation plan (e.g., Hourly Front Desk Associate, Salaried Executive Chef).',
    `plan_type` STRING COMMENT 'Classification of the compensation structure: hourly (paid per hour worked), salaried (fixed annual compensation), tipped (base plus gratuities), commission (performance-based), service_charge_eligible (eligible for service charge distribution), or hybrid (combination).. Valid values are `hourly|salaried|tipped|commission|service_charge_eligible|hybrid`',
    `rate_unit` STRING COMMENT 'Unit of measure for the compensation rate: hour (hourly wage), year (annual salary), month (monthly salary), week (weekly wage), day (daily rate).. Valid values are `hour|year|month|week|day`',
    `service_charge_eligible` BOOLEAN COMMENT 'Indicates whether employees under this plan are eligible to receive a share of service charges (True/False). Common in banquet and group dining operations.',
    `target_bonus_percentage` DECIMAL(18,2) COMMENT 'Target bonus as a percentage of base compensation (e.g., 10.00 for 10% target bonus). Null if not bonus eligible.',
    `tip_credit_eligible` BOOLEAN COMMENT 'Indicates whether this plan is eligible for tip credit under FLSA (True/False). Applicable to tipped positions in Food and Beverage (F&B) operations.',
    `union_affiliation` STRING COMMENT 'Name of the labor union associated with this compensation plan, if applicable. Null if non-union.',
    `usali_department` STRING COMMENT 'USALI department classification for labor cost reporting (e.g., Rooms, Food and Beverage, Administrative and General, Sales and Marketing).',
    CONSTRAINT pk_compensation_plan PRIMARY KEY(`compensation_plan_id`)
) COMMENT 'Compensation structure definitions and individual employee pay change history for hotel positions. Covers pay plan types (hourly, salaried, tipped, commission, service-charge-eligible), pay grades with min/mid/max rates, effective dates, and brand segment applicability. Includes merit increases, promotional adjustments, market adjustments, and off-cycle changes with previous/new rates, change percentage, justification, approval chain, and SAP S/4HANA HR infotype reference. Supports pay equity analysis, merit administration, total compensation cost tracking, and USALI labor cost benchmarking.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` (
    `disciplinary_action_id` BIGINT COMMENT 'Unique identifier for the disciplinary action record. Primary key for the disciplinary action entity.',
    `employee_id` BIGINT COMMENT 'User ID of the system user who created this disciplinary action record. Audit field for accountability and data lineage tracking.',
    `disciplinary_last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the system user who last modified this disciplinary action record. Audit field for accountability and change tracking.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Disciplinary actions occur within an organizational unit context (the employees department at time of incident). This provides organizational context for HR analytics, compliance reporting, and manag',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Disciplinary actions must cite specific policy violations for legal defensibility and consistency. HR and legal teams require direct link to policy violated for grievance defense, arbitration, and ens',
    `primary_disciplinary_employee_id` BIGINT COMMENT 'Unique identifier of the employee subject to the disciplinary action. Links to the employee master record in Oracle HCM Cloud or SAP S/4HANA HCM.',
    `property_id` BIGINT COMMENT 'Unique identifier of the hotel property where the disciplinary action occurred. Links to the property master record.',
    `tertiary_disciplinary_hr_business_partner_employee_id` BIGINT COMMENT 'Unique identifier of the HR business partner involved in reviewing and approving the disciplinary action. Links to the employee master record. Ensures HR oversight and policy compliance.',
    `workforce_safety_incident_id` BIGINT COMMENT 'Unique identifier linking this disciplinary action to an OSHA recordable incident record if applicable. Null if not an OSHA recordable incident. Supports integrated safety and HR compliance reporting.',
    `action_effective_date` DATE COMMENT 'The date on which the disciplinary action officially takes effect. For suspensions, this is the start date. For terminations, this is the last day of employment. May differ from incident date or issuance date.',
    `action_number` STRING COMMENT 'Business-facing unique reference number for the disciplinary action record. Format: DA-YYYYMMDD followed by sequence. Used for tracking and documentation purposes.. Valid values are `^DA-[0-9]{8}$`',
    `action_status` STRING COMMENT 'Current lifecycle status of the disciplinary action record. Statuses include draft (being prepared), issued (formally communicated to employee), active (in effect), completed (action period concluded), overturned (reversed on appeal), or expunged (removed from record per policy or legal requirement).. Valid values are `draft|issued|active|completed|overturned|expunged`',
    `action_type` STRING COMMENT 'The type of disciplinary action taken following progressive discipline policy. Includes verbal warning, written warning, final warning, suspension, termination, or performance improvement plan (PIP). Aligns with progressive discipline framework and union contract requirements where applicable.. Valid values are `verbal_warning|written_warning|final_warning|suspension|termination|performance_improvement_plan`',
    `corrective_action_plan` STRING COMMENT 'Description of the corrective actions required of the employee to address the violation and prevent recurrence. May include training, coaching, behavioral expectations, or performance targets. Part of progressive discipline and performance improvement process.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this disciplinary action record was first created in the system. Audit field for data lineage and compliance tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `employee_acknowledgment_date` DATE COMMENT 'The date on which the employee acknowledged receipt and understanding of the disciplinary action documentation. Null if not yet acknowledged. Critical for documentation completeness and legal defensibility.',
    `employee_acknowledgment_method` STRING COMMENT 'The method by which the employee acknowledged receipt of the disciplinary action. Methods include in-person signature, electronic signature, certified mail, email confirmation, or refused (employee declined to sign). Used for documentation audit trail.. Valid values are `in_person_signature|electronic_signature|certified_mail|email_confirmation|refused`',
    `expiration_date` DATE COMMENT 'The date on which the disciplinary action expires and is no longer considered active in progressive discipline tracking. Per policy, warnings may expire after a clean period (e.g., 12 months). Null for terminations or actions without expiration.',
    `expunged_date` DATE COMMENT 'The date on which the disciplinary action record was expunged from the employees active record. Null if not expunged. Used for data retention and compliance tracking.',
    `expunged_reason` STRING COMMENT 'Explanation of why the disciplinary action record was expunged. Reasons may include policy expiration, grievance settlement, legal requirement, or administrative correction. Null if not expunged.',
    `grievance_filed` BOOLEAN COMMENT 'Indicates whether the employee has filed a formal grievance or appeal against the disciplinary action. True if grievance filed, false otherwise. Critical for union contract compliance and legal risk management.',
    `grievance_outcome_notes` STRING COMMENT 'Detailed notes on the outcome of the grievance or appeal process, including any modifications to the original disciplinary action, settlements, or arbitration decisions. Null if no grievance filed.',
    `grievance_resolution_date` DATE COMMENT 'The date on which the grievance or appeal was formally resolved. Null if no grievance filed or if grievance is still pending. Used for labor relations reporting and compliance tracking.',
    `grievance_status` STRING COMMENT 'Current status of the grievance or appeal process if a grievance has been filed. Statuses include pending, under review, upheld (action stands), overturned (action reversed), settled, or withdrawn. Null if no grievance filed.. Valid values are `pending|under_review|upheld|overturned|settled|withdrawn`',
    `incident_date` DATE COMMENT 'The date on which the policy violation or incident occurred that led to the disciplinary action. This is the business event date, distinct from when the action was formally issued.',
    `incident_description` STRING COMMENT 'Detailed narrative description of the incident or policy violation that led to the disciplinary action. Includes facts, witnesses, and context. Critical for wrongful termination defense and grievance documentation.',
    `is_eligible_for_rehire` BOOLEAN COMMENT 'Indicates whether the employee is eligible for rehire following termination. True if eligible, false if not. Null for non-termination actions. Used by talent acquisition and background screening processes.',
    `is_expunged` BOOLEAN COMMENT 'Indicates whether the disciplinary action record has been expunged (removed from the employees active record) per policy, legal requirement, or grievance settlement. True if expunged, false otherwise. Expunged records are retained for audit but not used in progressive discipline tracking.',
    `is_paid_suspension` BOOLEAN COMMENT 'Indicates whether the suspension is paid or unpaid. True if paid, false if unpaid. Impacts payroll processing and labor cost allocation. Null for non-suspension actions.',
    `issued_date` DATE COMMENT 'The date on which the disciplinary action was formally issued and communicated to the employee. Distinct from incident date and effective date. Used for timeline tracking and compliance with notification requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this disciplinary action record was last modified in the system. Audit field for change tracking and compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `legal_hold` BOOLEAN COMMENT 'Indicates whether this disciplinary action record is subject to a legal hold due to pending or threatened litigation, regulatory investigation, or other legal proceedings. True if under legal hold, false otherwise. Records under legal hold must not be deleted or modified.',
    `legal_hold_case_number` STRING COMMENT 'Reference number of the legal case or investigation that triggered the legal hold on this record. Null if not under legal hold. Used for legal department tracking and e-discovery management.',
    `osha_recordable_incident` BOOLEAN COMMENT 'Indicates whether the incident that led to the disciplinary action is also an OSHA recordable safety incident. True if OSHA recordable, false otherwise. Links disciplinary actions to workplace safety compliance reporting.',
    `suspension_days` STRING COMMENT 'The total number of days of suspension if the action type is suspension. Null for non-suspension actions. Used for labor cost analysis and CPOR (Cost Per Occupied Room) labor component tracking.',
    `suspension_end_date` DATE COMMENT 'The end date of a suspension period if the action type is suspension. Null for non-suspension actions. Defines when the employee is eligible to return to work.',
    `suspension_start_date` DATE COMMENT 'The start date of a suspension period if the action type is suspension. Null for non-suspension actions. Used for payroll and scheduling system integration.',
    `termination_date` DATE COMMENT 'The effective date of employment termination if the action type is termination. Null for non-termination actions. This is the last day of active employment and triggers final payroll and benefits processing.',
    `termination_reason_code` STRING COMMENT 'Standardized code indicating the reason for termination if the action type is termination. Categories include voluntary resignation, involuntary for cause, involuntary for performance, involuntary for conduct, layoff, or mutual separation. Used for unemployment claims and compliance reporting.. Valid values are `voluntary|involuntary_cause|involuntary_performance|involuntary_conduct|layoff|mutual_separation`',
    `union_representative_name` STRING COMMENT 'Name of the union representative who was notified or involved in the disciplinary action process. Null if employee is not union-represented or if no representative was involved.',
    `union_representative_notified` BOOLEAN COMMENT 'Indicates whether the employees union representative was notified of the disciplinary action as required by union contract. True if notified, false otherwise. Null if employee is not union-represented. Critical for labor relations compliance.',
    `violation_category` STRING COMMENT 'The category of policy violation that triggered the disciplinary action. Categories include attendance issues, conduct violations, performance deficiencies, safety violations, general policy breaches, guest service failures, or theft/fraud. Used for trend analysis and compliance reporting. [ENUM-REF-CANDIDATE: attendance|conduct|performance|safety|policy_breach|guest_service|theft_fraud — 7 candidates stripped; promote to reference product]',
    `witness_names` STRING COMMENT 'Comma-separated list of names of witnesses to the incident or policy violation. Used for investigation documentation and wrongful termination defense. May be redacted in certain reporting contexts.',
    CONSTRAINT pk_disciplinary_action PRIMARY KEY(`disciplinary_action_id`)
) COMMENT 'Employee disciplinary and corrective action records for hotel staff including grievance tracking. Captures incident date, action type (verbal warning, written warning, final warning, suspension, termination), policy violation category, description of incident, corrective action plan, action effective date, appeal/grievance status, and HR business partner involved. Supports progressive discipline tracking, wrongful termination risk management, union grievance documentation, and OSHA recordable incident linkage.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` (
    `job_requisition_id` BIGINT COMMENT 'Unique identifier for the job requisition record. Primary key for the talent acquisition lifecycle tracking.',
    `org_unit_id` BIGINT COMMENT 'Reference to the department or functional area requesting the hire (e.g., Front Desk, Housekeeping, Food and Beverage (F&B), Sales, Revenue Management).',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Job requisitions are opened to fill authorized positions (headcount plan). This links talent acquisition to workforce planning. The job_requisition table has position_title and job_code (STRING) which',
    `employee_id` BIGINT COMMENT 'Reference to the employee who is the hiring manager responsible for the position and final candidate selection.',
    `property_id` BIGINT COMMENT 'Reference to the hotel property or resort location where the position will be based.',
    `tertiary_job_approved_by_employee_id` BIGINT COMMENT 'Reference to the employee who approved the requisition (typically department head, general manager, or HR director depending on approval hierarchy).',
    `approval_date` DATE COMMENT 'Date when the requisition received final approval and was authorized to proceed to posting and recruiting.',
    `background_check_required_flag` BOOLEAN COMMENT 'Indicates whether a background check is required for this position. Typically true for all guest-facing roles and positions with financial or security responsibilities.',
    `compensation_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the salary range (e.g., USD, EUR, GBP). Supports multi-country property operations.. Valid values are `^[A-Z]{3}$`',
    `compensation_frequency` STRING COMMENT 'Pay frequency for the position: hourly (most operational roles), annual (salaried management), monthly, or weekly.. Valid values are `hourly|annual|monthly|weekly`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition record was first created in the system. Audit trail for requisition lifecycle tracking.',
    `drug_screening_required_flag` BOOLEAN COMMENT 'Indicates whether pre-employment drug screening is required. Common for safety-sensitive positions and jurisdictions where permitted by law.',
    `eeo_job_category` STRING COMMENT 'Equal Employment Opportunity Commission job category for regulatory reporting (e.g., Executive/Senior Level Officials and Managers, First/Mid-Level Officials and Managers, Professionals, Service Workers). Required for EEO-1 compliance reporting.',
    `employment_type` STRING COMMENT 'Nature of the employment relationship: full-time, part-time, seasonal (high occupancy periods), temporary, contract, or on-call (banquet/event staff).. Valid values are `full_time|part_time|seasonal|temporary|contract|on_call`',
    `external_posting_flag` BOOLEAN COMMENT 'Indicates whether the requisition is posted to external job boards, career sites, and recruiting channels.',
    `flsa_classification` STRING COMMENT 'Fair Labor Standards Act classification determining overtime eligibility: exempt (salaried, not eligible for overtime) or non-exempt (hourly, eligible for overtime). Critical for labor cost management and compliance.. Valid values are `exempt|non_exempt`',
    `headcount_requested` STRING COMMENT 'Number of positions to be filled under this requisition. Typically 1 for individual roles, may be higher for bulk hiring (e.g., seasonal housekeeping staff).',
    `internal_posting_flag` BOOLEAN COMMENT 'Indicates whether the requisition is posted internally for current employees before external candidates. Supports internal mobility and career development programs.',
    `job_description` STRING COMMENT 'Detailed description of the role, responsibilities, qualifications, and expectations. Used for job postings and candidate communication.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition record was last updated. Tracks changes to status, details, or candidate pipeline throughout the hiring process.',
    `minimum_qualifications` STRING COMMENT 'Required education, certifications, experience, and skills for the position (e.g., high school diploma, hospitality degree, PMS system experience, food handler certification).',
    `posting_end_date` DATE COMMENT 'Date when the job posting will close and no longer accept new applications. May be extended if position remains unfilled.',
    `posting_location` STRING COMMENT 'Geographic location description for the job posting (city, state, country). Used for candidate search and location-based job board distribution.',
    `posting_start_date` DATE COMMENT 'Date when the job requisition was or will be posted to internal and external job boards and career sites.',
    `preferred_qualifications` STRING COMMENT 'Desired but not mandatory qualifications that would make a candidate more competitive (e.g., bilingual, luxury hotel experience, revenue management certification).',
    `priority_level` STRING COMMENT 'Urgency of the hiring need. Critical priority typically assigned to key operational roles (e.g., Executive Chef, Director of Revenue Management) or roles impacting guest experience during peak season.. Valid values are `low|medium|high|critical`',
    `requisition_closed_date` DATE COMMENT 'Date when the requisition was closed (filled, cancelled, or otherwise completed). Used to calculate time-to-fill metrics.',
    `requisition_justification` STRING COMMENT 'Business rationale for the hiring request, including operational need, budget impact, and strategic alignment. Used for approval workflow and headcount planning.',
    `requisition_number` STRING COMMENT 'Business identifier for the job requisition, typically system-generated and externally visible to hiring managers and recruiters.. Valid values are `^REQ-[0-9]{6,10}$`',
    `requisition_opened_date` DATE COMMENT 'Date when the requisition was approved and moved to open status, marking the start of active recruiting.',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the requisition: draft (being prepared), pending approval (awaiting manager/HR sign-off), approved (ready to post), open (actively recruiting), on hold (paused), filled (offer accepted), cancelled (no longer needed), closed (completed). [ENUM-REF-CANDIDATE: draft|pending_approval|approved|open|on_hold|filled|cancelled|closed — 8 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the hiring need: new position (headcount growth), replacement (turnover), backfill (internal promotion), seasonal (peak demand), temporary (project-based), or contract (contingent labor).. Valid values are `new_position|replacement|backfill|seasonal|temporary|contract`',
    `salary_range_max` DECIMAL(18,2) COMMENT 'Maximum annual salary or hourly rate for the position, aligned with compensation bands and market benchmarks.',
    `salary_range_min` DECIMAL(18,2) COMMENT 'Minimum annual salary or hourly rate for the position, aligned with compensation bands and market benchmarks.',
    `shift_type` STRING COMMENT 'Primary work shift for the position: day (morning/afternoon), evening, night (overnight), rotating (varies), or flexible. Critical for 24/7 hotel operations.. Valid values are `day|evening|night|rotating|flexible`',
    `target_start_date` DATE COMMENT 'Desired date for the new hire to begin employment. Critical for seasonal hiring and operational planning.',
    `time_to_fill_days` STRING COMMENT 'Number of calendar days from requisition opened date to requisition closed date. Key talent acquisition performance metric tracked against industry benchmarks.',
    `travel_requirement` STRING COMMENT 'Expected travel frequency for the role: none (property-based), occasional (less than 25%), frequent (25-50%), extensive (over 50%). Relevant for regional managers, corporate roles, and multi-property positions.. Valid values are `none|occasional|frequent|extensive`',
    `work_authorization_required` STRING COMMENT 'Description of work authorization requirements for the position (e.g., must be authorized to work in the United States, visa sponsorship available, etc.). Critical for international hiring and compliance.',
    `work_location_type` STRING COMMENT 'Physical work arrangement: on-site (property-based, typical for most hospitality roles), hybrid (mix of on-site and remote for corporate roles), or remote (fully remote for select positions).. Valid values are `on_site|hybrid|remote`',
    CONSTRAINT pk_job_requisition PRIMARY KEY(`job_requisition_id`)
) COMMENT 'Talent acquisition lifecycle management covering job requisitions, candidate/applicant tracking, and formal employment offers across hotel properties. Captures requisition details (position, department, property, type, headcount, status, time-to-fill), applicant records (source, pipeline stage, work authorization, EEOC data), and offer details (salary/rate, start date, offer status, background check). Supports the full hiring pipeline from requisition approval through offer acceptance and employee onboarding. Sourced from Oracle HCM Cloud Talent Acquisition and Recruiting modules.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record. Primary key for the performance review entity.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Performance reviews occur within organizational unit context for departmental performance analytics and manager accountability. The performance_review table has department_code (STRING) which should b',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Performance reviews are conducted for employees in specific positions. Position provides the authoritative job definition context for performance standards and competency frameworks. The performance_r',
    `employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed. Links to the employee master record in the workforce domain.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the employee conducting the performance review, typically the direct manager or supervisor.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the performance review record was first created in the system.',
    `development_areas_summary` STRING COMMENT 'Narrative summary of areas where the employee needs improvement or further development.',
    `development_plan_notes` STRING COMMENT 'Detailed notes on the employee development plan, including recommended training, mentoring, or stretch assignments to support career growth.',
    `employee_acknowledgement_date` DATE COMMENT 'The date when the employee acknowledged receipt and review of their performance evaluation.',
    `employee_comments` STRING COMMENT 'Comments provided by the employee in response to the performance review, including self-assessment and feedback on the review process.',
    `goals_met_count` STRING COMMENT 'The number of performance goals or objectives that the employee successfully met during the review period.',
    `goals_total_count` STRING COMMENT 'The total number of performance goals or objectives assigned to the employee for the review period.',
    `guest_service_rating` STRING COMMENT 'Competency rating for guest service excellence, a critical competency in hospitality operations. Assesses employees ability to deliver exceptional guest experiences.. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the performance review record was last updated or modified.',
    `leadership_rating` STRING COMMENT 'Competency rating for leadership and people management skills. Applicable to supervisory and management roles; marked not-applicable for individual contributors.. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding|not-applicable`',
    `merit_increase_eligible_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee is eligible for a merit-based salary increase based on this performance review outcome.',
    `overall_rating` STRING COMMENT 'The overall performance rating assigned to the employee for the review period. Used for merit increase decisions and succession planning.. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall performance rating, typically on a scale (e.g., 1.00 to 5.00). Enables quantitative analysis and compensation modeling.',
    `performance_improvement_plan_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee has been placed on a formal Performance Improvement Plan due to unsatisfactory performance.',
    `promotion_recommended_flag` BOOLEAN COMMENT 'Boolean indicator of whether the reviewer recommends the employee for promotion based on performance and readiness.',
    `property_code` STRING COMMENT 'The code identifying the hotel property or resort where the employee works and where this performance review was conducted.',
    `reliability_rating` STRING COMMENT 'Competency rating for reliability, punctuality, and attendance. Critical for 24/7 hospitality operations.. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding`',
    `review_completion_date` DATE COMMENT 'The date when the reviewer completed and submitted the performance review.',
    `review_due_date` DATE COMMENT 'The target date by which the performance review should be completed, based on organizational policy and review cycle.',
    `review_period_end_date` DATE COMMENT 'The end date of the performance evaluation period being assessed.',
    `review_period_start_date` DATE COMMENT 'The start date of the performance evaluation period being assessed.',
    `review_status` STRING COMMENT 'Current workflow status of the performance review (pending initiation, in-progress, completed by reviewer, acknowledged by employee, or cancelled).. Valid values are `pending|in-progress|completed|acknowledged|cancelled`',
    `review_template_code` STRING COMMENT 'The code identifying the performance review template or form used, which may vary by job level, department, or review type.',
    `review_type` STRING COMMENT 'The type or category of performance review being conducted (annual, mid-year, probationary, 90-day, project-based, or ad-hoc).. Valid values are `annual|mid-year|probationary|90-day|project|ad-hoc`',
    `reviewer_comments` STRING COMMENT 'Additional comments and observations from the reviewer providing context and detail beyond the structured ratings.',
    `strengths_summary` STRING COMMENT 'Narrative summary of the employees key strengths and positive contributions during the review period.',
    `succession_planning_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee has been identified for succession planning and leadership pipeline development.',
    `teamwork_rating` STRING COMMENT 'Competency rating for teamwork and collaboration with colleagues across departments and shifts.. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding`',
    `technical_skills_rating` STRING COMMENT 'Competency rating for job-specific technical skills (e.g., PMS proficiency for front desk, culinary skills for F&B, housekeeping standards).. Valid values are `exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding`',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Formal employee performance evaluation records for hotel staff. Captures review period, review type (annual, mid-year, probationary, 90-day), overall performance rating, individual competency ratings (guest service, teamwork, reliability, technical skills), reviewer identity, review completion date, review status (pending, in-progress, completed, acknowledged), and development notes. Supports merit increase decisions and succession planning. Sourced from Oracle HCM Cloud Performance Management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for the leave request record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor who approved or denied the leave request.',
    `procurement_benefit_plan_id` BIGINT COMMENT 'Identifier of the leave accrual plan governing this leave type for the employee, defining accrual rates, carryover rules, and maximum balances.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the cost center to which the employees labor costs are allocated, used for payroll liability calculations.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department where the employee works, used for scheduling coverage planning and labor cost allocation.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Leave requests must reference governing policy (FMLA, ADA, PTO) for validation and audit. HR systems validate eligibility against policy rules, track policy basis for regulatory compliance, and provid',
    `primary_leave_employee_id` BIGINT COMMENT 'Identifier of the employee submitting the leave request.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the employee is assigned.',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.schedule. Business justification: Leave requests impact published schedules and require coverage planning. This FK links absence management to scheduling, enabling coverage_status tracking (leave_request.coverage_status, coverage_empl',
    `accrual_period` STRING COMMENT 'Time period for which the accrual balance is calculated, such as calendar year, fiscal year, or rolling 12 months.',
    `approval_date` DATE COMMENT 'Date when the approving manager made the approval or denial decision in yyyy-MM-dd format.',
    `approval_notes` STRING COMMENT 'Comments or notes provided by the approving manager regarding the approval or denial decision.',
    `approval_status` STRING COMMENT 'Current approval state of the leave request: pending, approved, denied, or escalated to higher management.. Valid values are `pending|approved|denied|escalated`',
    `approval_timestamp` TIMESTAMP COMMENT 'Precise date and time when the approving manager made the approval or denial decision in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `balance_as_of_date` DATE COMMENT 'Date as of which the accrual balance figures are calculated in yyyy-MM-dd format.',
    `carryover_hours` DECIMAL(18,2) COMMENT 'Number of unused leave hours carried over from the previous accrual period, subject to plan carryover limits.',
    `certification_received_date` DATE COMMENT 'Date when required medical certification or supporting documentation was received by HR in yyyy-MM-dd format.',
    `coverage_status` STRING COMMENT 'Status of scheduling coverage arrangements for the employees absence: not required, pending, arranged, or confirmed.. Valid values are `not_required|pending|arranged|confirmed`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this leave request record was first created in the system in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `denial_reason` STRING COMMENT 'Explanation provided by the approving manager for denying the leave request, such as staffing constraints, blackout period, or insufficient accrual balance.',
    `end_date` DATE COMMENT 'Last date of the requested leave period in yyyy-MM-dd format.',
    `fmla_case_number` STRING COMMENT 'Unique case identifier for tracking FMLA leave usage and compliance, assigned when FMLA eligibility is established.',
    `hours_accrued` DECIMAL(18,2) COMMENT 'Total leave hours earned or accrued during the accrual period up to the request date.',
    `hours_requested` DECIMAL(18,2) COMMENT 'Number of leave hours being requested in this leave request, which will be deducted from the accrual balance if approved.',
    `hours_taken` DECIMAL(18,2) COMMENT 'Total leave hours used or taken during the accrual period prior to this request.',
    `is_ada_accommodation` BOOLEAN COMMENT 'Indicates whether this leave is granted as a reasonable accommodation under ADA (true) or not (false).',
    `is_fmla_qualifying` BOOLEAN COMMENT 'Indicates whether this leave request qualifies for FMLA protection (true) or not (false), based on reason and employee eligibility.',
    `is_intermittent` BOOLEAN COMMENT 'Indicates whether the leave is intermittent (true) or continuous (false). Intermittent leave is taken in separate blocks of time rather than one continuous period.',
    `is_paid` BOOLEAN COMMENT 'Indicates whether the leave is paid (true) or unpaid (false) based on leave type and accrual balance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this leave request record was last updated in the system in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `leave_subtype` STRING COMMENT 'Detailed classification within the leave type, such as continuous FMLA, intermittent FMLA, maternity, paternity, adoption leave, or COVID-19 sick leave.',
    `leave_type` STRING COMMENT 'Category of leave being requested: vacation, sick, FMLA (Family and Medical Leave Act), personal, bereavement, jury duty, military, unpaid, parental, or sabbatical. [ENUM-REF-CANDIDATE: vacation|sick|fmla|personal|bereavement|jury_duty|military|unpaid|parental|sabbatical — 10 candidates stripped; promote to reference product]',
    `opening_balance_hours` DECIMAL(18,2) COMMENT 'Leave accrual balance in hours at the start of the accrual period before this request.',
    `payroll_impact_amount` DECIMAL(18,2) COMMENT 'Estimated financial impact on payroll for this leave request, including accrued vacation liability or unpaid leave deductions.',
    `reason_description` STRING COMMENT 'Employee-provided explanation or justification for the leave request, such as medical appointment, family emergency, or vacation travel.',
    `remaining_balance_hours` DECIMAL(18,2) COMMENT 'Projected leave accrual balance in hours after this request is approved and hours are deducted.',
    `request_date` DATE COMMENT 'Date when the employee submitted the leave request in yyyy-MM-dd format.',
    `request_number` STRING COMMENT 'Business-facing unique reference number for the leave request, used for tracking and communication.',
    `request_status` STRING COMMENT 'Current workflow state of the leave request: draft, submitted, pending approval, approved, denied, cancelled, or withdrawn. [ENUM-REF-CANDIDATE: draft|submitted|pending_approval|approved|denied|cancelled|withdrawn — 7 candidates stripped; promote to reference product]',
    `request_timestamp` TIMESTAMP COMMENT 'Precise date and time when the employee submitted the leave request in yyyy-MM-ddTHH:mm:ss.SSSXXX format.',
    `requires_medical_certification` BOOLEAN COMMENT 'Indicates whether the leave request requires supporting medical documentation or certification (true) or not (false).',
    `start_date` DATE COMMENT 'First date of the requested leave period in yyyy-MM-dd format.',
    `total_days` DECIMAL(18,2) COMMENT 'Total number of calendar days covered by the leave request, including weekends and holidays if applicable.',
    `total_hours` DECIMAL(18,2) COMMENT 'Total number of work hours covered by the leave request, used for accrual deduction and payroll calculations.',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Employee absence management records covering leave requests, approvals, and accrual balances across hotel properties. Captures leave type (vacation, sick, FMLA, personal, bereavement, jury duty, military, unpaid), requested dates, total days, approval status, approving manager, and leave balance impact including accrual period, opening balance, hours accrued, hours taken, carryover, and balance as-of date. Supports FMLA compliance tracking, ADA accommodation leave, scheduling coverage planning, payroll liability calculations for accrued vacation, and compliance with state-mandated paid sick leave laws. Sourced from Oracle HCM Cloud Absence Management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` (
    `workforce_safety_incident_id` BIGINT COMMENT 'Unique identifier for the workplace safety incident record.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department where the incident occurred.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Safety incidents are analyzed by position/job type for OSHA risk assessment and compliance reporting. This enables OSHA 300 log reporting by job category and identification of high-risk positions. Cri',
    `employee_id` BIGINT COMMENT 'Identifier of the employee involved in the safety incident.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the incident occurred.',
    `body_part_affected` STRING COMMENT 'Specific body part or parts injured in the incident (e.g., lower back, right hand, left knee, head).',
    `corrective_action_date` DATE COMMENT 'Date when corrective actions were completed and implemented.',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective actions implemented to prevent recurrence of similar incidents.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this incident record was first created in the system.',
    `days_away_from_work` STRING COMMENT 'Number of calendar days the employee was unable to work due to the incident.',
    `days_on_restricted_duty` STRING COMMENT 'Number of calendar days the employee was on job transfer or restricted work activity due to the incident.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost of the incident including medical expenses, lost time, and property damage.',
    `incident_date` DATE COMMENT 'Date when the workplace safety incident occurred.',
    `incident_description` STRING COMMENT 'Detailed narrative description of how the incident occurred and the circumstances surrounding it.',
    `incident_location` STRING COMMENT 'Specific location within the property where the incident occurred (e.g., kitchen, guest room 305, loading dock, pool area).',
    `incident_number` STRING COMMENT 'Business-assigned unique incident reference number for tracking and reporting purposes.',
    `incident_time` TIMESTAMP COMMENT 'Precise timestamp when the workplace safety incident occurred.',
    `incident_type` STRING COMMENT 'Classification of the type of workplace safety incident.. Valid values are `slip_fall|chemical_exposure|equipment_injury|ergonomic|near_miss|burn`',
    `injury_severity` STRING COMMENT 'Classification of the severity level of the injury sustained in the incident.. Valid values are `first_aid|medical_treatment|lost_time|restricted_duty|fatality|no_injury`',
    `investigation_completed_date` DATE COMMENT 'Date when the formal investigation of the incident was completed.',
    `investigation_status` STRING COMMENT 'Current status of the incident investigation process.. Valid values are `open|under_investigation|closed|pending_review`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this incident record was last updated in the system.',
    `medical_treatment_facility` STRING COMMENT 'Name and location of the medical facility where the employee received treatment.',
    `osha_300_log_entry_number` STRING COMMENT 'Reference number assigned to this incident in the OSHA 300 log if recordable.',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA criteria for recordability on the OSHA 300 log.',
    `physician_name` STRING COMMENT 'Name of the physician or healthcare provider who treated the employee.',
    `preventable_flag` BOOLEAN COMMENT 'Indicates whether the incident was determined to be preventable through proper procedures or training.',
    `privacy_case_flag` BOOLEAN COMMENT 'Indicates whether the incident qualifies as a privacy case under OSHA regulations (e.g., mental health, sexual assault).',
    `reported_by` STRING COMMENT 'Name or identifier of the person who reported the incident (employee, supervisor, witness).',
    `reported_date` DATE COMMENT 'Date when the incident was formally reported to management or human resources.',
    `return_to_work_date` DATE COMMENT 'Date when the employee returned to full or modified work duties following the incident.',
    `root_cause_analysis` STRING COMMENT 'Detailed analysis of the underlying root cause(s) that led to the incident.',
    `witness_names` STRING COMMENT 'Names of any witnesses who observed the incident, separated by semicolons if multiple.',
    `workers_compensation_claim_number` STRING COMMENT 'Claim number assigned by the workers compensation insurance carrier for this incident.',
    CONSTRAINT pk_workforce_safety_incident PRIMARY KEY(`workforce_safety_incident_id`)
) COMMENT 'OSHA-recordable and non-recordable workplace safety incident records for hotel employees. Captures incident date and time, incident location (property, department, specific area), incident type (slip/fall, chemical exposure, equipment injury, ergonomic, near-miss), injury severity, body part affected, days away from work, OSHA recordable flag, OSHA 300 log entry reference, workers compensation claim number, and corrective action taken. Supports OSHA 300/301 regulatory reporting.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the employee record. Primary key for the employee entity. System of record identifier used across all workforce management systems.',
    `cost_center_id` BIGINT COMMENT 'Financial cost center to which the employees labor costs are allocated. Used for financial reporting, budgeting, and USALI compliance. Links to the finance cost center master.',
    `manager_employee_id` BIGINT COMMENT 'Employee identifier of the direct manager or supervisor to whom this employee reports. Enables organizational hierarchy analysis and reporting structure visualization. Self-referential foreign key to employee table.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the operational department to which the employee is assigned (e.g., Front Desk, Housekeeping, Food and Beverage, Sales, Engineering). Critical for USALI labor cost allocation and departmental GOP analysis.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Employee occupies an authorized position. Position is the authoritative source for job definitions, titles, codes, and levels. This normalizes job attributes and links workforce planning (position = h',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property where the employee is primarily assigned. Links to the property master data for location-based workforce analytics and USALI labor cost reporting by property.',
    `ada_accommodation_description` STRING COMMENT 'Description of the specific workplace accommodations provided to the employee under ADA or equivalent legislation. Highly sensitive health-related information. Used for accommodation implementation and compliance documentation.',
    `ada_accommodation_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee requires workplace accommodations under ADA or equivalent disability legislation. Used for compliance tracking and accommodation management. Confidential but not direct health information.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was first created in the system. Used for data lineage, audit trail, and record lifecycle tracking.',
    `date_of_birth` DATE COMMENT 'Date of birth of the employee. Used for age verification, benefits eligibility, retirement planning, and compliance with labor laws regarding minimum working age.',
    `email_address` STRING COMMENT 'Primary corporate email address assigned to the employee for business communications, system access, and official correspondence. Critical for Oracle HCM Cloud and internal communication systems.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the person to contact in case of employee emergency. Used for employee safety and crisis management. Confidential employee information.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact person. Used for employee safety and crisis management. Confidential employee information.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the employee (e.g., spouse, parent, sibling, friend). Used for emergency response prioritization and communication.',
    `employee_number` STRING COMMENT 'Human-readable employee number or badge number assigned by the organization. Used for timekeeping, access control, payroll identification, and operational reference. May differ from system employee_id.',
    `employment_status` STRING COMMENT 'Current lifecycle status of the employee record indicating whether the employee is actively working, on leave, suspended, terminated, retired, or deceased. Used for workforce planning and payroll processing.. Valid values are `active|on-leave|suspended|terminated|retired|deceased`',
    `employment_type` STRING COMMENT 'Classification of employment arrangement indicating whether the employee is full-time, part-time, seasonal, contract, temporary, or intern. Critical for labor cost analysis, benefits eligibility, and USALI reporting.. Valid values are `full-time|part-time|seasonal|contract|temporary|intern`',
    `first_name` STRING COMMENT 'Legal first name of the employee as recorded in official employment records and payroll systems. Used for identification, communication, and compliance with employment regulations.',
    `food_safety_certification_expiry_date` DATE COMMENT 'Date when the employees food safety certification expires. Null if not applicable to role. Used for proactive recertification scheduling and F&B compliance management.',
    `food_safety_certification_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee holds a current food safety certification (e.g., ServSafe, ISO 22000). Required for Food and Beverage department employees. Used for compliance with health department regulations.',
    `fte_percentage` DECIMAL(18,2) COMMENT 'Full-Time Equivalent percentage representing the employees work commitment relative to a full-time position. 1.0 = 100% full-time, 0.5 = 50% part-time. Critical for workforce capacity planning and labor cost analysis.',
    `full_name` STRING COMMENT '',
    `hire_date` DATE COMMENT 'Date the employee was originally hired by the organization. Used for calculating tenure, seniority, benefits eligibility, and anniversary recognition. Critical for workforce analytics and retention analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this employee record was last updated. Used for change tracking, data quality monitoring, and audit compliance.',
    `last_name` STRING COMMENT 'Legal last name (surname/family name) of the employee as recorded in official employment records and payroll systems. Used for identification, communication, and compliance with employment regulations.',
    `middle_name` STRING COMMENT 'Middle name or initial of the employee if applicable. Optional field used for complete legal identification in employment records.',
    `national_id_number` STRING COMMENT 'Government-issued national identification number (e.g., Social Security Number in USA, National Insurance Number in UK). Used for tax reporting, payroll processing, and employment verification. Highly sensitive PII.',
    `oracle_hcm_employee_code` STRING COMMENT 'External employee identifier from Oracle HCM Cloud system. Used for integration and reconciliation between lakehouse and source HCM system. Critical for maintaining data lineage from system of record.',
    `osha_training_current_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employees required OSHA safety training is current and up-to-date. Used for workplace safety compliance, audit readiness, and training program management.',
    `osha_training_expiry_date` DATE COMMENT 'Date when the employees current OSHA safety training certification expires. Used for proactive training renewal scheduling and compliance management.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to the employees position. Used for salary administration, compensation benchmarking, and pay equity analysis. Business-confidential but not direct PII.',
    `pay_type` STRING COMMENT 'Classification of how the employee is compensated (hourly wages, salaried, commission-based, or contract). Critical for payroll processing, labor cost calculation, and USALI reporting.. Valid values are `hourly|salaried|commission|contract`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee. Used for emergency contact, scheduling notifications, and operational communications. May be mobile or landline.',
    `preferred_name` STRING COMMENT 'Name the employee prefers to be called in day-to-day operations, which may differ from legal name. Used for name badges, internal communications, and guest-facing interactions.',
    `standard_hours_per_week` DECIMAL(18,2) COMMENT 'Standard number of hours the employee is scheduled to work per week based on their employment type. Used for FTE calculation, scheduling, and labor cost forecasting. Typically 40 for full-time, variable for part-time.',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Null for active employees. Used for turnover analysis, exit processing, and historical workforce reporting. Critical for calculating turnover rates and retention metrics.',
    `termination_reason` STRING COMMENT 'Classification of the reason for employment termination. Used for turnover analysis, exit trend identification, and workforce planning. Null for active employees. [ENUM-REF-CANDIDATE: voluntary-resignation|involuntary-termination|retirement|end-of-contract|layoff|death|other — 7 candidates stripped; promote to reference product]',
    `union_code` STRING COMMENT 'Code identifying the specific labor union to which the employee belongs, if applicable. Null for non-union employees. Used for contract administration and labor relations tracking.',
    `union_membership_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee is a member of a labor union. Used for labor relations management, collective bargaining compliance, and union dues processing.',
    `work_authorization_expiry_date` DATE COMMENT 'Date when the employees work authorization expires (if applicable). Null for citizens and permanent residents. Used for proactive renewal tracking and compliance management.',
    `work_authorization_status` STRING COMMENT 'Current status of the employees legal authorization to work in the jurisdiction. Critical for compliance with immigration and employment laws. Used for I-9 compliance tracking in USA and equivalent requirements in other jurisdictions.. Valid values are `citizen|permanent-resident|work-visa|pending-verification|expired|not-authorized`',
    `work_location_type` STRING COMMENT 'Classification of where the employee primarily performs their work. Indicates whether the employee works on-property at a hotel/resort, remotely, in a hybrid arrangement, at corporate office, or across multiple properties.. Valid values are `on-property|remote|hybrid|corporate-office|multi-property`',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for all hotel and resort employees across properties. Captures full employment profile including personal details, employment type (full-time, part-time, seasonal, contract), job classification, department assignment, property assignment, hire date, termination date, employment status, OSHA compliance flags, ADA accommodation requirements, work authorization status, and Oracle HCM Cloud employee identifier. SSOT for employee identity across the workforce domain. Supports USALI labor cost reporting by department.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the authorized position within the hotel organizational structure. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational unit or department to which this position belongs within the property structure.',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where this position is authorized.',
    `reports_to_position_id` BIGINT COMMENT 'Reference to the supervisory position to which this position reports in the organizational hierarchy. Enables organizational chart construction.',
    `ada_accommodation_required` BOOLEAN COMMENT 'Indicates whether this position has been identified as requiring reasonable accommodation under ADA compliance guidelines.',
    `budgeted_annual_salary` DECIMAL(18,2) COMMENT 'Planned annual base salary for this position as defined in the labor budget. Used for CPOR (Cost Per Occupied Room) labor cost calculations.',
    `position_code` STRING COMMENT 'Unique alphanumeric code identifying the position within the enterprise position catalog. Used for workforce planning and budgeting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this position record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budgeted salary amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `position_description` STRING COMMENT 'Detailed narrative description of the positions responsibilities, duties, and scope. Used for job postings and talent acquisition.',
    `effective_end_date` DATE COMMENT 'Date when this position was eliminated or frozen. Null for currently active positions. Used for historical workforce planning analysis.',
    `effective_start_date` DATE COMMENT 'Date when this position became active and available for assignment in the organizational structure.',
    `fte_allocation` DECIMAL(18,2) COMMENT 'Full-time equivalent allocation for this position expressed as a decimal (1.00 = full-time, 0.50 = half-time). Used for headcount planning and labor cost budgeting.',
    `is_budgeted` BOOLEAN COMMENT 'Indicates whether this position is included in the approved annual labor budget and headcount plan.',
    `is_exempt` BOOLEAN COMMENT 'Indicates whether this position is exempt from overtime pay requirements under the Fair Labor Standards Act (FLSA). Used for payroll and labor cost compliance.',
    `is_supervisory` BOOLEAN COMMENT 'Indicates whether this position has direct supervisory or management responsibilities over other employees.',
    `is_union` BOOLEAN COMMENT 'Indicates whether this position is covered by a collective bargaining agreement or union contract.',
    `job_code` STRING COMMENT 'Standardized job classification code linking this position to a job profile with defined competencies, responsibilities, and compensation bands.. Valid values are `^[A-Z0-9]{3,10}$`',
    `last_updated_by` STRING COMMENT 'Username or identifier of the system user who most recently modified this position record.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this position record was most recently modified.',
    `minimum_education_level` STRING COMMENT 'Minimum educational qualification required for this position as defined in the job profile.. Valid values are `high_school|associate|bachelor|master|doctorate|none`',
    `minimum_years_experience` STRING COMMENT 'Minimum number of years of relevant work experience required for this position.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to this position, defining the salary range and benefits eligibility.. Valid values are `^[A-Z0-9]{2,6}$`',
    `physical_requirements` STRING COMMENT 'Description of physical demands and working conditions for this position (e.g., standing for extended periods, lifting up to 50 lbs, exposure to kitchen heat). Used for ADA compliance and OSHA safety planning.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position. Active = authorized and available for assignment; Frozen = temporarily unavailable; Eliminated = removed from headcount plan; Proposed = pending approval.. Valid values are `active|frozen|eliminated|proposed`',
    `position_type` STRING COMMENT 'Classification of the position based on employment duration and nature. Regular = permanent; Seasonal = recurring high-demand periods; Temporary = fixed-term; Contract = third-party; On-Call = as-needed.. Valid values are `regular|seasonal|temporary|contract|on_call`',
    `required_certifications` STRING COMMENT 'Comma-separated list of mandatory certifications, licenses, or credentials required for this position (e.g., ServSafe Food Handler, CPR/First Aid, Certified Revenue Management Executive). Used for compliance tracking per OSHA and ADA requirements.',
    `shift_eligibility` STRING COMMENT 'Shift pattern or time-of-day eligibility for this position. Used for scheduling and labor management in 24/7 hotel operations.. Valid values are `day|evening|night|rotating|any`',
    `title` STRING COMMENT 'Official job title for the position as defined in the organizational structure (e.g., Front Desk Agent, Executive Chef, Revenue Manager).',
    `union_code` STRING COMMENT 'Code identifying the labor union or collective bargaining unit covering this position, if applicable.. Valid values are `^[A-Z0-9]{2,10}$`',
    `usali_department_code` STRING COMMENT 'Four-digit USALI department classification code for labor cost reporting and financial statement preparation per USALI standards (e.g., 3110 Rooms - Front Office, 4110 Food - Restaurants).. Valid values are `^[0-9]{4}$`',
    `work_location_type` STRING COMMENT 'Primary work location arrangement for this position. On-Property = hotel premises; Remote = off-site; Hybrid = combination; Field = traveling/multi-site.. Valid values are `on_property|remote|hybrid|field`',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this position record.',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Authorized positions (headcount plan) within the hotel organizational structure. Defines job titles, job codes, USALI department classifications, pay grade, FTE allocation, required certifications, shift eligibility, and whether the position is budgeted. Links to the organizational unit and property. Supports workforce planning and labor cost budgeting per USALI standards. Sourced from Oracle HCM Cloud Position Management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Reference to the finance cost center for labor and expense allocation. Enables CPOR (Cost Per Occupied Room) labor component reporting.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy. Enables multi-level organizational structure modeling (e.g., department within division).',
    `property_id` BIGINT COMMENT 'Reference to the property to which this organizational unit belongs. Links department to specific hotel or resort location.',
    `actual_headcount` STRING COMMENT 'Current number of active employees assigned to this organizational unit. Used to track variance against budgeted headcount.',
    `budgeted_headcount` STRING COMMENT 'Planned number of full-time equivalent (FTE) employees allocated to this organizational unit. Used for workforce planning and labor cost budgeting.',
    `certification_type` STRING COMMENT 'Type of certification or license required for employees in this organizational unit (e.g., ServSafe, HVAC License, Lifeguard, ADA Compliance Training). Supports compliance with OSHA and industry regulations.',
    `org_unit_code` STRING COMMENT 'Short alphanumeric code identifying the organizational unit. Used in payroll, scheduling, and financial reporting systems. Typically 2-10 characters.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system. Used for audit trail and data lineage.',
    `org_unit_description` STRING COMMENT 'Detailed description of the organizational units purpose, responsibilities, and scope of operations.',
    `effective_end_date` DATE COMMENT 'Date when this organizational unit was closed or became inactive. Null for currently active units. Used for historical tracking and organizational change management.',
    `effective_start_date` DATE COMMENT 'Date when this organizational unit became active and operational. Used for historical tracking and organizational change management.',
    `email_address` STRING COMMENT 'Primary email address for this organizational unit. Used for internal communication and departmental correspondence. Organizational contact data classified as confidential.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `hierarchy_level` STRING COMMENT 'Numeric level in the organizational hierarchy. Level 1 is top-level (e.g., corporate), increasing numbers represent deeper nesting (e.g., 2=division, 3=department, 4=team).',
    `hierarchy_path` STRING COMMENT 'Full hierarchical path from root to this unit, typically represented as slash-separated IDs or codes (e.g., /CORP/ROOMS/FRONTDESK). Enables efficient hierarchy queries.',
    `is_guest_facing` BOOLEAN COMMENT 'Indicates whether this organizational unit has direct guest interaction (e.g., Front Desk, Concierge, F&B service) or is back-of-house (e.g., Housekeeping, Engineering). Used for service quality and NPS tracking.',
    `is_revenue_generating` BOOLEAN COMMENT 'Indicates whether this organizational unit directly generates revenue (e.g., Rooms, F&B, Spa) or is a support/overhead department (e.g., Engineering, Admin). Used for GOP and GOPPAR calculations.',
    `is_unionized` BOOLEAN COMMENT 'Indicates whether employees in this organizational unit are represented by a labor union. Affects scheduling rules, overtime policies, and labor cost management.',
    `labor_cost_percentage_target` DECIMAL(18,2) COMMENT 'Target labor cost as percentage of revenue for this organizational unit. Key metric for GOP (Gross Operating Profit) management and USALI labor cost reporting.',
    `labor_productivity_standard` DECIMAL(18,2) COMMENT 'Standard productivity measure for this organizational unit, expressed as units per labor hour (e.g., rooms cleaned per hour, covers served per hour, check-ins per hour). Used for optimal staffing calculations.',
    `location_code` STRING COMMENT 'Physical location code or building identifier where this organizational unit operates (e.g., Main Building, Tower A, Spa Building). Used for facility management and space allocation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last modified. Used for audit trail and change tracking.',
    `org_unit_name` STRING COMMENT 'Full business name of the organizational unit (e.g., Front Desk Operations, Housekeeping, Food and Beverage, Engineering, Sales and Marketing).',
    `org_unit_status` STRING COMMENT 'Current operational status of the organizational unit. Indicates whether the unit is actively staffed and operational.. Valid values are `active|inactive|suspended|planned|closed`',
    `org_unit_type` STRING COMMENT 'Classification of the organizational unit level in the hierarchy. Defines whether this is a division, department, team, cost center, or work group.. Valid values are `division|department|team|cost_center|work_group`',
    `phone_number` STRING COMMENT 'Primary contact phone number for this organizational unit. Used for internal communication and guest inquiries. Organizational contact data classified as confidential.. Valid values are `^+?[1-9]d{1,14}$`',
    `productivity_target_percentage` DECIMAL(18,2) COMMENT 'Target productivity achievement percentage for this organizational unit. Typically 85-100%, representing expected efficiency relative to standard time.',
    `productivity_unit_of_measure` STRING COMMENT 'Unit of measure for labor productivity standard. Defines how productivity is measured for this organizational unit (e.g., rooms per hour for housekeeping, covers per hour for F&B).. Valid values are `rooms_per_hour|covers_per_hour|check_ins_per_hour|setups_per_hour|minutes_per_unit|units_per_shift`',
    `requires_certification` BOOLEAN COMMENT 'Indicates whether employees in this organizational unit require specific certifications or licenses (e.g., food safety for F&B, engineering licenses, lifeguard certification). Used for compliance tracking.',
    `shift_pattern` STRING COMMENT 'Standard shift pattern for this organizational unit. Defines typical scheduling model (e.g., 24x7 for front desk, AM/PM for housekeeping, business hours for sales).. Valid values are `24x7|am_pm_night|am_pm|business_hours|on_call|variable`',
    `standard_time_per_unit` DECIMAL(18,2) COMMENT 'Standard time in minutes required to complete one unit of work (e.g., 30 minutes to clean one room, 15 minutes per banquet setup). Used for scheduling and labor planning.',
    `union_affiliation` STRING COMMENT 'Name of labor union representing employees in this organizational unit, if applicable. Used for labor relations, collective bargaining, and compliance with union agreements.',
    `usali_classification` STRING COMMENT 'USALI department classification for financial reporting. Aligns organizational unit to standard hospitality accounting categories (Rooms, F&B, Spa, Engineering, Sales, Admin). [ENUM-REF-CANDIDATE: rooms|food_and_beverage|spa|golf|recreation|engineering|sales_marketing|admin_general|property_operations|other — 10 candidates stripped; promote to reference product]',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational hierarchy and department structure for hotel and resort operations. Defines divisions, departments, and cost centers aligned to USALI classifications (Rooms, F&B, Spa, Engineering, Sales, Admin) with department codes, cost center references, property assignments, parent-child hierarchy, and department managers. Includes labor productivity standards by department and task type (room cleaning, turndown, check-in, F&B cover, banquet setup) with standard time per unit, units per labor hour, and productivity targets. Enables labor cost allocation, CPOR labor component reporting, optimal staffing calculations relative to occupancy, and workforce planning against budgeted headcount.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` (
    `shift_template_id` BIGINT COMMENT 'Unique identifier for the shift template. Primary key for reusable shift pattern definitions used across hotel departments.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center where labor hours for this shift template are charged. Used for USALI departmental labor cost reporting and CPOR (Cost Per Occupied Room) calculations.',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Shift templates are defined for organizational units (departments). The shift_template table has an unlinked department_id (BIGINT) which should reference org_unit for consistency. This links shift de',
    `employee_id` BIGINT COMMENT 'Reference to the user (typically HR manager or department head) who created this shift template. Used for accountability and audit purposes.',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where this shift template is defined. Allows property-specific shift patterns within a multi-property portfolio.',
    `break_duration_minutes` STRING COMMENT 'Total break time allocated within the shift in minutes (e.g., 30, 60). Includes meal breaks and rest periods as required by labor regulations.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether employees must hold specific certifications to work this shift (e.g., food handler certification for F&B shifts, CPR certification for pool attendants) (True/False).',
    `consecutive_days_limit` STRING COMMENT 'Maximum number of consecutive days an employee can be scheduled for this shift template before a mandatory rest day, per labor regulations and fatigue management policies.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this shift template record was first created in the system. Used for audit trail and template lifecycle tracking.',
    `effective_end_date` DATE COMMENT 'Date when this shift template is retired or superseded. Null indicates the template is currently active with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this shift template becomes active and available for scheduling. Supports versioning of shift patterns over time.',
    `holiday_shift_flag` BOOLEAN COMMENT 'Indicates whether this shift template is designated for holiday scheduling, which typically carries premium pay rates (True/False).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this shift template record was last updated. Used for audit trail and change tracking.',
    `maximum_staffing_level` STRING COMMENT 'Maximum number of employees that can be scheduled for this shift pattern based on operational capacity and labor budget constraints.',
    `meal_allowance_eligible_flag` BOOLEAN COMMENT 'Indicates whether employees working this shift are eligible for complimentary or subsidized meals as part of compensation (True/False).',
    `minimum_staffing_level` STRING COMMENT 'Minimum number of employees required to work this shift pattern to meet operational standards and guest service levels (e.g., 2 front desk agents, 5 housekeepers).',
    `notes` STRING COMMENT 'Free-text field for additional scheduling instructions, special requirements, or operational notes related to this shift template (e.g., Requires bilingual staff, Peak check-in period).',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether hours worked on this shift template are eligible for overtime compensation under labor regulations and hotel policy (True/False).',
    `paid_break_minutes` STRING COMMENT 'Portion of break time that is compensated (e.g., 15-minute paid rest breaks). Used to calculate net paid hours.',
    `paid_hours` DECIMAL(18,2) COMMENT 'Net paid hours for the shift, excluding unpaid breaks (e.g., 7.50 for an 8-hour shift with 30-minute unpaid lunch). Used for payroll and labor cost calculations.',
    `rest_hours_required` STRING COMMENT 'Minimum number of hours required between the end of this shift and the start of the next shift for the same employee, per labor regulations.',
    `rotation_pattern` STRING COMMENT 'Describes how this shift template fits into a rotation schedule (e.g., 5-on-2-off, 4-on-3-off, rotating weekends). Used for fair scheduling and work-life balance.',
    `seasonal_applicability` STRING COMMENT 'Defines when this shift template is active based on hotel seasonality patterns. Year-round templates apply continuously; seasonal templates apply during high/low demand periods.. Valid values are `year_round|peak_season|off_season|summer|winter`',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional hourly pay rate or percentage premium applied to this shift (e.g., night shift differential, weekend premium). Used for labor cost calculations.',
    `shift_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the shift in hours, including break time (e.g., 8.00, 8.50, 12.00). Used for labor cost calculations and CPOR (Cost Per Occupied Room) reporting.',
    `shift_end_time` TIMESTAMP COMMENT 'Standard end time for the shift in 24-hour HH:mm format (e.g., 15:00, 23:00, 07:00). Represents the clock-out time. May cross midnight for night shifts.',
    `shift_start_time` TIMESTAMP COMMENT 'Standard start time for the shift in 24-hour HH:mm format (e.g., 07:00, 15:00, 23:00). Represents the clock-in time.',
    `shift_template_status` STRING COMMENT 'Current lifecycle status of the shift template. Active templates are available for scheduling; Draft templates are under review; Inactive/Archived templates are no longer used.. Valid values are `active|inactive|draft|archived`',
    `shift_type` STRING COMMENT 'Classification of the shift pattern by time of day or work arrangement. Morning (AM), Afternoon (PM), Evening, Night (overnight), Split (discontinuous hours), On-Call (standby).. Valid values are `morning|afternoon|evening|night|split|on_call`',
    `skill_requirement_level` STRING COMMENT 'Minimum skill or experience level required for employees assigned to this shift template (e.g., entry-level housekeepers vs. expert front desk supervisors).. Valid values are `entry|intermediate|advanced|expert`',
    `template_code` STRING COMMENT 'Short alphanumeric code for the shift template used in scheduling systems and reports (e.g., FD-AM, HK-PM, FB-SPLIT).. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `template_name` STRING COMMENT 'Business-friendly name for the shift template (e.g., Front Desk Morning, Housekeeping Evening, F&B Split Shift).',
    `transportation_allowance_eligible_flag` BOOLEAN COMMENT 'Indicates whether employees working this shift (especially late-night or early-morning shifts) are eligible for transportation reimbursement or shuttle service (True/False).',
    `uniform_code` STRING COMMENT 'Code identifying the required uniform or dress code for this shift template (e.g., FD-FORMAL, HK-STANDARD, FB-BANQUET). Links to uniform inventory and standards.',
    `weekend_shift_flag` BOOLEAN COMMENT 'Indicates whether this shift template is designated for weekend scheduling, which may carry premium pay or differential rates (True/False).',
    CONSTRAINT pk_shift_template PRIMARY KEY(`shift_template_id`)
) COMMENT 'Reusable shift pattern definitions used as building blocks for employee scheduling across hotel departments. Captures shift name, start/end times, duration, break rules, shift type (morning, afternoon, night, split, on-call), applicable department, minimum staffing level, overtime eligibility, and seasonal applicability. Referenced by the schedule product when constructing weekly rosters.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique identifier for the published work schedule. Primary key.',
    `org_unit_id` BIGINT COMMENT 'Reference to the operational department (housekeeping, front desk, food and beverage, etc.) covered by this schedule.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Schedules are built for authorized positions (headcount plan). This links workforce planning (position defines budgeted FTE and salary) to operational scheduling (schedule defines actual shifts). Enab',
    `employee_id` BIGINT COMMENT 'Reference to the senior manager or director who approved this schedule for finalization and payroll processing.',
    `property_id` BIGINT COMMENT 'Reference to the hotel or resort property for which this schedule is published.',
    `shift_template_id` BIGINT COMMENT 'Reference to the reusable shift template used as the basis for this schedule. Shift templates define standard shift patterns (e.g., morning, evening, overnight) with default start/end times and break rules.',
    `tertiary_schedule_published_by_user_employee_id` BIGINT COMMENT 'Reference to the manager who published this schedule, making it visible to employees.',
    `actual_labor_cost` DECIMAL(18,2) COMMENT 'Actual total labor cost incurred during this schedule period, including wages, overtime premiums, and shift differentials. Sourced from payroll system for variance analysis.',
    `compliance_notes` STRING COMMENT 'Notes related to OSHA hours-of-service compliance, ADA accommodation requests, or other regulatory considerations for this schedule.',
    `cpor_labor` DECIMAL(18,2) COMMENT 'Estimated labor cost per occupied room for this schedule period, calculated as estimated_labor_cost divided by forecasted occupied rooms. Used for labor efficiency benchmarking.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this schedule (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `estimated_labor_cost` DECIMAL(18,2) COMMENT 'Forecasted total labor cost for this schedule period, calculated from scheduled hours and average wage rates. Used for budgeting and GOPPAR (Gross Operating Profit Per Available Room) planning.',
    `finalized_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule was locked for payroll processing. After finalization, no further changes are permitted without creating a schedule adjustment record.',
    `forecast_adr` DECIMAL(18,2) COMMENT 'Forecasted Average Daily Rate for this schedule period, used to estimate revenue and align labor investment with revenue expectations.',
    `forecast_occupancy_rate` DECIMAL(18,2) COMMENT 'Forecasted hotel occupancy rate (percentage) for this schedule period, used to align labor scheduling with anticipated guest volume. Sourced from Revenue Management System (RMS).',
    `forecast_revpar` DECIMAL(18,2) COMMENT 'Forecasted Revenue Per Available Room for this schedule period, calculated as forecast_occupancy_rate multiplied by forecast_adr. Used for labor cost as percentage of revenue planning.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this schedule is currently active. True for current and future schedules; false for archived or superseded schedules.',
    `is_overtime_approved` BOOLEAN COMMENT 'Indicates whether overtime hours are pre-approved for this schedule period. True if overtime is authorized; false if all hours must remain within standard limits.',
    `labor_cost_percentage` DECIMAL(18,2) COMMENT 'Estimated labor cost as a percentage of forecasted revenue for this schedule period. Key metric for USALI labor cost reporting and GOP analysis.',
    `labor_variance_hours` DECIMAL(18,2) COMMENT 'Difference between total_actual_hours and total_scheduled_hours. Positive values indicate overtime or unplanned coverage; negative values indicate understaffing or no-shows.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to this schedule record.',
    `schedule_name` STRING COMMENT 'Descriptive name for the schedule (e.g., Front Desk Week 15 2024, Housekeeping Spring Break Schedule).',
    `notes` STRING COMMENT 'Free-text notes or instructions from the manager regarding this schedule (e.g., High occupancy expected due to conference, Reduced staffing for low season).',
    `period_end_date` DATE COMMENT 'Last calendar date covered by this schedule period.',
    `period_start_date` DATE COMMENT 'First calendar date covered by this schedule period.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule was published and made visible to employees.',
    `schedule_number` STRING COMMENT 'Human-readable business identifier for the schedule, typically formatted as property-department-period (e.g., HTL001-HSKP-2024W15).',
    `schedule_status` STRING COMMENT 'Current lifecycle state of the schedule. Draft: under construction by manager. Published: visible to employees. Finalized: locked for payroll processing. Archived: historical record.. Valid values are `draft|published|finalized|archived`',
    `schedule_type` STRING COMMENT 'Classification of the schedule based on operational context: regular (standard weekly/biweekly), seasonal (high/low season adjustments), event (MICE or special events), emergency (unplanned coverage), training (learning and development sessions).. Valid values are `regular|seasonal|event|emergency|training`',
    `total_actual_hours` DECIMAL(18,2) COMMENT 'Sum of actual hours worked by all employees during this schedule period, captured from time and attendance systems. Used for labor variance reporting (actual vs. scheduled).',
    `total_scheduled_fte` DECIMAL(18,2) COMMENT 'Full-time equivalent headcount for this schedule period, calculated as total_scheduled_hours divided by standard full-time hours (typically 40 hours per week). Used for labor productivity analysis and GOP (Gross Operating Profit) reporting.',
    `total_scheduled_hours` DECIMAL(18,2) COMMENT 'Sum of all scheduled shift hours across all employees in this schedule. Used for labor cost forecasting and CPOR (Cost Per Occupied Room) labor planning.',
    `version_number` STRING COMMENT 'Version number of this schedule. Incremented each time the schedule is revised before finalization. Supports schedule change tracking and audit trail.',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Published work schedules and individual shift assignments for hotel employees. Covers schedule period, property, department, total scheduled hours/FTE, schedule status (draft, published, finalized), and individual shift assignments linking employees to specific shifts with assigned date, start/end time, role, and status (scheduled, confirmed, swapped, called-out, no-show). Tracks actual vs. scheduled hours for labor variance reporting. Supports labor cost forecasting, CPOR labor planning, and OSHA hours-of-service compliance monitoring. References shift_template for reusable shift definitions.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique identifier for the time entry record. Primary key for the time entry entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual time entries drive real-time labor cost allocation to departments for daily flash reports, labor cost control dashboards, and manager variance reporting - core operational requirement for h',
    `org_unit_id` BIGINT COMMENT 'Foreign key linking to workforce.org_unit. Business justification: Time entries are recorded against organizational units for labor cost allocation and USALI reporting. The time_entry table has an unlinked department_id (BIGINT) which should reference org_unit. This ',
    `payroll_period_id` BIGINT COMMENT 'Identifier of the payroll period to which this time entry is assigned. Used to group time entries for payroll processing in SAP S/4HANA HCM.',
    `payroll_run_id` BIGINT COMMENT 'Identifier of the payroll run in which this time entry was processed. Nullable if not yet processed.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded this time entry. Links to the employee master record in Oracle HCM Cloud or SAP S/4HANA HCM.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the employee worked during this time entry. Used for labor cost allocation by property.',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to workforce.schedule. Business justification: Time entries represent actual hours worked against published schedules. This FK links actual time to planned schedules, enabling critical labor variance analysis (schedule.labor_variance_hours = sched',
    `shift_template_id` BIGINT COMMENT 'Foreign key linking to workforce.shift_template. Business justification: Time entries are worked on specific shift templates (AM, PM, overnight, etc.). This FK links actual time to shift definitions, enabling shift differential calculation (shift_template.shift_differentia',
    `tertiary_time_edited_by_employee_id` BIGINT COMMENT 'Identifier of the user who edited or adjusted the time entry. Nullable if never edited.',
    `procurement_work_order_id` BIGINT COMMENT 'Identifier of a specific work order or task assignment associated with this time entry. Used for project-based labor tracking and maintenance labor allocation.',
    `approval_status` STRING COMMENT 'Current approval status of the time entry in the workflow. Time entries must be approved before being sent to payroll processing.. Valid values are `pending|approved|rejected|submitted|auto_approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry was approved. Nullable if not yet approved.',
    `break_duration_minutes` STRING COMMENT 'Total duration of unpaid breaks taken during the shift, measured in minutes. Deducted from total hours worked for payroll calculation.',
    `clock_in_timestamp` TIMESTAMP COMMENT 'The precise date and time when the employee clocked in or started their shift. Captured from time clock, mobile app, or manager entry.',
    `clock_out_timestamp` TIMESTAMP COMMENT 'The precise date and time when the employee clocked out or ended their shift. Nullable for open shifts not yet completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry record was first created in the system. Used for audit trail and data lineage.',
    `device_identifier` STRING COMMENT 'Unique identifier of the device or time clock used to record the time entry. Used for audit trail and fraud prevention.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of hours worked that qualify for double-time pay, typically for work on holidays or beyond a certain daily threshold in some jurisdictions.',
    `edited_flag` BOOLEAN COMMENT 'Indicates whether the time entry was manually edited or adjusted after initial capture. True if edited, False if original entry.',
    `edited_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry was last edited. Nullable if never edited.',
    `entry_date` DATE COMMENT 'The calendar date on which the work was performed. Used for daily labor reporting and payroll period assignment.',
    `entry_source` STRING COMMENT 'The system or method through which the time entry was captured. Supports audit trail and data quality analysis. [ENUM-REF-CANDIDATE: time_clock|mobile_app|web_portal|manager_entry|biometric_scanner|telephony|kiosk — 7 candidates stripped; promote to reference product]',
    `entry_type` STRING COMMENT 'Classification of the time entry by work type or absence type. Used for labor cost categorization and compliance reporting. [ENUM-REF-CANDIDATE: regular_shift|overtime|holiday|sick_leave|vacation|training|meeting|on_call — 8 candidates stripped; promote to reference product]',
    `exception_code` STRING COMMENT 'Code indicating any time entry exception or anomaly (e.g., missed punch, late clock-in, early departure, unauthorized overtime). Used for compliance monitoring and manager review.',
    `exception_notes` STRING COMMENT 'Free-text notes explaining any exception or adjustment to the time entry. Entered by manager or HR for audit trail.',
    `geolocation_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate where the clock-in or clock-out occurred, captured from mobile app entries. Used for location verification and compliance with remote work policies.',
    `geolocation_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate where the clock-in or clock-out occurred, captured from mobile app entries. Used for location verification and compliance with remote work policies.',
    `job_code` BIGINT COMMENT 'Identifier of the job code or position classification for this time entry. Supports labor cost analysis by role (front desk agent, housekeeper, chef, etc.).',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost for this time entry, calculated as hours worked multiplied by applicable pay rates including overtime premiums. Used for USALI labor cost reporting and CPOR calculation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry record was last modified. Used for audit trail and change tracking.',
    `location_code` STRING COMMENT 'Code identifying the specific work location or outlet within the property where the employee worked (e.g., front desk, restaurant, spa, housekeeping floor). Used for detailed labor allocation.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours worked beyond the regular hours threshold that qualify for overtime pay under FLSA or local labor law. Typically paid at 1.5x or 2x regular rate.',
    `paid_break_duration_minutes` STRING COMMENT 'Total duration of paid breaks or rest periods during the shift, measured in minutes. Included in total hours worked for payroll calculation.',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicates whether this time entry has been processed in a payroll run. True if processed, False if pending.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of hours worked at the regular pay rate, typically up to 40 hours per week or 8 hours per day depending on jurisdiction. Used for payroll calculation.',
    `shift_differential_code` STRING COMMENT 'Code indicating any shift differential pay applicable to this time entry (e.g., night shift, weekend shift). Used for premium pay calculation.',
    `tips_reported_amount` DECIMAL(18,2) COMMENT 'Total amount of tips reported by the employee for this time entry. Relevant for F&B and guest-facing roles. Used for payroll tax calculation and FLSA tip credit compliance.',
    `total_hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours worked during this time entry, calculated as the difference between clock-out and clock-in minus break duration. Used for payroll processing and labor hour reporting per USALI standards.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Raw time and attendance records capturing actual clock-in and clock-out events for hotel employees. Includes entry date, clock-in timestamp, clock-out timestamp, total hours worked, overtime hours, break duration, entry source (time clock, mobile, manager entry), approval status, and payroll period reference. Feeds payroll processing in SAP S/4HANA HCM. Supports FLSA overtime compliance and USALI labor hour reporting.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` (
    `payroll_run_id` BIGINT COMMENT 'Unique identifier for the payroll processing cycle. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Payroll runs must allocate labor costs to cost centers for USALI departmental P&L reporting, labor cost variance analysis, and monthly financial close - fundamental to hotel financial operations and r',
    `employee_id` BIGINT COMMENT 'Reference to the user who approved this payroll run for processing and payment.',
    `ownership_entity_id` BIGINT COMMENT 'Reference to the legal entity responsible for payroll obligations and tax reporting.',
    `property_id` BIGINT COMMENT 'Reference to the hotel property or resort for which this payroll run is executed.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run was approved for processing.',
    `calculated_timestamp` TIMESTAMP COMMENT 'Date and time when payroll calculations were completed for this run.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary amounts in this payroll run.. Valid values are `^[A-Z]{3}$`',
    `employee_count` STRING COMMENT 'Total number of employees included in this payroll run.',
    `gl_posting_date` DATE COMMENT 'Date on which payroll expenses and liabilities were posted to the general ledger.',
    `gl_posting_status` STRING COMMENT 'Indicates whether payroll entries have been posted to the general ledger.. Valid values are `not_posted|posted|reversed`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this payroll run record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about this payroll run, including special circumstances, corrections, or processing exceptions.',
    `oracle_payroll_run_code` STRING COMMENT 'External reference identifier from Oracle HCM Cloud payroll system for reconciliation and audit trail.',
    `paid_timestamp` TIMESTAMP COMMENT 'Date and time when employee payments were disbursed for this payroll run.',
    `pay_date` DATE COMMENT 'Date on which employees receive payment for this payroll run.',
    `pay_frequency` STRING COMMENT 'Frequency at which employees are paid in this payroll run.. Valid values are `weekly|bi-weekly|semi-monthly|monthly`',
    `payroll_period_end_date` DATE COMMENT 'Last day of the payroll period covered by this run.',
    `payroll_period_start_date` DATE COMMENT 'First day of the payroll period covered by this run.',
    `payroll_run_number` STRING COMMENT 'Business identifier for the payroll run, typically formatted as YYYY-MM-PP where PP is the pay period sequence.',
    `payroll_run_status` STRING COMMENT 'Current lifecycle status of the payroll run indicating its processing stage. [ENUM-REF-CANDIDATE: draft|in_progress|calculated|approved|posted|paid|cancelled — 7 candidates stripped; promote to reference product]',
    `payroll_run_type` STRING COMMENT 'Classification of the payroll run indicating whether it is a regular scheduled run, off-cycle payment, bonus distribution, correction, or final payment.. Valid values are `regular|off-cycle|bonus|correction|final`',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when payroll entries were posted to the general ledger.',
    `sap_payroll_run_code` STRING COMMENT 'External reference identifier from SAP S/4HANA HCM payroll system for reconciliation and audit trail.',
    `total_bonus_pay` DECIMAL(18,2) COMMENT 'Sum of discretionary and non-discretionary bonuses paid to employees in this payroll run.',
    `total_commission_pay` DECIMAL(18,2) COMMENT 'Sum of commission earnings for sales and revenue-generating roles (e.g., event sales, group sales) in this payroll run.',
    `total_employer_taxes` DECIMAL(18,2) COMMENT 'Sum of employer-paid payroll taxes (employer FICA, FUTA, SUTA) for this payroll run.',
    `total_federal_tax` DECIMAL(18,2) COMMENT 'Sum of federal income tax withheld from all employees in this payroll run.',
    `total_gross_pay` DECIMAL(18,2) COMMENT 'Sum of all gross earnings for all employees in this payroll run before any deductions.',
    `total_local_tax` DECIMAL(18,2) COMMENT 'Sum of local or municipal income tax withheld from all employees in this payroll run.',
    `total_medicare_tax` DECIMAL(18,2) COMMENT 'Sum of Medicare tax withheld from all employees in this payroll run, including additional Medicare tax for high earners.',
    `total_net_pay` DECIMAL(18,2) COMMENT 'Sum of net pay (take-home pay) for all employees in this payroll run after all taxes and deductions.',
    `total_overtime_pay` DECIMAL(18,2) COMMENT 'Sum of overtime earnings for all employees in this payroll run, typically at 1.5x or 2x regular rate.',
    `total_post_tax_deductions` DECIMAL(18,2) COMMENT 'Sum of all post-tax deductions (garnishments, union dues, Roth 401k) for all employees in this payroll run.',
    `total_pre_tax_deductions` DECIMAL(18,2) COMMENT 'Sum of all pre-tax deductions (401k, health insurance premiums, FSA contributions) for all employees in this payroll run.',
    `total_regular_pay` DECIMAL(18,2) COMMENT 'Sum of regular hourly or salaried earnings for all employees in this payroll run.',
    `total_service_charge` DECIMAL(18,2) COMMENT 'Sum of mandatory service charges distributed to employees in this payroll run, common in banquet and group events.',
    `total_social_security_tax` DECIMAL(18,2) COMMENT 'Sum of Social Security (OASDI) tax withheld from all employees in this payroll run.',
    `total_state_tax` DECIMAL(18,2) COMMENT 'Sum of state income tax withheld from all employees in this payroll run.',
    `total_tax_withholding` DECIMAL(18,2) COMMENT 'Sum of all federal, state, and local income tax withholdings for all employees in this payroll run.',
    `total_tip_allocation` DECIMAL(18,2) COMMENT 'Sum of tip income allocated to tipped employees (servers, bartenders, bellhops) in this payroll run.',
    CONSTRAINT pk_payroll_run PRIMARY KEY(`payroll_run_id`)
) COMMENT 'Payroll processing cycles and individual earnings/deduction line items for hotel employees. Captures payroll period, pay frequency, property/legal entity, run status, totals (gross, net, taxes, deductions), and SAP S/4HANA payroll reference. Includes line-item detail: pay component type (regular, overtime, tip allocation, service charge, bonus, commission, deduction, tax withholding), hours, rate, amount, USALI department allocation, and GL account code. Supports USALI labor cost reporting, CPOR labor component breakdown, SOX payroll controls, and SAP S/4HANA GL posting.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` (
    `payroll_period_id` BIGINT COMMENT 'Primary key for payroll_period',
    `ownership_entity_id` BIGINT COMMENT 'Reference to the legal entity or company for which this payroll period applies.',
    `prior_payroll_period_id` BIGINT COMMENT 'Self-referencing FK on payroll_period (prior_payroll_period_id)',
    `approval_required_flag` BOOLEAN COMMENT 'Indicates whether this payroll period requires managerial or executive approval before payment processing (true/false).',
    `approved_by_user_code` STRING COMMENT 'Identifier of the user who approved this payroll period for payment.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period was approved for payment.',
    `calendar_month` STRING COMMENT 'The calendar month number (1-12) in which this payroll period starts.',
    `calendar_year` STRING COMMENT 'The calendar year in which this payroll period starts (e.g., 2024).',
    `check_date` DATE COMMENT 'The date printed on payroll checks or used for electronic payment transactions for this period.',
    `closed_by_user_code` STRING COMMENT 'Identifier of the user or system account that closed this payroll period.',
    `closed_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period was officially closed and locked from further changes.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the jurisdiction in which this payroll period applies (e.g., USA, CAN, GBR).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for payments in this payroll period (e.g., USD, CAD, GBP, EUR).',
    `cutoff_date` DATE COMMENT 'The deadline date by which time and attendance data must be submitted for processing in this payroll period.',
    `end_date` DATE COMMENT 'The last calendar date included in this payroll period.',
    `fiscal_month` STRING COMMENT 'The fiscal month number within the fiscal year (1-12).',
    `fiscal_quarter` STRING COMMENT 'The fiscal quarter within the fiscal year (1, 2, 3, or 4).',
    `fiscal_year` STRING COMMENT 'The fiscal year to which this payroll period belongs (e.g., 2024).',
    `is_adjustment_period` BOOLEAN COMMENT 'Indicates whether this is a special adjustment or correction period (true) or a regular payroll period (false).',
    `is_year_end_period` BOOLEAN COMMENT 'Indicates whether this payroll period is the final period of the fiscal or calendar year (true/false).',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this payroll period record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or comments about this payroll period, such as special processing instructions, holidays, or adjustments.',
    `pay_date` DATE COMMENT 'The date on which employees are paid for this payroll period.',
    `payroll_group_code` STRING COMMENT 'Code identifying the payroll group or employee segment (e.g., hourly, salaried, executive, union) to which this period applies.',
    `payroll_period_status` STRING COMMENT 'Current lifecycle status of the payroll period (draft, open, processing, closed, locked, archived).',
    `period_code` STRING COMMENT 'Business identifier code for the payroll period, typically used in payroll systems and reporting (e.g., PP202401, 2024-W01).',
    `period_name` STRING COMMENT 'Human-readable name or label for the payroll period (e.g., January 2024 - Period 1, Week Ending 2024-01-07).',
    `period_number` STRING COMMENT 'Sequential number of this payroll period within the fiscal or calendar year (e.g., 1-52 for weekly, 1-26 for bi-weekly, 1-12 for monthly).',
    `period_type` STRING COMMENT 'Classification of the payroll period frequency (weekly, bi-weekly, semi-monthly, monthly, quarterly, annual).',
    `processing_end_timestamp` TIMESTAMP COMMENT 'The date and time when payroll processing was completed for this period.',
    `processing_start_timestamp` TIMESTAMP COMMENT 'The date and time when payroll processing began for this period.',
    `start_date` DATE COMMENT 'The first calendar date included in this payroll period.',
    `tax_year` STRING COMMENT 'The tax year to which this payroll period belongs for tax reporting purposes.',
    `total_days_count` STRING COMMENT 'Total number of calendar days in this payroll period.',
    `working_days_count` STRING COMMENT 'Number of standard working days (typically Monday-Friday) within this payroll period, excluding holidays.',
    CONSTRAINT pk_payroll_period PRIMARY KEY(`payroll_period_id`)
) COMMENT 'Master reference table for payroll_period. Referenced by payroll_period_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` (
    `benefit_enrollment_id` BIGINT COMMENT 'Primary key for procurement_enrollment',
    `procurement_benefit_plan_id` BIGINT COMMENT 'Foreign key linking to the benefit plan in which the employee is enrolling',
    `employee_id` BIGINT COMMENT 'Foreign key linking to the employee who is enrolling in the benefit plan',
    `beneficiary_name` STRING COMMENT 'Name of the primary beneficiary designated for this enrollment (applicable for life insurance and similar plans). Captured from detection phase relationship data.',
    `confirmation_number` STRING COMMENT 'Confirmation or transaction number issued when the enrollment was processed.',
    `coverage_tier` STRING COMMENT 'Level of coverage elected by the employee for this enrollment (employee only, employee + spouse, employee + children, family). Captured from detection phase relationship data.',
    `dependent_count` STRING COMMENT 'Number of dependents covered under this enrollment. Captured from detection phase relationship data.',
    `effective_end_date` DATE COMMENT 'Date when the benefit coverage ends for this enrollment. Null for active enrollments. Captured from detection phase relationship data.',
    `effective_start_date` DATE COMMENT 'Date when the benefit coverage begins for this enrollment. Captured from detection phase relationship data.',
    `employee_contribution_amount` DECIMAL(18,2) COMMENT 'Dollar amount the employee contributes per pay period for this specific enrollment. May differ from plan default based on coverage tier elected. Captured from detection phase relationship data.',
    `enrollment_code` BIGINT COMMENT 'Unique identifier for this enrollment record. Primary key for the enrollment association.',
    `enrollment_source` STRING COMMENT 'Classification of the event that triggered this enrollment (open enrollment, new hire, qualifying life event, annual renewal).',
    `life_event_date` DATE COMMENT 'Date of the qualifying life event. Null if not a life event enrollment.',
    `life_event_type` STRING COMMENT 'Type of qualifying life event that allowed mid-year enrollment change (marriage, birth, adoption, loss of other coverage). Null if not a life event enrollment.',
    `oracle_hcm_enrollment_code` STRING COMMENT 'External enrollment identifier from Oracle HCM Cloud Benefits module. Used for integration and reconciliation.',
    `procurement_enrollment_date` DATE COMMENT 'Date when the employee elected or enrolled in this benefit plan. Captured from detection phase relationship data.',
    `procurement_enrollment_status` STRING COMMENT 'Current lifecycle status of this enrollment record (pending, active, terminated, waived). Captured from detection phase relationship data.',
    `waived_flag` BOOLEAN COMMENT 'Boolean indicator of whether the employee explicitly waived this benefit plan. Captured from detection phase relationship data.',
    `waiver_reason` STRING COMMENT 'Reason code or description for why the employee waived this benefit plan (e.g., covered under spouse plan, cost, not needed). Captured from detection phase relationship data.',
    CONSTRAINT pk_benefit_enrollment PRIMARY KEY(`benefit_enrollment_id`)
) COMMENT 'This association product represents the enrollment event between employee and benefit_plan. It captures the employees election of a specific benefit plan, including coverage details, contribution amounts, dependent information, and enrollment lifecycle status. Each record links one employee to one benefit_plan with attributes that exist only in the context of this enrollment relationship. Supports ACA compliance reporting, open enrollment processing, life event changes, and total compensation analysis per USALI standards.. Existence Justification: Benefit enrollment is a core HR operational process where employees actively elect multiple benefit plans (health, dental, vision, 401k, life insurance) and each plan is elected by multiple employees. HR benefits teams manage enrollment campaigns, process elections, track coverage periods, calculate contributions, and produce regulatory reports (ACA 1095-C). The enrollment relationship has its own lifecycle (pending → active → terminated), business rules (eligibility, waiting periods, enrollment windows), and dedicated systems (Oracle HCM Cloud Benefits).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_training_completion` (
    `workforce_training_completion_id` BIGINT COMMENT '',
    CONSTRAINT pk_workforce_training_completion PRIMARY KEY(`workforce_training_completion_id`)
) COMMENT '';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ADD CONSTRAINT `fk_workforce_learning_course_prerequisite_course_learning_course_id` FOREIGN KEY (`prerequisite_course_learning_course_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`learning_course`(`learning_course_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ADD CONSTRAINT `fk_workforce_compensation_plan_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_disciplinary_last_modified_by_user_employee_id` FOREIGN KEY (`disciplinary_last_modified_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_primary_disciplinary_employee_id` FOREIGN KEY (`primary_disciplinary_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_tertiary_disciplinary_hr_business_partner_employee_id` FOREIGN KEY (`tertiary_disciplinary_hr_business_partner_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ADD CONSTRAINT `fk_workforce_disciplinary_action_workforce_safety_incident_id` FOREIGN KEY (`workforce_safety_incident_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident`(`workforce_safety_incident_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ADD CONSTRAINT `fk_workforce_job_requisition_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ADD CONSTRAINT `fk_workforce_job_requisition_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ADD CONSTRAINT `fk_workforce_job_requisition_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ADD CONSTRAINT `fk_workforce_job_requisition_tertiary_job_approved_by_employee_id` FOREIGN KEY (`tertiary_job_approved_by_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_primary_leave_employee_id` FOREIGN KEY (`primary_leave_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`schedule`(`schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ADD CONSTRAINT `fk_workforce_workforce_safety_incident_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ADD CONSTRAINT `fk_workforce_workforce_safety_incident_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ADD CONSTRAINT `fk_workforce_workforce_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_reports_to_position_id` FOREIGN KEY (`reports_to_position_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ADD CONSTRAINT `fk_workforce_shift_template_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ADD CONSTRAINT `fk_workforce_shift_template_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_position_id` FOREIGN KEY (`position_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_shift_template_id` FOREIGN KEY (`shift_template_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`shift_template`(`shift_template_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_tertiary_schedule_published_by_user_employee_id` FOREIGN KEY (`tertiary_schedule_published_by_user_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_payroll_run_id` FOREIGN KEY (`payroll_run_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`payroll_run`(`payroll_run_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`schedule`(`schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_shift_template_id` FOREIGN KEY (`shift_template_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`shift_template`(`shift_template_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_tertiary_time_edited_by_employee_id` FOREIGN KEY (`tertiary_time_edited_by_employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ADD CONSTRAINT `fk_workforce_payroll_run_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ADD CONSTRAINT `fk_workforce_payroll_period_prior_payroll_period_id` FOREIGN KEY (`prior_payroll_period_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ADD CONSTRAINT `fk_workforce_benefit_enrollment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_travel_hospitality_v1`.`workforce`.`employee`(`employee_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Learning Course ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `prerequisite_course_learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Course ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `certificate_template_code` SET TAGS ('dbx_business_glossary_term' = 'Certificate Template ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `compliance_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirement Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `content_version` SET TAGS ('dbx_business_glossary_term' = 'Content Version');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `content_version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `continuing_education_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Credits (CEU)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `cost_per_learner` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Learner');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `cost_per_learner` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_development|retired|suspended');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_type` SET TAGS ('dbx_business_glossary_term' = 'Course Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `course_type` SET TAGS ('dbx_value_regex' = 'mandatory|optional|recommended|certification');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'instructor_led|online|blended|on_the_job|virtual_classroom');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Course Duration Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Capacity');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `enrollment_capacity` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `last_content_update_date` SET TAGS ('dbx_business_glossary_term' = 'Last Content Update Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `max_attempts` SET TAGS ('dbx_business_glossary_term' = 'Maximum Attempts Allowed');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `passing_score` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `validity_period_days` SET TAGS ('dbx_business_glossary_term' = 'Validity Period Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`learning_course` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Training Vendor Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` SET TAGS ('dbx_subdomain' = 'benefits_payroll');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `workforce_benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `aca_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'Affordable Care Act (ACA) Compliant Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Insurance Carrier Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Carrier Policy Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `carrier_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `cobra_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Consolidated Omnibus Budget Reconciliation Act (COBRA) Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Coinsurance Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `coinsurance_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_business_glossary_term' = 'Contribution Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `contribution_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly|annual');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `copay_amount` SET TAGS ('dbx_business_glossary_term' = 'Copay Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_business_glossary_term' = 'Coverage Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `coverage_amount` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_value_regex' = 'employee_only|employee_spouse|employee_children|employee_family');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Deductible Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `dependent_coverage_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Dependent Coverage Allowed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `dependent_coverage_allowed_flag` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `employer_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employer Contribution Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `enrollment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `enrollment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Period Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `life_event_enrollment_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Life Event Enrollment Allowed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `maximum_dependent_age` SET TAGS ('dbx_business_glossary_term' = 'Maximum Dependent Age');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `maximum_dependent_age` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `out_of_pocket_maximum` SET TAGS ('dbx_business_glossary_term' = 'Out-of-Pocket Maximum');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `plan_document_url` SET TAGS ('dbx_business_glossary_term' = 'Plan Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|terminated');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Plan Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_benefit_plan` ALTER COLUMN `waiting_period_days` SET TAGS ('dbx_business_glossary_term' = 'Waiting Period Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `benefits_package_code` SET TAGS ('dbx_business_glossary_term' = 'Benefits Package Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `benefits_package_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `benefits_package_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `brand_segment` SET TAGS ('dbx_business_glossary_term' = 'Brand Segment Applicability');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `brand_segment` SET TAGS ('dbx_value_regex' = 'luxury|premium|select_service|extended_stay|resort|all');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `commission_eligible` SET TAGS ('dbx_business_glossary_term' = 'Commission Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Commission Rate Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `commission_rate_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compa_ratio_target` SET TAGS ('dbx_business_glossary_term' = 'Comparative Ratio (Compa-Ratio) Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|obsolete');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_status` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `compensation_plan_description` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `is_unionized` SET TAGS ('dbx_business_glossary_term' = 'Unionized Position Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `market_pricing_date` SET TAGS ('dbx_business_glossary_term' = 'Market Pricing Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `market_pricing_source` SET TAGS ('dbx_business_glossary_term' = 'Market Pricing Data Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `maximum_rate` SET TAGS ('dbx_business_glossary_term' = 'Maximum Compensation Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `merit_increase_cycle` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Cycle');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `merit_increase_cycle` SET TAGS ('dbx_value_regex' = 'annual|biannual|quarterly|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `merit_increase_eligible` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `midpoint_rate` SET TAGS ('dbx_business_glossary_term' = 'Midpoint Compensation Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `minimum_rate` SET TAGS ('dbx_business_glossary_term' = 'Minimum Compensation Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Pay Multiplier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|semimonthly|monthly');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Compensation Plan Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'hourly|salaried|tipped|commission|service_charge_eligible|hybrid');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = 'hour|year|month|week|day');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `service_charge_eligible` SET TAGS ('dbx_business_glossary_term' = 'Service Charge Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_business_glossary_term' = 'Target Bonus Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `target_bonus_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `tip_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Tip Credit Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`compensation_plan` ALTER COLUMN `usali_department` SET TAGS ('dbx_business_glossary_term' = 'Uniform System of Accounts for the Lodging Industry (USALI) Department');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_action_id` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `disciplinary_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `primary_disciplinary_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `primary_disciplinary_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `primary_disciplinary_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Human Resources (HR) Business Partner ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `tertiary_disciplinary_hr_business_partner_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `workforce_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Incident ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Action Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_number` SET TAGS ('dbx_value_regex' = '^DA-[0-9]{8}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_status` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_status` SET TAGS ('dbx_value_regex' = 'draft|issued|active|completed|overturned|expunged');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Disciplinary Action Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'verbal_warning|written_warning|final_warning|suspension|termination|performance_improvement_plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_method` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `employee_acknowledgment_method` SET TAGS ('dbx_value_regex' = 'in_person_signature|electronic_signature|certified_mail|email_confirmation|refused');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Action Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `expunged_date` SET TAGS ('dbx_business_glossary_term' = 'Expunged Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `expunged_reason` SET TAGS ('dbx_business_glossary_term' = 'Expunged Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `grievance_filed` SET TAGS ('dbx_business_glossary_term' = 'Grievance Filed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `grievance_outcome_notes` SET TAGS ('dbx_business_glossary_term' = 'Grievance Outcome Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `grievance_outcome_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `grievance_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Grievance Resolution Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `grievance_status` SET TAGS ('dbx_business_glossary_term' = 'Grievance Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `grievance_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|upheld|overturned|settled|withdrawn');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `incident_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `is_eligible_for_rehire` SET TAGS ('dbx_business_glossary_term' = 'Eligible for Rehire Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `is_expunged` SET TAGS ('dbx_business_glossary_term' = 'Is Expunged Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `is_paid_suspension` SET TAGS ('dbx_business_glossary_term' = 'Is Paid Suspension Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `issued_date` SET TAGS ('dbx_business_glossary_term' = 'Action Issued Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `legal_hold` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `legal_hold_case_number` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Case Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `legal_hold_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `osha_recordable_incident` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Incident Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_days` SET TAGS ('dbx_business_glossary_term' = 'Suspension Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary_cause|involuntary_performance|involuntary_conduct|layoff|mutual_separation');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `union_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Union Representative Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `union_representative_notified` SET TAGS ('dbx_business_glossary_term' = 'Union Representative Notified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `violation_category` SET TAGS ('dbx_business_glossary_term' = 'Policy Violation Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `witness_names` SET TAGS ('dbx_business_glossary_term' = 'Witness Names');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`disciplinary_action` ALTER COLUMN `witness_names` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `job_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Job Requisition ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Hiring Manager ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `tertiary_job_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `tertiary_job_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `tertiary_job_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `background_check_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_value_regex' = 'hourly|annual|monthly|weekly');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `compensation_frequency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `drug_screening_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Drug Screening Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `eeo_job_category` SET TAGS ('dbx_business_glossary_term' = 'Equal Employment Opportunity (EEO) Job Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|seasonal|temporary|contract|on_call');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `external_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'External Posting Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `flsa_classification` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `headcount_requested` SET TAGS ('dbx_business_glossary_term' = 'Headcount Requested');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `internal_posting_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Posting Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `job_description` SET TAGS ('dbx_business_glossary_term' = 'Job Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `minimum_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Minimum Qualifications');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `posting_end_date` SET TAGS ('dbx_business_glossary_term' = 'Posting End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `posting_location` SET TAGS ('dbx_business_glossary_term' = 'Posting Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `posting_start_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `preferred_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Preferred Qualifications');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `requisition_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Closed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `requisition_justification` SET TAGS ('dbx_business_glossary_term' = 'Requisition Justification');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^REQ-[0-9]{6,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `requisition_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Requisition Opened Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'new_position|replacement|backfill|seasonal|temporary|contract');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Maximum');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `salary_range_max` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_business_glossary_term' = 'Salary Range Minimum');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `salary_range_min` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|flexible');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `target_start_date` SET TAGS ('dbx_business_glossary_term' = 'Target Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `time_to_fill_days` SET TAGS ('dbx_business_glossary_term' = 'Time to Fill (Days)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `travel_requirement` SET TAGS ('dbx_business_glossary_term' = 'Travel Requirement');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `travel_requirement` SET TAGS ('dbx_value_regex' = 'none|occasional|frequent|extensive');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `work_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`job_requisition` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on_site|hybrid|remote');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'talent_acquisition');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `development_areas_summary` SET TAGS ('dbx_business_glossary_term' = 'Development Areas Summary');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `development_plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgement_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgement Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `goals_met_count` SET TAGS ('dbx_business_glossary_term' = 'Goals Met Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `goals_total_count` SET TAGS ('dbx_business_glossary_term' = 'Total Goals Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `guest_service_rating` SET TAGS ('dbx_business_glossary_term' = 'Guest Service Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `guest_service_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_business_glossary_term' = 'Leadership Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `leadership_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding|not-applicable');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_improvement_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Performance Improvement Plan (PIP) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommended Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `property_code` SET TAGS ('dbx_business_glossary_term' = 'Property Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `reliability_rating` SET TAGS ('dbx_business_glossary_term' = 'Reliability Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `reliability_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `review_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Review Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Review Due Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'pending|in-progress|completed|acknowledged|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `review_template_code` SET TAGS ('dbx_business_glossary_term' = 'Review Template Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid-year|probationary|90-day|project|ad-hoc');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Strengths Summary');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `succession_planning_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Planning Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `teamwork_rating` SET TAGS ('dbx_business_glossary_term' = 'Teamwork Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `teamwork_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `technical_skills_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Skills Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`performance_review` ALTER COLUMN `technical_skills_rating` SET TAGS ('dbx_value_regex' = 'exceeds-expectations|meets-expectations|needs-improvement|unsatisfactory|outstanding');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'benefits_payroll');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Manager ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `procurement_benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Accrual Plan ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `accrual_period` SET TAGS ('dbx_business_glossary_term' = 'Accrual Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_notes` SET TAGS ('dbx_business_glossary_term' = 'Approval Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied|escalated');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `balance_as_of_date` SET TAGS ('dbx_business_glossary_term' = 'Balance As-Of Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `carryover_hours` SET TAGS ('dbx_business_glossary_term' = 'Carryover Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `certification_received_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `coverage_status` SET TAGS ('dbx_business_glossary_term' = 'Coverage Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `coverage_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|arranged|confirmed');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `coverage_status` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Leave End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Case Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `hours_accrued` SET TAGS ('dbx_business_glossary_term' = 'Hours Accrued');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `hours_requested` SET TAGS ('dbx_business_glossary_term' = 'Hours Requested');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `hours_taken` SET TAGS ('dbx_business_glossary_term' = 'Hours Taken');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `is_ada_accommodation` SET TAGS ('dbx_business_glossary_term' = 'Is ADA (Americans with Disabilities Act) Accommodation');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `is_fmla_qualifying` SET TAGS ('dbx_business_glossary_term' = 'Is FMLA (Family and Medical Leave Act) Qualifying');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `is_intermittent` SET TAGS ('dbx_business_glossary_term' = 'Is Intermittent Leave');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `is_paid` SET TAGS ('dbx_business_glossary_term' = 'Is Paid Leave');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_subtype` SET TAGS ('dbx_business_glossary_term' = 'Leave Subtype');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `opening_balance_hours` SET TAGS ('dbx_business_glossary_term' = 'Opening Balance Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Payroll Impact Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_impact_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Leave Reason Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `remaining_balance_hours` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `request_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Submission Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Submission Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `requires_medical_certification` SET TAGS ('dbx_business_glossary_term' = 'Requires Medical Certification');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `requires_medical_certification` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `requires_medical_certification` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Leave Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `total_days` SET TAGS ('dbx_business_glossary_term' = 'Total Leave Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`leave_request` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Leave Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` SET TAGS ('dbx_subdomain' = 'scheduling_attendance');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `workforce_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Workforce Safety Incident ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `corrective_action_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `days_on_restricted_duty` SET TAGS ('dbx_business_glossary_term' = 'Days on Restricted Duty');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'slip_fall|chemical_exposure|equipment_injury|ergonomic|near_miss|burn');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_value_regex' = 'first_aid|medical_treatment|lost_time|restricted_duty|fatality|no_injury');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|closed|pending_review');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `medical_treatment_facility` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Facility');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `medical_treatment_facility` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `medical_treatment_facility` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `osha_300_log_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) 300 Log Entry Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `physician_name` SET TAGS ('dbx_business_glossary_term' = 'Physician Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `physician_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `preventable_flag` SET TAGS ('dbx_business_glossary_term' = 'Preventable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `privacy_case_flag` SET TAGS ('dbx_business_glossary_term' = 'Privacy Case Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `witness_names` SET TAGS ('dbx_business_glossary_term' = 'Witness Names');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `workers_compensation_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `workers_compensation_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_safety_incident` ALTER COLUMN `workers_compensation_claim_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `ada_accommodation_description` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accommodation Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `ada_accommodation_description` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `ada_accommodation_description` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `ada_accommodation_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accommodation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `ada_accommodation_required_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Employee Date of Birth');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on-leave|suspended|terminated|retired|deceased');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full-time|part-time|seasonal|contract|temporary|intern');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `food_safety_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `food_safety_certification_flag` SET TAGS ('dbx_business_glossary_term' = 'Food Safety Certification Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `fte_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Middle Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_business_glossary_term' = 'National Identification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii_national_id' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `national_id_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `oracle_hcm_employee_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle Human Capital Management (HCM) Employee Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `oracle_hcm_employee_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `oracle_hcm_employee_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `osha_training_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Training Current Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `osha_training_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Training Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `pay_type` SET TAGS ('dbx_business_glossary_term' = 'Pay Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `pay_type` SET TAGS ('dbx_value_regex' = 'hourly|salaried|commission|contract');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `pay_type` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Preferred Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `standard_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Standard Hours Per Week');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `work_authorization_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Work Authorization Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `work_authorization_status` SET TAGS ('dbx_value_regex' = 'citizen|permanent-resident|work-visa|pending-verification|expired|not-authorized');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`employee` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on-property|remote|hybrid|corporate-office|multi-property');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `reports_to_position_id` SET TAGS ('dbx_business_glossary_term' = 'Reports To Position ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `ada_accommodation_required` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Accommodation Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Annual Salary');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `budgeted_annual_salary` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `fte_allocation` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Allocation');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `is_budgeted` SET TAGS ('dbx_business_glossary_term' = 'Is Budgeted Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `is_exempt` SET TAGS ('dbx_business_glossary_term' = 'Is Exempt Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `is_supervisory` SET TAGS ('dbx_business_glossary_term' = 'Is Supervisory Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `is_union` SET TAGS ('dbx_business_glossary_term' = 'Is Union Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `last_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Education Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `minimum_education_level` SET TAGS ('dbx_value_regex' = 'high_school|associate|bachelor|master|doctorate|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `minimum_years_experience` SET TAGS ('dbx_business_glossary_term' = 'Minimum Years of Experience');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `physical_requirements` SET TAGS ('dbx_business_glossary_term' = 'Physical Requirements');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|frozen|eliminated|proposed');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'regular|seasonal|temporary|contract|on_call');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `shift_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Shift Eligibility');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `shift_eligibility` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|any');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform System of Accounts for the Lodging Industry (USALI) Department Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `usali_department_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'on_property|remote|hybrid|field');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`position` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'employee_records');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `actual_headcount` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `budgeted_headcount` SET TAGS ('dbx_business_glossary_term' = 'Budgeted Headcount');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Email Address');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `is_guest_facing` SET TAGS ('dbx_business_glossary_term' = 'Is Guest Facing');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `is_revenue_generating` SET TAGS ('dbx_business_glossary_term' = 'Is Revenue Generating');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `is_unionized` SET TAGS ('dbx_business_glossary_term' = 'Is Unionized');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `labor_cost_percentage_target` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Percentage Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `labor_cost_percentage_target` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `labor_productivity_standard` SET TAGS ('dbx_business_glossary_term' = 'Labor Productivity Standard');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|planned|closed');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_type` SET TAGS ('dbx_value_regex' = 'division|department|team|cost_center|work_group');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[1-9]d{1,14}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `productivity_target_percentage` SET TAGS ('dbx_business_glossary_term' = 'Productivity Target Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `productivity_target_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `productivity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Productivity Unit of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `productivity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'rooms_per_hour|covers_per_hour|check_ins_per_hour|setups_per_hour|minutes_per_unit|units_per_shift');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `requires_certification` SET TAGS ('dbx_business_glossary_term' = 'Requires Certification');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `shift_pattern` SET TAGS ('dbx_value_regex' = '24x7|am_pm_night|am_pm|business_hours|on_call|variable');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `standard_time_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Standard Time Per Unit');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`org_unit` ALTER COLUMN `usali_classification` SET TAGS ('dbx_business_glossary_term' = 'USALI (Uniform System of Accounts for the Lodging Industry) Classification');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` SET TAGS ('dbx_subdomain' = 'scheduling_attendance');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `shift_template_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Template ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `consecutive_days_limit` SET TAGS ('dbx_business_glossary_term' = 'Consecutive Days Limit');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `holiday_shift_flag` SET TAGS ('dbx_business_glossary_term' = 'Holiday Shift Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `maximum_staffing_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Staffing Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `meal_allowance_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Meal Allowance Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `minimum_staffing_level` SET TAGS ('dbx_business_glossary_term' = 'Minimum Staffing Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `paid_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Paid Break Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `paid_hours` SET TAGS ('dbx_business_glossary_term' = 'Paid Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `rest_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Rest Hours Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_business_glossary_term' = 'Rotation Pattern');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `seasonal_applicability` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Applicability');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `seasonal_applicability` SET TAGS ('dbx_value_regex' = 'year_round|peak_season|off_season|summer|winter');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `shift_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `shift_template_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `shift_template_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|night|split|on_call');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `skill_requirement_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Requirement Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `skill_requirement_level` SET TAGS ('dbx_value_regex' = 'entry|intermediate|advanced|expert');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `template_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `template_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `transportation_allowance_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Transportation Allowance Eligible Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `uniform_code` SET TAGS ('dbx_business_glossary_term' = 'Uniform Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`shift_template` ALTER COLUMN `weekend_shift_flag` SET TAGS ('dbx_business_glossary_term' = 'Weekend Shift Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` SET TAGS ('dbx_subdomain' = 'scheduling_attendance');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `shift_template_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Template ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `tertiary_schedule_published_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Published By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `tertiary_schedule_published_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `tertiary_schedule_published_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `actual_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `cpor_labor` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Occupied Room (CPOR) Labor');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `estimated_labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `finalized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Finalized Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `forecast_adr` SET TAGS ('dbx_business_glossary_term' = 'Forecast Average Daily Rate (ADR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `forecast_occupancy_rate` SET TAGS ('dbx_business_glossary_term' = 'Forecast Occupancy Rate (OCC)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `forecast_revpar` SET TAGS ('dbx_business_glossary_term' = 'Forecast Revenue Per Available Room (RevPAR)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `is_overtime_approved` SET TAGS ('dbx_business_glossary_term' = 'Is Overtime Approved');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `labor_cost_percentage` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `labor_cost_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `labor_variance_hours` SET TAGS ('dbx_business_glossary_term' = 'Labor Variance Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Period End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Period Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|published|finalized|archived');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'regular|seasonal|event|emergency|training');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `total_actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Actual Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `total_scheduled_fte` SET TAGS ('dbx_business_glossary_term' = 'Total Scheduled Full-Time Equivalent (FTE)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `total_scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Scheduled Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'scheduling_attendance');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Org Unit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_template_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Template Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `tertiary_time_edited_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Edited By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `tertiary_time_edited_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `tertiary_time_edited_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `procurement_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|submitted|auto_approved');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `clock_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-In Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `clock_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Clock-Out Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `device_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii' = 'contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `edited_flag` SET TAGS ('dbx_business_glossary_term' = 'Edited Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `edited_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Edited Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `entry_date` SET TAGS ('dbx_business_glossary_term' = 'Entry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `entry_source` SET TAGS ('dbx_business_glossary_term' = 'Entry Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Entry Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `exception_code` SET TAGS ('dbx_business_glossary_term' = 'Exception Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Latitude');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geolocation Longitude');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `paid_break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Paid Break Duration (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `shift_differential_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `tips_reported_amount` SET TAGS ('dbx_business_glossary_term' = 'Tips Reported Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `tips_reported_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `tips_reported_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`time_entry` ALTER COLUMN `total_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_subdomain' = 'benefits_payroll');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `ownership_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `calculated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Calculated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `employee_count` SET TAGS ('dbx_business_glossary_term' = 'Employee Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_value_regex' = 'not_posted|posted|reversed');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `oracle_payroll_run_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle Payroll Run ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `paid_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Paid Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_business_glossary_term' = 'Pay Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `pay_frequency` SET TAGS ('dbx_value_regex' = 'weekly|bi-weekly|semi-monthly|monthly');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_number` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_status` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_type` SET TAGS ('dbx_business_glossary_term' = 'Payroll Run Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `payroll_run_type` SET TAGS ('dbx_value_regex' = 'regular|off-cycle|bonus|correction|final');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posted Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `sap_payroll_run_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Payroll Run ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_bonus_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Bonus Pay');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_commission_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Commission Pay');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_employer_taxes` SET TAGS ('dbx_business_glossary_term' = 'Total Employer Payroll Taxes');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_federal_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Federal Income Tax');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Gross Pay');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_gross_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_local_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Local Income Tax');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_medicare_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Medicare Tax (FICA)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Net Pay');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_net_pay` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_overtime_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Overtime (OT) Pay');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_post_tax_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Post-Tax Deductions');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_pre_tax_deductions` SET TAGS ('dbx_business_glossary_term' = 'Total Pre-Tax Deductions');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_regular_pay` SET TAGS ('dbx_business_glossary_term' = 'Total Regular Pay');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_service_charge` SET TAGS ('dbx_business_glossary_term' = 'Total Service Charge');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_social_security_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Social Security Tax (FICA)');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_social_security_tax` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_social_security_tax` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_social_security_tax` SET TAGS ('dbx_pii' = 'sensitive');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_state_tax` SET TAGS ('dbx_business_glossary_term' = 'Total State Income Tax');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_state_tax` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_tax_withholding` SET TAGS ('dbx_business_glossary_term' = 'Total Tax Withholding');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_run` ALTER COLUMN `total_tip_allocation` SET TAGS ('dbx_business_glossary_term' = 'Total Tip Allocation');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` SET TAGS ('dbx_subdomain' = 'benefits_payroll');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `ownership_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `prior_payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Prior Payroll Period Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `prior_payroll_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Approval Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `calendar_month` SET TAGS ('dbx_business_glossary_term' = 'Calendar Month');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `calendar_year` SET TAGS ('dbx_business_glossary_term' = 'Calendar Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `check_date` SET TAGS ('dbx_business_glossary_term' = 'Check Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `closed_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Closed By User Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `cutoff_date` SET TAGS ('dbx_business_glossary_term' = 'Cutoff Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `fiscal_month` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Month');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `fiscal_quarter` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Quarter');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `is_adjustment_period` SET TAGS ('dbx_business_glossary_term' = 'Is Adjustment Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `is_year_end_period` SET TAGS ('dbx_business_glossary_term' = 'Is Year End Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `pay_date` SET TAGS ('dbx_business_glossary_term' = 'Pay Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `payroll_group_code` SET TAGS ('dbx_business_glossary_term' = 'Payroll Group Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `payroll_period_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Period Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Period Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_number` SET TAGS ('dbx_business_glossary_term' = 'Period Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Period Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `processing_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing End Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `processing_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Start Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `total_days_count` SET TAGS ('dbx_business_glossary_term' = 'Total Days Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`payroll_period` ALTER COLUMN `working_days_count` SET TAGS ('dbx_business_glossary_term' = 'Working Days Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_subdomain' = 'benefits_administration');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_association_edges' = 'workforce.employee,workforce.benefit_plan');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `benefit_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'procurement_enrollment Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `procurement_benefit_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Benefit Plan Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `beneficiary_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Confirmation Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_business_glossary_term' = 'Coverage Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `coverage_tier` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_business_glossary_term' = 'Dependent Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `dependent_count` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective End Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Coverage Effective Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `employee_contribution_amount` SET TAGS ('dbx_business_glossary_term' = 'Employee Contribution Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_code` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `life_event_date` SET TAGS ('dbx_business_glossary_term' = 'Life Event Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `life_event_type` SET TAGS ('dbx_business_glossary_term' = 'Life Event Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `oracle_hcm_enrollment_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle HCM Enrollment Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `procurement_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `procurement_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `waived_flag` SET TAGS ('dbx_business_glossary_term' = 'Waived Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`benefit_enrollment` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`workforce`.`workforce_training_completion` SET TAGS ('dbx_data_type' = 'transactional_data');
