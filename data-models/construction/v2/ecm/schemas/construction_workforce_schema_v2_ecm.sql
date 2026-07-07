-- Schema for Domain: workforce | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:10:00

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_construction_v1`.`workforce` COMMENT 'Construction workforce management domain tracking labor resources, crew assignments, time tracking, production rates, skill certifications, labor cost coding, field personnel deployment, and site access records. Manages craft labor, supervision, and project-based staffing distinct from corporate HR functions. Integrates with HCSS HeavyJob for timesheets and SAP SuccessFactors for HCM.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`craft_worker` (
    `craft_worker_id` BIGINT COMMENT 'Unique identifier for the craft worker record. Primary key for the craft worker entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Payroll & compliance reports require each worker to be linked to the employing client account for tax, insurance and HSE reporting.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Each permit designates a responsible worker (permit holder) to ensure compliance; linking enables accountability audits.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the primary construction project to which the craft worker is currently assigned as their home base.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Payroll & benefits integration: linking each craft worker to their HR employee record ensures accurate salary, tax, and benefits processing.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Employer assignment: linking each craft worker to the subcontractor firm that employs them, required for labor cost allocation and compliance reporting.',
    `party_id` BIGINT COMMENT 'Foreign key linking to contract.contract_party. Business justification: REQUIRED: Workers are employed by a contract party (contractor/sub‑contractor); linking supports payroll, insurance, and compliance reporting.',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Standardize trade information by referencing skill_trade; remove redundant primary_trade_code and primary_trade_name from craft_worker.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to procurement.vendor. Business justification: REQUIRED: Vendor‑Supplied Labor Tracking – each subcontractor worker must be linked to the vendor that supplies them for compliance and cost allocation.',
    `craft_code` STRING COMMENT 'Standardized craft classification code used for cost coding and labor reporting in project management systems.. Valid values are `^[A-Z0-9]{2,8}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the craft worker record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the workers compensation (e.g., USD, CAD, GBP).. Valid values are `^[A-Z]{3}$`',
    `demobilization_date` DATE COMMENT 'Date the craft worker was demobilized from their project assignment, if applicable.',
    `email_address` STRING COMMENT 'Primary email address for the craft worker used for communication and system access.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the craft workers designated emergency contact person.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the craft workers designated emergency contact person.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the craft worker (e.g., spouse, parent, sibling, friend).',
    `employment_type` STRING COMMENT 'Classification of the workers employment relationship with the organization: direct hire (permanent employee), agency (temporary staffing), union referral (union hall dispatch), or subcontractor (independent contractor).. Valid values are `direct_hire|agency|union_referral|subcontractor`',
    `first_name` STRING COMMENT 'Legal first name of the craft worker as recorded in HR systems.',
    `hire_date` DATE COMMENT 'Date the craft worker was hired or first engaged by the organization.',
    `hourly_base_rate` DECIMAL(18,2) COMMENT 'Standard hourly wage rate for the craft worker in their primary trade classification, excluding overtime premiums and benefits.',
    `last_name` STRING COMMENT 'Legal last name of the craft worker as recorded in HR systems.',
    `middle_name` STRING COMMENT 'Middle name or initial of the craft worker, if applicable.',
    `mobilization_date` DATE COMMENT 'Date the craft worker was mobilized to their current project assignment.',
    `mobilization_status` STRING COMMENT 'Current deployment status of the craft worker: mobilized (actively deployed to a project site), demobilized (released from project), on_leave (temporarily unavailable), or available (ready for assignment).. Valid values are `mobilized|demobilized|on_leave|available`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the craft worker record was last modified in the system.',
    `osha_certification_expiry_date` DATE COMMENT 'Expiration date of the craft workers OSHA safety certification, if applicable.',
    `osha_certification_flag` BOOLEAN COMMENT 'Indicates whether the craft worker holds valid OSHA safety training certification (e.g., OSHA 10-hour or 30-hour).',
    `overtime_rate_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base hourly rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time).',
    `phone_number` STRING COMMENT 'Primary contact phone number for the craft worker for emergency contact and field coordination.',
    `ppe_size_boots` STRING COMMENT 'Boot size for issuing Personal Protective Equipment (PPE) such as steel-toed safety boots.',
    `ppe_size_pants` STRING COMMENT 'Pants size for issuing Personal Protective Equipment (PPE) such as work pants and coveralls.',
    `ppe_size_shirt` STRING COMMENT 'Shirt size for issuing Personal Protective Equipment (PPE) such as high-visibility vests and work shirts. [ENUM-REF-CANDIDATE: XS|S|M|L|XL|XXL|XXXL — 7 candidates stripped; promote to reference product]',
    `secondary_trade_code` STRING COMMENT 'Secondary craft trade classification code for multi-skilled workers who hold certifications in more than one trade.. Valid values are `^[A-Z]{2,6}$`',
    `security_clearance_level` STRING COMMENT 'Security clearance level held by the craft worker for access to restricted project sites (e.g., government, defense, critical infrastructure projects).. Valid values are `none|basic|confidential|secret|top_secret`',
    `site_access_badge_number` STRING COMMENT 'Unique badge or access card number issued to the craft worker for site entry and time tracking at construction sites.. Valid values are `^[A-Z0-9]{6,15}$`',
    `skill_level` STRING COMMENT 'Proficiency level of the craft worker in their primary trade: apprentice (in training), journeyman (certified tradesperson), master (advanced certification), or foreman (supervisory level).. Valid values are `apprentice|journeyman|master|foreman`',
    `supervisory_role_flag` BOOLEAN COMMENT 'Indicates whether the craft worker currently holds a supervisory role such as working foreman or crew lead (True) or is a non-supervisory hourly worker (False).',
    `supervisory_title` STRING COMMENT 'Job title for supervisory role if applicable (e.g., Working Foreman, Crew Lead, General Foreman).',
    `termination_date` DATE COMMENT 'Date the craft workers employment or engagement was terminated, if applicable.',
    `union_affiliation_flag` BOOLEAN COMMENT 'Indicates whether the craft worker is affiliated with a labor union (True) or non-union (False).',
    `union_local_number` STRING COMMENT 'Local union chapter number the worker belongs to, if union-affiliated.. Valid values are `^[0-9]{1,6}$`',
    `union_name` STRING COMMENT 'Name of the labor union the worker is affiliated with, if applicable (e.g., International Brotherhood of Electrical Workers, United Association of Plumbers).',
    `worker_status` STRING COMMENT 'Current lifecycle status of the craft worker record: active (currently employed and available), inactive (temporarily not working), suspended (disciplinary or safety hold), or terminated (employment ended).. Valid values are `active|inactive|suspended|terminated`',
    `years_of_experience` STRING COMMENT 'Total number of years of experience the craft worker has in their primary trade.',
    CONSTRAINT pk_craft_worker PRIMARY KEY(`craft_worker_id`)
) COMMENT 'Master record for all craft labor personnel deployed on construction projects including hourly trade workers and working foremen/supervisors. Captures worker identity, trade classification (from skill_trade taxonomy), employment type (direct hire, agency, union referral), union affiliation and local, craft code, supervisory role flag, home project assignment, mobilization status, security clearance level, and field deployment history. SSOT for individual field worker identity in the workforce domain. Workers may hold multiple trade classifications and rotate between craft and supervisory roles across projects. Integrates with SAP SuccessFactors for HCM master data and HCSS HeavyJob for field time tracking.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`crew` (
    `crew_id` BIGINT COMMENT 'Unique identifier for the construction crew. Primary key for the crew entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: REQUIRED: Crew allocation is planned per contract agreement; linking allows crew costs and productivity to be attributed to the agreement.',
    `asset_id` BIGINT COMMENT 'Foreign key linking to equipment.asset. Business justification: Needed for Crew Equipment Allocation report, assigning primary equipment to a crew for cost allocation, scheduling, and safety compliance.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Hot‑work permits assign a specific crew; tracking crew per permit is required for safety compliance reports.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project to which this crew is currently assigned. A crew may be reassigned between projects over its lifecycle.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for crew cost allocation reports that roll crew labor costs to the projects cost center, enabling accurate budgeting and variance analysis per cost center.',
    `cost_code_id` BIGINT COMMENT 'Reference to the home cost code for this crew. Used for labor cost allocation and job costing when crew time is not charged to a specific activity cost code.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the worker record of the foreman or crew lead responsible for supervising this crew. The foreman is accountable for crew productivity, safety, and quality.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Crew ownership: crews are supplied by subcontractors; linking enables crew billing and performance tracking per subcontractor.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Crew safety oversight: crew supervisor (an employee) is responsible for safety briefings and incident reporting for the crew.',
    `average_hourly_rate` DECIMAL(18,2) COMMENT 'Blended average hourly labor rate for the crew, calculated across all crew members. Used for cost estimation and Earned Value Management (EVM) calculations. Currency is USD unless otherwise specified in project configuration.',
    `crew_code` STRING COMMENT 'Business identifier code for the crew used in field operations and timekeeping systems. Typically alphanumeric and unique within a project or division.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was first created in the system. Used for audit trail and data lineage tracking.',
    `crew_status` STRING COMMENT 'Current operational status of the crew in its lifecycle. Active crews are deployed and working; inactive crews are not currently assigned; mobilizing/demobilizing crews are in transition; standby crews are available but not deployed; disbanded crews are permanently closed.. Valid values are `active|inactive|mobilizing|demobilizing|standby|disbanded`',
    `crew_type` STRING COMMENT 'Classification of the crew based on trade or discipline. Defines the primary craft or work scope the crew is organized to perform. [ENUM-REF-CANDIDATE: civil|structural|concrete|mep|electrical|plumbing|hvac|finishing|earthworks|piling — 10 candidates stripped; promote to reference product]',
    `days_since_last_incident` STRING COMMENT 'Number of calendar days since the last recordable safety incident for this crew. Used for safety milestone recognition and Total Recordable Incident Rate (TRIR) tracking. Null if no incidents have occurred.',
    `demobilization_date` DATE COMMENT 'Planned or actual date when the crew will be or was demobilized from the current project. Null for active crews with no planned demobilization.',
    `home_location` STRING COMMENT 'Primary site, yard, or facility where this crew is based or reports to. May be a project site, equipment yard, or regional office.',
    `is_union_crew` BOOLEAN COMMENT 'Flag indicating whether this is a union crew subject to collective bargaining agreements and union work rules. True if union, false if non-union or open shop.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was last updated. Used for audit trail, change tracking, and data synchronization across systems.',
    `last_safety_incident_date` DATE COMMENT 'Date of the most recent recordable safety incident involving this crew. Used for safety performance tracking and Lost Time Injury (LTI) frequency calculations. Null if no incidents have occurred.',
    `mobilization_date` DATE COMMENT 'Date when the crew was mobilized and became operational on the current project or assignment. Used for crew lifecycle tracking and project staffing history.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this crew record. Used for audit trail and accountability in crew management.',
    `crew_name` STRING COMMENT 'Human-readable name of the crew, often reflecting the crew type, foreman name, or project assignment (e.g., Smith Concrete Gang, MEP Crew A).',
    `notes` STRING COMMENT 'Free-text field for additional information about the crew, such as special skills, project-specific arrangements, or operational constraints. Used by project management and field supervision.',
    `planned_crew_size` STRING COMMENT 'Target or planned number of workers for this crew based on project staffing plans and Work Breakdown Structure (WBS) resource requirements.',
    `productivity_rate` DECIMAL(18,2) COMMENT 'Standard or historical productivity rate for this crew, expressed in units per hour (e.g., cubic yards of concrete per hour, linear feet of pipe per hour). Unit of measure depends on crew type and work scope.',
    `productivity_uom` STRING COMMENT 'Unit of measure for the productivity rate (e.g., CY/HR for cubic yards per hour, LF/HR for linear feet per hour, EA/HR for each per hour). Aligns with Bill of Quantities (BOQ) units.',
    `quality_rating` STRING COMMENT 'Current quality performance rating for the crew based on Quality Assurance/Quality Control (QA/QC) inspections, Non-Conformance Reports (NCR), and rework rates. Used for crew selection and quality incentive programs.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `required_certifications` STRING COMMENT 'Comma-separated list of skill certifications or licenses required for crew members (e.g., OSHA 30, Confined Space, Rigging Level II). Used for crew qualification verification and compliance with Inspection and Test Plans (ITP).',
    `safety_rating` STRING COMMENT 'Current safety performance rating for the crew based on Health Safety and Environment (HSE) inspections, incident history, and compliance with Safe Work Method Statements (SWMS). Used for crew selection and safety incentive programs.. Valid values are `excellent|good|satisfactory|needs_improvement|unsatisfactory`',
    `shift_end_time` TIMESTAMP COMMENT 'Standard end time for the crews shift in HH:MM format (24-hour clock). Used for timesheet validation and labor hour planning.',
    `shift_start_time` TIMESTAMP COMMENT 'Standard start time for the crews shift in HH:MM format (24-hour clock). Used for timesheet validation and site access control.',
    `shift_type` STRING COMMENT 'Standard shift pattern for this crew. Day shift is typical daytime hours; night shift is overnight; swing shift is evening; rotating shifts alternate; extended shifts are longer than standard 8-hour shifts.. Valid values are `day|night|swing|rotating|extended`',
    `size` STRING COMMENT 'Current number of workers assigned to this crew, including the foreman. Used for resource planning and productivity rate calculations.',
    `union_affiliation` STRING COMMENT 'Name of the labor union or trade association to which the majority of crew members belong, if applicable. Null for non-union crews. Relevant for labor relations, collective bargaining agreements, and jurisdictional work rules.',
    CONSTRAINT pk_crew PRIMARY KEY(`crew_id`)
) COMMENT 'Master record for a named field crew or gang deployed on a construction project. Captures crew name, crew type (civil, MEP, structural, concrete, etc.), foreman assignment, home cost code, project assignment, crew size, and active status. A crew is the primary unit of field labor organization in construction operations. Distinct from individual worker records.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` (
    `crew_assignment_id` BIGINT COMMENT 'Primary key for crew_assignment',
    `activity_id` BIGINT COMMENT 'Foreign key linking to schedule.activity. Business justification: Crew scheduling assigns crews to specific activities; required for dispatch, labor tracking, and activity labor cost reporting.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project where the crew assignment is active. Links to the project entity.',
    `cost_code_id` BIGINT COMMENT 'Identifier of the cost code used for labor cost allocation. Links to the cost code entity for job costing and financial tracking.',
    `craft_worker_id` BIGINT COMMENT 'Identifier of the craft worker assigned to the crew. Links to the individual workforce member.',
    `crew_id` BIGINT COMMENT 'Identifier of the crew to which the worker is assigned. Links to the crew entity.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the supervisor or foreman responsible for this crew assignment. Links to the workforce member acting as supervisor.',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element to which the crew assignment is allocated. Enables tracking of labor allocation to specific work packages.',
    `assignment_end_date` DATE COMMENT 'Date when the workers assignment to the crew ends. Null for open-ended assignments. Marks the effective end of the crew membership period.',
    `assignment_notes` STRING COMMENT 'Free-text notes or comments related to the crew assignment. May include special instructions, restrictions, or contextual information.',
    `assignment_number` STRING COMMENT 'Business identifier for the crew assignment. Human-readable reference number used in field operations and timekeeping systems.',
    `assignment_reason` STRING COMMENT 'Business reason or justification for the crew assignment. May include project need, skill requirement, backfill, or resource leveling.',
    `assignment_start_date` DATE COMMENT 'Date when the workers assignment to the crew begins. Marks the effective start of the crew membership period.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the crew assignment. Tracks whether the assignment is currently active, temporarily suspended, or has ended.. Valid values are `active|inactive|suspended|completed|terminated`',
    `assignment_type` STRING COMMENT 'Classification of the crew assignment duration and nature. Distinguishes between permanent crew members, temporary assignments, seasonal workers, and project-specific staffing.. Valid values are `permanent|temporary|seasonal|project_based`',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether labor hours from this crew assignment are billable to the client. Relevant for cost-plus and time-and-materials contracts.',
    `craft_type` STRING COMMENT 'Craft or trade classification of the worker for this assignment (e.g., carpenter, electrician, pipefitter, ironworker, concrete finisher). Aligns with union classifications and skill requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the crew assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `crew_role` STRING COMMENT 'Role of the worker within the crew. Defines the workers responsibility level and function within the crew structure.. Valid values are `laborer|operator|foreman|lead|journeyman|apprentice`',
    `demobilization_date` DATE COMMENT 'Date when the worker was demobilized from the project site. Marks the end of on-site presence for this crew assignment.',
    `hse_orientation_completed_flag` BOOLEAN COMMENT 'Indicates whether the worker has completed mandatory HSE orientation for this crew assignment. Required before site access is granted.',
    `hse_orientation_date` DATE COMMENT 'Date when the worker completed HSE orientation for this crew assignment. Used for compliance tracking and re-certification scheduling.',
    `labor_rate` DECIMAL(18,2) COMMENT 'Hourly labor rate for the worker in this crew assignment. Used for cost allocation and job costing. Rate may vary by project, craft, and role.',
    `labor_rate_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the labor rate (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the crew assignment record was last updated. Used for audit trail and change tracking.',
    `mobilization_date` DATE COMMENT 'Date when the worker was mobilized to the project site for this crew assignment. Relevant for remote or multi-site projects requiring worker relocation.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether the worker is eligible for overtime pay in this crew assignment. Driven by labor agreements, regulations, and contract terms.',
    `per_diem_eligible_flag` BOOLEAN COMMENT 'Indicates whether the worker is eligible for per diem allowances during this crew assignment. Typically applies to workers assigned away from their home location.',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily per diem allowance rate for the worker in this crew assignment. Covers meals, lodging, and incidental expenses for remote assignments.',
    `planned_end_date` DATE COMMENT 'Originally planned end date for the crew assignment. Used for schedule variance analysis and workforce planning.',
    `planned_start_date` DATE COMMENT 'Originally planned start date for the crew assignment. Used for schedule variance analysis and workforce planning.',
    `ppe_issued_flag` BOOLEAN COMMENT 'Indicates whether required PPE has been issued to the worker for this crew assignment. Tracks compliance with safety equipment requirements.',
    `shift_type` STRING COMMENT 'Shift schedule for the crew assignment. Defines the working hours pattern (day shift, night shift, swing shift, or rotating schedule).. Valid values are `day|night|swing|rotating`',
    `site_access_badge_number` STRING COMMENT 'Site access badge or credential number issued to the worker for this crew assignment. Used for site security and access control tracking.',
    `source_system_code` STRING COMMENT 'Unique identifier of the crew assignment record in the source operational system. Enables traceability back to the system of record.',
    `termination_reason` STRING COMMENT 'Reason for ending the crew assignment if terminated before planned end date. Includes completion, reassignment, performance issues, or project cancellation.',
    `union_affiliation` STRING COMMENT 'Union or labor organization affiliation for this crew assignment (e.g., IBEW, Carpenters Union, Laborers Union). Null for non-union assignments.',
    `union_local_number` STRING COMMENT 'Local union chapter number for this crew assignment. Used for labor compliance reporting and union dues tracking.',
    `work_location` STRING COMMENT 'Physical site or area where the crew assignment is performed. May reference a specific zone, building, or geographic area within the project site.',
    CONSTRAINT pk_crew_assignment PRIMARY KEY(`crew_assignment_id`)
) COMMENT 'Transactional record linking individual craft workers to a specific crew for a defined period on a project. Captures worker role within the crew (laborer, operator, foreman, lead), assignment start and end dates, cost code, WBS element, shift, and assignment status. Enables tracking of crew composition changes over time and supports labor cost allocation.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`timesheet` (
    `timesheet_id` BIGINT COMMENT 'Unique identifier for the timesheet record. Primary key for the timesheet entity.',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: REQUIRED: Timesheet entries must be billed to the correct contract agreement; the FK enables accurate invoicing and milestone payment tracking.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project where the work was performed.',
    `cost_code_id` BIGINT COMMENT 'Identifier of the cost code used for labor cost allocation and job costing. Enables tracking of labor costs by activity type.',
    `craft_worker_id` BIGINT COMMENT 'Identifier of the craft worker who performed the work. Links to the workforce master data.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the supervisor or foreman responsible for overseeing the work performed. Used for approval workflow and accountability.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Timesheet billing: associate each timesheet with the subcontractor of the worker for accurate payroll and contract invoicing.',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: Timesheets capture the rate applied; referencing labor_rate provides the authoritative rate definition and removes the duplicated hourly_rate column.',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element to which the labor hours are charged. Enables project cost control at the work package level.',
    `approval_status` STRING COMMENT 'Current approval status of the timesheet entry in the workflow. Determines whether the timesheet can be processed for payroll and job costing.. Valid values are `draft|submitted|approved|rejected|pending_review`',
    `approved_by` STRING COMMENT 'Username or identifier of the person who approved the timesheet. Provides audit trail for timesheet approval workflow.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet was approved. Critical for payroll processing cutoff and audit compliance.',
    `craft_classification` STRING COMMENT 'The trade or craft classification of the worker for this timesheet entry. Determines applicable pay rates and union rules.. Valid values are `carpenter|electrician|plumber|welder|ironworker|laborer`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet record was first created in the system. Audit trail for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the labor cost amount. Enables multi-currency project cost tracking.. Valid values are `^[A-Z]{3}$`',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of double-time hours worked, typically on holidays or after extended overtime. Paid at 2x the regular rate.',
    `equipment_operated` STRING COMMENT 'Description or identifier of equipment operated by the worker during this timesheet period. Used for equipment utilization tracking and operator certification validation.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether the labor hours are billable to the client or are non-billable overhead. Critical for revenue recognition and client invoicing.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost for this timesheet entry, calculated from hours worked and applicable pay rates. Core metric for job costing and project financial management.',
    `location_code` STRING COMMENT 'Code identifying the specific site location or work area where the labor was performed. Enables location-based cost tracking and site access control.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet record was last modified. Audit trail for record updates.',
    `notes` STRING COMMENT 'Free-text notes or comments about the work performed, issues encountered, or special circumstances. Provides context for time entries.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked beyond the standard work period. Typically paid at 1.5x the regular rate.',
    `pay_type` STRING COMMENT 'The compensation method applied to this timesheet entry. Determines how labor costs are calculated.. Valid values are `hourly|salary|per_diem|piece_rate`',
    `payroll_period` STRING COMMENT 'Identifier of the payroll period to which this timesheet belongs. Used for grouping timesheets for payroll processing.',
    `production_quantity` DECIMAL(18,2) COMMENT 'Quantity of work units produced during the timesheet period. Used for productivity rate calculation and earned value analysis.',
    `production_unit` STRING COMMENT 'Unit of measure for the production quantity (e.g., cubic yards, linear feet, square meters, each). Enables standardized productivity tracking.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular hours worked during the standard work period. Typically up to 8 hours per day or 40 hours per week.',
    `rejection_reason` STRING COMMENT 'Explanation provided when a timesheet is rejected. Enables corrective action and quality improvement in time tracking.',
    `shift_type` STRING COMMENT 'The type of work shift during which the labor was performed. Affects pay rates and scheduling.. Valid values are `day|night|swing|rotating`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet was submitted for approval. Marks the transition from draft to submitted status in the workflow.',
    `total_hours` DECIMAL(18,2) COMMENT 'Total hours worked across all categories (regular, overtime, double-time). Sum of all hour types for the timesheet entry.',
    `union_local` STRING COMMENT 'Union local chapter number to which the worker belongs. Required for union reporting and compliance with collective bargaining agreements.',
    `weather_condition` STRING COMMENT 'Weather conditions during the work period. Impacts productivity rates and may justify schedule delays or Extension of Time (EOT) claims.. Valid values are `clear|rain|snow|extreme_heat|extreme_cold|wind`',
    `work_classification` STRING COMMENT 'Classification of the work activity type. Distinguishes between productive work, non-productive time, rework, standby, and travel time for productivity analysis.. Valid values are `productive|non_productive|rework|standby|travel`',
    `work_date` DATE COMMENT 'The calendar date on which the work was performed. Core business event timestamp for labor tracking.',
    `work_order_number` STRING COMMENT 'Reference number of the work order or task assignment associated with this timesheet. Links labor hours to specific work packages.',
    CONSTRAINT pk_timesheet PRIMARY KEY(`timesheet_id`)
) COMMENT 'Daily field timesheet record capturing hours worked by a craft worker on a specific project, cost code, and WBS element. Sourced from HCSS HeavyJob. Captures regular hours, overtime hours, double-time hours, shift type, work classification, pay type, equipment operated, and approval status. Core transactional record for labor cost coding and payroll processing in field operations.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` (
    `timesheet_line_id` BIGINT COMMENT 'Unique identifier for the timesheet line item. Primary key for granular labor allocation tracking within a daily timesheet.',
    `activity_id` BIGINT COMMENT 'Reference to the specific project activity or task performed. Links labor hours to scheduled activities for progress tracking and resource leveling.',
    `asset_id` BIGINT COMMENT 'Reference to the equipment unit operated or supported during this labor allocation. Captures operator-equipment pairing for equipment utilization analysis and maintenance scheduling.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where the labor was performed. Enables project-level labor cost rollup and resource tracking.',
    `cost_code_id` BIGINT COMMENT 'Reference to the detailed cost code for labor allocation. Supports split-coding of hours across multiple cost centers within a single shift for accurate job costing.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the field worker or crew member who performed the labor. Links to the workforce master record for the individual.',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: Timesheet lines record work details; linking to labor_rate centralizes rate information and removes duplicated hourly_rate and burden_rate columns.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the supervisor or project manager who approved this timesheet line. Supports audit trail and accountability for labor cost approvals.',
    `timesheet_id` BIGINT COMMENT 'Reference to the parent daily timesheet record. Links this line item to the overall timesheet submission for a worker on a specific date.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element where labor was applied. Enables activity-level labor tracking for Earned Value Management (EVM) and Critical Path Method (CPM) scheduling.',
    `approval_status` STRING COMMENT 'Current approval workflow state for this timesheet line. Tracks progression from field entry through supervisor approval to payroll posting.. Valid values are `draft|submitted|approved|rejected|posted`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this timesheet line was approved. Lifecycle event timestamp for approval workflow tracking and audit compliance.',
    `craft_code` STRING COMMENT 'Standardized code identifying the labor craft or trade performed (e.g., carpenter, electrician, heavy equipment operator, concrete finisher). Used for skill-based labor cost analysis and union reporting.. Valid values are `^[A-Z0-9]{2,10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this timesheet line record was first created in the system. Audit trail timestamp for record creation tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for labor cost amount. Supports multi-currency projects and international joint ventures.. Valid values are `^[A-Z]{3}$`',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of double-time labor hours allocated to this cost code and activity. Compensated at 2x regular rate, typically for holidays or extended overtime per union agreements.',
    `is_billable` BOOLEAN COMMENT 'Indicates whether this labor allocation is billable to the client under the contract terms. Supports reimbursable cost tracking for cost-plus and time-and-materials contracts.',
    `is_rework` BOOLEAN COMMENT 'Indicates whether this labor was performed to correct defective work or address a Non-Conformance Report (NCR). Used for quality cost tracking and root cause analysis.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Total labor cost for this line item (hours × burden rate). Principal monetary value for job costing, EVM cost tracking, and project financial management.',
    `line_number` STRING COMMENT 'Sequential line number within the parent timesheet. Determines the order of labor allocation entries for a single workers daily timesheet.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this timesheet line record was last modified. Audit trail timestamp for change tracking and data lineage.',
    `notes` STRING COMMENT 'Free-text notes or comments about this labor allocation. Captures field conditions, work delays, safety observations, or other contextual information for the timesheet line.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime labor hours allocated to this cost code and activity. Typically compensated at premium rates (1.5x or 2x) per labor agreements and OSHA regulations.',
    `posted_to_job_cost_flag` BOOLEAN COMMENT 'Indicates whether this timesheet line has been posted to the job costing system for project financial tracking. Ensures labor costs are captured in project actuals.',
    `posted_to_payroll_flag` BOOLEAN COMMENT 'Indicates whether this timesheet line has been posted to the payroll system for worker compensation. Prevents duplicate payment processing.',
    `production_quantity` DECIMAL(18,2) COMMENT 'Quantity of work produced during this labor allocation (e.g., cubic yards of concrete poured, linear feet of pipe installed, square feet of formwork erected). Enables productivity rate calculation.',
    `production_unit` STRING COMMENT 'Unit of measure for production quantity (e.g., CY for cubic yards, LF for linear feet, SF for square feet, EA for each). Standardized per Bill of Quantities (BOQ) conventions.. Valid values are `^[A-Z]{2,10}$`',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular (straight-time) labor hours allocated to this cost code and activity. Used for standard labor cost calculation and productivity analysis.',
    `shift_code` STRING COMMENT 'Identifies the work shift during which labor was performed. Supports shift-differential pay calculations and 24-hour site operations tracking.. Valid values are `day|night|swing|overtime`',
    `total_hours` DECIMAL(18,2) COMMENT 'Total labor hours for this line item (sum of regular, overtime, and double-time hours). Used for resource loading and earned value calculations.',
    `union_local_code` STRING COMMENT 'Code identifying the labor union local chapter for this worker. Required for union labor reporting, fringe benefit calculations, and collective bargaining agreement compliance.. Valid values are `^[A-Z0-9]{2,10}$`',
    `weather_condition` STRING COMMENT 'Weather condition during the work period. Impacts productivity rates and may justify schedule delays or Extension of Time (EOT) claims per FIDIC contract terms. [ENUM-REF-CANDIDATE: clear|rain|snow|wind|extreme_heat|extreme_cold|fog — 7 candidates stripped; promote to reference product]',
    `work_date` DATE COMMENT 'The calendar date on which the labor was performed. Principal business event timestamp for labor allocation and daily production tracking.',
    `work_location_code` STRING COMMENT 'Site-specific location code where labor was performed (e.g., building zone, elevation level, grid coordinate). Supports spatial tracking and site logistics management.. Valid values are `^[A-Z0-9]{2,15}$`',
    `work_order_number` STRING COMMENT 'External work order or service order number if labor was performed under a specific work authorization. Links to maintenance orders or change orders.. Valid values are `^[A-Z0-9-]{5,20}$`',
    CONSTRAINT pk_timesheet_line PRIMARY KEY(`timesheet_line_id`)
) COMMENT 'Individual line item within a daily timesheet record, capturing granular labor allocation to a specific cost code, activity, WBS element, or equipment unit within a single shift. Supports split-coding of hours across multiple cost centers in a single day. Enables detailed job costing and EVM (Earned Value Management) labor tracking at the activity level.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` (
    `labor_cost_code_id` BIGINT COMMENT 'Unique identifier for the labor cost code record. Primary key.',
    `cost_code_id` BIGINT COMMENT 'Foreign key to finance.cost_code.cost_code_id',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Labor cost codes classify trades; linking to skill_trade centralizes trade definitions and removes duplicate trade attributes.',
    `budget_category` STRING COMMENT 'High-level budget classification for financial planning and cost control. Determines how labor costs are aggregated in project budgets and Earned Value Management (EVM) reporting.. Valid values are `direct_labor|indirect_labor|supervision|premium_time|mobilization`',
    `burden_rate_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to base hourly rate to account for payroll taxes, workers compensation insurance, benefits, and other indirect labor costs. Expressed as a percentage (e.g., 45.50 for 45.5%).',
    `cost_code` STRING COMMENT 'The unique alphanumeric cost code identifier used to classify and allocate field labor expenditure. This is the externally-known business identifier used in timesheets, job costing, and financial reporting.. Valid values are `^[A-Z0-9]{4,12}$`',
    `cost_code_description` STRING COMMENT 'Detailed textual description of the labor cost code explaining its purpose, scope, and typical usage in project cost allocation.',
    `cost_code_status` STRING COMMENT 'Current lifecycle status of the labor cost code. Only active codes are available for timesheet entry and new project assignments.. Valid values are `active|inactive|deprecated|pending_approval`',
    `craft_discipline` STRING COMMENT 'Standardized craft discipline category for workforce competency classification. Defines the primary skill domain for this labor cost code. [ENUM-REF-CANDIDATE: ironworker|pipefitter|electrician|carpenter|heavy_equipment_operator|concrete_finisher|welder|plumber|hvac_technician|mason|roofer|painter|laborer|foreman|superintendent — promote to reference product]. Valid values are `ironworker|pipefitter|electrician|carpenter|heavy_equipment_operator|concrete_finisher`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this labor cost code record was first created in the system.',
    `effective_end_date` DATE COMMENT 'The date after which this labor cost code is no longer valid for new assignments. Null for open-ended cost codes. Historical timesheets retain the code for audit purposes.',
    `effective_start_date` DATE COMMENT 'The date from which this labor cost code becomes valid and available for use in timesheets and project cost allocation.',
    `hcss_cost_code_mapping` STRING COMMENT 'The corresponding cost code identifier in HCSS HeavyJob field operations system. Used for timesheet integration and production tracking synchronization.',
    `hourly_rate_base` DECIMAL(18,2) COMMENT 'Standard base hourly wage rate for this labor cost code in the organizations default currency. Excludes burden, benefits, and premium time multipliers. Used for budget estimation and cost forecasting.',
    `hse_risk_level` STRING COMMENT 'The inherent Health, Safety, and Environment risk classification for this labor activity. Determines inspection frequency, permit-to-work requirements, and safety supervision levels.. Valid values are `low|medium|high|critical`',
    `is_prevailing_wage_applicable` BOOLEAN COMMENT 'Indicates whether this cost code is subject to prevailing wage requirements on government-funded projects (Davis-Bacon Act, state prevailing wage laws).',
    `is_union_classification` BOOLEAN COMMENT 'Indicates whether this labor cost code represents a union-covered trade classification subject to collective bargaining agreements and union work rules.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last updated this labor cost code record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this labor cost code record was last modified.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'The multiplier applied to base hourly rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Null if overtime is not applicable to this cost code.',
    `ppe_requirements` STRING COMMENT 'Comma-separated list of mandatory Personal Protective Equipment items required for workers assigned to this cost code (e.g., hard hat, safety glasses, steel-toed boots, fall protection harness, respirator).',
    `prevailing_wage_classification` STRING COMMENT 'The official prevailing wage classification code as defined by federal or state labor departments (e.g., Davis-Bacon Act classifications). Used to determine minimum wage rates for government-funded projects.',
    `productivity_unit_of_measure` STRING COMMENT 'The standard unit of measure used to track production rates for this labor classification (e.g., cubic yards of concrete, linear feet of pipe, square feet of formwork, tons of steel erected).',
    `required_certification_types` STRING COMMENT 'Comma-separated list of mandatory certifications, licenses, or qualifications required for workers assigned to this cost code (e.g., OSHA 30-Hour, Journeyman License, Crane Operator Certification, Confined Space Entry).',
    `requires_site_access_clearance` BOOLEAN COMMENT 'Indicates whether workers assigned to this cost code require special site access clearance, background checks, or security credentials (common for energy, defense, or critical infrastructure projects).',
    `sap_wbs_element` STRING COMMENT 'The SAP Project Systems Work Breakdown Structure element code that this labor cost code maps to for integration with SAP S/4HANA financial and project accounting modules.',
    `skill_level` STRING COMMENT 'The proficiency or seniority level associated with this cost code classification. Determines base wage rates and crew assignment eligibility.. Valid values are `apprentice|journeyman|foreman|superintendent|master`',
    `standard_crew_size` STRING COMMENT 'The typical number of workers in a standard crew for this trade classification. Used for resource planning and crew assignment optimization.',
    `union_jurisdiction` STRING COMMENT 'The labor union or trade association that holds jurisdiction over this craft discipline (e.g., International Brotherhood of Electrical Workers, United Association of Plumbers and Pipefitters). Null for non-union classifications.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this labor cost code record in the system.',
    CONSTRAINT pk_labor_cost_code PRIMARY KEY(`labor_cost_code_id`)
) COMMENT 'Unified reference master for labor cost codes and trade/skill classifications used to classify and allocate field labor expenditure and define workforce competency categories. Captures cost code identifier, description, trade code, trade name, craft discipline (ironworker, pipefitter, electrician, carpenter, etc.), union jurisdiction, prevailing wage classification, required certification types, budget category, SAP PS (Project Systems) WBS mapping, and active status. Serves as the single source of truth for both cost allocation and trade/skill classification — the authoritative taxonomy of construction trades and their cost coding. Integrates with SAP S/4HANA Project Systems and HCSS HeavyJob cost coding structures. Referenced by timesheets, labor rates, agency orders, and staffing plans for consistent trade and cost classification.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`craft_certification` (
    `craft_certification_id` BIGINT COMMENT 'Unique identifier for the craft certification record. Primary key.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the craft worker who holds this certification. Links to the workforce master record.',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Craft certifications reference a trade; linking to skill_trade consolidates trade metadata and eliminates redundant trade_category column.',
    `certification_level` STRING COMMENT 'The proficiency or skill level represented by this certification. Used to match workers to project requirements and determine pay grades.. Valid values are `Entry|Intermediate|Advanced|Master|Journeyman|Apprentice`',
    `certification_name` STRING COMMENT 'The full descriptive name of the certification as issued by the certifying body. Provides human-readable detail beyond the type code.',
    `certification_number` STRING COMMENT 'The unique certificate or credential number issued by the certifying body. Used for verification and audit purposes.',
    `certification_type` STRING COMMENT 'The category or type of certification held by the worker. Defines the specific trade skill, safety qualification, or competency credential. [ENUM-REF-CANDIDATE: OSHA 10|OSHA 30|NCCER Core|NCCER Craft|Rigger|Scaffolder|Welder|Crane Operator|Confined Space|Fall Protection|Forklift|Electrical|HVAC|Plumbing|First Aid|CPR|Hazmat|Asbestos|Lead Abatement — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was first created in the system. Used for audit trail and data lineage tracking.',
    `document_reference` STRING COMMENT 'Reference identifier or file path to the scanned or digital copy of the certification document stored in the document management system. Supports audit and verification workflows.',
    `expiry_date` DATE COMMENT 'The date on which the certification expires and is no longer valid. Nullable for certifications that do not expire.',
    `issue_date` DATE COMMENT 'The date on which the certification was originally issued to the worker.',
    `issuing_body` STRING COMMENT 'The organization or authority that issued the certification. Examples include OSHA (Occupational Safety and Health Administration), NCCER (National Center for Construction Education and Research), NCCCO (National Commission for the Certification of Crane Operators), AWS (American Welding Society), or state licensing boards.',
    `issuing_country_code` STRING COMMENT 'The three-letter ISO country code representing the country in which the certification was issued. Used for international workforce management and cross-border project assignments.. Valid values are `^[A-Z]{3}$`',
    `issuing_state_province` STRING COMMENT 'The state or province in which the certification was issued. Relevant for certifications that are jurisdiction-specific, such as state contractor licenses or provincial trade qualifications.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this certification record was last updated. Supports change tracking and audit compliance.',
    `next_renewal_date` DATE COMMENT 'The date by which the certification must be renewed to remain valid. Used for proactive workforce planning and compliance alerts.',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, or remarks related to the certification. May include details on restrictions, endorsements, or verification challenges.',
    `project_requirement_flag` BOOLEAN COMMENT 'Indicates whether this certification is required by specific project contracts or client specifications. True if the certification is a project-specific qualification requirement, False if it is a general workforce credential.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this certification is required to meet federal, state, or local regulatory requirements. True if the certification is mandated by law or regulation, False if it is voluntary or company-specific.',
    `renewal_frequency_months` STRING COMMENT 'The number of months between required renewals for this certification. Nullable if renewal is not required.',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this certification requires periodic renewal. True if renewal is required, False if the certification is permanent or does not expire.',
    `site_access_required_flag` BOOLEAN COMMENT 'Indicates whether this certification is mandatory for site access control. True if workers cannot badge in without a valid certification of this type, False otherwise. Supports HSE (Health Safety and Environment) compliance and access control integration.',
    `training_completion_date` DATE COMMENT 'The date on which the worker completed the training program associated with this certification.',
    `training_hours_required` DECIMAL(18,2) COMMENT 'The total number of training hours required to obtain or renew this certification. Used for workforce development planning and compliance tracking.',
    `verification_date` DATE COMMENT 'The date on which the certification was last verified by the company or issuing body. Used to track compliance audit trails.',
    `verification_status` STRING COMMENT 'The current verification state of the certification. Indicates whether the credential has been validated by the issuing body or internal compliance team, and whether it is currently active and valid for site access and work assignment.. Valid values are `Verified|Pending|Expired|Revoked|Suspended|Not Verified`',
    `verified_by` STRING COMMENT 'The name or identifier of the person or system that performed the verification. Supports audit and accountability requirements.',
    CONSTRAINT pk_craft_certification PRIMARY KEY(`craft_certification_id`)
) COMMENT 'Master record for a specific trade certification, license, or qualification held by a craft worker. Captures certification type (OSHA 10/30, NCCER credentials, rigger, scaffolder, welder qualification, crane operator NCCCO, confined space, etc.), issuing body, issue date, expiry date, certification number, verification status, and renewal requirements. Supports site access control (workers cannot badge in without valid certs), workforce competency management, and compliance with project-specific qualification requirements. Distinct from apprenticeship_progression which tracks cumulative hours and level advancement — this product tracks discrete credentials already earned.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`skill_trade` (
    `skill_trade_id` BIGINT COMMENT 'Unique identifier for the construction trade skill or craft discipline record. Primary key.',
    `hr_org_unit_id` BIGINT COMMENT 'Foreign key to hr.hr.org_unit_id',
    `apprenticeship_duration_hours` STRING COMMENT 'Standard duration of apprenticeship training program in hours (e.g., 8000 hours for journeyman electrician). Used for workforce development planning and training program management.',
    `apprenticeship_required_flag` BOOLEAN COMMENT 'Indicates whether formal apprenticeship training is required or recommended for this trade skill. True if apprenticeship is a standard pathway; false otherwise.',
    `average_hourly_rate_usd` DECIMAL(18,2) COMMENT 'Average or benchmark hourly labor rate for journeyman-level workers in this trade, in US dollars. Used for project cost estimation and budget planning. Actual rates vary by geography, project type, and union agreements.',
    `bim_integration_level` STRING COMMENT 'Level of BIM (Building Information Modeling) technology integration and digital literacy expected for this trade (none, basic, intermediate, advanced). Used for technology training planning and digital construction readiness.. Valid values are `none|basic|intermediate|advanced`',
    `certification_issuing_body` STRING COMMENT 'Name of the organization or regulatory body that issues the required certification for this trade (e.g., NCCER, AWS, NCCCO, state licensing board). Used for credential verification and compliance tracking.',
    `certification_type_required` STRING COMMENT 'Type of professional certification, license, or credential required to perform work in this trade (e.g., NCCER certification, state electrical license, AWS welding certification, NCCCO crane operator certification). Multiple certifications may be listed as comma-separated values.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade skill record was first created in the system. Used for audit trail and data lineage tracking.',
    `effective_end_date` DATE COMMENT 'Date when this trade skill classification was retired or became obsolete. Null for currently active trades. Used for temporal validity and historical analysis.',
    `effective_start_date` DATE COMMENT 'Date when this trade skill classification became active and available for use in workforce planning and assignment. Used for temporal validity and historical tracking.',
    `equipment_dependency_flag` BOOLEAN COMMENT 'Indicates whether this trade requires specialized heavy equipment or machinery to perform work (e.g., crane operators require cranes, equipment operators require excavators). True if equipment-dependent; false if primarily manual labor.',
    `hazard_exposure_level` STRING COMMENT 'Classification of typical occupational hazard exposure level for this trade (low, moderate, high, extreme). Used for risk assessment, insurance rating, and HSE planning.. Valid values are `low|moderate|high|extreme`',
    `labor_cost_code_id` BIGINT COMMENT 'add column labor_cost_code_id (BIGINT) with FK to workforce.labor_cost_code.labor_cost_code_id - skill trades typically map to a default labor cost code',
    `labor_shortage_indicator` STRING COMMENT 'Current market assessment of labor availability for this trade (surplus, balanced, shortage, critical shortage). Used for strategic workforce planning and recruitment prioritization.. Valid values are `surplus|balanced|shortage|critical_shortage`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this trade skill record was last updated or modified. Used for audit trail and change tracking.',
    `mep_discipline_flag` BOOLEAN COMMENT 'Indicates whether this trade is part of the MEP (Mechanical, Electrical, and Plumbing) disciplines. True for electricians, pipefitters, HVAC technicians, plumbers; false for structural and civil trades.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations related to this trade skill classification. May include regional variations, specialty sub-disciplines, or unique requirements.',
    `osha_training_requirement` STRING COMMENT 'Specific OSHA training courses or certifications required for this trade (e.g., OSHA 10-hour, OSHA 30-hour, confined space, fall protection, scaffolding). Used for safety compliance and site access control.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Standard overtime pay multiplier for this trade (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Used for labor cost calculation and payroll processing.',
    `physical_demand_rating` STRING COMMENT 'Classification of physical exertion and strength requirements for this trade (light, medium, heavy, very heavy). Used for workforce health management and ergonomic planning.. Valid values are `light|medium|heavy|very_heavy`',
    `ppe_requirements` STRING COMMENT 'Standard personal protective equipment required for workers in this trade (e.g., hard hat, safety glasses, steel-toed boots, gloves, fall protection harness, welding helmet). Used for safety planning and PPE procurement.',
    `prevailing_wage_classification` STRING COMMENT 'Official wage classification code used for prevailing wage determination on public works projects, as defined by Davis-Bacon Act or state-specific prevailing wage laws. Critical for labor cost estimation and compliance on government-funded projects.',
    `productivity_unit_of_measure` STRING COMMENT 'Standard unit of measure used to track productivity for this trade (e.g., linear feet of pipe installed per day, cubic yards of concrete placed per hour, square feet of drywall hung per shift). Used for production tracking and earned value management (EVM).',
    `seasonal_demand_pattern` STRING COMMENT 'Description of typical seasonal demand fluctuation for this trade (e.g., high demand in summer for outdoor trades, year-round for indoor MEP work). Used for workforce capacity planning and recruitment timing.',
    `skill_level_tiers` STRING COMMENT 'Defined progression tiers or grades within this trade (e.g., apprentice, journeyman, foreman, general foreman, superintendent). Used for career path planning and labor rate determination. Typically stored as comma-separated hierarchy.',
    `standard_crew_size` STRING COMMENT 'Typical or recommended crew size for efficient work execution in this trade (e.g., 4-person ironworker crew, 2-person electrician crew). Used for resource planning and scheduling.',
    `trade_category` STRING COMMENT 'High-level classification grouping of the trade skill (structural, mechanical, electrical, civil, finishing, equipment operation, specialty). Used for workforce segmentation and reporting. [ENUM-REF-CANDIDATE: structural|mechanical|electrical|civil|finishing|equipment_operation|specialty — 7 candidates stripped; promote to reference product]',
    `trade_code` STRING COMMENT 'Standardized alphanumeric code identifying the construction trade or craft discipline (e.g., IW for ironworker, EL for electrician, CP for carpenter). Used for workforce planning, labor rate determination, and crew composition.. Valid values are `^[A-Z0-9]{2,10}$`',
    `trade_name` STRING COMMENT 'Full descriptive name of the construction trade or craft discipline (e.g., Ironworker, Pipefitter, Electrician, Carpenter, Concrete Finisher, Heavy Equipment Operator, Rigger, Welder).',
    `trade_status` STRING COMMENT 'Current lifecycle status of the trade skill classification. Active trades are available for workforce planning and assignment; inactive trades are no longer used; obsolete trades are deprecated; emerging trades are newly recognized.. Valid values are `active|inactive|obsolete|emerging`',
    `travel_requirement_typical` STRING COMMENT 'Typical geographic travel requirement for workers in this trade (none, local, regional, national, international). Used for workforce planning and per diem budgeting.. Valid values are `none|local|regional|national|international`',
    `union_jurisdiction_code` STRING COMMENT 'Code identifying the labor union or trade union that has jurisdiction over this craft discipline (e.g., IBEW for electricians, UA for pipefitters, IUOE for operators). Used for labor relations, collective bargaining, and compliance.',
    `union_jurisdiction_name` STRING COMMENT 'Full name of the labor union or trade union with jurisdiction over this craft (e.g., International Brotherhood of Electrical Workers, United Association of Plumbers and Pipefitters).',
    CONSTRAINT pk_skill_trade PRIMARY KEY(`skill_trade_id`)
) COMMENT 'Reference classification of construction trade skills and craft disciplines (e.g., ironworker, pipefitter, electrician, carpenter, concrete finisher, heavy equipment operator, rigger, welder). Captures trade code, trade name, union jurisdiction, prevailing wage classification, and required certification types. Used for workforce planning, crew composition, and labor rate determination.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`site_access_record` (
    `site_access_record_id` BIGINT COMMENT 'Unique identifier for the site access record. Primary key for tracking individual entry and exit events at construction project sites.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where the access event occurred. Enables site-specific headcount tracking and project labor analytics.',
    `hr_employee_id` BIGINT COMMENT 'Reference to the security officer or gate attendant who processed the access event. Supports accountability and manual entry verification.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Site access control: replace free‑text contractor name with FK to subcontractor firm for security audit and regulatory compliance.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the craft worker or supervisor who accessed the site. Links to the workforce master data for personnel tracking and muster reporting.',
    `access_denial_reason` STRING COMMENT 'Free-text explanation for why access was denied or flagged as unauthorized. Null for successful authorized entries. Supports security incident investigation.',
    `access_direction` STRING COMMENT 'Indicates whether this record represents a site entry or exit event. Critical for calculating current on-site headcount and emergency muster accuracy.. Valid values are `entry|exit`',
    `access_method` STRING COMMENT 'The technology or process used to record the access event. Distinguishes automated badge scans from manual security guard entries.. Valid values are `badge_scan|biometric|manual_entry|qr_code|mobile_app|visitor_log`',
    `access_notes` STRING COMMENT 'Free-text notes or comments recorded by security personnel regarding the access event. May include special circumstances, exceptions, or observations.',
    `access_timestamp` TIMESTAMP COMMENT 'The precise date and time when the worker entered or exited the site gate. Principal business event timestamp for time tracking and muster reporting.',
    `access_zone` STRING COMMENT 'The specific zone or area of the construction site the worker is authorized to access (e.g., Zone A, Mechanical Area, Restricted Area). Supports zone-based access control and safety management.',
    `actual_exit_timestamp` TIMESTAMP COMMENT 'The actual date and time when the worker exited the site. Paired with access_timestamp to calculate time on site. Null for entry records without matching exit.',
    `authorization_status` STRING COMMENT 'Indicates whether the worker had valid authorization to access the site at the time of entry. Supports security compliance and unauthorized access detection.. Valid values are `authorized|unauthorized|override|expired|pending`',
    `badge_number` STRING COMMENT 'The physical or digital badge identifier used by the worker to access the site. May be RFID card number, biometric ID, or manual entry code.',
    `duration_on_site_minutes` STRING COMMENT 'Calculated duration in minutes between entry and exit timestamps. Used for labor hour tracking and productivity analysis. Null if exit has not yet occurred.',
    `emergency_muster_status` STRING COMMENT 'Current status of the worker for emergency muster and evacuation purposes. Updated in real-time based on entry/exit events and emergency roll call procedures.. Valid values are `on_site|off_site|accounted_for|unaccounted_for`',
    `escort_required_flag` BOOLEAN COMMENT 'Indicates whether the worker requires an escort while on site. Typically true for visitors, inspectors, or personnel without full site authorization.',
    `expected_exit_timestamp` TIMESTAMP COMMENT 'The anticipated date and time when the worker is expected to exit the site. Used for visitor management and to flag overdue exits for safety follow-up.',
    `health_screening_status` STRING COMMENT 'Result of health screening questionnaire or assessment performed at gate entry. Used during pandemic or outbreak situations to prevent spread of illness on site.. Valid values are `passed|failed|not_required|waived`',
    `induction_status` STRING COMMENT 'Indicates whether the worker has completed the required site safety induction or orientation before being granted access. Critical for HSE compliance and first-time visitor management.. Valid values are `completed|not_required|pending|expired`',
    `photo_captured_flag` BOOLEAN COMMENT 'Indicates whether a photograph of the worker was captured at the gate for identity verification or visitor badge printing purposes.',
    `ppe_compliance_status` STRING COMMENT 'Result of the PPE compliance check performed at the gate. Indicates whether the worker was wearing required safety equipment (hard hat, safety vest, boots) at time of entry.. Valid values are `compliant|non_compliant|not_checked|waived`',
    `ppe_items_verified` STRING COMMENT 'Comma-separated list of PPE items verified during the gate check (e.g., hard_hat, safety_vest, steel_toe_boots, safety_glasses, gloves). Supports detailed HSE compliance auditing.',
    `purpose_of_visit` STRING COMMENT 'Free-text description of the reason for site access. Particularly relevant for visitors, inspectors, and non-routine personnel. Supports audit trails and security investigations.',
    `record_created_timestamp` TIMESTAMP COMMENT 'System timestamp when this access record was first created in the database. Supports audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this access record was last modified. Tracks corrections, exit timestamp updates, and status changes.',
    `signature_captured_flag` BOOLEAN COMMENT 'Indicates whether the worker provided a digital or physical signature acknowledging site safety rules and access terms at time of entry.',
    `site_gate_code` BIGINT COMMENT 'Reference to the specific entry or exit gate where the access event was recorded. Supports multi-gate site layouts and zone-based access control.',
    `temperature_reading` DECIMAL(18,2) COMMENT 'Body temperature measurement taken at gate entry for health screening purposes (e.g., pandemic protocols). Measured in degrees Celsius. May be null if health screening is not active.',
    `vehicle_registration` STRING COMMENT 'License plate or registration number of the vehicle used by the worker to access the site. Supports parking management and vehicle tracking for security purposes.',
    `worker_classification` STRING COMMENT 'Categorizes the type of personnel accessing the site. Distinguishes between direct employees, subcontractor labor, visitors, and other site personnel for reporting and compliance.. Valid values are `direct_hire|subcontractor|visitor|vendor|inspector|client_representative`',
    CONSTRAINT pk_site_access_record PRIMARY KEY(`site_access_record_id`)
) COMMENT 'Transactional record of a craft worker or supervisor entering or exiting a project site. Captures worker identity, site gate, entry/exit timestamp, access method (badge scan, biometric, manual), access authorization status, visitor vs. direct hire classification, and PPE compliance check result. Supports HSE compliance, headcount tracking, and emergency muster reporting.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` (
    `labor_mobilization_id` BIGINT COMMENT 'Unique identifier for the labor mobilization record. Primary key for tracking worker movement to/from project sites.',
    `regulatory_permit_id` BIGINT COMMENT 'Foreign key linking to compliance.permit. Business justification: Mobilizing labor to a site often depends on a site‑access or work permit; linking validates permit compliance before mobilization.',
    `cost_code_id` BIGINT COMMENT 'Cost code to which mobilization expenses will be charged. Links to project cost accounting structure.',
    `craft_worker_id` BIGINT COMMENT 'Identifier of the craft worker or supervisor being mobilized. Links to the workforce master record.',
    `crew_assignment_id` BIGINT COMMENT 'Identifier of the crew the worker is assigned to at the destination project. Null if not yet assigned.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the project site the worker is mobilizing to. Null for demobilizations.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Mobilization tracking: tie each labor mobilization record to the subcontractor providing the labor for cost and schedule analysis.',
    `primary_labor_construction_project_id` BIGINT COMMENT 'Identifier of the project site the worker is mobilizing from. Null for initial mobilizations.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the project manager or supervisor who requested the mobilization.',
    `accommodation_booking_reference` STRING COMMENT 'Booking confirmation number for temporary accommodation (hotel, camp, rental housing).',
    `accommodation_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost of temporary accommodation for the mobilization period.',
    `accommodation_required_flag` BOOLEAN COMMENT 'Indicates whether temporary accommodation is required at the destination site (True) or not (False).',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time the worker arrived at the destination project site, recorded for compliance and payroll purposes.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time the worker departed from the origin project site, recorded for compliance and payroll purposes.',
    `approval_date` DATE COMMENT 'Date the mobilization request was formally approved by authorized personnel.',
    `craft_code` STRING COMMENT 'Code representing the workers primary trade or craft skill (e.g., CARP for carpenter, ELEC for electrician, WELD for welder).. Valid values are `^[A-Z]{2,6}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mobilization record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this mobilization record.. Valid values are `^[A-Z]{3}$`',
    `demobilization_date` DATE COMMENT 'Date the worker is scheduled to depart from the origin project site. Null for initial mobilizations.',
    `hse_orientation_completed_flag` BOOLEAN COMMENT 'Indicates whether the worker has completed mandatory HSE (Health Safety and Environment) site orientation at the destination project (True) or not (False).',
    `hse_orientation_date` DATE COMMENT 'Date the worker completed HSE (Health Safety and Environment) orientation training at the destination site.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the mobilization record was last updated or modified.',
    `mobilization_date` DATE COMMENT 'Date the worker is scheduled to arrive at the destination project site and begin work.',
    `mobilization_number` STRING COMMENT 'Business identifier for the mobilization transaction. Format: MOB-YYYYMMDD followed by sequence number.. Valid values are `^MOB-[0-9]{8}$`',
    `mobilization_reason` STRING COMMENT 'Business justification or reason for the mobilization (e.g., project ramp-up, skill shortage, emergency response, project closeout).',
    `mobilization_status` STRING COMMENT 'Current status of the mobilization transaction in its lifecycle workflow.. Valid values are `planned|approved|in_transit|completed|cancelled`',
    `mobilization_type` STRING COMMENT 'Type of mobilization event: initial (first assignment to project), transfer (move between projects), demobilization (release from project), remobilization (return after temporary leave).. Valid values are `initial|transfer|demobilization|remobilization`',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the mobilization transaction for operational reference.',
    `per_diem_duration_days` STRING COMMENT 'Number of days the worker is entitled to receive per diem allowance.',
    `per_diem_eligible_flag` BOOLEAN COMMENT 'Indicates whether the worker is eligible for per diem allowance during mobilization (True) or not (False).',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily per diem allowance rate in the projects currency for meals and incidental expenses.',
    `site_access_badge_issued_flag` BOOLEAN COMMENT 'Indicates whether a site access badge or credential has been issued to the worker at the destination site (True) or not (False).',
    `special_requirements` STRING COMMENT 'Any special requirements or considerations for the mobilization such as medical accommodations, dietary restrictions, security clearances, or equipment transport needs.',
    `total_mobilization_cost` DECIMAL(18,2) COMMENT 'Total estimated or actual cost of the mobilization including travel, accommodation, per diem, and administrative expenses.',
    `travel_booking_reference` STRING COMMENT 'Booking confirmation number or reference code for travel arrangements (flight, train, rental car).',
    `travel_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost of travel arrangements including airfare, ground transportation, and related expenses.',
    `travel_mode` STRING COMMENT 'Primary mode of transportation arranged for the workers mobilization journey.. Valid values are `air|ground|rail|company_vehicle|personal_vehicle|not_applicable`',
    CONSTRAINT pk_labor_mobilization PRIMARY KEY(`labor_mobilization_id`)
) COMMENT 'Transactional record tracking the mobilization or demobilization of a craft worker or supervisor to/from a project site. Captures mobilization type (initial, transfer, demobilization), origin and destination project, travel arrangement details, per diem entitlement, mobilization date, demobilization date, and associated cost. Supports project staffing planning and labor cost forecasting.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`production_rate` (
    `production_rate_id` BIGINT COMMENT 'Unique identifier for the production rate record.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project where this production rate was recorded.',
    `cost_code_id` BIGINT COMMENT 'Reference to the cost code used for labor cost allocation for this production activity.',
    `craft_worker_id` BIGINT COMMENT 'Reference to the foreman or supervisor overseeing the crew during this production activity.',
    `crew_id` BIGINT COMMENT 'Reference to the crew that performed the work and achieved this production rate.',
    `project_baseline_id` BIGINT COMMENT 'Reference to the project baseline against which this production rate performance is being measured.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Production reporting audit: the employee who records daily production rates must be captured for traceability.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element under which this production activity was performed.',
    `activity_code` STRING COMMENT 'The unique code identifying the specific construction activity being measured (e.g., concrete pour, rebar installation, excavation). Sourced from project scheduling system.',
    `activity_description` STRING COMMENT 'Detailed description of the construction activity for which production rate is being tracked.',
    `actual_production_rate` DECIMAL(18,2) COMMENT 'The actual production rate achieved (units per labor-hour), calculated as actual quantity divided by expended labor hours.',
    `actual_quantity` DECIMAL(18,2) COMMENT 'The actual quantity of work completed or installed by the crew during this production period, measured in the specified unit of measure.',
    `approval_date` DATE COMMENT 'The date on which this production rate record was approved for use in cost and schedule reporting.',
    `approved_by` STRING COMMENT 'Name or identifier of the supervisor or project manager who approved this production rate record.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this production rate record was first created in the source system.',
    `earned_hours` DECIMAL(18,2) COMMENT 'The labor hours that should have been required to complete the actual quantity based on the planned production rate. Used in Earned Value Management (EVM) calculations.',
    `equipment_availability_flag` BOOLEAN COMMENT 'Indicates whether all required equipment was available and operational during the production period. True if equipment was fully available; False if equipment shortages or breakdowns occurred.',
    `expended_hours` DECIMAL(18,2) COMMENT 'The actual labor hours expended by the crew to complete the work during this production period.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this production rate record was last updated or modified in the source system.',
    `material_availability_flag` BOOLEAN COMMENT 'Indicates whether all required materials were available on-site during the production period. True if materials were fully available; False if material shortages or delays occurred.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about the production activity, including any factors that affected productivity, lessons learned, or special circumstances.',
    `planned_production_rate` DECIMAL(18,2) COMMENT 'The estimated or target production rate (units per labor-hour) that was planned for this activity based on historical data or estimating standards.',
    `planned_quantity` DECIMAL(18,2) COMMENT 'The quantity of work planned or estimated to be completed during this production period, measured in the specified unit of measure.',
    `productivity_factor` DECIMAL(18,2) COMMENT 'The ratio of earned hours to expended hours, indicating crew efficiency. A value of 1.0 means work was completed at planned productivity; >1.0 indicates better than planned; <1.0 indicates below planned productivity.',
    `quality_inspection_status` STRING COMMENT 'The outcome of quality inspection for the work completed during this production period.. Valid values are `passed|failed|pending|not_required`',
    `recorded_by` STRING COMMENT 'Name or identifier of the person who recorded this production rate entry (typically a foreman, superintendent, or timekeeper).',
    `rework_flag` BOOLEAN COMMENT 'Indicates whether any portion of the work performed was rework or correction of previously completed work. True if rework was involved; False if all work was original installation.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether any safety incident occurred during this production period that may have impacted productivity. True if an incident occurred; False otherwise.',
    `shift` STRING COMMENT 'The shift during which the production work was performed.. Valid values are `day|night|swing|overtime`',
    `site_condition` STRING COMMENT 'The physical site condition or constraint that may have affected crew productivity during this production period.. Valid values are `normal|congested|restricted_access|hazardous|confined_space|underground`',
    `source_record_reference` STRING COMMENT 'The unique identifier of this production rate record in the source operational system, used for traceability and reconciliation.',
    `trade_category` STRING COMMENT 'The construction trade or craft category performing the work (e.g., concrete, carpentry, electrical, plumbing, steel erection, masonry). [ENUM-REF-CANDIDATE: concrete|carpentry|electrical|plumbing|steel_erection|masonry|hvac|painting|roofing|excavation — promote to reference product]',
    `unit_of_measure` STRING COMMENT 'The unit in which production quantity is measured. Common construction units: CY (Cubic Yard), LF (Linear Foot), SF (Square Foot), EA (Each), TON (Ton), CYD (Cubic Yard), SY (Square Yard), LBS (Pounds), GAL (Gallon), HR (Hour). [ENUM-REF-CANDIDATE: CY|LF|SF|EA|TON|CYD|SY|LBS|GAL|HR — 10 candidates stripped; promote to reference product]',
    `variance_hours` DECIMAL(18,2) COMMENT 'The difference between earned hours and expended hours (earned minus expended). Positive values indicate efficient performance; negative values indicate inefficient performance.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'The difference between actual quantity and planned quantity (actual minus planned). Positive values indicate over-performance; negative values indicate under-performance.',
    `weather_condition` STRING COMMENT 'The prevailing weather condition during the work period that may have impacted production rates. [ENUM-REF-CANDIDATE: clear|rain|snow|wind|extreme_heat|extreme_cold|fog — 7 candidates stripped; promote to reference product]',
    `work_date` DATE COMMENT 'The calendar date on which this production work was performed.',
    `work_difficulty_rating` STRING COMMENT 'Subjective assessment of the difficulty level of the work performed, used to contextualize production rate performance.. Valid values are `easy|normal|difficult|very_difficult`',
    CONSTRAINT pk_production_rate PRIMARY KEY(`production_rate_id`)
) COMMENT 'Transactional record capturing actual field production rates achieved by a crew on a specific activity, measured against planned/estimated production rates. Sourced from HCSS HeavyJob production tracking. Captures activity code, unit of measure (CY, LF, SF, EA, TON), planned quantity, actual quantity installed, earned hours, expended hours, and productivity factor. Enables historical productivity benchmarking for future estimates and real-time crew performance monitoring. Owned by workforce domain as it measures LABOR productivity — the output per labor-hour of a crew.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` (
    `staffing_plan_id` BIGINT COMMENT 'Primary key for staffing_plan',
    `agreement_id` BIGINT COMMENT 'Foreign key linking to contract.agreement. Business justification: REQUIRED: Staffing plans are approved per contract agreement for budgeting and compliance; linking ensures plan totals roll up to the correct agreement.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this staffing plan is defined.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Links staffing plan headcount to the cost center responsible for payroll budgeting, used in the Staffing Budget vs. Cost Center variance report.',
    `firm_profile_id` BIGINT COMMENT 'Foreign key linking to bid.firm_profile. Business justification: Staffing plan: associate planned headcount with subcontractor to forecast labor supply and contractual obligations.',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Connect staffing plan to skill_trade to capture required trade mix for planning.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element this staffing plan applies to, enabling phase-specific or activity-specific workforce planning.',
    `accommodation_required_flag` BOOLEAN COMMENT 'Indicates whether worker accommodation (camps, hotels, per diem) is required for this staffing plan, typically true for remote or large-scale projects.',
    `actual_headcount` STRING COMMENT 'Actual number of workers deployed as of the last reporting period, enabling planned vs. actual variance analysis.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Actual labor hours worked as of the last reporting period, supporting Earned Value Management (EVM) and productivity tracking.',
    `agency_headcount` STRING COMMENT 'Number of workers planned to be sourced through temporary staffing agencies or labor brokers.',
    `approval_date` DATE COMMENT 'Date on which this staffing plan was formally approved and authorized for execution.',
    `approved_by` STRING COMMENT 'Name or identifier of the project manager, PMO lead, or executive who approved this staffing plan.',
    `baseline_flag` BOOLEAN COMMENT 'Indicates whether this staffing plan is the approved baseline against which all future revisions and actuals will be compared.',
    `craft_labor_headcount` STRING COMMENT 'Number of skilled trade workers (carpenters, electricians, welders, masons, etc.) planned for the period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this staffing plan record was first created in the system.',
    `direct_hire_headcount` STRING COMMENT 'Number of workers planned to be sourced through direct employment by the general contractor or project owner.',
    `headcount_variance` STRING COMMENT 'Difference between planned and actual headcount (actual minus planned), indicating over- or under-staffing relative to the plan.',
    `labor_hours_variance` DECIMAL(18,2) COMMENT 'Difference between planned and actual labor hours (actual minus planned), supporting cost and schedule performance analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this staffing plan record was last updated, supporting audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional context, assumptions, constraints, or special instructions related to this staffing plan.',
    `peak_headcount` STRING COMMENT 'Maximum number of workers required at any single point during the planning period, critical for site logistics, accommodation, and safety planning.',
    `peak_headcount_date` DATE COMMENT 'Date on which the peak headcount is expected to occur, enabling targeted resource mobilization and site readiness planning.',
    `plan_name` STRING COMMENT 'Descriptive name of the staffing plan, often indicating the project phase, location, or scope (e.g., Foundation Phase Labor Plan, MEP Installation Crew Plan).',
    `plan_number` STRING COMMENT 'Business identifier for the staffing plan, typically a human-readable code used in project documentation and workforce planning meetings.',
    `plan_status` STRING COMMENT 'Current lifecycle status of the staffing plan indicating its approval state and operational validity.. Valid values are `draft|approved|active|superseded|cancelled|archived`',
    `plan_type` STRING COMMENT 'Classification of the staffing plan indicating its purpose (baseline for original plan, forecast for updated projections, scenario for what-if analysis).. Valid values are `baseline|forecast|revised|scenario|contingency`',
    `plan_version` STRING COMMENT 'Version identifier for the staffing plan, enabling tracking of plan revisions and baseline comparisons (e.g., V1.0, V2.1, Baseline, Revised).',
    `planning_period_end_date` DATE COMMENT 'End date of the time period covered by this staffing plan, defining the conclusion of the workforce deployment window.',
    `planning_period_start_date` DATE COMMENT 'Start date of the time period covered by this staffing plan, defining the beginning of the workforce deployment window.',
    `ramp_down_end_date` DATE COMMENT 'Date when workforce demobilization is complete, marking the end of the labor deployment for this plan.',
    `ramp_down_start_date` DATE COMMENT 'Date when workforce demobilization begins, marking the start of the labor reduction curve as project activities wind down.',
    `ramp_up_end_date` DATE COMMENT 'Date when workforce reaches full planned strength, marking the end of the mobilization phase.',
    `ramp_up_start_date` DATE COMMENT 'Date when workforce mobilization and ramp-up begins, marking the start of the labor deployment curve.',
    `site_access_requirements` STRING COMMENT 'Description of site access prerequisites for workers (security clearances, background checks, client-specific badging), critical for mobilization planning.',
    `skill_certification_requirements` STRING COMMENT 'Summary of mandatory certifications and qualifications required for workers in this staffing plan (e.g., OSHA 30, Confined Space, Rigging Level II), supporting compliance and safety planning.',
    `sourcing_strategy` STRING COMMENT 'Primary workforce sourcing approach for this staffing plan, defining how labor will be procured and managed.. Valid values are `direct_hire|subcontract|mixed|agency|joint_venture`',
    `subcontractor_headcount` STRING COMMENT 'Number of workers planned to be provided by subcontractors under contract to the general contractor.',
    `supervision_headcount` STRING COMMENT 'Number of supervisory personnel (foremen, superintendents, site managers) planned for the period.',
    `support_staff_headcount` STRING COMMENT 'Number of support personnel (site engineers, QA/QC inspectors, safety officers, administrative staff) planned for the period.',
    `total_planned_headcount` STRING COMMENT 'Total number of workers planned across all trades and roles for this staffing plan period, representing the aggregate workforce requirement.',
    `total_planned_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours planned across all workers and trades for the planning period, used for cost estimation and productivity forecasting.',
    `trade_mix_breakdown` STRING COMMENT 'Structured breakdown of planned headcount by trade category (e.g., Concrete:50|Steel:30|Electrical:25|Plumbing:20), supporting trade-specific procurement and scheduling.',
    `transportation_required_flag` BOOLEAN COMMENT 'Indicates whether worker transportation (buses, flights, shuttles) is required for this staffing plan, impacting mobilization logistics and costs.',
    CONSTRAINT pk_staffing_plan PRIMARY KEY(`staffing_plan_id`)
) COMMENT 'Master record for a project-level workforce staffing plan defining the planned headcount, trade mix, and labor hours required by project phase, WBS element, and time period. Captures planned vs. actual headcount, peak labor requirements, trade breakdown, source strategy (direct hire, subcontract, agency), ramp-up/ramp-down curves, and plan version. Supports workforce forecasting, labor procurement decisions, and project mobilization planning. Integrates with SAP SuccessFactors workforce planning.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` (
    `labor_agreement_id` BIGINT COMMENT 'Unique identifier for the labor agreement record. Primary key for the labor agreement entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Labor agreements are negotiated per client (owner) and must be tracked against the client account for legal and financial audit.',
    `construction_project_id` BIGINT COMMENT 'Reference to the specific construction project to which this labor agreement applies, if it is a project-specific PLA. Null for general agreements.',
    `hr_employee_id` BIGINT COMMENT 'Foreign key linking to hr.employee. Business justification: Contract compliance: a designated HR employee manages and signs off labor agreements for each project.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Associates each labor agreement with the cost center charging wages, needed for payroll cost accounting and compliance with union wage reporting.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the labor agreement indicating its operational state and enforceability. [ENUM-REF-CANDIDATE: draft|pending_approval|active|expired|terminated|superseded|under_negotiation — 7 candidates stripped; promote to reference product]',
    `agreement_type` STRING COMMENT 'Classification of the labor agreement indicating its nature and scope. Collective Bargaining Agreement (CBA) covers union-negotiated terms, Project Labor Agreement (PLA) applies to specific projects, prevailing wage determination sets minimum wage rates for public works.. Valid values are `collective_bargaining_agreement|project_labor_agreement|union_agreement|prevailing_wage_determination|master_labor_agreement|local_supplement`',
    `apprentice_ratio` STRING COMMENT 'Required ratio of apprentices to journeymen workers on projects covered by this labor agreement (e.g., 1:4 means one apprentice for every four journeymen).',
    `arbitration_required_flag` BOOLEAN COMMENT 'Indicates whether binding arbitration is required for dispute resolution under this labor agreement.',
    `base_wage_rate` DECIMAL(18,2) COMMENT 'Standard hourly wage rate for the base classification under this labor agreement, excluding overtime premiums and fringe benefits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this labor agreement record was first created in the system.',
    `double_time_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base wage rate for double-time hours, typically for work on Sundays or holidays (e.g., 2.0).',
    `double_time_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours worked per day after which double-time rates apply, or indicator for specific days (e.g., 12 hours per day, Sundays, holidays).',
    `effective_date` DATE COMMENT 'Date when the labor agreement becomes binding and enforceable.',
    `expiration_date` DATE COMMENT 'Date when the labor agreement terminates or expires. Null for open-ended agreements or those without a fixed end date.',
    `fringe_benefit_rate` DECIMAL(18,2) COMMENT 'Total hourly rate for fringe benefits including health insurance, pension, training, and other benefits as specified in the labor agreement.',
    `geographic_coverage` STRING COMMENT 'Description of the geographic area or region where this labor agreement is applicable (e.g., state, county, metropolitan area, or specific project site).',
    `grievance_procedure_description` STRING COMMENT 'Summary of the grievance and dispute resolution procedures established in the labor agreement.',
    `health_welfare_rate` DECIMAL(18,2) COMMENT 'Hourly contribution rate for health insurance and welfare benefits under this labor agreement.',
    `hiring_hall_required_flag` BOOLEAN COMMENT 'Indicates whether workers must be hired through the union hiring hall under this labor agreement.',
    `jurisdiction_type` STRING COMMENT 'Scope of coverage defining where and how the labor agreement applies (geographic region, specific project, or organizational scope). [ENUM-REF-CANDIDATE: geographic|project_specific|company_wide|multi_employer|national|regional|local — 7 candidates stripped; promote to reference product]',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this labor agreement record was last updated or modified in the system.',
    `multi_employer_agreement_flag` BOOLEAN COMMENT 'Indicates whether this is a multi-employer agreement covering multiple contractors or a single-employer agreement.',
    `no_strike_clause_flag` BOOLEAN COMMENT 'Indicates whether the labor agreement includes a no-strike clause prohibiting work stoppages during the agreement term.',
    `notes` STRING COMMENT 'Additional notes, comments, or special provisions related to this labor agreement.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base wage rate for overtime hours (e.g., 1.5 for time-and-a-half, 2.0 for double-time).',
    `overtime_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours worked per day or week after which overtime rates apply (e.g., 8 hours per day, 40 hours per week).',
    `pension_rate` DECIMAL(18,2) COMMENT 'Hourly contribution rate for pension or retirement benefits under this labor agreement.',
    `prevailing_wage_determination_number` STRING COMMENT 'Official determination number issued by the Department of Labor for prevailing wage rates applicable to this agreement, if applicable to public works projects.',
    `ratification_date` DATE COMMENT 'Date when the labor agreement was formally ratified or approved by the union membership and employer parties.',
    `reporting_pay_hours` DECIMAL(18,2) COMMENT 'Minimum number of hours guaranteed to be paid when a worker reports for work as scheduled.',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional hourly rate paid for work performed during non-standard shifts (e.g., night shift, swing shift).',
    `show_up_time_hours` DECIMAL(18,2) COMMENT 'Minimum number of hours guaranteed to be paid when a worker reports to the job site but cannot work due to weather or other conditions.',
    `signatory_employer_name` STRING COMMENT 'Name of the employer or employer association that is signatory to this labor agreement.',
    `trade_category` STRING COMMENT 'Primary craft or trade classification covered by this labor agreement (e.g., Carpenter, Electrician, Ironworker, Laborer, Operating Engineer, Pipefitter).',
    `training_fund_rate` DECIMAL(18,2) COMMENT 'Hourly contribution rate for apprenticeship and training programs under this labor agreement.',
    `travel_subsistence_rate` DECIMAL(18,2) COMMENT 'Daily or hourly allowance for travel expenses and subsistence when workers are required to work outside their normal jurisdiction.',
    `union_international_affiliation` STRING COMMENT 'Name of the international or national union body to which the local union is affiliated (e.g., AFL-CIO, International Brotherhood of Electrical Workers).',
    `union_local_number` STRING COMMENT 'Identifier for the union local chapter or branch that is party to this labor agreement.',
    `union_name` STRING COMMENT 'Full name of the labor union or trade organization that is party to this agreement.',
    `union_security_clause` STRING COMMENT 'Type of union security arrangement specified in the agreement governing union membership requirements for workers.. Valid values are `open_shop|union_shop|agency_shop|closed_shop|modified_union_shop`',
    `vacation_holiday_rate` DECIMAL(18,2) COMMENT 'Hourly contribution rate for vacation and holiday pay under this labor agreement.',
    `wage_rate_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all wage rates and monetary amounts in this agreement (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `wage_scale_document_reference` STRING COMMENT 'Reference to the detailed wage scale document or attachment that contains classification-specific wage rates and rules.',
    CONSTRAINT pk_labor_agreement PRIMARY KEY(`labor_agreement_id`)
) COMMENT 'Master record for collective bargaining agreements (CBAs), union agreements, project labor agreements (PLAs), and prevailing wage determinations governing craft labor on a project or region. Captures agreement type, union local, effective dates, wage scales by trade and classification, overtime rules, fringe benefit rates, and jurisdictional coverage. Distinct from commercial contracts owned by the contract domain.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`labor_rate` (
    `labor_rate_id` BIGINT COMMENT 'Unique identifier for the labor rate record. Primary key.',
    `account_id` BIGINT COMMENT 'Foreign key linking to client.account. Business justification: Rate tables are defined per client account to support project cost estimating and billing accuracy.',
    `construction_project_id` BIGINT COMMENT 'Reference to the construction project for which this labor rate applies. Nullable for enterprise-wide or agreement-level rates that are not project-specific.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Connects labor rate definitions to the cost center that applies the rates, supporting the Labor Rate Master report used in payroll processing.',
    `cost_code_id` BIGINT COMMENT 'Reference to the labor cost code that categorizes this rate for job costing and financial reporting. Links to the WBS (Work Breakdown Structure) and SAP cost elements.',
    `labor_agreement_id` BIGINT COMMENT 'Reference to the labor agreement or collective bargaining agreement under which this rate is defined. Links to union contracts, prevailing wage determinations, or project-specific labor agreements.',
    `labor_cost_code_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_cost_code. Business justification: Link labor_rate to labor_cost_code to associate each rate with its cost code definition, enabling removal of duplicate cost code attributes from labor_rate.',
    `apprentice_ratio` DECIMAL(18,2) COMMENT 'The maximum allowable ratio of apprentices to journeymen for this trade classification, as defined by union agreements or prevailing wage law (e.g., 1:3 means one apprentice per three journeymen). Nullable if not applicable.',
    `base_hourly_rate` DECIMAL(18,2) COMMENT 'The straight-time hourly wage rate paid to the worker for regular hours (typically up to 8 hours per day or 40 hours per week). Excludes fringe benefits and burden.',
    `certified_payroll_required_flag` BOOLEAN COMMENT 'Indicates whether this rate is subject to certified payroll reporting requirements under prevailing wage law (True) or not (False). Used to trigger compliance workflows in HCSS HeavyJob and Viewpoint Vista.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this labor rate record was first created in the source system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (e.g., USD, CAD, EUR, GBP). Required for multi-currency projects and international joint ventures.. Valid values are `^[A-Z]{3}$`',
    `double_time_hourly_rate` DECIMAL(18,2) COMMENT 'The hourly wage rate for double-time hours, typically 2.0x the base rate for hours worked on Sundays, holidays, or beyond a threshold (e.g., over 12 hours per day). Nullable if not applicable.',
    `effective_end_date` DATE COMMENT 'The date on which this labor rate expires or is superseded. Nullable for open-ended rates. Used to manage rate changes and contract renewals.',
    `effective_start_date` DATE COMMENT 'The date from which this labor rate becomes effective. Used for rate escalation tracking and historical cost analysis.',
    `escalation_clause` STRING COMMENT 'Description of any contractual escalation provisions that adjust this rate over time (e.g., annual CPI adjustment, fixed percentage increase, renegotiation trigger). Nullable if no escalation applies.',
    `fringe_benefit_rate` DECIMAL(18,2) COMMENT 'The hourly cost of fringe benefits (health insurance, pension, vacation, training funds, etc.) as defined by the labor agreement or prevailing wage determination. Added to base wage to calculate total compensation.',
    `jurisdiction` STRING COMMENT 'The geographic or contractual jurisdiction where this rate applies (e.g., Cook County IL, State of California, Federal Davis-Bacon). Used to enforce prevailing wage compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this labor rate record was last modified in the source system. Used for incremental data refresh and audit trail.',
    `notes` STRING COMMENT 'Free-text field for additional context, special conditions, or clarifications regarding this labor rate (e.g., project-specific adjustments, negotiated exceptions, compliance notes).',
    `overhead_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to cover indirect costs and general overhead (field supervision, small tools, consumables, field office, etc.). Used in bid pricing and Guaranteed Maximum Price (GMP) calculations. Nullable if not applicable.',
    `overtime_hourly_rate` DECIMAL(18,2) COMMENT 'The hourly wage rate for overtime hours, typically 1.5x the base rate for hours beyond 8 per day or 40 per week, as defined by labor agreements or prevailing wage law.',
    `payroll_burden_percentage` DECIMAL(18,2) COMMENT 'The percentage markup applied to gross wages to cover employer-paid payroll taxes (FICA, FUTA, SUTA, workers compensation insurance, general liability insurance). Expressed as a percentage (e.g., 35.50 for 35.5%).',
    `per_diem_rate` DECIMAL(18,2) COMMENT 'Daily per diem allowance for meals and incidental expenses when workers are mobilized away from their home location. Nullable if not applicable. Used in labor mobilization cost calculations.',
    `prevailing_wage_determination_number` STRING COMMENT 'The official reference number of the government-issued prevailing wage determination (e.g., Davis-Bacon wage decision number) that mandates this rate. Nullable for non-prevailing-wage projects.',
    `profit_margin_percentage` DECIMAL(18,2) COMMENT 'The profit margin percentage applied to the fully burdened labor cost for bid pricing. Used in EPC (Engineering, Procurement, and Construction) and GMP (Guaranteed Maximum Price) contracts. Nullable if not applicable.',
    `rate_code` STRING COMMENT 'Business identifier for the labor rate. Typically a concatenation of trade classification, skill level, and agreement reference used in estimating and job costing systems.',
    `rate_status` STRING COMMENT 'Current lifecycle status of the labor rate record. Active rates are used in cost estimation and job costing. Expired or superseded rates are retained for historical cost analysis and audit trails.. Valid values are `active|pending|expired|superseded|suspended`',
    `rate_type` STRING COMMENT 'Classification of the rate basis: union (collective bargaining agreement), prevailing_wage (government-mandated), open_shop (non-union competitive), project_specific (negotiated for a single project), or market_rate (regional benchmark).. Valid values are `union|prevailing_wage|open_shop|project_specific|market_rate`',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional hourly premium paid for non-standard shifts (e.g., night shift, swing shift). Nullable if not applicable. Used in 24/7 operations and accelerated project schedules.',
    `skill_level` STRING COMMENT 'The skill or seniority level within the trade classification. Determines the applicable wage scale and supervisory responsibility.. Valid values are `apprentice|journeyman|foreman|general_foreman|superintendent`',
    `source_system_code` STRING COMMENT 'The unique identifier of this labor rate record in the source operational system. Used for traceability and incremental data synchronization.',
    `subsistence_rate` DECIMAL(18,2) COMMENT 'Daily subsistence allowance for lodging and living expenses when workers are required to stay overnight away from home. Nullable if not applicable. Used in remote project cost planning.',
    `total_loaded_hourly_rate` DECIMAL(18,2) COMMENT 'The all-in hourly cost including base wage, fringe benefits, payroll burden, overhead, and profit. This is the rate used for project cost estimation, Bill of Quantities (BOQ) pricing, and Earned Value Management (EVM) calculations.',
    `trade_classification` STRING COMMENT 'The craft or trade classification for which this rate applies (e.g., Carpenter, Electrician, Pipefitter, Ironworker, Heavy Equipment Operator, Laborer). Aligns with union jurisdictions and prevailing wage schedules.',
    `travel_zone` STRING COMMENT 'The geographic travel zone or radius from the union hall or home base that determines eligibility for travel pay, per diem, and subsistence. Nullable if not applicable.',
    `union_local` STRING COMMENT 'The union local or labor organization that governs this rate (e.g., IBEW Local 134, Carpenters Local 1). Nullable for non-union or open-shop rates.',
    CONSTRAINT pk_labor_rate PRIMARY KEY(`labor_rate_id`)
) COMMENT 'Reference record defining the all-in labor rates (base wage, fringe benefits, burden, overhead) for each trade classification under a specific labor agreement or project. Captures trade classification, effective date range, straight-time rate, overtime rate, double-time rate, fringe benefit rate, payroll burden percentage, and total loaded rate. Used for project cost estimation, bid pricing (BOQ), and job cost control.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` (
    `agency_labor_order_id` BIGINT COMMENT 'Unique identifier for the agency labor order record.',
    `agency_id` BIGINT COMMENT 'Identifier of the labor hire agency or staffing firm supplying the workers.',
    `construction_project_id` BIGINT COMMENT 'Identifier of the construction project for which the agency labor is requested.',
    `cost_code_id` BIGINT COMMENT 'Identifier of the cost code for labor cost allocation and tracking.',
    `hr_employee_id` BIGINT COMMENT 'Identifier of the user or project manager who requested the agency labor order.',
    `skill_trade_id` BIGINT COMMENT 'Foreign key linking to workforce.skill_trade. Business justification: Reference standardized skill_trade for trade classification, removing free-text trade_classification column.',
    `wbs_element_id` BIGINT COMMENT 'Identifier of the WBS element to which the agency labor cost will be charged.',
    `actual_end_date` DATE COMMENT 'Actual date when the agency workers assignment concluded.',
    `actual_start_date` DATE COMMENT 'Actual date when the agency workers commenced work on the project.',
    `approval_date` DATE COMMENT 'Date when the agency labor order was approved.',
    `bill_rate` DECIMAL(18,2) COMMENT 'Hourly billing rate charged by the agency per worker.',
    `cancellation_date` DATE COMMENT 'Date when the agency labor order was cancelled.',
    `cancellation_reason` STRING COMMENT 'Reason or explanation for the cancellation of the agency labor order.',
    `craft_code` STRING COMMENT 'Standardized code representing the craft discipline requested.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agency labor order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the bill rate and pay rate.. Valid values are `^[A-Z]{3}$`',
    `estimated_end_date` DATE COMMENT 'Estimated date when the agency workers assignment is expected to conclude.',
    `fulfillment_date` DATE COMMENT 'Date when the agency completed fulfillment of the order by supplying the requested workers.',
    `hse_orientation_required_flag` BOOLEAN COMMENT 'Indicates whether HSE site orientation is required for the agency workers before starting work.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the agency labor order record was last modified or updated.',
    `markup_percentage` DECIMAL(18,2) COMMENT 'Agency markup percentage applied on top of the pay rate to arrive at the bill rate.',
    `notes` STRING COMMENT 'General notes or comments related to the agency labor order.',
    `order_date` DATE COMMENT 'Date when the agency labor order was placed or submitted to the agency.',
    `order_number` STRING COMMENT 'Externally-known unique reference number for the agency labor order.',
    `order_status` STRING COMMENT 'Current lifecycle status of the agency labor order. [ENUM-REF-CANDIDATE: draft|submitted|approved|in_fulfillment|fulfilled|partially_fulfilled|cancelled|closed — promote to reference product]',
    `pay_rate` DECIMAL(18,2) COMMENT 'Hourly pay rate paid to the agency worker.',
    `po_number` STRING COMMENT 'Purchase order number issued to the agency for this labor order.',
    `ppe_requirements` STRING COMMENT 'Description of PPE required for the agency workers on this assignment.',
    `required_certifications` STRING COMMENT 'Comma-separated list of certifications or qualifications required for the agency workers (e.g., OSHA 30, rigging certification, confined space).',
    `required_start_date` DATE COMMENT 'Date by which the agency workers are required to begin work on the project.',
    `site_access_clearance_required_flag` BOOLEAN COMMENT 'Indicates whether site access clearance or background check is required for the agency workers.',
    `skill_level` STRING COMMENT 'Required skill or experience level for the requested workers.. Valid values are `apprentice|journeyman|foreman|master|helper`',
    `special_requirements` STRING COMMENT 'Additional special requirements or instructions for the agency workers (e.g., language skills, equipment operation, shift preferences).',
    `union_affiliation_required_flag` BOOLEAN COMMENT 'Indicates whether the agency workers must be affiliated with a specific union or labor organization.',
    `union_local` STRING COMMENT 'Union local chapter or jurisdiction required for the agency workers.',
    `workers_fulfilled_quantity` STRING COMMENT 'Actual number of workers supplied by the agency to fulfill this order.',
    `workers_requested_quantity` STRING COMMENT 'Number of workers requested from the agency for this order.',
    CONSTRAINT pk_agency_labor_order PRIMARY KEY(`agency_labor_order_id`)
) COMMENT 'Transactional record for a request placed with a labor hire agency or staffing firm to supply craft workers for a project. Captures agency identity, trade classification requested, number of workers, required qualifications, required start date, project and site, bill rate, markup percentage, PO reference, fulfillment status, and workers actually supplied. Tracks the full lifecycle from request through fulfillment. Distinct from subcontractor work orders — covers temporary staffing arrangements where workers report to the GCs supervision.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` (
    `apprenticeship_progression_id` BIGINT COMMENT 'Unique surrogate key for each apprenticeship progression record.',
    `craft_worker_id` BIGINT COMMENT 'Identifier of the craft worker to whom this apprenticeship record belongs.',
    `prior_apprenticeship_progression_id` BIGINT COMMENT 'Self-referencing FK on apprenticeship_progression (prior_apprenticeship_progression_id)',
    `actual_journeyman_completion_date` DATE COMMENT 'Date the apprentice actually attained journeyman status, if applicable.',
    `apprentice_to_journeyman_ratio` DECIMAL(18,2) COMMENT 'Ratio of apprentices to journeymen required for prevailing‑wage project compliance.',
    `apprenticeship_end_date` DATE COMMENT 'Scheduled or actual end date of the apprenticeship (nullable if ongoing).',
    `apprenticeship_hours_required` DECIMAL(18,2) COMMENT 'Total OJT hours required to complete the apprenticeship.',
    `apprenticeship_level` STRING COMMENT 'Current apprenticeship level or period (e.g., Level 1, Year 2, Journeyman Candidate).',
    `apprenticeship_period` STRING COMMENT 'Designated period within the apprenticeship program (e.g., "Year 1", "Quarter 3").',
    `apprenticeship_program_code` STRING COMMENT 'Standard code identifying the apprenticeship program (e.g., NCCER, JATC, state program).',
    `apprenticeship_program_name` STRING COMMENT 'Human‑readable name of the apprenticeship program.',
    `apprenticeship_start_date` DATE COMMENT 'Date the worker entered the apprenticeship program.',
    `apprenticeship_status` STRING COMMENT 'Current lifecycle status of the apprenticeship record.. Valid values are `active|completed|terminated|suspended|pending`',
    `apprenticeship_status_reason` STRING COMMENT 'Free‑text explanation for the current status (e.g., "suspended due to safety violation").',
    `apprenticeship_type` STRING COMMENT 'Classification of the apprenticeship program (union‑sponsored, state‑registered, private, or company‑run).. Valid values are `union|state|private|company`',
    `certification_earned_date` DATE COMMENT 'Date the required certification was awarded.',
    `certification_earned_flag` BOOLEAN COMMENT 'True if the apprentice has earned the required certification for the trade.',
    `compliance_check_date` DATE COMMENT 'Date of the most recent compliance verification.',
    `compliance_status` STRING COMMENT 'Overall compliance status of the apprenticeship record with DOL and state requirements.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the apprenticeship progression record was first created.',
    `dol_compliance_flag` BOOLEAN COMMENT 'True if the apprenticeship meets all Department of Labor requirements.',
    `expected_journeyman_completion_date` DATE COMMENT 'Projected date when the apprentice is expected to achieve journeyman status.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to any field in the record.',
    `last_status_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent change to apprenticeship_status.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations about the apprenticeship.',
    `ojt_hours_accumulated` DECIMAL(18,2) COMMENT 'Total OJT hours the worker has logged toward the required apprenticeship hours.',
    `prevailing_wage_classification` STRING COMMENT 'Classification used for prevailing‑wage calculations (e.g., "Skilled Craft").',
    `record_version` STRING COMMENT 'Incremental version number for optimistic concurrency control.',
    `sponsoring_jatc` STRING COMMENT 'Name or identifier of the Joint Apprenticeship Training Committee sponsoring the apprenticeship.',
    `state_apprenticeship_compliance_flag` BOOLEAN COMMENT 'True if the apprenticeship complies with the applicable state apprenticeship agency rules.',
    `technical_instruction_hours` DECIMAL(18,2) COMMENT 'Cumulative classroom or online instruction hours completed for the apprenticeship.',
    `technical_instruction_hours_required` DECIMAL(18,2) COMMENT 'Total classroom or online instruction hours required for the apprenticeship.',
    `training_provider` STRING COMMENT 'Organization that delivered the technical instruction hours.',
    `union_local` STRING COMMENT 'Union local identifier associated with the apprentice, if applicable.',
    `wage_progression_effective_date` DATE COMMENT 'Date when the current wage progression step became effective.',
    `wage_progression_step` STRING COMMENT 'Current step in the wage progression schedule for the apprentice.',
    `wage_step` STRING COMMENT 'Current wage step associated with the apprentices progression.',
    CONSTRAINT pk_apprenticeship_progression PRIMARY KEY(`apprenticeship_progression_id`)
) COMMENT 'Transactional record tracking a craft workers progression through a registered apprenticeship program (NCCER, union JATC, or state-registered). Captures current apprenticeship level/period, accumulated OJT (On-the-Job Training) hours by trade, related technical instruction hours completed, wage progression step, sponsoring JATC (Joint Apprenticeship Training Committee), expected journey-level completion date, and compliance status with DOL (Department of Labor) or state apprenticeship agency requirements. Supports Davis-Bacon Act apprentice-to-journeyman ratio compliance, certified payroll reporting of apprentice classifications, and union reporting of hours toward journeyman upgrade. Critical for contractors participating in federal/state prevailing wage projects where apprentice utilization ratios are audited.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` (
    `carbon_reduction_participation_id` BIGINT COMMENT 'Primary key for the carbon_reduction_participation association',
    `carbon_reduction_initiative_id` BIGINT COMMENT 'Foreign key linking to the carbon reduction initiative',
    `construction_project_id` BIGINT COMMENT 'add column construction_project_id (BIGINT) with FK to project.construction_project.construction_project_id - participation records are project-scoped',
    `craft_worker_id` BIGINT COMMENT 'Foreign key linking to the craft worker',
    `crew_id` BIGINT COMMENT '',
    `activity_type` STRING COMMENT '',
    `carbon_saved_kg` DECIMAL(18,2) COMMENT '',
    `completion_date` DATE COMMENT '',
    `contribution_description` STRING COMMENT '',
    `contribution_notes` STRING COMMENT '',
    `created_timestamp` TIMESTAMP COMMENT '',
    `currency_code` STRING COMMENT '',
    `end_date` DATE COMMENT 'Date when the craft worker ended participation in the initiative',
    `enrollment_date` DATE COMMENT '',
    `estimated_carbon_saved_kg` DECIMAL(18,2) COMMENT '',
    `estimated_carbon_saving_kgco2e` DECIMAL(18,2) COMMENT 'Estimated carbon savings attributed to the worker.',
    `hours_contributed` DECIMAL(18,2) COMMENT 'Number of labor hours the craft worker contributed to the initiative',
    `incentive_amount` DECIMAL(18,2) COMMENT '',
    `initiative_role` STRING COMMENT '',
    `participation_date` DATE COMMENT '',
    `participation_role` STRING COMMENT 'The role of the craft worker within the initiative (e.g., installer, supervisor)',
    `participation_status` STRING COMMENT '',
    `recognition_awarded` BOOLEAN COMMENT '',
    `remarks` STRING COMMENT '',
    `start_date` DATE COMMENT 'Date when the craft worker started participation in the initiative',
    `training_completed` BOOLEAN COMMENT '',
    `training_completion_date` DATE COMMENT '',
    `updated_timestamp` TIMESTAMP COMMENT '',
    `verification_status` STRING COMMENT '',
    `verified_flag` BOOLEAN COMMENT '',
    CONSTRAINT pk_carbon_reduction_participation PRIMARY KEY(`carbon_reduction_participation_id`)
) COMMENT 'Represents the participation of a craft worker in a carbon reduction initiative, capturing the role, hours contributed, and the period of involvement. Each record links one craft worker to one initiative.. Existence Justification: Craft workers can be assigned to multiple carbon reduction initiatives, and each initiative can involve many craft workers. The organization actively records each workers participation role, hours contributed, and the start/end dates of the involvement for compliance and reporting purposes.';

CREATE OR REPLACE TABLE `vibe_construction_v1`.`workforce`.`agency` (
    `agency_id` BIGINT COMMENT 'Primary key for agency',
    `account_id` BIGINT COMMENT 'add column account_id (BIGINT) with FK to client.account.account_id - labor agencies are organizations and should anchor to the account master',
    `parent_agency_id` BIGINT COMMENT 'Self-referencing FK on agency (parent_agency_id)',
    `address_line1` STRING COMMENT 'Primary street address of the agency.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `agency_status` STRING COMMENT 'Current operational status of the agency.',
    `agency_type` STRING COMMENT 'Category describing the primary function of the agency.',
    `bank_account_number` STRING COMMENT 'Bank account number for payments to the agency.',
    `bank_routing_number` STRING COMMENT 'Routing number associated with the agencys bank account.',
    `bonding_amount` DECIMAL(18,2) COMMENT 'Bond amount provided by the agency for project guarantees.',
    `city` STRING COMMENT 'City where the agency is located.',
    `classification` STRING COMMENT 'Indicates whether the agency is internal to the organization or an external partner.',
    `agency_code` STRING COMMENT 'Business code or abbreviation used internally to identify the agency.',
    `compliance_status` STRING COMMENT 'Current compliance standing of the agency with regulatory requirements.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the agency operates.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the agency record was first created.',
    `default_currency` STRING COMMENT 'Currency used for transactions with the agency.',
    `effective_from` DATE COMMENT 'Date when the agency relationship becomes effective.',
    `effective_until` DATE COMMENT 'Date when the agency relationship ends or is scheduled to end (null if open‑ended).',
    `email_address` STRING COMMENT 'Primary email address for agency communications.',
    `insurance_coverage_amount` DECIMAL(18,2) COMMENT 'Maximum amount covered by the agencys liability insurance.',
    `last_audit_date` DATE COMMENT 'Date of the most recent compliance or financial audit of the agency.',
    `legal_name` STRING COMMENT 'Full legal name of the agency as registered with authorities.',
    `license_expiry` DATE COMMENT 'Expiration date of the agencys license.',
    `license_number` STRING COMMENT 'Official license number issued to the agency.',
    `agency_name` STRING COMMENT 'Common name used to reference the agency.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the agency.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed with the agency.',
    `phone_number` STRING COMMENT 'Primary telephone number for the agency.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the agency address.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact.',
    `primary_contact_name` STRING COMMENT 'Name of the main point‑of‑contact at the agency.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact.',
    `rating` STRING COMMENT 'Internal rating (1‑5) reflecting agency performance and reliability.',
    `safety_certification` STRING COMMENT 'Safety certification held by the agency.',
    `state_province` STRING COMMENT 'State or province of the agencys address.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the agency is exempt from tax reporting.',
    `tax_number` STRING COMMENT 'Government‑issued tax identification number for the agency.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the agency record.',
    `website_url` STRING COMMENT 'Public website URL of the agency.',
    CONSTRAINT pk_agency PRIMARY KEY(`agency_id`)
) COMMENT 'Master reference table for agency. Referenced by agency_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ADD CONSTRAINT `fk_workforce_craft_worker_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ADD CONSTRAINT `fk_workforce_crew_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ADD CONSTRAINT `fk_workforce_timesheet_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ADD CONSTRAINT `fk_workforce_timesheet_line_timesheet_id` FOREIGN KEY (`timesheet_id`) REFERENCES `vibe_construction_v1`.`workforce`.`timesheet`(`timesheet_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ADD CONSTRAINT `fk_workforce_labor_cost_code_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ADD CONSTRAINT `fk_workforce_craft_certification_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ADD CONSTRAINT `fk_workforce_craft_certification_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ADD CONSTRAINT `fk_workforce_site_access_record_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ADD CONSTRAINT `fk_workforce_labor_mobilization_crew_assignment_id` FOREIGN KEY (`crew_assignment_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew_assignment`(`crew_assignment_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ADD CONSTRAINT `fk_workforce_production_rate_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ADD CONSTRAINT `fk_workforce_production_rate_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ADD CONSTRAINT `fk_workforce_staffing_plan_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_labor_agreement_id` FOREIGN KEY (`labor_agreement_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_agreement`(`labor_agreement_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_labor_cost_code_id` FOREIGN KEY (`labor_cost_code_id`) REFERENCES `vibe_construction_v1`.`workforce`.`labor_cost_code`(`labor_cost_code_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ADD CONSTRAINT `fk_workforce_agency_labor_order_agency_id` FOREIGN KEY (`agency_id`) REFERENCES `vibe_construction_v1`.`workforce`.`agency`(`agency_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ADD CONSTRAINT `fk_workforce_agency_labor_order_skill_trade_id` FOREIGN KEY (`skill_trade_id`) REFERENCES `vibe_construction_v1`.`workforce`.`skill_trade`(`skill_trade_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ADD CONSTRAINT `fk_workforce_apprenticeship_progression_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ADD CONSTRAINT `fk_workforce_apprenticeship_progression_prior_apprenticeship_progression_id` FOREIGN KEY (`prior_apprenticeship_progression_id`) REFERENCES `vibe_construction_v1`.`workforce`.`apprenticeship_progression`(`apprenticeship_progression_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ADD CONSTRAINT `fk_workforce_carbon_reduction_participation_craft_worker_id` FOREIGN KEY (`craft_worker_id`) REFERENCES `vibe_construction_v1`.`workforce`.`craft_worker`(`craft_worker_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ADD CONSTRAINT `fk_workforce_carbon_reduction_participation_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_construction_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ADD CONSTRAINT `fk_workforce_agency_parent_agency_id` FOREIGN KEY (`parent_agency_id`) REFERENCES `vibe_construction_v1`.`workforce`.`agency`(`agency_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_construction_v1`.`workforce` SET TAGS ('pii_division' = 'operations');
ALTER SCHEMA `vibe_construction_v1`.`workforce` SET TAGS ('pii_domain' = 'workforce');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` SET TAGS ('pii_subdomain' = 'field_personnel');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Craft Worker ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Home Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `party_id` SET TAGS ('pii_business_glossary_term' = 'Contract Party Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `skill_trade_id` SET TAGS ('pii_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `vendor_id` SET TAGS ('pii_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `craft_code` SET TAGS ('pii_business_glossary_term' = 'Craft Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `craft_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,8}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `demobilization_date` SET TAGS ('pii_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `email_address` SET TAGS ('pii_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('pii_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `employment_type` SET TAGS ('pii_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `employment_type` SET TAGS ('pii_value_regex' = 'direct_hire|agency|union_referral|subcontractor');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `first_name` SET TAGS ('pii_business_glossary_term' = 'First Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `first_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `first_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `hire_date` SET TAGS ('pii_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `hourly_base_rate` SET TAGS ('pii_business_glossary_term' = 'Hourly Base Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `hourly_base_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `last_name` SET TAGS ('pii_business_glossary_term' = 'Last Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `last_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `last_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `middle_name` SET TAGS ('pii_business_glossary_term' = 'Middle Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `middle_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `middle_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `mobilization_date` SET TAGS ('pii_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `mobilization_status` SET TAGS ('pii_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `mobilization_status` SET TAGS ('pii_value_regex' = 'mobilized|demobilized|on_leave|available');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `osha_certification_expiry_date` SET TAGS ('pii_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Certification Expiry Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `osha_certification_flag` SET TAGS ('pii_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Certification Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `overtime_rate_multiplier` SET TAGS ('pii_business_glossary_term' = 'Overtime Rate Multiplier');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `ppe_size_boots` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Size Boots');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `ppe_size_pants` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Size Pants');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `ppe_size_shirt` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Size Shirt');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `secondary_trade_code` SET TAGS ('pii_business_glossary_term' = 'Secondary Trade Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `secondary_trade_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `security_clearance_level` SET TAGS ('pii_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `security_clearance_level` SET TAGS ('pii_value_regex' = 'none|basic|confidential|secret|top_secret');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `site_access_badge_number` SET TAGS ('pii_business_glossary_term' = 'Site Access Badge Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `site_access_badge_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{6,15}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `site_access_badge_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `site_access_badge_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `skill_level` SET TAGS ('pii_business_glossary_term' = 'Skill Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `skill_level` SET TAGS ('pii_value_regex' = 'apprentice|journeyman|master|foreman');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `supervisory_role_flag` SET TAGS ('pii_business_glossary_term' = 'Supervisory Role Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `supervisory_title` SET TAGS ('pii_business_glossary_term' = 'Supervisory Title');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `termination_date` SET TAGS ('pii_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `union_affiliation_flag` SET TAGS ('pii_business_glossary_term' = 'Union Affiliation Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `union_local_number` SET TAGS ('pii_business_glossary_term' = 'Union Local Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `union_local_number` SET TAGS ('pii_value_regex' = '^[0-9]{1,6}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `union_name` SET TAGS ('pii_business_glossary_term' = 'Union Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `worker_status` SET TAGS ('pii_business_glossary_term' = 'Worker Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `worker_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|terminated');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_worker` ALTER COLUMN `years_of_experience` SET TAGS ('pii_business_glossary_term' = 'Years of Experience');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` SET TAGS ('pii_subdomain' = 'field_personnel');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` SET TAGS ('pii_industry' = 'construction');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Assigned Asset Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Foreman ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Supervisor Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `average_hourly_rate` SET TAGS ('pii_business_glossary_term' = 'Average Hourly Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `average_hourly_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_code` SET TAGS ('pii_business_glossary_term' = 'Crew Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_status` SET TAGS ('pii_business_glossary_term' = 'Crew Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_status` SET TAGS ('pii_value_regex' = 'active|inactive|mobilizing|demobilizing|standby|disbanded');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_type` SET TAGS ('pii_business_glossary_term' = 'Crew Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `days_since_last_incident` SET TAGS ('pii_business_glossary_term' = 'Days Since Last Incident');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `demobilization_date` SET TAGS ('pii_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `home_location` SET TAGS ('pii_business_glossary_term' = 'Home Location');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `is_union_crew` SET TAGS ('pii_business_glossary_term' = 'Is Union Crew');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `last_safety_incident_date` SET TAGS ('pii_business_glossary_term' = 'Last Safety Incident Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `mobilization_date` SET TAGS ('pii_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `modified_by` SET TAGS ('pii_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `crew_name` SET TAGS ('pii_business_glossary_term' = 'Crew Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `planned_crew_size` SET TAGS ('pii_business_glossary_term' = 'Planned Crew Size');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `productivity_rate` SET TAGS ('pii_business_glossary_term' = 'Productivity Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `productivity_uom` SET TAGS ('pii_business_glossary_term' = 'Productivity Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `quality_rating` SET TAGS ('pii_business_glossary_term' = 'Quality Rating');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `quality_rating` SET TAGS ('pii_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `required_certifications` SET TAGS ('pii_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `safety_rating` SET TAGS ('pii_business_glossary_term' = 'Safety Rating');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `safety_rating` SET TAGS ('pii_value_regex' = 'excellent|good|satisfactory|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `shift_end_time` SET TAGS ('pii_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `shift_start_time` SET TAGS ('pii_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `shift_type` SET TAGS ('pii_value_regex' = 'day|night|swing|rotating|extended');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `size` SET TAGS ('pii_business_glossary_term' = 'Crew Size');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew` ALTER COLUMN `union_affiliation` SET TAGS ('pii_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` SET TAGS ('pii_subdomain' = 'field_personnel');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `crew_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Crew Assignment Identifier');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('pii_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('pii_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_number` SET TAGS ('pii_business_glossary_term' = 'Assignment Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_reason` SET TAGS ('pii_business_glossary_term' = 'Assignment Reason');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('pii_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_status` SET TAGS ('pii_value_regex' = 'active|inactive|suspended|completed|terminated');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_type` SET TAGS ('pii_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `assignment_type` SET TAGS ('pii_value_regex' = 'permanent|temporary|seasonal|project_based');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `billable_flag` SET TAGS ('pii_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `craft_type` SET TAGS ('pii_business_glossary_term' = 'Craft Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `crew_role` SET TAGS ('pii_business_glossary_term' = 'Crew Role');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `crew_role` SET TAGS ('pii_value_regex' = 'laborer|operator|foreman|lead|journeyman|apprentice');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `demobilization_date` SET TAGS ('pii_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `hse_orientation_completed_flag` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Orientation Completed Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `hse_orientation_date` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Orientation Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `labor_rate` SET TAGS ('pii_business_glossary_term' = 'Labor Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `labor_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `labor_rate_currency` SET TAGS ('pii_business_glossary_term' = 'Labor Rate Currency');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `labor_rate_currency` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `mobilization_date` SET TAGS ('pii_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `per_diem_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Per Diem Eligible Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('pii_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `per_diem_rate` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `planned_end_date` SET TAGS ('pii_business_glossary_term' = 'Planned End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `planned_start_date` SET TAGS ('pii_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `ppe_issued_flag` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Issued Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `shift_type` SET TAGS ('pii_value_regex' = 'day|night|swing|rotating');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `site_access_badge_number` SET TAGS ('pii_business_glossary_term' = 'Site Access Badge Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `site_access_badge_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `site_access_badge_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `termination_reason` SET TAGS ('pii_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `union_affiliation` SET TAGS ('pii_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `union_local_number` SET TAGS ('pii_business_glossary_term' = 'Union Local Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`crew_assignment` ALTER COLUMN `work_location` SET TAGS ('pii_business_glossary_term' = 'Work Location');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` SET TAGS ('pii_subdomain' = 'labor_tracking');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `timesheet_id` SET TAGS ('pii_business_glossary_term' = 'Timesheet ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `labor_rate_id` SET TAGS ('pii_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|pending_review');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By User');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `craft_classification` SET TAGS ('pii_business_glossary_term' = 'Craft Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `craft_classification` SET TAGS ('pii_value_regex' = 'carpenter|electrician|plumber|welder|ironworker|laborer');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `double_time_hours` SET TAGS ('pii_business_glossary_term' = 'Double Time Hours Worked');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `equipment_operated` SET TAGS ('pii_business_glossary_term' = 'Equipment Operated');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `is_billable` SET TAGS ('pii_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `labor_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `labor_cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `location_code` SET TAGS ('pii_business_glossary_term' = 'Work Location Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Timesheet Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `overtime_hours` SET TAGS ('pii_business_glossary_term' = 'Overtime (OT) Hours Worked');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `pay_type` SET TAGS ('pii_business_glossary_term' = 'Pay Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `pay_type` SET TAGS ('pii_value_regex' = 'hourly|salary|per_diem|piece_rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `payroll_period` SET TAGS ('pii_business_glossary_term' = 'Payroll Period');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `production_quantity` SET TAGS ('pii_business_glossary_term' = 'Production Quantity');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `production_unit` SET TAGS ('pii_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `regular_hours` SET TAGS ('pii_business_glossary_term' = 'Regular Hours Worked');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `rejection_reason` SET TAGS ('pii_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `shift_type` SET TAGS ('pii_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `shift_type` SET TAGS ('pii_value_regex' = 'day|night|swing|rotating');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `submitted_timestamp` SET TAGS ('pii_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `total_hours` SET TAGS ('pii_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `union_local` SET TAGS ('pii_business_glossary_term' = 'Union Local Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `weather_condition` SET TAGS ('pii_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `weather_condition` SET TAGS ('pii_value_regex' = 'clear|rain|snow|extreme_heat|extreme_cold|wind');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `work_classification` SET TAGS ('pii_business_glossary_term' = 'Work Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `work_classification` SET TAGS ('pii_value_regex' = 'productive|non_productive|rework|standby|travel');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `work_date` SET TAGS ('pii_business_glossary_term' = 'Work Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet` ALTER COLUMN `work_order_number` SET TAGS ('pii_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` SET TAGS ('pii_subdomain' = 'labor_tracking');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `timesheet_line_id` SET TAGS ('pii_business_glossary_term' = 'Timesheet Line ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `activity_id` SET TAGS ('pii_business_glossary_term' = 'Activity ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `asset_id` SET TAGS ('pii_business_glossary_term' = 'Equipment ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `labor_rate_id` SET TAGS ('pii_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `timesheet_id` SET TAGS ('pii_business_glossary_term' = 'Timesheet Header ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `approval_status` SET TAGS ('pii_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `approval_status` SET TAGS ('pii_value_regex' = 'draft|submitted|approved|rejected|posted');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `approved_timestamp` SET TAGS ('pii_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `craft_code` SET TAGS ('pii_business_glossary_term' = 'Craft Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `craft_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `double_time_hours` SET TAGS ('pii_business_glossary_term' = 'Double Time Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `is_billable` SET TAGS ('pii_business_glossary_term' = 'Is Billable Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `is_rework` SET TAGS ('pii_business_glossary_term' = 'Is Rework Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `labor_cost_amount` SET TAGS ('pii_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `labor_cost_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `line_number` SET TAGS ('pii_business_glossary_term' = 'Line Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `overtime_hours` SET TAGS ('pii_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `posted_to_job_cost_flag` SET TAGS ('pii_business_glossary_term' = 'Posted to Job Cost Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `posted_to_payroll_flag` SET TAGS ('pii_business_glossary_term' = 'Posted to Payroll Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `production_quantity` SET TAGS ('pii_business_glossary_term' = 'Production Quantity');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `production_unit` SET TAGS ('pii_business_glossary_term' = 'Production Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `production_unit` SET TAGS ('pii_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `regular_hours` SET TAGS ('pii_business_glossary_term' = 'Regular Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `shift_code` SET TAGS ('pii_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `shift_code` SET TAGS ('pii_value_regex' = 'day|night|swing|overtime');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `total_hours` SET TAGS ('pii_business_glossary_term' = 'Total Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `union_local_code` SET TAGS ('pii_business_glossary_term' = 'Union Local Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `union_local_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `weather_condition` SET TAGS ('pii_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `work_date` SET TAGS ('pii_business_glossary_term' = 'Work Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `work_location_code` SET TAGS ('pii_business_glossary_term' = 'Work Location Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `work_location_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,15}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `work_order_number` SET TAGS ('pii_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`timesheet_line` ALTER COLUMN `work_order_number` SET TAGS ('pii_value_regex' = '^[A-Z0-9-]{5,20}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` SET TAGS ('pii_subdomain' = 'trade_agreements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `labor_cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Labor Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Cost Code Id');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `skill_trade_id` SET TAGS ('pii_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `budget_category` SET TAGS ('pii_business_glossary_term' = 'Budget Category');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `budget_category` SET TAGS ('pii_value_regex' = 'direct_labor|indirect_labor|supervision|premium_time|mobilization');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `burden_rate_percentage` SET TAGS ('pii_business_glossary_term' = 'Burden Rate Percentage');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `burden_rate_percentage` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `cost_code` SET TAGS ('pii_business_glossary_term' = 'Cost Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `cost_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `cost_code_description` SET TAGS ('pii_business_glossary_term' = 'Cost Code Description');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `cost_code_status` SET TAGS ('pii_business_glossary_term' = 'Cost Code Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `cost_code_status` SET TAGS ('pii_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `craft_discipline` SET TAGS ('pii_business_glossary_term' = 'Craft Discipline');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `craft_discipline` SET TAGS ('pii_value_regex' = 'ironworker|pipefitter|electrician|carpenter|heavy_equipment_operator|concrete_finisher');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `hcss_cost_code_mapping` SET TAGS ('pii_business_glossary_term' = 'HCSS HeavyJob Cost Code Mapping');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `hourly_rate_base` SET TAGS ('pii_business_glossary_term' = 'Hourly Rate Base');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `hourly_rate_base` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `hse_risk_level` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Risk Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `hse_risk_level` SET TAGS ('pii_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `is_prevailing_wage_applicable` SET TAGS ('pii_business_glossary_term' = 'Is Prevailing Wage Applicable');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `is_prevailing_wage_applicable` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `is_prevailing_wage_applicable` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `is_union_classification` SET TAGS ('pii_business_glossary_term' = 'Is Union Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `last_modified_by` SET TAGS ('pii_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `overtime_multiplier` SET TAGS ('pii_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `ppe_requirements` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('pii_business_glossary_term' = 'Prevailing Wage Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `productivity_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Productivity Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `required_certification_types` SET TAGS ('pii_business_glossary_term' = 'Required Certification Types');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `requires_site_access_clearance` SET TAGS ('pii_business_glossary_term' = 'Requires Site Access Clearance');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `sap_wbs_element` SET TAGS ('pii_business_glossary_term' = 'SAP Work Breakdown Structure (WBS) Element');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `skill_level` SET TAGS ('pii_business_glossary_term' = 'Skill Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `skill_level` SET TAGS ('pii_value_regex' = 'apprentice|journeyman|foreman|superintendent|master');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `standard_crew_size` SET TAGS ('pii_business_glossary_term' = 'Standard Crew Size');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `union_jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Union Jurisdiction');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_cost_code` ALTER COLUMN `created_by` SET TAGS ('pii_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` SET TAGS ('pii_subdomain' = 'field_personnel');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `craft_certification_id` SET TAGS ('pii_business_glossary_term' = 'Craft Certification ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `skill_trade_id` SET TAGS ('pii_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `certification_level` SET TAGS ('pii_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `certification_level` SET TAGS ('pii_value_regex' = 'Entry|Intermediate|Advanced|Master|Journeyman|Apprentice');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `certification_name` SET TAGS ('pii_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `certification_number` SET TAGS ('pii_business_glossary_term' = 'Certification Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `certification_type` SET TAGS ('pii_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `document_reference` SET TAGS ('pii_business_glossary_term' = 'Document Reference');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `expiry_date` SET TAGS ('pii_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `issue_date` SET TAGS ('pii_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `issuing_body` SET TAGS ('pii_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('pii_business_glossary_term' = 'Issuing Country Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `issuing_country_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `issuing_state_province` SET TAGS ('pii_business_glossary_term' = 'Issuing State or Province');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `next_renewal_date` SET TAGS ('pii_business_glossary_term' = 'Next Renewal Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `project_requirement_flag` SET TAGS ('pii_business_glossary_term' = 'Project Requirement Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `renewal_frequency_months` SET TAGS ('pii_business_glossary_term' = 'Renewal Frequency (Months)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `renewal_required_flag` SET TAGS ('pii_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `site_access_required_flag` SET TAGS ('pii_business_glossary_term' = 'Site Access Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `training_completion_date` SET TAGS ('pii_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `training_hours_required` SET TAGS ('pii_business_glossary_term' = 'Training Hours Required');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `verification_date` SET TAGS ('pii_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `verification_status` SET TAGS ('pii_value_regex' = 'Verified|Pending|Expired|Revoked|Suspended|Not Verified');
ALTER TABLE `vibe_construction_v1`.`workforce`.`craft_certification` ALTER COLUMN `verified_by` SET TAGS ('pii_business_glossary_term' = 'Verified By');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` SET TAGS ('pii_subdomain' = 'trade_agreements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `skill_trade_id` SET TAGS ('pii_business_glossary_term' = 'Skill Trade Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `hr_org_unit_id` SET TAGS ('pii_business_glossary_term' = 'Org Unit Id');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `apprenticeship_duration_hours` SET TAGS ('pii_business_glossary_term' = 'Apprenticeship Duration Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `apprenticeship_required_flag` SET TAGS ('pii_business_glossary_term' = 'Apprenticeship Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `average_hourly_rate_usd` SET TAGS ('pii_business_glossary_term' = 'Average Hourly Rate United States Dollars (USD)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `average_hourly_rate_usd` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `bim_integration_level` SET TAGS ('pii_business_glossary_term' = 'Building Information Modeling (BIM) Integration Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `bim_integration_level` SET TAGS ('pii_value_regex' = 'none|basic|intermediate|advanced');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `certification_issuing_body` SET TAGS ('pii_business_glossary_term' = 'Certification Issuing Body');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `certification_type_required` SET TAGS ('pii_business_glossary_term' = 'Certification Type Required');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `equipment_dependency_flag` SET TAGS ('pii_business_glossary_term' = 'Equipment Dependency Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `hazard_exposure_level` SET TAGS ('pii_business_glossary_term' = 'Hazard Exposure Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `hazard_exposure_level` SET TAGS ('pii_value_regex' = 'low|moderate|high|extreme');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `labor_shortage_indicator` SET TAGS ('pii_business_glossary_term' = 'Labor Shortage Indicator');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `labor_shortage_indicator` SET TAGS ('pii_value_regex' = 'surplus|balanced|shortage|critical_shortage');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `mep_discipline_flag` SET TAGS ('pii_business_glossary_term' = 'Mechanical Electrical and Plumbing (MEP) Discipline Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Trade Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `osha_training_requirement` SET TAGS ('pii_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Training Requirement');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `overtime_multiplier` SET TAGS ('pii_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `physical_demand_rating` SET TAGS ('pii_business_glossary_term' = 'Physical Demand Rating');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `physical_demand_rating` SET TAGS ('pii_value_regex' = 'light|medium|heavy|very_heavy');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `ppe_requirements` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('pii_business_glossary_term' = 'Prevailing Wage Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `productivity_unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Productivity Unit of Measure');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `seasonal_demand_pattern` SET TAGS ('pii_business_glossary_term' = 'Seasonal Demand Pattern');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `skill_level_tiers` SET TAGS ('pii_business_glossary_term' = 'Skill Level Tiers');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `standard_crew_size` SET TAGS ('pii_business_glossary_term' = 'Standard Crew Size');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `trade_category` SET TAGS ('pii_business_glossary_term' = 'Trade Category');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `trade_code` SET TAGS ('pii_business_glossary_term' = 'Trade Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `trade_code` SET TAGS ('pii_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `trade_name` SET TAGS ('pii_business_glossary_term' = 'Trade Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `trade_status` SET TAGS ('pii_business_glossary_term' = 'Trade Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `trade_status` SET TAGS ('pii_value_regex' = 'active|inactive|obsolete|emerging');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `travel_requirement_typical` SET TAGS ('pii_business_glossary_term' = 'Travel Requirement Typical');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `travel_requirement_typical` SET TAGS ('pii_value_regex' = 'none|local|regional|national|international');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `union_jurisdiction_code` SET TAGS ('pii_business_glossary_term' = 'Union Jurisdiction Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`skill_trade` ALTER COLUMN `union_jurisdiction_name` SET TAGS ('pii_business_glossary_term' = 'Union Jurisdiction Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` SET TAGS ('pii_subdomain' = 'field_personnel');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `site_access_record_id` SET TAGS ('pii_business_glossary_term' = 'Site Access Record Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Security Officer Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Worker Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `access_denial_reason` SET TAGS ('pii_business_glossary_term' = 'Access Denial Reason');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `access_direction` SET TAGS ('pii_business_glossary_term' = 'Access Direction');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `access_direction` SET TAGS ('pii_value_regex' = 'entry|exit');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `access_method` SET TAGS ('pii_business_glossary_term' = 'Access Method');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `access_method` SET TAGS ('pii_value_regex' = 'badge_scan|biometric|manual_entry|qr_code|mobile_app|visitor_log');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `access_notes` SET TAGS ('pii_business_glossary_term' = 'Access Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `access_timestamp` SET TAGS ('pii_business_glossary_term' = 'Access Event Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `access_zone` SET TAGS ('pii_business_glossary_term' = 'Access Zone');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `actual_exit_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Exit Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `authorization_status` SET TAGS ('pii_business_glossary_term' = 'Access Authorization Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `authorization_status` SET TAGS ('pii_value_regex' = 'authorized|unauthorized|override|expired|pending');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `badge_number` SET TAGS ('pii_business_glossary_term' = 'Worker Badge Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `badge_number` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `badge_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `duration_on_site_minutes` SET TAGS ('pii_business_glossary_term' = 'Duration on Site (Minutes)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `emergency_muster_status` SET TAGS ('pii_business_glossary_term' = 'Emergency Muster Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `emergency_muster_status` SET TAGS ('pii_value_regex' = 'on_site|off_site|accounted_for|unaccounted_for');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `escort_required_flag` SET TAGS ('pii_business_glossary_term' = 'Escort Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `expected_exit_timestamp` SET TAGS ('pii_business_glossary_term' = 'Expected Exit Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `health_screening_status` SET TAGS ('pii_business_glossary_term' = 'Health Screening Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `health_screening_status` SET TAGS ('pii_value_regex' = 'passed|failed|not_required|waived');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `health_screening_status` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `health_screening_status` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `induction_status` SET TAGS ('pii_business_glossary_term' = 'Site Induction Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `induction_status` SET TAGS ('pii_value_regex' = 'completed|not_required|pending|expired');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `photo_captured_flag` SET TAGS ('pii_business_glossary_term' = 'Photo Captured Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `ppe_compliance_status` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Compliance Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `ppe_compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|not_checked|waived');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `ppe_items_verified` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Items Verified');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `purpose_of_visit` SET TAGS ('pii_business_glossary_term' = 'Purpose of Visit');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `signature_captured_flag` SET TAGS ('pii_business_glossary_term' = 'Signature Captured Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `site_gate_code` SET TAGS ('pii_business_glossary_term' = 'Site Gate Identifier (ID)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `temperature_reading` SET TAGS ('pii_business_glossary_term' = 'Body Temperature Reading');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `temperature_reading` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `temperature_reading` SET TAGS ('pii_health' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `vehicle_registration` SET TAGS ('pii_business_glossary_term' = 'Vehicle Registration Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `vehicle_registration` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `worker_classification` SET TAGS ('pii_business_glossary_term' = 'Worker Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`site_access_record` ALTER COLUMN `worker_classification` SET TAGS ('pii_value_regex' = 'direct_hire|subcontractor|visitor|vendor|inspector|client_representative');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` SET TAGS ('pii_subdomain' = 'field_personnel');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `labor_mobilization_id` SET TAGS ('pii_business_glossary_term' = 'Labor Mobilization ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `regulatory_permit_id` SET TAGS ('pii_business_glossary_term' = 'Permit Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `crew_assignment_id` SET TAGS ('pii_business_glossary_term' = 'Crew Assignment ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Destination Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `primary_labor_construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Origin Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Requested By User ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `accommodation_booking_reference` SET TAGS ('pii_business_glossary_term' = 'Accommodation Booking Reference');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `accommodation_cost_estimate` SET TAGS ('pii_business_glossary_term' = 'Accommodation Cost Estimate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `accommodation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Accommodation Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('pii_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `craft_code` SET TAGS ('pii_business_glossary_term' = 'Craft Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `craft_code` SET TAGS ('pii_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `demobilization_date` SET TAGS ('pii_business_glossary_term' = 'Demobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `hse_orientation_completed_flag` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Orientation Completed Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `hse_orientation_date` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Orientation Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_date` SET TAGS ('pii_business_glossary_term' = 'Mobilization Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_number` SET TAGS ('pii_business_glossary_term' = 'Mobilization Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_number` SET TAGS ('pii_value_regex' = '^MOB-[0-9]{8}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_reason` SET TAGS ('pii_business_glossary_term' = 'Mobilization Reason');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_status` SET TAGS ('pii_business_glossary_term' = 'Mobilization Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_status` SET TAGS ('pii_value_regex' = 'planned|approved|in_transit|completed|cancelled');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_type` SET TAGS ('pii_business_glossary_term' = 'Mobilization Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `mobilization_type` SET TAGS ('pii_value_regex' = 'initial|transfer|demobilization|remobilization');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Mobilization Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `per_diem_duration_days` SET TAGS ('pii_business_glossary_term' = 'Per Diem Duration Days');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `per_diem_eligible_flag` SET TAGS ('pii_business_glossary_term' = 'Per Diem Eligible Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `per_diem_rate` SET TAGS ('pii_business_glossary_term' = 'Per Diem Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `site_access_badge_issued_flag` SET TAGS ('pii_business_glossary_term' = 'Site Access Badge Issued Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `special_requirements` SET TAGS ('pii_business_glossary_term' = 'Special Requirements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `total_mobilization_cost` SET TAGS ('pii_business_glossary_term' = 'Total Mobilization Cost');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `travel_booking_reference` SET TAGS ('pii_business_glossary_term' = 'Travel Booking Reference');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `travel_cost_estimate` SET TAGS ('pii_business_glossary_term' = 'Travel Cost Estimate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `travel_mode` SET TAGS ('pii_business_glossary_term' = 'Travel Mode');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_mobilization` ALTER COLUMN `travel_mode` SET TAGS ('pii_value_regex' = 'air|ground|rail|company_vehicle|personal_vehicle|not_applicable');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` SET TAGS ('pii_subdomain' = 'labor_tracking');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `production_rate_id` SET TAGS ('pii_business_glossary_term' = 'Production Rate ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Foreman ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `project_baseline_id` SET TAGS ('pii_business_glossary_term' = 'Baseline ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Recorded By Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `activity_code` SET TAGS ('pii_business_glossary_term' = 'Activity Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `activity_description` SET TAGS ('pii_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `actual_production_rate` SET TAGS ('pii_business_glossary_term' = 'Actual Production Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `actual_quantity` SET TAGS ('pii_business_glossary_term' = 'Actual Quantity Installed');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `earned_hours` SET TAGS ('pii_business_glossary_term' = 'Earned Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `equipment_availability_flag` SET TAGS ('pii_business_glossary_term' = 'Equipment Availability Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `expended_hours` SET TAGS ('pii_business_glossary_term' = 'Expended Labor Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `material_availability_flag` SET TAGS ('pii_business_glossary_term' = 'Material Availability Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Production Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `planned_production_rate` SET TAGS ('pii_business_glossary_term' = 'Planned Production Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `planned_quantity` SET TAGS ('pii_business_glossary_term' = 'Planned Quantity');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `productivity_factor` SET TAGS ('pii_business_glossary_term' = 'Productivity Factor');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `quality_inspection_status` SET TAGS ('pii_business_glossary_term' = 'Quality Assurance/Quality Control (QA/QC) Inspection Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `quality_inspection_status` SET TAGS ('pii_value_regex' = 'passed|failed|pending|not_required');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `recorded_by` SET TAGS ('pii_business_glossary_term' = 'Recorded By');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `rework_flag` SET TAGS ('pii_business_glossary_term' = 'Rework Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `safety_incident_flag` SET TAGS ('pii_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `shift` SET TAGS ('pii_business_glossary_term' = 'Work Shift');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `shift` SET TAGS ('pii_value_regex' = 'day|night|swing|overtime');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `site_condition` SET TAGS ('pii_business_glossary_term' = 'Site Condition');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `site_condition` SET TAGS ('pii_value_regex' = 'normal|congested|restricted_access|hazardous|confined_space|underground');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `source_record_reference` SET TAGS ('pii_business_glossary_term' = 'Source Record ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `trade_category` SET TAGS ('pii_business_glossary_term' = 'Trade Category');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `unit_of_measure` SET TAGS ('pii_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `variance_hours` SET TAGS ('pii_business_glossary_term' = 'Labor Hours Variance');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `variance_quantity` SET TAGS ('pii_business_glossary_term' = 'Quantity Variance');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `weather_condition` SET TAGS ('pii_business_glossary_term' = 'Weather Condition');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `work_date` SET TAGS ('pii_business_glossary_term' = 'Work Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `work_difficulty_rating` SET TAGS ('pii_business_glossary_term' = 'Work Difficulty Rating');
ALTER TABLE `vibe_construction_v1`.`workforce`.`production_rate` ALTER COLUMN `work_difficulty_rating` SET TAGS ('pii_value_regex' = 'easy|normal|difficult|very_difficult');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` SET TAGS ('pii_subdomain' = 'labor_tracking');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `staffing_plan_id` SET TAGS ('pii_business_glossary_term' = 'Staffing Plan Identifier');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `agreement_id` SET TAGS ('pii_business_glossary_term' = 'Agreement Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Construction Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `firm_profile_id` SET TAGS ('pii_business_glossary_term' = 'Sub Firm Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `skill_trade_id` SET TAGS ('pii_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `accommodation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Accommodation Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `actual_headcount` SET TAGS ('pii_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `actual_labor_hours` SET TAGS ('pii_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `agency_headcount` SET TAGS ('pii_business_glossary_term' = 'Agency Headcount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `approved_by` SET TAGS ('pii_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `baseline_flag` SET TAGS ('pii_business_glossary_term' = 'Baseline Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `craft_labor_headcount` SET TAGS ('pii_business_glossary_term' = 'Craft Labor Headcount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `direct_hire_headcount` SET TAGS ('pii_business_glossary_term' = 'Direct Hire Headcount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `headcount_variance` SET TAGS ('pii_business_glossary_term' = 'Headcount Variance');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `labor_hours_variance` SET TAGS ('pii_business_glossary_term' = 'Labor Hours Variance');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `peak_headcount` SET TAGS ('pii_business_glossary_term' = 'Peak Headcount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `peak_headcount_date` SET TAGS ('pii_business_glossary_term' = 'Peak Headcount Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `plan_name` SET TAGS ('pii_business_glossary_term' = 'Staffing Plan Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `plan_number` SET TAGS ('pii_business_glossary_term' = 'Staffing Plan Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_business_glossary_term' = 'Plan Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `plan_status` SET TAGS ('pii_value_regex' = 'draft|approved|active|superseded|cancelled|archived');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_business_glossary_term' = 'Plan Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `plan_type` SET TAGS ('pii_value_regex' = 'baseline|forecast|revised|scenario|contingency');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `plan_version` SET TAGS ('pii_business_glossary_term' = 'Plan Version');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `planning_period_end_date` SET TAGS ('pii_business_glossary_term' = 'Planning Period End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `planning_period_start_date` SET TAGS ('pii_business_glossary_term' = 'Planning Period Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `ramp_down_end_date` SET TAGS ('pii_business_glossary_term' = 'Ramp-Down End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `ramp_down_start_date` SET TAGS ('pii_business_glossary_term' = 'Ramp-Down Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `ramp_up_end_date` SET TAGS ('pii_business_glossary_term' = 'Ramp-Up End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `ramp_up_start_date` SET TAGS ('pii_business_glossary_term' = 'Ramp-Up Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `site_access_requirements` SET TAGS ('pii_business_glossary_term' = 'Site Access Requirements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `skill_certification_requirements` SET TAGS ('pii_business_glossary_term' = 'Skill Certification Requirements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `sourcing_strategy` SET TAGS ('pii_business_glossary_term' = 'Sourcing Strategy');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `sourcing_strategy` SET TAGS ('pii_value_regex' = 'direct_hire|subcontract|mixed|agency|joint_venture');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `subcontractor_headcount` SET TAGS ('pii_business_glossary_term' = 'Subcontractor Headcount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `supervision_headcount` SET TAGS ('pii_business_glossary_term' = 'Supervision Headcount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `support_staff_headcount` SET TAGS ('pii_business_glossary_term' = 'Support Staff Headcount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `total_planned_headcount` SET TAGS ('pii_business_glossary_term' = 'Total Planned Headcount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `total_planned_labor_hours` SET TAGS ('pii_business_glossary_term' = 'Total Planned Labor Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `trade_mix_breakdown` SET TAGS ('pii_business_glossary_term' = 'Trade Mix Breakdown');
ALTER TABLE `vibe_construction_v1`.`workforce`.`staffing_plan` ALTER COLUMN `transportation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Transportation Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` SET TAGS ('pii_subdomain' = 'trade_agreements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `labor_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Labor Agreement ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Contract Manager Employee Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_status` SET TAGS ('pii_business_glossary_term' = 'Agreement Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_business_glossary_term' = 'Agreement Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `agreement_type` SET TAGS ('pii_value_regex' = 'collective_bargaining_agreement|project_labor_agreement|union_agreement|prevailing_wage_determination|master_labor_agreement|local_supplement');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `apprentice_ratio` SET TAGS ('pii_business_glossary_term' = 'Apprentice Ratio');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `arbitration_required_flag` SET TAGS ('pii_business_glossary_term' = 'Arbitration Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `base_wage_rate` SET TAGS ('pii_business_glossary_term' = 'Base Wage Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `base_wage_rate` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `base_wage_rate` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `double_time_multiplier` SET TAGS ('pii_business_glossary_term' = 'Double Time Multiplier');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `double_time_threshold_hours` SET TAGS ('pii_business_glossary_term' = 'Double Time Threshold Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `effective_date` SET TAGS ('pii_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `expiration_date` SET TAGS ('pii_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `fringe_benefit_rate` SET TAGS ('pii_business_glossary_term' = 'Fringe Benefit Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `geographic_coverage` SET TAGS ('pii_business_glossary_term' = 'Geographic Coverage');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `grievance_procedure_description` SET TAGS ('pii_business_glossary_term' = 'Grievance Procedure Description');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `health_welfare_rate` SET TAGS ('pii_business_glossary_term' = 'Health and Welfare Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `health_welfare_rate` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `health_welfare_rate` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `hiring_hall_required_flag` SET TAGS ('pii_business_glossary_term' = 'Hiring Hall Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `jurisdiction_type` SET TAGS ('pii_business_glossary_term' = 'Jurisdiction Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `multi_employer_agreement_flag` SET TAGS ('pii_business_glossary_term' = 'Multi-Employer Agreement Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `no_strike_clause_flag` SET TAGS ('pii_business_glossary_term' = 'No-Strike Clause Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `overtime_multiplier` SET TAGS ('pii_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `overtime_threshold_hours` SET TAGS ('pii_business_glossary_term' = 'Overtime Threshold Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `pension_rate` SET TAGS ('pii_business_glossary_term' = 'Pension Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `prevailing_wage_determination_number` SET TAGS ('pii_business_glossary_term' = 'Prevailing Wage Determination Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `prevailing_wage_determination_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `prevailing_wage_determination_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `ratification_date` SET TAGS ('pii_business_glossary_term' = 'Ratification Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `reporting_pay_hours` SET TAGS ('pii_business_glossary_term' = 'Reporting Pay Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `shift_differential_rate` SET TAGS ('pii_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `show_up_time_hours` SET TAGS ('pii_business_glossary_term' = 'Show-Up Time Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `signatory_employer_name` SET TAGS ('pii_business_glossary_term' = 'Signatory Employer Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `trade_category` SET TAGS ('pii_business_glossary_term' = 'Trade Category');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `training_fund_rate` SET TAGS ('pii_business_glossary_term' = 'Training Fund Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `travel_subsistence_rate` SET TAGS ('pii_business_glossary_term' = 'Travel and Subsistence Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `union_international_affiliation` SET TAGS ('pii_business_glossary_term' = 'Union International Affiliation');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `union_local_number` SET TAGS ('pii_business_glossary_term' = 'Union Local Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `union_name` SET TAGS ('pii_business_glossary_term' = 'Union Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `union_security_clause` SET TAGS ('pii_business_glossary_term' = 'Union Security Clause');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `union_security_clause` SET TAGS ('pii_value_regex' = 'open_shop|union_shop|agency_shop|closed_shop|modified_union_shop');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `vacation_holiday_rate` SET TAGS ('pii_business_glossary_term' = 'Vacation and Holiday Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `wage_rate_currency_code` SET TAGS ('pii_business_glossary_term' = 'Wage Rate Currency Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `wage_rate_currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `wage_rate_currency_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `wage_rate_currency_code` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `wage_scale_document_reference` SET TAGS ('pii_business_glossary_term' = 'Wage Scale Document Reference');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `wage_scale_document_reference` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_agreement` ALTER COLUMN `wage_scale_document_reference` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` SET TAGS ('pii_data_type' = 'reference_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` SET TAGS ('pii_subdomain' = 'trade_agreements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `labor_rate_id` SET TAGS ('pii_business_glossary_term' = 'Labor Rate ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `account_id` SET TAGS ('pii_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `cost_center_id` SET TAGS ('pii_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `labor_agreement_id` SET TAGS ('pii_business_glossary_term' = 'Labor Agreement ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `labor_cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Labor Cost Code Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `apprentice_ratio` SET TAGS ('pii_business_glossary_term' = 'Apprentice to Journeyman Ratio');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `base_hourly_rate` SET TAGS ('pii_business_glossary_term' = 'Base Hourly Wage Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `certified_payroll_required_flag` SET TAGS ('pii_business_glossary_term' = 'Certified Payroll Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `double_time_hourly_rate` SET TAGS ('pii_business_glossary_term' = 'Double-Time Hourly Wage Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `effective_end_date` SET TAGS ('pii_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `effective_start_date` SET TAGS ('pii_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `escalation_clause` SET TAGS ('pii_business_glossary_term' = 'Rate Escalation Clause');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `fringe_benefit_rate` SET TAGS ('pii_business_glossary_term' = 'Fringe Benefit Hourly Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `jurisdiction` SET TAGS ('pii_business_glossary_term' = 'Labor Jurisdiction');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Labor Rate Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `overhead_percentage` SET TAGS ('pii_business_glossary_term' = 'Overhead Percentage');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `overtime_hourly_rate` SET TAGS ('pii_business_glossary_term' = 'Overtime Hourly Wage Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `payroll_burden_percentage` SET TAGS ('pii_business_glossary_term' = 'Payroll Burden Percentage');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `per_diem_rate` SET TAGS ('pii_business_glossary_term' = 'Per Diem Daily Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `prevailing_wage_determination_number` SET TAGS ('pii_business_glossary_term' = 'Prevailing Wage Determination Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `prevailing_wage_determination_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `prevailing_wage_determination_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `profit_margin_percentage` SET TAGS ('pii_business_glossary_term' = 'Profit Margin Percentage');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `rate_code` SET TAGS ('pii_business_glossary_term' = 'Labor Rate Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `rate_status` SET TAGS ('pii_business_glossary_term' = 'Labor Rate Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `rate_status` SET TAGS ('pii_value_regex' = 'active|pending|expired|superseded|suspended');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `rate_type` SET TAGS ('pii_business_glossary_term' = 'Labor Rate Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `rate_type` SET TAGS ('pii_value_regex' = 'union|prevailing_wage|open_shop|project_specific|market_rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `shift_differential_rate` SET TAGS ('pii_business_glossary_term' = 'Shift Differential Hourly Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `skill_level` SET TAGS ('pii_business_glossary_term' = 'Skill Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `skill_level` SET TAGS ('pii_value_regex' = 'apprentice|journeyman|foreman|general_foreman|superintendent');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `source_system_code` SET TAGS ('pii_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `subsistence_rate` SET TAGS ('pii_business_glossary_term' = 'Subsistence Daily Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `total_loaded_hourly_rate` SET TAGS ('pii_business_glossary_term' = 'Total Loaded Hourly Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `trade_classification` SET TAGS ('pii_business_glossary_term' = 'Trade Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `travel_zone` SET TAGS ('pii_business_glossary_term' = 'Travel Zone');
ALTER TABLE `vibe_construction_v1`.`workforce`.`labor_rate` ALTER COLUMN `union_local` SET TAGS ('pii_business_glossary_term' = 'Union Local');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` SET TAGS ('pii_data_type' = 'transactional_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` SET TAGS ('pii_subdomain' = 'trade_agreements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `agency_labor_order_id` SET TAGS ('pii_business_glossary_term' = 'Agency Labor Order ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `agency_id` SET TAGS ('pii_business_glossary_term' = 'Agency ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `construction_project_id` SET TAGS ('pii_business_glossary_term' = 'Project ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `cost_code_id` SET TAGS ('pii_business_glossary_term' = 'Cost Code ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_business_glossary_term' = 'Requested By User ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `hr_employee_id` SET TAGS ('pii_pii' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `skill_trade_id` SET TAGS ('pii_business_glossary_term' = 'Skill Trade Id (Foreign Key)');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `wbs_element_id` SET TAGS ('pii_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `actual_end_date` SET TAGS ('pii_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `actual_start_date` SET TAGS ('pii_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `approval_date` SET TAGS ('pii_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `bill_rate` SET TAGS ('pii_business_glossary_term' = 'Bill Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `cancellation_date` SET TAGS ('pii_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `cancellation_reason` SET TAGS ('pii_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `craft_code` SET TAGS ('pii_business_glossary_term' = 'Craft Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `currency_code` SET TAGS ('pii_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `estimated_end_date` SET TAGS ('pii_business_glossary_term' = 'Estimated End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `fulfillment_date` SET TAGS ('pii_business_glossary_term' = 'Fulfillment Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `hse_orientation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Health Safety and Environment (HSE) Orientation Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `markup_percentage` SET TAGS ('pii_business_glossary_term' = 'Markup Percentage');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `order_date` SET TAGS ('pii_business_glossary_term' = 'Order Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `order_number` SET TAGS ('pii_business_glossary_term' = 'Order Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `order_status` SET TAGS ('pii_business_glossary_term' = 'Order Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `pay_rate` SET TAGS ('pii_business_glossary_term' = 'Pay Rate');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `po_number` SET TAGS ('pii_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `ppe_requirements` SET TAGS ('pii_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `required_certifications` SET TAGS ('pii_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `required_start_date` SET TAGS ('pii_business_glossary_term' = 'Required Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `site_access_clearance_required_flag` SET TAGS ('pii_business_glossary_term' = 'Site Access Clearance Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `skill_level` SET TAGS ('pii_business_glossary_term' = 'Skill Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `skill_level` SET TAGS ('pii_value_regex' = 'apprentice|journeyman|foreman|master|helper');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `special_requirements` SET TAGS ('pii_business_glossary_term' = 'Special Requirements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `union_affiliation_required_flag` SET TAGS ('pii_business_glossary_term' = 'Union Affiliation Required Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `union_local` SET TAGS ('pii_business_glossary_term' = 'Union Local');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `workers_fulfilled_quantity` SET TAGS ('pii_business_glossary_term' = 'Workers Fulfilled Quantity');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency_labor_order` ALTER COLUMN `workers_requested_quantity` SET TAGS ('pii_business_glossary_term' = 'Workers Requested Quantity');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` SET TAGS ('pii_subdomain' = 'field_personnel');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprenticeship_progression_id` SET TAGS ('pii_business_glossary_term' = 'Apprenticeship Progression ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Worker ID');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `prior_apprenticeship_progression_id` SET TAGS ('pii_business_glossary_term' = 'Prior Apprenticeship Progression Id');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `prior_apprenticeship_progression_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `actual_journeyman_completion_date` SET TAGS ('pii_business_glossary_term' = 'Actual Journeyman Completion Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprentice_to_journeyman_ratio` SET TAGS ('pii_business_glossary_term' = 'Apprentice‑to‑Journeyman Ratio');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprenticeship_end_date` SET TAGS ('pii_business_glossary_term' = 'Apprenticeship End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprenticeship_hours_required` SET TAGS ('pii_business_glossary_term' = 'Required Apprenticeship Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprenticeship_level` SET TAGS ('pii_business_glossary_term' = 'Apprenticeship Level');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprenticeship_period` SET TAGS ('pii_business_glossary_term' = 'Apprenticeship Period');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprenticeship_program_code` SET TAGS ('pii_business_glossary_term' = 'Apprenticeship Program Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprenticeship_program_name` SET TAGS ('pii_business_glossary_term' = 'Apprenticeship Program Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprenticeship_start_date` SET TAGS ('pii_business_glossary_term' = 'Apprenticeship Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprenticeship_status` SET TAGS ('pii_business_glossary_term' = 'Apprenticeship Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprenticeship_status` SET TAGS ('pii_value_regex' = 'active|completed|terminated|suspended|pending');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprenticeship_status_reason` SET TAGS ('pii_business_glossary_term' = 'Apprenticeship Status Reason');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprenticeship_type` SET TAGS ('pii_business_glossary_term' = 'Apprenticeship Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `apprenticeship_type` SET TAGS ('pii_value_regex' = 'union|state|private|company');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `certification_earned_date` SET TAGS ('pii_business_glossary_term' = 'Certification Earned Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `certification_earned_flag` SET TAGS ('pii_business_glossary_term' = 'Certification Earned Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `compliance_check_date` SET TAGS ('pii_business_glossary_term' = 'Compliance Check Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `compliance_status` SET TAGS ('pii_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `dol_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'DOL Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `expected_journeyman_completion_date` SET TAGS ('pii_business_glossary_term' = 'Expected Journeyman Completion Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `last_modified_timestamp` SET TAGS ('pii_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `last_status_update_timestamp` SET TAGS ('pii_business_glossary_term' = 'Last Status Update Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `ojt_hours_accumulated` SET TAGS ('pii_business_glossary_term' = 'On‑the‑Job Training Hours Accumulated');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('pii_business_glossary_term' = 'Prevailing Wage Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `prevailing_wage_classification` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `record_version` SET TAGS ('pii_business_glossary_term' = 'Record Version');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `sponsoring_jatc` SET TAGS ('pii_business_glossary_term' = 'Sponsoring JATC');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `state_apprenticeship_compliance_flag` SET TAGS ('pii_business_glossary_term' = 'State Compliance Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `technical_instruction_hours` SET TAGS ('pii_business_glossary_term' = 'Technical Instruction Hours Completed');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `technical_instruction_hours_required` SET TAGS ('pii_business_glossary_term' = 'Required Technical Instruction Hours');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `training_provider` SET TAGS ('pii_business_glossary_term' = 'Training Provider');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `union_local` SET TAGS ('pii_business_glossary_term' = 'Union Local');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `wage_progression_effective_date` SET TAGS ('pii_business_glossary_term' = 'Wage Progression Effective Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `wage_progression_effective_date` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `wage_progression_effective_date` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `wage_progression_step` SET TAGS ('pii_business_glossary_term' = 'Wage Progression Step');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `wage_progression_step` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `wage_progression_step` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `wage_step` SET TAGS ('pii_business_glossary_term' = 'Wage Step');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `wage_step` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`apprenticeship_progression` ALTER COLUMN `wage_step` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` SET TAGS ('pii_data_type' = 'association_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` SET TAGS ('pii_subdomain' = 'labor_tracking');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` SET TAGS ('pii_association_edges' = 'workforce.craft_worker,sustainability.carbon_reduction_initiative');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `carbon_reduction_participation_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Reduction Participation - Participation Id');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `carbon_reduction_initiative_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Reduction Participation - Carbon Reduction Initiative Id');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `craft_worker_id` SET TAGS ('pii_business_glossary_term' = 'Carbon Reduction Participation - Craft Worker Id');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `crew_id` SET TAGS ('pii_business_glossary_term' = 'Crew Id');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `activity_type` SET TAGS ('pii_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `carbon_saved_kg` SET TAGS ('pii_business_glossary_term' = 'Carbon Saved Kg');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `completion_date` SET TAGS ('pii_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `contribution_description` SET TAGS ('pii_business_glossary_term' = 'Contribution Description');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `contribution_notes` SET TAGS ('pii_business_glossary_term' = 'Contribution Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `currency_code` SET TAGS ('pii_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `end_date` SET TAGS ('pii_business_glossary_term' = 'Participation End Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `enrollment_date` SET TAGS ('pii_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `estimated_carbon_saved_kg` SET TAGS ('pii_business_glossary_term' = 'Estimated Carbon Saved Kg');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `estimated_carbon_saving_kgco2e` SET TAGS ('pii_business_glossary_term' = 'Estimated Carbon Saving Kgco2e');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `hours_contributed` SET TAGS ('pii_business_glossary_term' = 'Hours Contributed');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `incentive_amount` SET TAGS ('pii_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `initiative_role` SET TAGS ('pii_business_glossary_term' = 'Initiative Role');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `participation_date` SET TAGS ('pii_business_glossary_term' = 'Participation Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `participation_role` SET TAGS ('pii_business_glossary_term' = 'Participation Role');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `participation_status` SET TAGS ('pii_business_glossary_term' = 'Participation Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `recognition_awarded` SET TAGS ('pii_business_glossary_term' = 'Recognition Awarded');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `remarks` SET TAGS ('pii_business_glossary_term' = 'Remarks');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `start_date` SET TAGS ('pii_business_glossary_term' = 'Participation Start Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `training_completed` SET TAGS ('pii_business_glossary_term' = 'Training Completed');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `training_completion_date` SET TAGS ('pii_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `verification_status` SET TAGS ('pii_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`carbon_reduction_participation` ALTER COLUMN `verified_flag` SET TAGS ('pii_business_glossary_term' = 'Verified Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` SET TAGS ('pii_data_type' = 'master_data');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` SET TAGS ('pii_subdomain' = 'trade_agreements');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` SET TAGS ('pii_required_structure' = 'v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` SET TAGS ('pii_ecm_structure' = 'preserved_v2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` SET TAGS ('pii_structure_required' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `agency_id` SET TAGS ('pii_business_glossary_term' = 'Agency Identifier');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `parent_agency_id` SET TAGS ('pii_business_glossary_term' = 'Parent Agency Id');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `parent_agency_id` SET TAGS ('pii_self_ref_fk' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `address_line1` SET TAGS ('pii_business_glossary_term' = 'Address Line1');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `address_line1` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `address_line1` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `address_line2` SET TAGS ('pii_business_glossary_term' = 'Address Line2');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `address_line2` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `address_line2` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `agency_status` SET TAGS ('pii_business_glossary_term' = 'Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `agency_type` SET TAGS ('pii_business_glossary_term' = 'Agency Type');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `bank_account_number` SET TAGS ('pii_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `bank_account_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `bank_account_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `bank_routing_number` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `bonding_amount` SET TAGS ('pii_business_glossary_term' = 'Bonding Amount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `bonding_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `bonding_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `city` SET TAGS ('pii_business_glossary_term' = 'City');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `classification` SET TAGS ('pii_business_glossary_term' = 'Classification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `agency_code` SET TAGS ('pii_business_glossary_term' = 'Agency Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `compliance_status` SET TAGS ('pii_business_glossary_term' = 'Compliance Status');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `country_code` SET TAGS ('pii_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `created_timestamp` SET TAGS ('pii_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `default_currency` SET TAGS ('pii_business_glossary_term' = 'Default Currency');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `effective_from` SET TAGS ('pii_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `effective_until` SET TAGS ('pii_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `email_address` SET TAGS ('pii_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `email_address` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `email_address` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('pii_business_glossary_term' = 'Insurance Coverage Amount');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('pii_confidential' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `insurance_coverage_amount` SET TAGS ('pii_financial' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `last_audit_date` SET TAGS ('pii_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `legal_name` SET TAGS ('pii_business_glossary_term' = 'Legal Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `license_expiry` SET TAGS ('pii_business_glossary_term' = 'License Expiry');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `license_number` SET TAGS ('pii_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `license_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `license_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `agency_name` SET TAGS ('pii_business_glossary_term' = 'Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `notes` SET TAGS ('pii_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `payment_terms` SET TAGS ('pii_business_glossary_term' = 'Payment Terms');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `phone_number` SET TAGS ('pii_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `phone_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `phone_number` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `postal_code` SET TAGS ('pii_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `postal_code` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `postal_code` SET TAGS ('pii_address' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Email');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `primary_contact_email` SET TAGS ('pii_email' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `primary_contact_name` SET TAGS ('pii_name' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_business_glossary_term' = 'Primary Contact Phone');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `primary_contact_phone` SET TAGS ('pii_phone' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `rating` SET TAGS ('pii_business_glossary_term' = 'Rating');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `safety_certification` SET TAGS ('pii_business_glossary_term' = 'Safety Certification');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `state_province` SET TAGS ('pii_business_glossary_term' = 'State Province');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `tax_exempt_flag` SET TAGS ('pii_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `tax_number` SET TAGS ('pii_business_glossary_term' = 'Tax Number');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `tax_number` SET TAGS ('pii_restricted' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `tax_number` SET TAGS ('pii_identifier' = 'true');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `updated_timestamp` SET TAGS ('pii_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_construction_v1`.`workforce`.`agency` ALTER COLUMN `website_url` SET TAGS ('pii_business_glossary_term' = 'Website Url');
