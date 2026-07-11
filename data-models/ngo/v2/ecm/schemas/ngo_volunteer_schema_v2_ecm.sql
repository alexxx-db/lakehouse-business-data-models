-- Schema for Domain: volunteer | Business:  | Version: v2_ecm
-- Generated on: 2026-07-10 18:48:27

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_ngo_v1`.`volunteer` COMMENT 'Manages volunteer recruitment, onboarding, deployment, scheduling, training, recognition, and contribution tracking. Distinct from paid workforce, covers community health workers, field volunteers, and event-based supporters. Tracks volunteer hours, skills, certifications, and engagement across programs coordinated through Microsoft Dynamics 365.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` (
    `volunteer_id` BIGINT COMMENT 'Unique identifier for the volunteer record. Primary key for the volunteer entity.',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Volunteers are frequently also donors in nonprofits. Linking enables integrated constituent relationship management, lifetime value analysis across giving and service, unified recognition programs, an',
    `safeguarding_incident_id` BIGINT COMMENT 'Foreign key linking to safeguarding.safeguarding_incident. Business justification: Volunteers can be reporters, witnesses, or subjects of safeguarding incidents. Incident management systems link volunteer records to incidents for investigation tracking, background checks, and deploy',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Federal funding recipients must screen volunteers against OFAC and sanctions lists. Required for USAID, EU funding compliance. Links volunteer record to their most recent screening result for audit tr',
    `address_line_1` STRING COMMENT 'First line of the volunteers residential address, typically street number and name.',
    `address_line_2` STRING COMMENT 'Second line of the volunteers residential address, typically apartment or unit number.',
    `availability_hours_per_week` DECIMAL(18,2) COMMENT 'Number of hours per week the volunteer is available to contribute, used for scheduling and capacity planning.',
    `availability_status` STRING COMMENT 'Current availability status of the volunteer for new assignments. Available indicates ready for deployment, unavailable indicates temporarily not available, on assignment indicates currently deployed, on leave indicates scheduled absence, and inactive indicates not currently volunteering.. Valid values are `available|unavailable|on assignment|on leave|inactive`',
    `background_check_date` DATE COMMENT 'Date when the most recent background check was completed for the volunteer.',
    `background_check_status` STRING COMMENT 'Status of the volunteers background check or vetting process. Not required indicates no check needed for this role, pending indicates check requested, in progress indicates check underway, cleared indicates check passed, flagged indicates issues identified, and expired indicates check needs renewal.. Valid values are `not required|pending|in progress|cleared|flagged|expired`',
    `certifications` STRING COMMENT 'Comma-separated list of professional certifications, licenses, and credentials held by the volunteer, such as first aid, WASH (Water Sanitation and Hygiene) training, PSS (Psychosocial Support) certification, or medical licenses.',
    `city` STRING COMMENT 'City or municipality of the volunteers residential address.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code of the volunteers residential address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the volunteer record was first created in the system.',
    `date_of_birth` DATE COMMENT 'Date of birth of the volunteer, used for age verification, insurance, and compliance purposes.',
    `email_address` STRING COMMENT 'Primary email address for volunteer communication, coordination, and notifications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the volunteers designated emergency contact person.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the volunteers designated emergency contact person.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the volunteer, such as spouse, parent, sibling, or friend.',
    `external_volunteer_code` STRING COMMENT 'Business identifier for the volunteer as known in Microsoft Dynamics 365 for Nonprofits or other external systems. Used for cross-system reconciliation and integration.',
    `first_name` STRING COMMENT 'The given name of the volunteer.',
    `first_volunteer_date` DATE COMMENT 'Date of the volunteers first volunteer activity or assignment with the organization.',
    `gender` STRING COMMENT 'Self-identified gender of the volunteer, used for demographic reporting and program planning.. Valid values are `male|female|non-binary|prefer not to say|other`',
    `geographic_base` STRING COMMENT 'Primary geographic location or region where the volunteer is based and prefers to serve, used for matching volunteers to local programs and field operations.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the volunteer record was last updated or modified.',
    `last_name` STRING COMMENT 'The family name or surname of the volunteer.',
    `last_volunteer_date` DATE COMMENT 'Date of the volunteers most recent volunteer activity or assignment with the organization.',
    `middle_name` STRING COMMENT 'The middle name or initial of the volunteer, if applicable.',
    `mobile_number` STRING COMMENT 'Mobile phone number for the volunteer, used for SMS notifications and field coordination.',
    `nationality` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code representing the volunteers nationality or citizenship.. Valid values are `^[A-Z]{3}$`',
    `notes` STRING COMMENT 'Free-text notes and comments about the volunteer, including special considerations, preferences, feedback, and coordination details.',
    `onboarding_completion_date` DATE COMMENT 'Date when the volunteer completed all onboarding requirements and became eligible for deployment.',
    `onboarding_status` STRING COMMENT 'Current status of the volunteers onboarding process. Pending indicates application received, in progress indicates onboarding steps underway, completed indicates fully onboarded and ready for deployment, expired indicates onboarding credentials need renewal, and inactive indicates volunteer is not currently active.. Valid values are `pending|in progress|completed|expired|inactive`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the volunteer.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the volunteers residential address.',
    `preferred_name` STRING COMMENT 'The name the volunteer prefers to be called, which may differ from their legal name.',
    `primary_language` STRING COMMENT 'Two-letter ISO 639-1 language code representing the volunteers primary or preferred language for communication.. Valid values are `^[a-z]{2}$`',
    `recognition_level` STRING COMMENT 'Recognition tier or award level assigned to the volunteer based on their contribution hours, impact, and tenure. Used for volunteer appreciation programs and engagement tracking.. Valid values are `bronze|silver|gold|platinum|lifetime`',
    `secondary_languages` STRING COMMENT 'Comma-separated list of two-letter ISO 639-1 language codes representing additional languages the volunteer speaks, used for matching volunteers to beneficiary populations and field assignments.',
    `skills` STRING COMMENT 'Comma-separated list of skills, competencies, and professional qualifications the volunteer possesses, used for matching volunteers to program needs and deployment opportunities.',
    `state_province` STRING COMMENT 'State, province, or administrative region of the volunteers residential address.',
    `total_volunteer_hours` DECIMAL(18,2) COMMENT 'Cumulative total number of hours the volunteer has contributed across all assignments and programs since registration.',
    `volunteer_type` STRING COMMENT 'Classification of the volunteer based on their role and engagement model. Community health workers provide ongoing health services, field volunteers support program delivery, event-based supporters assist with specific events, skilled professionals offer specialized expertise, youth volunteers are under 25, and corporate volunteers come through employer partnerships.. Valid values are `community health worker|field volunteer|event-based supporter|skilled professional|youth volunteer|corporate volunteer`',
    `willing_to_travel` BOOLEAN COMMENT 'Indicates whether the volunteer is willing to travel outside their geographic base for assignments, deployments, or emergency response.',
    CONSTRAINT pk_volunteer PRIMARY KEY(`volunteer_id`)
) COMMENT 'Master record for all individuals who serve as volunteers across the organizations programs and events. Captures volunteer identity, contact details, demographic profile, volunteer type (community health worker, field volunteer, event-based supporter), onboarding status, availability, language skills, geographic base, emergency contact, and engagement history. This is the SSOT for volunteer identity within the volunteer domain, distinct from paid workforce managed in the workforce domain. Sourced from Microsoft Dynamics 365 for Nonprofits.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`application` (
    `application_id` BIGINT COMMENT 'Unique identifier for the volunteer application record. Primary key.',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Applications are submitted to and processed by specific country offices for local recruitment, background checks, and onboarding coordination. Essential for decentralized volunteer management and comp',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project for which the volunteer is applying.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Volunteers often apply to work specifically with a partner organization rather than directly with the lead NGO. Common in localization strategies where partners recruit and manage volunteers. Essentia',
    `psea_policy_id` BIGINT COMMENT 'Foreign key linking to safeguarding.psea_policy. Business justification: Volunteer applications require acknowledgment of current PSEA policy before approval. Compliance teams track which policy version each applicant acknowledged during onboarding. Standard safeguarding d',
    `role_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_role. Business justification: Volunteer applications are submitted FOR a specific volunteer role. The application has denormalized volunteer_role_type (STRING) which should be normalized to FK to volunteer_role catalog. This allow',
    `sanctions_screening_id` BIGINT COMMENT 'Foreign key linking to compliance.sanctions_screening. Business justification: Sanctions screening performed during application phase before volunteer acceptance. Donor compliance requirement for federally-funded programs. Links application to screening result that informed acce',
    `volunteer_id` BIGINT COMMENT 'Reference to the constituent or prospective volunteer who submitted this application.',
    `background_check_completed_date` DATE COMMENT 'The date on which the background check was completed.',
    `background_check_outcome` STRING COMMENT 'The final outcome or result of the background check process.. Valid values are `cleared|conditional|not_cleared`',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether a background check is required for this volunteer application based on role sensitivity and organizational policy.',
    `background_check_status` STRING COMMENT 'Current status of the background check process for the applicant.. Valid values are `not_required|pending|in_progress|cleared|failed|expired`',
    `code_of_conduct_signed` BOOLEAN COMMENT 'Indicates whether the volunteer has signed the organizations code of conduct and ethical standards agreement.',
    `commitment_duration_months` STRING COMMENT 'The number of months the applicant is willing to commit to the volunteer role.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this volunteer application record was first created in the system.',
    `application_date` DATE COMMENT 'The date on which the volunteer application was submitted by the applicant.',
    `decision_date` DATE COMMENT 'The date on which the final decision on the volunteer application was made.',
    `decision_made_by` STRING COMMENT 'Name or identifier of the staff member or committee who made the final decision on the application.',
    `decision_status` STRING COMMENT 'The final decision status on the volunteer application: whether the applicant has been accepted, rejected, or placed on a waitlist.. Valid values are `pending|accepted|rejected|waitlisted`',
    `emergency_contact_provided` BOOLEAN COMMENT 'Indicates whether the volunteer has provided emergency contact information as part of the onboarding process.',
    `hours_per_week` DECIMAL(18,2) COMMENT 'The number of hours per week the applicant is available to volunteer.',
    `interview_completed_date` DATE COMMENT 'The date on which the interview was conducted.',
    `interview_notes` STRING COMMENT 'Internal notes and observations recorded by the interviewer during or after the volunteer interview.',
    `interview_outcome` STRING COMMENT 'The outcome or recommendation resulting from the volunteer interview.. Valid values are `recommended|not_recommended|conditional`',
    `interview_required` BOOLEAN COMMENT 'Indicates whether an interview is required as part of the volunteer application process for this role.',
    `interview_scheduled_date` TIMESTAMP COMMENT 'The date and time when the interview with the applicant is scheduled.',
    `languages_spoken` STRING COMMENT 'Comma-separated list of languages the applicant speaks, relevant for field operations and beneficiary communication.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this volunteer application record was last updated or modified.',
    `motivation_statement` STRING COMMENT 'Applicants written statement explaining their motivation for volunteering and alignment with the organizations mission.',
    `number` STRING COMMENT 'Externally visible unique application reference number assigned to this volunteer application for tracking and communication purposes.. Valid values are `^VA-[0-9]{8}$`',
    `onboarding_completed_date` DATE COMMENT 'The date on which the volunteer successfully completed all onboarding requirements and is ready for deployment.',
    `onboarding_start_date` DATE COMMENT 'The date on which the volunteer onboarding process began.',
    `onboarding_status` STRING COMMENT 'Status of the volunteer onboarding process, including orientation, training, and administrative setup.. Valid values are `not_started|in_progress|completed|incomplete`',
    `orientation_completed` BOOLEAN COMMENT 'Indicates whether the volunteer has completed the required orientation session introducing them to the organizations mission, values, and policies.',
    `preferred_start_date` DATE COMMENT 'The date on which the applicant indicates they are available to begin volunteering.',
    `previous_volunteer_experience` STRING COMMENT 'Narrative description of the applicants prior volunteer experience with this organization or other NGOs, CSOs, or INGOs.',
    `recruitment_channel` STRING COMMENT 'The channel or source through which the applicant learned about the volunteer opportunity and submitted their application.. Valid values are `website|social_media|referral|event|partner_organization|direct_outreach`',
    `reference_check_completed_date` DATE COMMENT 'The date on which reference checks were completed.',
    `reference_check_status` STRING COMMENT 'Status of the reference check process, including verification of applicants professional or personal references.. Valid values are `not_started|in_progress|completed|satisfactory|unsatisfactory`',
    `rejection_reason` STRING COMMENT 'Explanation or reason provided for rejecting the volunteer application, if applicable.',
    `safeguarding_policy_acknowledged` BOOLEAN COMMENT 'Indicates whether the volunteer has acknowledged and agreed to the organizations safeguarding and protection policies.',
    `screening_completed_date` DATE COMMENT 'The date on which the initial screening process was completed.',
    `screening_status` STRING COMMENT 'Status of the initial screening process to assess applicant suitability and alignment with volunteer role requirements.. Valid values are `not_started|in_progress|completed|cleared|flagged`',
    `skills_offered` STRING COMMENT 'Comma-separated list or narrative description of the skills, competencies, and expertise the applicant brings to the volunteer role.',
    `application_status` STRING COMMENT 'Current lifecycle status of the volunteer application in the recruitment and onboarding workflow. [ENUM-REF-CANDIDATE: submitted|under_review|screening|interview_scheduled|accepted|rejected|withdrawn — 7 candidates stripped; promote to reference product]',
    `training_completed` BOOLEAN COMMENT 'Indicates whether the volunteer has completed all required role-specific training modules.',
    CONSTRAINT pk_application PRIMARY KEY(`application_id`)
) COMMENT 'Captures the end-to-end recruitment and onboarding application lifecycle for prospective volunteers. Tracks application submission date, recruitment channel, program of interest, screening status, background check outcome, reference check status, interview notes, acceptance or rejection decision, and onboarding completion milestones. Supports the Volunteer and Staff Recruitment and Management core business process.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`role` (
    `role_id` BIGINT COMMENT 'Unique identifier for the volunteer role. Primary key for the volunteer role catalog.',
    `intervention_id` BIGINT COMMENT 'add column program_intervention_id (BIGINT) with FK to program.intervention.intervention_id - volunteer roles are defined in the context of specific program interventions',
    `training_program_id` BIGINT COMMENT 'Foreign key linking to safeguarding.training_program. Business justification: Volunteer roles define required safeguarding training programs based on beneficiary contact level and risk. Role definitions specify which safeguarding training_program must be completed before deploy',
    `background_check_required` BOOLEAN COMMENT 'Indicates whether a formal background check or police clearance is required before assignment to this volunteer role, typically for roles involving vulnerable populations.',
    `role_code` STRING COMMENT 'Unique business identifier code for the volunteer role used across systems and documentation.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this volunteer role record was first created in the system.',
    `deployment_context` STRING COMMENT 'The operational context in which this volunteer role is typically deployed, aligned with program phases and humanitarian response cycles. [ENUM-REF-CANDIDATE: Emergency Response|Development Program|Advocacy Campaign|Community Outreach|Capacity Building|Disaster Relief|Long-Term Recovery — 7 candidates stripped; promote to reference product]',
    `role_description` STRING COMMENT 'Comprehensive description of the volunteer role including responsibilities, typical activities, and expected contributions to program outcomes.',
    `effective_end_date` DATE COMMENT 'Date when this volunteer role is scheduled to be discontinued or archived. Null for ongoing roles with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this volunteer role became or will become active and available for volunteer assignments.',
    `estimated_time_commitment_hours` DECIMAL(18,2) COMMENT 'Expected number of volunteer hours per week or per assignment period for this role, used for scheduling and capacity planning.',
    `functional_area` STRING COMMENT 'The primary program or operational area where this volunteer role is deployed. WASH (Water Sanitation and Hygiene), GBV (Gender-Based Violence), PSS (Psychosocial Support), MEAL (Monitoring Evaluation Accountability and Learning), ICT4D (Information and Communication Technology for Development). [ENUM-REF-CANDIDATE: WASH|GBV|PSS|Nutrition|Logistics|Health|Education|Protection|Shelter|Livelihoods|MEAL|Communications|Fundraising|Administration|ICT4D — 15 candidates stripped; promote to reference product]',
    `insurance_coverage_required` BOOLEAN COMMENT 'Indicates whether the organization must provide or verify insurance coverage (medical, liability, travel) for volunteers in this role.',
    `language_requirements` STRING COMMENT 'Languages required or preferred for this volunteer role, including proficiency levels, to ensure effective communication with beneficiaries and team members.',
    `last_modified_by` STRING COMMENT 'Identifier of the user or system that most recently updated this volunteer role record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this volunteer role record was most recently updated.',
    `maximum_concurrent_assignments` STRING COMMENT 'Maximum number of volunteers that can be simultaneously assigned to this role, used for capacity planning and deployment management.',
    `minimum_age_requirement` STRING COMMENT 'Minimum age in years that a volunteer must be to be eligible for this role, based on legal, safety, and program requirements.',
    `minimum_certification_requirements` STRING COMMENT 'Mandatory certifications, licenses, or formal qualifications required before a volunteer can be assigned to this role (e.g., First Aid, SPHERE certification, safeguarding training, drivers license).',
    `physical_demands` STRING COMMENT 'Level of physical exertion and mobility required for this volunteer role, ranging from sedentary office work to strenuous field activities.. Valid values are `None|Light|Moderate|Heavy|Extreme`',
    `preferred_skills` STRING COMMENT 'Comma-separated list of desirable but not mandatory skills that would enhance volunteer effectiveness in this role.',
    `recognition_program_eligible` BOOLEAN COMMENT 'Indicates whether volunteers in this role are eligible for formal recognition programs, awards, or certificates upon completion.',
    `remote_work_eligible` BOOLEAN COMMENT 'Indicates whether this volunteer role can be performed remotely or requires physical presence at a specific location.',
    `reporting_requirements` STRING COMMENT 'Description of reporting obligations for volunteers in this role, including frequency, format, and content of activity reports or timesheets.',
    `required_skills` STRING COMMENT 'Comma-separated list of essential skills, competencies, and technical abilities required to perform this volunteer role effectively.',
    `risk_level` STRING COMMENT 'Security and safety risk classification for this volunteer role based on deployment context, location, and nature of activities.. Valid values are `Low|Medium|High|Critical`',
    `safeguarding_training_required` BOOLEAN COMMENT 'Indicates whether completion of organizational safeguarding and protection training is mandatory before deployment in this role.',
    `role_status` STRING COMMENT 'Current lifecycle status of the volunteer role indicating whether it is available for recruitment and assignment.. Valid values are `Active|Inactive|Suspended|Under Review|Archived`',
    `stipend_amount` DECIMAL(18,2) COMMENT 'Standard stipend or per diem amount provided to volunteers in this role, if applicable. Null if no stipend is provided.',
    `stipend_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the stipend amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `stipend_eligible` BOOLEAN COMMENT 'Indicates whether volunteers in this role are eligible to receive a stipend, per diem, or other financial support to cover expenses.',
    `supervision_level` STRING COMMENT 'Level of supervision and oversight required for volunteers in this role, ranging from independent work to intensive direct supervision.. Valid values are `Independent|Minimal|Moderate|Close|Intensive`',
    `time_commitment_unit` STRING COMMENT 'Unit of measure for the estimated time commitment (e.g., hours per week, total hours for event-based roles).. Valid values are `Per Week|Per Month|Per Assignment|Per Event|Total`',
    `title` STRING COMMENT 'The official title of the volunteer role as presented to volunteers and used in recruitment materials.',
    `travel_required` BOOLEAN COMMENT 'Indicates whether this volunteer role requires travel to field sites, beneficiary locations, or other operational areas.',
    `role_type` STRING COMMENT 'Classification of the volunteer role by engagement model and location context.. Valid values are `Field|Office|Remote|Hybrid|Event-Based|Ongoing`',
    `typical_assignment_duration_days` STRING COMMENT 'Standard length of a volunteer assignment in this role measured in days, used for planning and volunteer expectation setting.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this volunteer role record.',
    CONSTRAINT pk_role PRIMARY KEY(`role_id`)
) COMMENT 'Defines the catalog of volunteer roles available across programs and field operations. Each role specifies the role title, functional area (e.g., WASH, GBV, PSS, nutrition, logistics), required skills, minimum certification requirements, physical demands, deployment context (field/office/remote), maximum concurrent assignments, and whether the role is active. Acts as the reference catalog for role-based volunteer deployment.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` (
    `volunteer_deployment_id` BIGINT COMMENT 'Unique identifier for the volunteer deployment record. Primary key.',
    `award_id` BIGINT COMMENT 'Identifier of the grant or funding source supporting this volunteer deployment position.',
    `chs_self_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.chs_self_assessment. Business justification: CHS Commitment 2 requires competent, supported volunteers. Deployments serve as evidence during CHS self-assessment (volunteer qualifications, supervision, support). Links deployment to assessment whe',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deployments are charged to cost centers for expense tracking, grant compliance reporting, and monthly budget-vs-actual analysis. Essential for Form 990 functional expense allocation and donor financia',
    `country_office_id` BIGINT COMMENT 'Identifier of the country office or regional office coordinating this volunteer deployment.',
    `distribution_order_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_order. Business justification: Volunteers support distribution operations (loading trucks, beneficiary registration, crowd management, distribution site setup). Linking deployments to specific distribution orders enables accurate v',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Deployments often tied to donor requirements (volunteer quotas, local volunteer percentages, specific skill requirements in grant agreements). Links deployment to donor requirement it satisfies for co',
    `field_team_id` BIGINT COMMENT 'Foreign key linking to field.team. Business justification: Field teams supervise deployed volunteers for daily activity coordination, security briefings, and resource allocation. Essential for operational management and volunteer safety oversight in field ope',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Deployments are funded by restricted or unrestricted funds. Grant managers track which fund pays for each deployment to ensure compliance with donor restrictions and award ceilings.',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Volunteer deployments directly contribute to indicator achievement (beneficiaries reached, services delivered). Donor reports require attribution of volunteer effort to specific indicators for USAID, ',
    `intervention_id` BIGINT COMMENT 'Identifier of the program to which the volunteer is assigned.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Field deployments require IT equipment (laptops, tablets, satellite phones). Nonprofits track asset assignment for accountability, insurance claims, and retrieval upon deployment end. Essential for as',
    `meal_plan_id` BIGINT COMMENT 'Foreign key linking to mel.meal_plan. Business justification: MEL plans specify volunteer engagement strategy, data collection roles, and volunteer-led monitoring activities. Deployments implement the MEL plans volunteer components. Essential for MEL plan execu',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Volunteers are routinely deployed to work with/through partner organizations in field operations. Essential for tracking volunteer placement arrangements, liability coverage, partnership performance m',
    `partnership_agreement_id` BIGINT COMMENT 'Foreign key linking to partnership.partnership_agreement. Business justification: Volunteer deployments under consortium or partnership agreements require tracking which agreement governs the deployment for compliance, insurance, liability determination, and donor reporting on part',
    `project_site_id` BIGINT COMMENT 'Identifier of the field location or project site where the volunteer is deployed.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: Volunteers are deployed to serve specific registered beneficiaries in case management, PSS, nutrition, and protection programs. Essential for tracking volunteer-beneficiary assignments and service del',
    `role_id` BIGINT COMMENT 'Identifier of the role or position the volunteer is performing during this deployment.',
    `risk_assessment_id` BIGINT COMMENT 'Foreign key linking to safeguarding.risk_assessment. Business justification: Deployments undergo safeguarding risk assessments before volunteer placement. Risk management teams assess power dynamics, vulnerable population access, and mitigation measures. Deployment approval de',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member responsible for supervising and managing the volunteer during this deployment.',
    `statutory_registration_id` BIGINT COMMENT 'Foreign key linking to compliance.statutory_registration. Business justification: Deployments require verification that the organization holds valid statutory registration in the deployment jurisdiction. Essential for legal volunteer operations and insurance coverage, particularly ',
    `volunteer_id` BIGINT COMMENT 'Identifier of the volunteer being deployed to the program or field operation.',
    `volunteer_team_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_team. Business justification: Volunteer deployments can be team-based assignments where the volunteer is deployed as part of a team structure. Not all deployments are team-based (many are individual), so this FK is nullable. This ',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Volunteers are frequently deployed to warehouse operations (inventory management, goods receipt, kit assembly, donation sorting). Tracking warehouse assignment is essential for security clearance, acc',
    `actual_end_date` DATE COMMENT 'The actual date the volunteer completed or left the deployment, which may differ from the scheduled deployment end date.',
    `actual_hours` DECIMAL(18,2) COMMENT 'The total number of volunteer hours actually contributed during this deployment, tracked for MEL and donor reporting.',
    `actual_start_date` DATE COMMENT 'The actual date the volunteer began work on the deployment, which may differ from the scheduled deployment start date.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the country where the volunteer is deployed.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this deployment record was first created in the system.',
    `end_date` DATE COMMENT 'Date when the volunteer deployment to the partner organization ended or is scheduled to end. Null indicates an ongoing deployment.',
    `fte_equivalent` DECIMAL(18,2) COMMENT 'The full-time equivalent contribution of the volunteer during this deployment, expressed as a decimal (e.g., 0.5000 for half-time, 1.0000 for full-time).',
    `hours_contributed` DECIMAL(18,2) COMMENT 'Total number of hours the volunteer has contributed during this specific deployment to this partner organization. Used for tracking volunteer engagement and reporting.',
    `location_name` STRING COMMENT 'The name of the specific location, community, or facility where the volunteer is deployed.',
    `modified_by` STRING COMMENT 'The username or identifier of the user who last modified this deployment record.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this deployment record was last modified in the system.',
    `notes` STRING COMMENT 'Free-text notes or comments about the deployment, including coordination details, performance observations, or special circumstances.',
    `number` STRING COMMENT 'Human-readable unique business identifier for the deployment assignment, used for tracking and reporting.. Valid values are `^VD-[0-9]{6,10}$`',
    `orientation_completed_date` DATE COMMENT 'The date when the volunteer completed the deployment-specific orientation or onboarding.',
    `orientation_completed_flag` BOOLEAN COMMENT 'Indicates whether the volunteer has completed the required orientation or onboarding for this specific deployment.',
    `performance_rating` DECIMAL(18,2) COMMENT 'Performance assessment score for the volunteer during this deployment, typically on a scale (e.g., 1.00 to 5.00). Reflects the partner organizations evaluation of the volunteers effectiveness in this specific assignment.',
    `planned_hours` DECIMAL(18,2) COMMENT 'The total number of volunteer hours planned or expected for this deployment assignment.',
    `priority` STRING COMMENT 'The priority level of this deployment assignment, indicating urgency and importance for resource allocation and coordination.. Valid values are `low|medium|high|critical|emergency`',
    `recognition_awarded_flag` BOOLEAN COMMENT 'Indicates whether the volunteer received formal recognition or an award for their contribution during this deployment.',
    `region` STRING COMMENT 'The administrative region, province, or district within the country where the volunteer is deployed.',
    `remote_deployment_flag` BOOLEAN COMMENT 'Indicates whether this is a remote or virtual deployment where the volunteer contributes remotely rather than being physically present at the project site.',
    `role` STRING COMMENT 'Specific role or function the volunteer performs during this deployment (e.g., Community Health Worker, Field Coordinator, Training Facilitator). The same volunteer may have different roles at different partner organizations.',
    `security_clearance_level` STRING COMMENT 'The level of security clearance required or obtained for this deployment, particularly relevant for high-risk or conflict-affected areas.. Valid values are `none|basic|standard|enhanced|critical`',
    `source_system_code` STRING COMMENT 'The unique identifier of this deployment record in the source system.',
    `special_conditions` STRING COMMENT 'Any special conditions, requirements, or accommodations associated with this deployment (e.g., remote work, hazard pay equivalent, specific equipment needs).',
    `start_date` DATE COMMENT 'Date when the volunteer deployment to the partner organization began. Tracks the beginning of the assignment period.',
    `volunteer_deployment_status` STRING COMMENT 'Current lifecycle status of the volunteer deployment: active (currently deployed), completed (assignment finished), withdrawn (volunteer left early), suspended (temporarily paused), pending (approved but not started), or cancelled (assignment cancelled before start).. Valid values are `active|completed|withdrawn|suspended|pending|cancelled`',
    `volunteer_deployment_type` STRING COMMENT 'Classification of the deployment based on the nature of the assignment: emergency response, development program, event support, capacity building, advocacy campaign, or disaster relief.. Valid values are `emergency_response|development_program|event_support|capacity_building|advocacy_campaign|disaster_relief`',
    `withdrawal_date` DATE COMMENT 'The date when the volunteer withdrew from or was removed from the deployment.',
    `withdrawal_reason` STRING COMMENT 'The reason provided when a volunteer withdraws from or is removed from a deployment before completion.',
    `created_by` STRING COMMENT 'The username or identifier of the user who created this deployment record.',
    CONSTRAINT pk_volunteer_deployment PRIMARY KEY(`volunteer_deployment_id`)
) COMMENT 'Authoritative operational record of a volunteers assignment to a specific program, project site, field operation, or event for a defined period. Captures deployment start and end dates, assigned program, field location or country office, role performed (FK to volunteer_role), deployment status (active, completed, withdrawn, suspended), supervising staff member, deployment type (emergency response, development program, event support), FTE equivalent contribution, grant or funding source supporting the position, and any special conditions or security clearance requirements. This is the SSOT for volunteer-to-program assignments, serving both field coordination and MEL/donor accountability reporting. Sourced from Microsoft Dynamics 365.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` (
    `hour_log_id` BIGINT COMMENT 'Unique identifier for the volunteer hour log entry. Primary key for the hour log record.',
    `component_id` BIGINT COMMENT 'Identifier of the program or project to which the volunteer hours are attributed. Enables program-level effort tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Volunteer hours are allocated to cost centers for indirect cost rate (NICRA) calculations, functional expense reporting on Form 990, and grant cost-share documentation. Required for annual audit trail',
    `distribution_event_id` BIGINT COMMENT 'Foreign key linking to field.distribution_event. Business justification: Volunteer hours during distributions must be attributed to specific events for donor reporting, cost allocation, and activity-based costing. Required for grant compliance and in-kind contribution valu',
    `distribution_order_id` BIGINT COMMENT 'Foreign key linking to supply.distribution_order. Business justification: Volunteer hours directly supporting specific distribution orders (packing commodities, transport escort, distribution point setup) must be linked to distribution orders for accurate in-kind contributi',
    `field_deployment_id` BIGINT COMMENT 'Identifier of the volunteer deployment or assignment context under which the hours were contributed. Links to volunteer_deployment.',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: In-kind volunteer hours must be tracked by fund for grant reporting when donors require cost-share or matching documentation. Essential for quarterly grant financial reports showing in-kind contributi',
    `gl_account_id` BIGINT COMMENT 'Foreign key reference to the finance GL account associated with this hour log entry',
    `indicator_id` BIGINT COMMENT 'Foreign key linking to mel.indicator. Business justification: Volunteer hours are tracked against specific indicators for donor reporting (e.g., volunteer hours contributed to health education as indicator). Required for USAID VKR, EU in-kind contribution repo',
    `mobile_health_outreach_id` BIGINT COMMENT 'Foreign key linking to field.mobile_health_outreach. Business justification: Community health volunteers conducting outreach sessions require hour tracking per session for health cluster reporting, DHIS2 integration, volunteer recognition milestones, and in-kind contribution d',
    `project_site_id` BIGINT COMMENT 'Identifier of the field project site or location where the volunteer hours were contributed. Links to field operations site master.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: Volunteers log hours against specific beneficiaries they serve for direct service delivery tracking. Required for donor reporting, impact measurement, and demonstrating beneficiary reach. Standard pra',
    `role_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_role. Business justification: Hour logs record time worked in the context of performing a specific volunteer role. The hour_log table has skill_utilized (STRING) which is a denormalized representation of the role/skill context. No',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to volunteer.schedule. Business justification: Hour logs often record time worked against scheduled shifts. While volunteers can log hours for ad-hoc activities not tied to a schedule, many hour logs are for scheduled activities. This FK (nullable',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or supervisor who approved the volunteer hours. Links to workforce or staff master record.',
    `volunteer_id` BIGINT COMMENT 'Identifier of the volunteer who contributed the hours. Links to the volunteer master record.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Volunteer hours logged at warehouse locations (sorting in-kind donations, physical inventory counts, emergency kit assembly) must capture warehouse location for cost center allocation, in-kind contrib',
    `wash_intervention_id` BIGINT COMMENT 'Foreign key linking to field.wash_intervention. Business justification: Volunteers supporting WASH activities (hygiene promotion, latrine construction supervision) need hours tracked against specific interventions for donor reports, cluster reporting, and in-kind contribu',
    `activity_description` STRING COMMENT 'Detailed narrative description of the volunteer activity performed during the logged hours. Provides context for the contribution.',
    `activity_type` STRING COMMENT 'Classification of the volunteer activity performed. Categorizes the nature of the volunteer contribution for reporting and analysis.. Valid values are `direct_service|administrative_support|fundraising_event|training_facilitation|community_outreach|monitoring_evaluation`',
    `approval_status` STRING COMMENT 'Current approval status of the volunteer hour log entry. Tracks the workflow state of the timesheet record.. Valid values are `pending|approved|rejected|under_review|auto_approved`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the volunteer hours were approved. Records the moment of supervisor sign-off.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking to detailed audit trail records for this hour log entry. Supports institutional donor compliance and audit requirements.',
    `beneficiary_count` STRING COMMENT 'Number of beneficiaries directly served or impacted during the volunteer activity. Supports MEL indicator calculation.',
    `cost_center` STRING COMMENT 'Cost center or organizational unit to which the volunteer hours are attributed. Supports internal cost allocation and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the hour log record was first created in the system. System audit field for record lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO currency code for the fair market value rate and in-kind value. Supports multi-currency volunteer operations.. Valid values are `^[A-Z]{3}$`',
    `hour_log_date` DATE COMMENT 'The calendar date on which the volunteer hours were contributed. Primary business event date for timesheet reporting.',
    `device_code` STRING COMMENT 'Identifier of the device used to submit or verify the volunteer hours. Supports digital check-in and GPS verification methods.',
    `donor_report_eligible` BOOLEAN COMMENT 'Flag indicating whether the volunteer hours are eligible for inclusion in donor reports and institutional compliance reporting.',
    `end_time` TIMESTAMP COMMENT 'Timestamp when the volunteer activity ended. Used to calculate duration and validate claimed hours.',
    `fair_market_value_rate` DECIMAL(18,2) COMMENT 'Fair market value rate per hour used to calculate the in-kind contribution value of volunteer hours. Based on IRS guidelines or local equivalents.',
    `grant_allocation_code` STRING COMMENT 'Grant or fund code to which the volunteer hours are allocated. Enables budget versus actual (BvA) reporting on volunteer effort.',
    `hours_claimed` DECIMAL(18,2) COMMENT 'Number of volunteer hours claimed or self-reported by the volunteer for the activity. Initial submission value before verification.',
    `hours_verified` DECIMAL(18,2) COMMENT 'Number of volunteer hours verified and approved by a supervisor or through automated validation. Final accepted value for reporting.',
    `in_kind_value` DECIMAL(18,2) COMMENT 'Calculated in-kind contribution value of the volunteer hours (hours_verified × fair_market_value_rate). Used for donor reporting and financial statements.',
    `is_group_activity` BOOLEAN COMMENT 'Flag indicating whether the volunteer activity was performed as part of a group or team (true) versus individually (false).',
    `is_overtime` BOOLEAN COMMENT 'Flag indicating whether the volunteer hours exceed the standard expected commitment for the period. Used for volunteer engagement monitoring.',
    `is_virtual` BOOLEAN COMMENT 'Flag indicating whether the volunteer activity was performed virtually or remotely (true) versus on-site (false).',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the volunteer activity location. Supports GPS-based verification and spatial analysis.',
    `location_name` STRING COMMENT 'Name or description of the specific location where the volunteer hours were contributed. Provides geographic context.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the volunteer activity location. Supports GPS-based verification and spatial analysis.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the hour log record was last modified. System audit field for change tracking and compliance.',
    `notes` STRING COMMENT 'Additional notes or comments about the volunteer hour log entry. Captures supervisor feedback, exceptions, or contextual information.',
    `recognition_milestone_triggered` BOOLEAN COMMENT 'Flag indicating whether this hour log entry triggered a volunteer recognition milestone (e.g., 100 hours, 500 hours). Used to automate recognition workflows.',
    `rejection_reason` STRING COMMENT 'Reason provided by the supervisor for rejecting the volunteer hour log entry. Populated only when approval_status is rejected.',
    `start_time` TIMESTAMP COMMENT 'Timestamp when the volunteer activity started. Provides precise timing for shift-based or event-based volunteer work.',
    `submission_method` STRING COMMENT 'Method or channel through which the volunteer submitted the hour log entry. Tracks data collection channel for quality assessment.. Valid values are `mobile_app|web_portal|paper_form|sms|email|kiosk`',
    `submitted_timestamp` TIMESTAMP COMMENT 'Date and time when the volunteer hour log entry was initially submitted by the volunteer. Records the moment of timesheet submission.',
    `verification_method` STRING COMMENT 'Method used to verify the volunteer hours. Indicates the level of validation applied to the hour log entry.. Valid values are `supervisor_signoff|digital_checkin|gps_verification|self_reported|biometric_scan|event_roster`',
    CONSTRAINT pk_hour_log PRIMARY KEY(`hour_log_id`)
) COMMENT 'Authoritative transactional record of volunteer hours contributed per activity, deployment, or event — the timesheet equivalent for unpaid contributors. Captures log date, volunteer (FK to volunteer), deployment or program context (FK to volunteer_deployment), activity type, location, hours claimed, hours verified, verification method (supervisor sign-off, digital check-in/GPS, self-reported), approval status, approving supervisor, and notes. Primary source for donor reporting on volunteer in-kind contributions (valued at fair market rates per IRS guidelines or local equivalents), MEL indicator tracking (e.g., volunteer-hours per beneficiary), recognition milestone triggers, and BvA reporting on volunteer effort allocation across grants. Supports audit trail requirements for institutional donor compliance.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique identifier for the volunteer schedule record. Primary key.',
    `distribution_event_id` BIGINT COMMENT 'Foreign key linking to field.distribution_event. Business justification: Volunteer schedules are tied to distribution events for beneficiary registration, queue management, and commodity handling. Critical for event staffing plans, volunteer hour attribution, and operation',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project for which this volunteer schedule is created. Links to program master data.',
    `project_site_id` BIGINT COMMENT 'Reference to the field location or project site where the volunteer will serve during this schedule. Links to project site master data.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: Volunteers are scheduled for appointments/sessions with specific beneficiaries (case management visits, PSS sessions, home visits, health education). Essential for appointment management, service deli',
    `role_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_role. Business justification: Schedules/shifts are created FOR specific volunteer roles. The schedule table has denormalized role_title and required_skills which duplicate data from volunteer_role. Adding volunteer_role_id FK allo',
    `staff_member_id` BIGINT COMMENT 'Reference to the staff member or volunteer coordinator responsible for managing this schedule. Links to workforce or volunteer master data.',
    `volunteer_deployment_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_deployment. Business justification: Schedules can be created within the context of a formal volunteer deployment. While some schedules are for ad-hoc activities or events outside formal deployments, many schedules are part of ongoing de',
    `volunteer_id` BIGINT COMMENT 'Reference to the volunteer assigned to this schedule. Links to the volunteer master data product.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Volunteer shift schedules at warehouse locations (weekend inventory counts, donation sorting events, emergency prepositioning operations) need warehouse assignment for access control coordination, fac',
    `activity_description` STRING COMMENT 'Detailed description of the volunteer activities, tasks, or responsibilities for this schedule. Provides context for volunteers about what they will be doing.',
    `actual_hours` DECIMAL(18,2) COMMENT 'Actual number of volunteer hours served, recorded after shift completion. May differ from planned hours due to early/late arrival or departure.',
    `assigned_volunteer_count` STRING COMMENT 'Number of volunteers currently assigned to this schedule. Used to track fulfillment against required count.',
    `attendance_status` STRING COMMENT 'Status of volunteer attendance for this schedule: scheduled (not yet started), checked_in (volunteer arrived), checked_out (volunteer departed), no_show (did not attend), excused_absence (absence approved), late (arrived after start time), early_departure (left before end time). [ENUM-REF-CANDIDATE: scheduled|checked_in|checked_out|no_show|excused_absence|late|early_departure — promote to reference product]',
    `cancellation_reason` STRING COMMENT 'Explanation for why the schedule was cancelled (e.g., Program postponed, Insufficient volunteers, Weather conditions, Volunteer unavailable).',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule was cancelled. Null if schedule was not cancelled.',
    `check_in_timestamp` TIMESTAMP COMMENT 'Date and time when the volunteer checked in or arrived for the shift. Used for attendance tracking and actual hours calculation.',
    `check_out_timestamp` TIMESTAMP COMMENT 'Date and time when the volunteer checked out or departed from the shift. Used for attendance tracking and actual hours calculation.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Date and time when the volunteer confirmed their acceptance of this schedule assignment. Represents a key lifecycle event.',
    `conflict_flag` BOOLEAN COMMENT 'Boolean indicator of whether this schedule conflicts with the volunteers availability or other assignments. True if conflict detected, False otherwise.',
    `conflict_reason` STRING COMMENT 'Description of the scheduling conflict if conflict_flag is true (e.g., Overlaps with another assignment, Outside volunteer availability window).',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule record was first created in the system. Audit trail field.',
    `location_address` STRING COMMENT 'Full street address of the volunteer assignment location. Organizational contact data classified as confidential.',
    `location_city` STRING COMMENT 'City or municipality where the volunteer assignment takes place.',
    `location_country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code for the volunteer assignment location (e.g., USA, GBR, KEN).. Valid values are `^[A-Z]{3}$`',
    `location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the volunteer assignment location. Used for mapping and Geographic Information System (GIS) integration.',
    `location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the volunteer assignment location. Used for mapping and Geographic Information System (GIS) integration.',
    `location_name` STRING COMMENT 'Name or description of the specific location where the volunteer will serve (e.g., Community Center, Mobile Clinic Site A, Distribution Point 3).',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule record was last modified. Audit trail field.',
    `schedule_name` STRING COMMENT 'Descriptive name or title for the volunteer schedule (e.g., Community Health Outreach - Morning Shift, Food Distribution - Weekend Team).',
    `notes` STRING COMMENT 'Free-text notes or comments about the schedule, including special instructions, volunteer feedback, or coordinator observations.',
    `number` STRING COMMENT 'Human-readable business identifier for the schedule, used for communication and coordination purposes (e.g., SCH-2024-001).',
    `override_approved` BOOLEAN COMMENT 'Boolean indicator of whether a scheduling conflict or policy exception has been approved by a coordinator. True if override approved, False otherwise.',
    `override_reason` STRING COMMENT 'Business justification for approving a scheduling override or exception (e.g., Emergency response requires additional coverage, Volunteer requested exception).',
    `planned_hours` DECIMAL(18,2) COMMENT 'Expected number of volunteer hours for this schedule, calculated from shift start and end times or manually entered for ongoing assignments.',
    `published_timestamp` TIMESTAMP COMMENT 'Date and time when the schedule was published and communicated to volunteers. Represents a key lifecycle event.',
    `recurrence_end_date` DATE COMMENT 'Date when the recurring schedule pattern ends. Null for one-time schedules or open-ended recurring schedules.',
    `recurrence_pattern` STRING COMMENT 'Indicates if and how this schedule recurs: none (one-time), daily, weekly, biweekly, monthly, custom (complex pattern defined elsewhere).. Valid values are `none|daily|weekly|biweekly|monthly|custom`',
    `required_volunteer_count` STRING COMMENT 'Number of volunteers needed for this schedule or shift. Used for capacity planning and coverage management.',
    `shift_end_timestamp` TIMESTAMP COMMENT 'Date and time when the volunteer shift or assignment ends. Used to calculate shift duration and volunteer hours.',
    `shift_start_timestamp` TIMESTAMP COMMENT 'Date and time when the volunteer shift or assignment begins. Represents the principal business event time for this schedule.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the volunteer schedule: draft (being planned), published (communicated to volunteers), confirmed (volunteer accepted), in_progress (shift underway), completed (shift finished), cancelled (schedule cancelled), no_show (volunteer did not attend). [ENUM-REF-CANDIDATE: draft|published|confirmed|in_progress|completed|cancelled|no_show — 7 candidates stripped; promote to reference product]',
    `schedule_type` STRING COMMENT 'Classification of the schedule by its nature: shift (regular time-bound shift), event (one-time event), field_assignment (field deployment), ongoing (continuous assignment), ad_hoc (unplanned), emergency_response (disaster/crisis response).. Valid values are `shift|event|field_assignment|ongoing|ad_hoc|emergency_response`',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Manages the scheduling of volunteers for specific shifts, activities, or field assignments within a program or event. Captures schedule period, shift start and end times, location, required volunteer count, assigned volunteers (FK to volunteer), schedule status (draft, published, confirmed, cancelled), scheduling conflicts or overrides, and recurrence patterns. Enables field coordinators to plan volunteer coverage across concurrent programs, manage shift swaps, and communicate rosters. Integrates with volunteer availability attributes on the volunteer master for conflict detection.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`training` (
    `training_id` BIGINT COMMENT 'Unique identifier for the training program. Primary key.',
    `governance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.governance_policy. Business justification: Training programs must align with board-approved policies (safeguarding policy mandates specific training, code of conduct requires orientation). Links training curriculum to authorizing governance po',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: Partner organizations frequently deliver training to volunteers (local context, safeguarding, technical skills). Tracking the delivering partner is essential for quality assurance, certification valid',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Training delivery uses LMS platforms (Moodle, TalentLMS, custom systems). Tracking which platform hosts each training enables access provisioning, integration with HR systems, and compliance reporting',
    `accrediting_body` STRING COMMENT 'Official organization or institution that accredits or endorses this training program, such as SPHERE Association, CHS Alliance, or national certification bodies.',
    `assessment_method` STRING COMMENT 'Method used to assess volunteer competency and completion: written exam, practical demonstration, project submission, peer review, or no formal assessment.. Valid values are `written_exam|practical_demonstration|project_submission|peer_review|no_assessment`',
    `available_languages` STRING COMMENT 'Comma-separated list of ISO 639-3 language codes for all languages in which this training is available, supporting multilingual volunteer populations.',
    `training_category` STRING COMMENT 'Classification of the training program. Categories include safety and security, technical skills, Core Humanitarian Standard (CHS) orientation, SPHERE standards, Gender-Based Violence (GBV) awareness, Protection from Sexual Exploitation and Abuse (PSEA), first aid, and other capacity-building areas.. Valid values are `safety_and_security|technical_skills|chs_orientation|sphere_standards|gbv_awareness|psea`',
    `certification_awarded` STRING COMMENT 'Name of the certificate or credential awarded to volunteers upon successful completion of the training program.',
    `certification_validity_months` STRING COMMENT 'Number of months the certification remains valid before renewal or recertification is required. Null if certification does not expire.',
    `chs_standard_alignment` STRING COMMENT 'Specific Core Humanitarian Standard (CHS) commitments that this training addresses, ensuring accountability and quality in humanitarian response.',
    `training_code` STRING COMMENT 'Externally-known unique code for the training program used in volunteer systems and communications.. Valid values are `^[A-Z0-9]{6,12}$`',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Average cost incurred by the organization per volunteer participant for delivering this training, including materials, facilitator fees, and venue costs. Used for budget planning and grant reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this training program record was first created in the system.',
    `delivery_modality` STRING COMMENT 'Method by which the training is delivered to volunteers: in-person classroom, e-learning online, blended (combination), virtual instructor-led, or self-paced.. Valid values are `in_person|e_learning|blended|virtual_instructor_led|self_paced`',
    `training_description` STRING COMMENT 'Detailed description of the training program content, learning objectives, and expected outcomes for volunteers.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the training program measured in hours, including all sessions and modules.',
    `effective_from_date` DATE COMMENT 'Date when this training program becomes available for volunteer enrollment and delivery.',
    `effective_until_date` DATE COMMENT 'Date when this training program is scheduled to be retired or replaced. Null if no end date is planned.',
    `facilitator_name` STRING COMMENT 'Name of the primary facilitator or instructor responsible for delivering the training program.',
    `funding_source` STRING COMMENT 'Name of the grant, donor, or internal budget line that funds this training program, supporting financial stewardship and compliance reporting.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this training is mandatory for specific volunteer roles or deployment types. True if required, False if optional.',
    `language` STRING COMMENT 'Primary language in which the training is delivered, using ISO 639-3 three-letter language codes (e.g., ENG for English, FRA for French, ARA for Arabic).. Valid values are `^[A-Z]{3}$`',
    `last_review_date` DATE COMMENT 'Date when the training content and materials were last reviewed and updated to ensure relevance and accuracy.',
    `mandatory_for_roles` STRING COMMENT 'Comma-separated list of volunteer role codes or titles for which this training is mandatory before deployment or assignment.',
    `materials_url` STRING COMMENT 'Web URL where training materials, resources, and documentation can be accessed by volunteers and facilitators.. Valid values are `^https?://.*$`',
    `max_participants` STRING COMMENT 'Maximum number of volunteers that can enroll in a single session or cohort of this training program. Null if no limit.',
    `modified_by` STRING COMMENT 'Name or identifier of the staff member or partner who last modified this training program record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this training program record was last modified in the system.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review and update of the training program content and materials.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage score required for volunteers to pass the training assessment and receive certification. Null if no assessment.',
    `prerequisites` STRING COMMENT 'Required prior training, certifications, or experience that volunteers must have before enrolling in this training program.',
    `sdg_alignment` STRING COMMENT 'Comma-separated list of United Nations Sustainable Development Goal (SDG) numbers that this training program supports (e.g., SDG 3 Good Health, SDG 4 Quality Education).',
    `sphere_standard_alignment` STRING COMMENT 'Specific SPHERE Humanitarian Charter and Minimum Standards chapters or technical standards that this training covers (e.g., WASH, Shelter, Health).',
    `training_status` STRING COMMENT 'Current lifecycle status of the training program: draft (under development), active (available for enrollment), suspended (temporarily unavailable), retired (no longer offered), or under review (being updated).. Valid values are `draft|active|suspended|retired|under_review`',
    `target_audience` STRING COMMENT 'Description of the intended volunteer audience for this training, such as community health workers, field volunteers, event-based supporters, or program-specific volunteers.',
    `title` STRING COMMENT 'Full title of the training program or workshop as presented to volunteers.',
    `version` STRING COMMENT 'Version number of the training program content, following semantic versioning (e.g., 1.0, 2.1), to track curriculum updates and revisions.. Valid values are `^[0-9]+.[0-9]+$`',
    `created_by` STRING COMMENT 'Name or identifier of the staff member or partner who created this training program record in the system.',
    CONSTRAINT pk_training PRIMARY KEY(`training_id`)
) COMMENT 'Catalog of training programs, workshops, and capacity-building courses available to volunteers. Captures training title, delivery modality (in-person, e-learning, blended), training category (safety and security, technical skills, CHS orientation, SPHERE standards, GBV awareness, PSEA, first aid), duration, facilitator, accrediting body, certification awarded upon completion, and whether training is mandatory for specific roles. Distinct from the workforce LMS — this catalog is specific to volunteer capacity building.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` (
    `training_enrollment_id` BIGINT COMMENT 'Unique identifier for the training enrollment record. Primary key.',
    `obligation_id` BIGINT COMMENT 'Foreign key linking to compliance.obligation. Business justification: Mandatory training tied to compliance obligations (safeguarding training for child protection laws, financial training for grant compliance). Tracks which enrollments satisfy specific regulatory or do',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Training costs are allocated to cost centers when organization pays for volunteer training. Supports training budget tracking, cost recovery analysis, and capacity-building expenditure reporting to do',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Training expenses are charged to specific funds, often restricted grants requiring capacity building or volunteer development. Essential for grant compliance reporting and demonstrating allowable trai',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Links volunteer training enrollment to staff member who delivered the training. Essential for instructor workload management, training quality assessment, and compliance with training delivery standar',
    `intervention_id` BIGINT COMMENT 'Identifier of the program context for which this training enrollment is required or associated.',
    `partner_org_id` BIGINT COMMENT 'Foreign key linking to partnership.partner_org. Business justification: When volunteers take training delivered by a partner organization, this link tracks the delivery partner for certification validation, quality assurance, and partnership reporting. Essential for capac',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: Beneficiaries enroll in capacity-building training delivered or facilitated by volunteers (livelihoods, life skills, vocational training, health education). Core program activity linking beneficiary d',
    `training_id` BIGINT COMMENT 'Identifier of the training course in which the volunteer is enrolled.',
    `user_account_id` BIGINT COMMENT 'Foreign key linking to technology.user_account. Business justification: Learners need system access to complete online training. This link enables automatic account provisioning, tracks which account completed which training, and supports single sign-on. Critical for digi',
    `volunteer_id` BIGINT COMMENT 'Identifier of the volunteer enrolled in the training course.',
    `assessment_attempts` STRING COMMENT 'Number of times the volunteer attempted the training course assessment.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score achieved by the volunteer on the training course assessment or examination, typically expressed as a percentage.',
    `certificate_expiry_date` DATE COMMENT 'Date on which the training certificate expires and requires renewal or recertification.',
    `certificate_issue_date` DATE COMMENT 'Date on which the training certificate was issued to the volunteer.',
    `certificate_number` STRING COMMENT 'Unique certificate reference number issued to the volunteer upon successful completion of the training course.',
    `certification_issued_flag` BOOLEAN COMMENT 'Indicates whether a certification was issued to the volunteer upon successful completion of the training course.',
    `compliance_training_category` STRING COMMENT 'Category of compliance or regulatory training that this enrollment represents, such as Protection from Sexual Exploitation and Abuse (PSEA), Core Humanitarian Standard (CHS), safeguarding, data protection, health and safety, or financial integrity. [ENUM-REF-CANDIDATE: psea|chs|safeguarding|data_protection|health_safety|financial_integrity|other — 7 candidates stripped; promote to reference product]',
    `continuing_education_credits` DECIMAL(18,2) COMMENT 'Number of continuing education or professional development credits earned by the volunteer upon successful completion of the training course.',
    `cost` DECIMAL(18,2) COMMENT 'Cost incurred by the organization for enrolling the volunteer in the training course, including tuition, materials, and administrative fees.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the training enrollment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the enrollment cost.. Valid values are `^[A-Z]{3}$`',
    `training_enrollment_date` DATE COMMENT 'Date on which the volunteer was enrolled in the training course.',
    `feedback_comments` STRING COMMENT 'Free-text comments provided by the volunteer regarding their experience with the training course, including suggestions for improvement.',
    `feedback_rating` STRING COMMENT 'Numeric rating provided by the volunteer evaluating the quality and effectiveness of the training course, typically on a scale of 1 to 5.',
    `funding_source` STRING COMMENT 'Source of funding or budget allocation used to cover the cost of the training enrollment, such as a specific grant, donor, or organizational budget line.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the training enrollment record was last updated or modified in the system.',
    `mandatory_training_flag` BOOLEAN COMMENT 'Indicates whether this training course is mandatory for the volunteer based on their role, program assignment, or organizational policy (e.g., PSEA, CHS, safeguarding).',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to the training enrollment, including special accommodations, exceptions, or contextual information.',
    `number` STRING COMMENT 'Human-readable unique enrollment reference number assigned to this training enrollment for tracking and reporting purposes.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the training course assessment, typically expressed as a percentage.',
    `recertification_due_date` DATE COMMENT 'Date by which the volunteer must complete recertification or refresher training to maintain their certification status.',
    `recertification_required_flag` BOOLEAN COMMENT 'Indicates whether the volunteer is required to undergo recertification or refresher training after the certificate expiry date.',
    `source` STRING COMMENT 'Source or channel through which the volunteer was enrolled in the training course.. Valid values are `self_enrolled|manager_assigned|program_required|hr_assigned|system_triggered`',
    `training_enrollment_status` STRING COMMENT 'Current lifecycle status of the training enrollment indicating the volunteers progress through the course.. Valid values are `registered|in_progress|completed|failed|withdrawn|cancelled`',
    `training_completion_date` DATE COMMENT 'Date on which the volunteer successfully completed the training course.',
    `training_delivery_mode` STRING COMMENT 'Mode or format in which the training course was delivered to the volunteer.. Valid values are `in_person|online|hybrid|self_paced|webinar|workshop`',
    `training_hours` DECIMAL(18,2) COMMENT 'Total number of hours the volunteer spent in the training course, including instruction, practice, and assessment time.',
    `training_language` STRING COMMENT 'Primary language in which the training course content was delivered to the volunteer.',
    `training_location` STRING COMMENT 'Physical location or facility where the training course was conducted, if applicable for in-person or hybrid delivery modes.',
    `training_start_date` DATE COMMENT 'Date on which the volunteer began the training course.',
    `training_withdrawal_date` DATE COMMENT 'Date on which the volunteer withdrew from the training course before completion.',
    `withdrawal_reason` STRING COMMENT 'Reason provided by the volunteer or organization for withdrawing from the training course before completion.',
    CONSTRAINT pk_training_enrollment PRIMARY KEY(`training_enrollment_id`)
) COMMENT 'Transactional record of a volunteers enrollment in and completion of a specific training course. Captures enrollment date, training, volunteer, enrollment status (registered, in-progress, completed, failed, withdrawn), completion date, assessment score, certification issued, certificate expiry date, and continuing education credits earned. Supports compliance tracking for mandatory training (e.g., PSEA, CHS) and volunteer certification management.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique identifier for the certification record. Primary key for the certification entity.',
    `commodity_id` BIGINT COMMENT 'Foreign key linking to supply.commodity. Business justification: Commodity-specific certifications (certified to handle controlled medical supplies, food safety certification for nutrition commodities, hazmat certification for chemical storage) must link to commodi',
    `governance_policy_id` BIGINT COMMENT 'Foreign key linking to compliance.governance_policy. Business justification: Certifications must meet standards defined in governance policies (safeguarding policy specifies required certifications, volunteer management policy defines minimum qualifications). Links certificati',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Tracks which staff member verified volunteer certification authenticity. Critical for audit trail, compliance with safeguarding requirements, and accountability in volunteer credentialing process. No ',
    `volunteer_id` BIGINT COMMENT 'Identifier of the volunteer who holds this certification. Links to the volunteer master record.',
    `accreditation_body` STRING COMMENT 'Name of the accreditation or regulatory body that oversees the issuing organization (e.g., national medical board, international humanitarian standards body). Used for credential validation.',
    `assessment_passing_score` DECIMAL(18,2) COMMENT 'Minimum score required to pass the certification assessment. Used to determine whether the volunteer met competency standards.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score or grade achieved on the certification assessment or examination. Null if no formal assessment was conducted.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued by the certifying body. Used for verification and audit purposes.',
    `compliance_category` STRING COMMENT 'Regulatory or organizational compliance category this certification satisfies: Protection from Sexual Exploitation and Abuse (PSEA), safeguarding, data protection, security clearance, health and safety, ethics, or none for non-compliance certifications. [ENUM-REF-CANDIDATE: psea|safeguarding|data_protection|security|health_safety|ethics|none — 7 candidates stripped; promote to reference product]',
    `continuing_education_hours` DECIMAL(18,2) COMMENT 'Number of continuing education or professional development hours required for renewal. Null if not applicable.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to obtain or renew the certification. Used for volunteer investment tracking and reimbursement processing.',
    `cost_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the certification cost amount.',
    `country_of_issue` STRING COMMENT 'Three-letter ISO country code of the country where the certification was issued. Relevant for professional licenses and country-specific credentials.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system. Used for audit trail and data lineage tracking.',
    `deployment_eligible` BOOLEAN COMMENT 'Indicates whether this certification qualifies the volunteer for field deployment. True for certifications that meet deployment readiness criteria (verified, current, and role-appropriate).',
    `evidence_document_reference` STRING COMMENT 'Reference identifier or file path to the supporting documentation (certificate scan, transcript, license copy) stored in the document management system.',
    `expiry_date` DATE COMMENT 'Date when the certification expires and requires renewal. Null for certifications with no expiration (e.g., academic degrees, lifetime licenses).',
    `issue_date` DATE COMMENT 'Date when the certification or credential was originally issued to the volunteer.',
    `issuing_body` STRING COMMENT 'Name of the organization, institution, or authority that issued the certification (e.g., Red Cross, Sphere Association, Ministry of Health, professional licensing board, internal training department).',
    `language_of_certification` STRING COMMENT 'Primary language in which the certification training and assessment were conducted. Important for language-specific skill matching and deployment planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was most recently updated. Used for audit trail and change tracking.',
    `last_verified_date` DATE COMMENT 'Date when the certification was most recently verified by the organization through documentation review or third-party confirmation.',
    `mandatory_for_role` BOOLEAN COMMENT 'Indicates whether this certification is mandatory (required) for the volunteers assigned role versus preferred (nice-to-have). Used for deployment readiness assessment and compliance tracking.',
    `certification_name` STRING COMMENT 'Full name of the certification, credential, or training program (e.g., Certified Emergency Medical Technician, SPHERE Practitioner Certificate, PSEA Compliance Training, Community Health Worker Level 2).',
    `notes` STRING COMMENT 'Free-text notes providing additional context about the certification, including special conditions, restrictions, verification challenges, or other relevant information for volunteer coordinators.',
    `proficiency_level` STRING COMMENT 'Level of proficiency or competency in the skill: beginner (basic awareness), intermediate (can perform with supervision), advanced (can perform independently), expert (can train others), master (recognized authority).. Valid values are `beginner|intermediate|advanced|expert|master`',
    `recognized_by_organization` BOOLEAN COMMENT 'Indicates whether this certification is formally recognized and accepted by the organization for volunteer deployment and role assignment. False for certifications that are recorded but not organizationally endorsed.',
    `reimbursed_by_organization` BOOLEAN COMMENT 'Indicates whether the organization reimbursed the volunteer for the cost of obtaining this certification. Used for financial tracking and volunteer benefit reporting.',
    `renewal_frequency_months` STRING COMMENT 'Number of months between required renewals for time-limited certifications. Null if renewal is not required or frequency is irregular.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether this certification requires periodic renewal to remain valid. True for time-limited certifications (e.g., first aid, PSEA training), false for permanent credentials.',
    `skill_category` STRING COMMENT 'Primary category of the skill or competency. Aligns with organizational skill taxonomy including medical, logistics, language, psychosocial support (PSS), Water Sanitation and Hygiene (WASH), Information and Communication Technology for Development (ICT4D), community mobilization, protection, nutrition, and education. [ENUM-REF-CANDIDATE: medical|logistics|language|psychosocial|wash|ict4d|community_mobilization|protection|nutrition|education — 10 candidates stripped; promote to reference product]',
    `skill_name` STRING COMMENT 'Specific name of the skill or competency (e.g., First Aid, Community Health Worker Training, SPHERE Standards, Gender-Based Violence (GBV) Response, Mid-Upper Arm Circumference (MUAC) Screening, Psychosocial Support (PSS) Facilitation).',
    `training_hours` DECIMAL(18,2) COMMENT 'Total number of training or instruction hours completed to earn this certification. Used for volunteer contribution tracking and competency assessment.',
    `certification_type` STRING COMMENT 'Type of certification record: professional license (e.g., nursing, medical), certificate (e.g., first aid, SPHERE practitioner), training completion, self-assessed proficiency, verified competency, or compliance certificate (e.g., Protection from Sexual Exploitation and Abuse (PSEA), safeguarding).. Valid values are `professional_license|certificate|training_completion|self_assessed|verified_competency|compliance_certificate`',
    `verification_status` STRING COMMENT 'Current verification status of the certification: verified (documentation confirmed), pending verification (under review), self-reported (not yet verified), expired (past validity date), revoked (withdrawn by issuer), not verified (no documentation provided).. Valid values are `verified|pending_verification|self_reported|expired|revoked|not_verified`',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Unified competency and credential product — the single source of truth for all skills taxonomy and individual volunteer credentials within the volunteer domain. As REFERENCE CATALOG: defines skill categories (medical, logistics, language, psychosocial, WASH, ICT4D, community mobilization), proficiency levels, role-to-skill requirements, and mandatory vs. preferred designations for volunteer_role entries. As INDIVIDUAL RECORDS: tracks specific credentials held by each volunteer including professional licenses, first aid certificates, SPHERE practitioner credentials, PSEA compliance certificates, verified and self-assessed proficiency levels, issuing body, issue and expiry dates, certificate numbers, verification status, renewal requirements, and evidence document references. Supports skill-based volunteer matching, competency gap analysis, compliance tracking, deployment readiness assessment, and training needs identification.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`recognition` (
    `recognition_id` BIGINT COMMENT 'Unique identifier for the volunteer recognition record. Primary key.',
    `constituent_id` BIGINT COMMENT 'Foreign key linking to donor.constituent. Business justification: Tracking constituent identity of recognized volunteers enables integrated stewardship strategies and major gift cultivation. Volunteers who receive recognition are high-engagement prospects. Supports ',
    `country_office_id` BIGINT COMMENT 'Identifier of the country office or field location that awarded this recognition. Links to the country office master record. Supports geographic analysis of volunteer engagement.',
    `intervention_id` BIGINT COMMENT 'Identifier of the program or project context in which the volunteer earned this recognition. Links to the program master record. Nullable for organization-wide recognitions not tied to a specific program.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member or manager who approved this recognition. Links to the workforce master record. Nullable if recognition is still pending approval.',
    `recognition_nominator_staff_member_id` BIGINT COMMENT 'Identifier of the person (staff member, volunteer, or partner) who nominated this volunteer for recognition. Links to the workforce or volunteer master record. Nullable for system-generated recognitions based on automated milestones.',
    `volunteer_deployment_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_deployment. Business justification: Recognition awards are often tied to performance in a specific deployment assignment. While some recognition is general (e.g., lifetime achievement), many awards are deployment-specific (e.g., outstan',
    `volunteer_id` BIGINT COMMENT 'Identifier of the volunteer receiving this recognition. Links to the volunteer master record managed in Microsoft Dynamics 365 for Nonprofits.',
    `nominating_staff_member_id` BIGINT COMMENT '',
    `approval_date` DATE COMMENT 'Date on which the recognition nomination was approved by the authorizing manager or committee. Nullable if recognition is still pending approval.',
    `award_date` DATE COMMENT 'Date on which the recognition was formally presented or awarded to the volunteer. Represents the principal business event timestamp for this recognition.',
    `award_description` STRING COMMENT 'Detailed narrative describing the reason for the recognition, the volunteers contributions, and the impact achieved. Used in certificates, announcements, and donor reports.',
    `award_title` STRING COMMENT 'Formal name or title of the recognition award. Examples: Volunteer of the Year, 500 Hours Service Award, Outstanding Community Health Worker, Emergency Response Excellence Award.',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a formal certificate or award document was issued to the volunteer. True if certificate was generated and delivered, false otherwise.',
    `certificate_number` STRING COMMENT 'Unique identifier printed on the formal certificate document, formatted as CERT- followed by 10 digits. Used for verification and authenticity. Nullable if no certificate was issued.. Valid values are `^CERT-[0-9]{10}$`',
    `channel` STRING COMMENT 'Medium or platform through which the recognition was communicated or presented. Ceremony indicates in-person event, newsletter indicates organizational publication, social media indicates public digital acknowledgment, certificate indicates formal document, email indicates direct communication, internal portal indicates intranet posting.. Valid values are `ceremony|newsletter|social_media|certificate|email|internal_portal`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this recognition record was first created in the system. Audit field for data lineage and compliance.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the monetary value. Examples: USD, EUR, GBP. Nullable if no monetary value is associated.. Valid values are `^[A-Z]{3}$`',
    `hours_milestone_threshold` STRING COMMENT 'Cumulative volunteer hours threshold that triggered this recognition, if applicable. For example, 100 hours, 500 hours, 1000 hours milestones. Nullable for recognitions not based on hours served.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this recognition record was last updated. Audit field for change tracking and data quality monitoring.',
    `monetary_value` DECIMAL(18,2) COMMENT 'Monetary value of any tangible award or gift accompanying the recognition, in the organizations functional currency. Used for budget tracking and tax reporting. Nullable for non-monetary recognitions.',
    `nomination_date` DATE COMMENT 'Date on which the volunteer was nominated for this recognition. Precedes approval and award dates in the recognition lifecycle.',
    `nominator_type` STRING COMMENT 'Category of the nominator. Staff indicates organizational employee, volunteer indicates peer volunteer, partner indicates external partner organization representative, beneficiary indicates program participant, system indicates automated milestone-based nomination.. Valid values are `staff|volunteer|partner|beneficiary|system`',
    `notes` STRING COMMENT 'Additional internal notes or comments about the recognition, including context, special circumstances, or follow-up actions. Not typically shared externally.',
    `number` STRING COMMENT 'Human-readable business identifier for the recognition event, formatted as REC- followed by 8 digits. Used for tracking and reference in volunteer engagement reports.. Valid values are `^REC-[0-9]{8}$`',
    `public_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the volunteer consented to public acknowledgment of this recognition in external communications, social media, or donor reports. True if public acknowledgment is permitted, false if volunteer requested privacy.',
    `skills_category` STRING COMMENT 'Specific skill area or competency domain for which the volunteer is being recognized, if applicable. Examples: Community Health, Data Collection, Logistics, Psychosocial Support (PSS), Water Sanitation and Hygiene (WASH). Nullable for non-skills-based recognitions. [ENUM-REF-CANDIDATE: community_health|data_collection|logistics|pss|wash|nutrition|education|protection|emergency_response — promote to reference product]',
    `recognition_status` STRING COMMENT 'Current lifecycle state of the recognition. Nominated indicates initial submission, approved indicates management approval, awarded indicates formal presentation completed, declined indicates volunteer opted out, revoked indicates withdrawn due to policy violation.. Valid values are `nominated|approved|awarded|declined|revoked`',
    `recognition_type` STRING COMMENT 'Category of recognition awarded to the volunteer. Includes length-of-service award (milestone anniversaries), outstanding contribution (exceptional impact), skills milestone (competency achievement), program completion certificate (training or project completion), public acknowledgment (featured in communications), and peer nomination (colleague-nominated honors).. Valid values are `length_of_service_award|outstanding_contribution|skills_milestone|program_completion_certificate|public_acknowledgment|peer_nomination`',
    CONSTRAINT pk_recognition PRIMARY KEY(`recognition_id`)
) COMMENT 'Records formal and informal recognition events awarded to volunteers for contributions, milestones, and achievements. Captures recognition type (length-of-service award, outstanding contribution, skills milestone, program completion certificate, public acknowledgment, peer nomination), award date, awarding program or country office, recognition channel (ceremony, newsletter, social media, certificate), associated volunteer hours milestone threshold, nominator, and approval status. Supports volunteer retention and motivation strategies aligned with organizational volunteer engagement policy.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` (
    `volunteer_team_id` BIGINT COMMENT 'Unique identifier for the volunteer team. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Volunteer teams operate within cost center structures for budget accountability. Team-level budget allocation, equipment costs, and operational expenses are tracked by cost center for financial manage',
    `country_office_id` BIGINT COMMENT 'Foreign key linking to field.country_office. Business justification: Volunteer teams operate under country office administrative oversight for compliance, budget allocation, and reporting. Required for organizational hierarchy, resource management, and country-level vo',
    `finance_fund_id` BIGINT COMMENT 'Foreign key linking to finance.finance_fund. Business justification: Volunteer teams are funded by specific grants or unrestricted funds. Grant managers track team-level expenditures (equipment, training, stipends) against award budgets for compliance and financial rep',
    `intervention_id` BIGINT COMMENT 'Identifier of the program or project to which this volunteer team is affiliated and deployed.',
    `volunteer_id` BIGINT COMMENT 'Identifier of the volunteer who serves as the team lead or coordinator. May be null if led by staff.',
    `project_site_id` BIGINT COMMENT 'Identifier of the primary field project site or geographic location where this team operates.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who serves as the team supervisor or coordinator. May be null if led by a volunteer.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Volunteer teams assigned to specific warehouses (warehouse management committees, inventory audit teams, donation processing teams) require warehouse linkage for team coordination, performance trackin',
    `beneficiaries_served_count` STRING COMMENT 'Cumulative count of unique beneficiaries or Persons of Concern (PoC) served by this team since formation.',
    `budget_allocation` DECIMAL(18,2) COMMENT 'The financial budget allocated to support this volunteer teams operations, including training, supplies, and recognition activities. Stored in the organizations base currency.',
    `volunteer_team_code` STRING COMMENT 'Short alphanumeric code or identifier used for quick reference and operational communication (e.g., CHW-D5, EDT-ALPHA, PSS-RCB).',
    `communication_channel` STRING COMMENT 'The primary communication channel or platform used for team coordination and information sharing. [ENUM-REF-CANDIDATE: whatsapp|email|sms|radio|in_person|microsoft_teams|other — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this volunteer team record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the budget allocation (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `current_member_count` STRING COMMENT 'The current number of active volunteers who are members of this team.',
    `dissolution_date` DATE COMMENT 'The date on which the volunteer team was officially dissolved or deactivated. Null if the team is still active.',
    `equipment_assigned` STRING COMMENT 'Description or list of equipment, supplies, or Non-Food Items (NFI) assigned to the team for operational use (e.g., Mobile tablets, first aid kits, distribution tents, hygiene kits).',
    `formation_date` DATE COMMENT 'The date on which the volunteer team was officially formed and became operational.',
    `geographic_area` STRING COMMENT 'Textual description of the geographic area, district, camp, or community where the team is deployed (e.g., District 5, Northern Province, Refugee Camp B, Sector 3).',
    `last_modified_by` STRING COMMENT 'Username or identifier of the system user who last modified this team record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this volunteer team record was last updated in the system.',
    `last_performance_review_date` DATE COMMENT 'The date of the most recent performance review or evaluation conducted for this team.',
    `meeting_frequency` STRING COMMENT 'The regular frequency at which the team holds coordination or planning meetings.. Valid values are `daily|weekly|biweekly|monthly|as_needed|none`',
    `volunteer_team_name` STRING COMMENT 'The official name or designation of the volunteer team (e.g., Community Health Worker Group - District 5, Emergency Distribution Team Alpha, PSS Support Group - Refugee Camp B).',
    `notes` STRING COMMENT 'Free-text field for additional notes, observations, or context about the teams operations, challenges, achievements, or special considerations.',
    `operational_hours` STRING COMMENT 'Textual description of the typical operational hours or shift schedule for the team (e.g., 08:00-17:00 Mon-Fri, 24/7 rotation, Event-based).',
    `performance_rating` STRING COMMENT 'Overall performance assessment or rating of the team based on Monitoring Evaluation and Learning (MEL) criteria, service delivery quality, and beneficiary feedback.. Valid values are `excellent|good|satisfactory|needs_improvement|not_rated`',
    `primary_language` STRING COMMENT 'The primary language used for communication and coordination within the team and with beneficiaries (e.g., English, French, Arabic, Swahili).',
    `recognition_awards_count` STRING COMMENT 'Total number of recognition awards, certificates, or commendations received by the team for outstanding service.',
    `required_certifications` STRING COMMENT 'Comma-separated list of certifications or training modules required for team membership (e.g., First Aid, SPHERE Standards, Protection Principles, PSS Basics).',
    `safety_incidents_count` STRING COMMENT 'Total number of safety or security incidents involving team members during operations.',
    `secondary_languages` STRING COMMENT 'Additional languages spoken by team members, stored as a comma-separated list (e.g., Spanish, Portuguese).',
    `volunteer_team_status` STRING COMMENT 'Current operational status of the volunteer team in its lifecycle.. Valid values are `active|inactive|suspended|disbanded|on_hold|forming`',
    `target_member_count` STRING COMMENT 'The planned or target number of volunteers intended to be part of this team for optimal operational capacity.',
    `total_volunteer_hours` DECIMAL(18,2) COMMENT 'Cumulative total of volunteer hours contributed by all team members since team formation.',
    `training_completion_required` BOOLEAN COMMENT 'Indicates whether all team members are required to complete specific training or certification before joining the team.',
    `volunteer_team_type` STRING COMMENT 'Classification of the volunteer team based on its primary function and operational focus. PSS refers to Psychosocial Support, WASH refers to Water Sanitation and Hygiene. [ENUM-REF-CANDIDATE: community_health_worker_group|distribution_team|pss_support_group|event_crew|wash_team|nutrition_outreach_team|education_support_team|protection_response_team|logistics_support_team|other — 10 candidates stripped; promote to reference product]',
    `created_by` STRING COMMENT 'Username or identifier of the system user who created this team record.',
    CONSTRAINT pk_volunteer_team PRIMARY KEY(`volunteer_team_id`)
) COMMENT 'Defines volunteer teams or groups organized for specific programs, field operations, or community outreach activities, including team roster membership. Captures team name, team type (community health worker group, distribution team, PSS support group, event crew), program affiliation, geographic area of operation, team lead (volunteer or staff FK), formation and dissolution dates, current status, and member roster with individual roles, join/exit dates, and leadership responsibilities within the team. Enables group-level coordination, communication, shift planning, and historical team composition reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` (
    `incident_report_id` BIGINT COMMENT 'Unique identifier for the volunteer incident report record. Primary key.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: Incidents involving beneficiaries during volunteer service delivery must be tracked for safeguarding, protection incident reporting, and duty of care. Links incidents to affected beneficiaries for cas',
    `compliance_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.incident. Business justification: Volunteer incidents (safeguarding violations, fraud, misconduct) trigger formal compliance incidents requiring investigation, donor notification, and regulatory reporting. Links volunteer incident to ',
    `component_id` BIGINT COMMENT 'Identifier of the program or project under which the volunteer was deployed at the time of the incident. Links to program master data.',
    `corrective_action_plan_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action_plan. Business justification: Volunteer incidents require documented corrective actions for donor reporting, audit response, and organizational learning. Links incident to CAP for tracking resolution, preventive measures, and comp',
    `distribution_event_id` BIGINT COMMENT 'Foreign key linking to field.distribution_event. Business justification: Volunteer incidents during distributions (crowd control issues, beneficiary disputes, safety concerns) must be linked to events for risk management, future event planning, and volunteer safety protoco',
    `field_deployment_id` BIGINT COMMENT 'Identifier of the specific volunteer deployment or assignment during which the incident occurred. Links to deployment tracking records.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who reported or documented the incident. Links to workforce/staff master data.',
    `volunteer_id` BIGINT COMMENT 'Identifier of the primary volunteer involved in the incident. Links to the volunteer master record.',
    `safeguarding_incident_id` BIGINT COMMENT 'Foreign key linking to safeguarding.safeguarding_incident. Business justification: Volunteer incident reports escalate to formal safeguarding investigations when PSEA concerns arise. Safeguarding teams track which volunteer incident reports triggered formal investigations. Standard ',
    `schedule_id` BIGINT COMMENT 'Foreign key linking to volunteer.schedule. Business justification: Incidents often occur during scheduled volunteer activities. Linking incidents to the schedule provides temporal and activity context for incident analysis, pattern detection, and risk assessment. Thi',
    `security_incident_id` BIGINT COMMENT 'Foreign key linking to field.security_incident. Business justification: Volunteer incidents (safety, harassment) may be part of broader security incidents affecting the site. Required for consolidated incident reporting, UNDSS coordination, and organizational risk managem',
    `volunteer_team_id` BIGINT COMMENT 'Foreign key linking to volunteer.volunteer_team. Business justification: Incidents can occur during team-based activities and may involve or affect an entire volunteer team. While many incidents are individual-level, team-based incidents (e.g., security incident affecting ',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Safety incidents at warehouse facilities (forklift accidents, slip-and-fall, heat exhaustion, hazmat exposure) require warehouse linkage for facility risk management, insurance claims, corrective acti',
    `confidentiality_level` STRING COMMENT 'Data classification level for the incident report based on sensitivity: public (shareable externally), internal (organization-wide access), confidential (limited access, sensitive), restricted (highly sensitive, need-to-know only, e.g., PSEA cases).. Valid values are `public|internal|confidential|restricted`',
    `corrective_actions` STRING COMMENT 'Description of corrective actions recommended or implemented to prevent recurrence, including policy changes, training, or operational adjustments. Supports Monitoring Evaluation and Learning (MEL).',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the incident occurred. Supports cross-border incident tracking and country-level risk analysis.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this incident report record was first created in the database. Part of audit trail for data governance.',
    `incident_report_date` DATE COMMENT 'The date when the incident was formally reported to the organization. Used to measure reporting timeliness and response lag.',
    `immediate_response_actions` STRING COMMENT 'Description of immediate actions taken at the time of the incident, including first aid, evacuation, security measures, or emergency notifications. Documents duty-of-care response.',
    `incident_date` DATE COMMENT 'The calendar date on which the incident occurred. Critical for timeline analysis and duty-of-care reporting.',
    `incident_description` STRING COMMENT 'Detailed narrative description of what happened during the incident, including sequence of events, context, and any contributing factors. Critical for investigation and learning.',
    `incident_location` STRING COMMENT 'Textual description of where the incident occurred, including facility name, address, field site, or geographic area. Supports situational awareness and risk mapping.',
    `incident_number` STRING COMMENT 'Human-readable unique business identifier for the incident report, typically system-generated or manually assigned following organizational numbering convention.. Valid values are `^INC-[0-9]{6,10}$`',
    `incident_time` TIMESTAMP COMMENT 'The precise date and time when the incident occurred, including timezone information for accurate chronological tracking.',
    `incident_type` STRING COMMENT 'Primary classification of the incident nature: security_threat (armed conflict, kidnapping, robbery), accident (vehicle, fall, injury), health_emergency (illness, medical crisis), harassment (verbal, physical, sexual), psea_violation (Protection from Sexual Exploitation and Abuse violation), natural_hazard (flood, earthquake, storm).. Valid values are `security_threat|accident|health_emergency|harassment|psea_violation|natural_hazard`',
    `injury_type` STRING COMMENT 'Classification of the physical or psychological injury sustained: physical_injury, psychological_trauma, illness, no_injury. Used for health and safety trend analysis.',
    `insurance_claim_filed` BOOLEAN COMMENT 'Indicates whether an insurance claim was filed related to this incident for medical expenses, liability, or other covered losses. True if filed, False otherwise.',
    `insurance_claim_number` STRING COMMENT 'Reference number assigned by the insurance provider for the claim related to this incident. Supports financial tracking and claim resolution.',
    `investigation_completion_date` DATE COMMENT 'The date when the investigation was completed and findings were documented. Supports accountability reporting and case closure tracking.',
    `investigation_findings` STRING COMMENT 'Summary of key findings from the investigation, including root causes, contributing factors, and any policy or procedural violations identified.',
    `investigation_required` BOOLEAN COMMENT 'Indicates whether a formal investigation is required for this incident based on severity, type, or organizational policy. True if investigation needed, False otherwise.',
    `investigation_start_date` DATE COMMENT 'The date when the formal investigation into the incident was initiated. Used to track investigation timeliness and compliance with response protocols.',
    `investigation_status` STRING COMMENT 'Current status of the incident investigation process: not_started (investigation not yet initiated), in_progress (investigation underway), completed (investigation finished, findings documented), closed (case closed with final resolution).. Valid values are `not_started|in_progress|completed|closed`',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the incident location in decimal degrees format. Enables GIS mapping and spatial analysis of incident patterns.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the incident location in decimal degrees format. Enables GIS mapping and spatial analysis of incident patterns.',
    `medical_attention_required` BOOLEAN COMMENT 'Indicates whether the incident required medical attention or treatment for the volunteer. True if medical care was needed, False otherwise.',
    `medical_facility_name` STRING COMMENT 'Name of the medical facility, clinic, or hospital where the volunteer received treatment, if applicable. Supports insurance claims and follow-up care coordination.',
    `modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this incident report record was last updated. Supports change tracking and audit compliance.',
    `police_report_filed` BOOLEAN COMMENT 'Indicates whether a police report or formal law enforcement notification was filed for this incident. True if filed, False otherwise. Required for certain incident types and insurance claims.',
    `police_report_number` STRING COMMENT 'Official reference number or case number assigned by law enforcement authorities if a police report was filed. Supports legal follow-up and insurance claims.',
    `referral_to_support_services` STRING COMMENT 'Description of any referrals made to support services such as Psychosocial Support (PSS), counseling, legal aid, or victim assistance programs. Documents duty-of-care follow-up.',
    `resolution_date` DATE COMMENT 'The date when the incident case was formally resolved and closed. Used to measure case resolution time and accountability performance.',
    `resolution_outcome` STRING COMMENT 'Final outcome or resolution of the incident case, including any disciplinary actions, compensation provided, or systemic improvements made. Documents accountability and closure.',
    `severity_level` STRING COMMENT 'Assessment of incident severity based on impact to volunteer safety and welfare: critical (life-threatening, immediate evacuation required), high (serious injury or threat, urgent response needed), medium (moderate impact, monitoring required), low (minor incident, standard follow-up).. Valid values are `critical|high|medium|low`',
    `incident_report_status` STRING COMMENT 'Current lifecycle status of the incident report: open (newly reported, awaiting review), under_review (being assessed or investigated), resolved (actions completed, awaiting closure), closed (case finalized).. Valid values are `open|under_review|resolved|closed`',
    `timestamp` TIMESTAMP COMMENT 'The precise date and time when the incident report was submitted into the system. Supports audit trail and response time analysis.',
    `witness_count` STRING COMMENT 'Number of witnesses to the incident who provided statements or corroborating information. Supports investigation credibility and evidence gathering.',
    CONSTRAINT pk_incident_report PRIMARY KEY(`incident_report_id`)
) COMMENT 'Records safety, security, and welfare incidents involving volunteers during deployments or activities. Captures incident date, location, incident type (security threat, accident, health emergency, harassment, PSEA violation, natural hazard), severity level, volunteer(s) involved, immediate response actions taken, referral to support services, investigation status, and resolution outcome. Supports duty-of-care obligations and CHS accountability requirements. Distinct from field operations incident tracking — this is volunteer-welfare focused.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`feedback` (
    `feedback_id` BIGINT COMMENT 'Unique identifier for the volunteer feedback record. Primary key.',
    `assessment_id` BIGINT COMMENT 'Foreign key linking to field.assessment. Business justification: Volunteers conducting assessments provide feedback on data collection tools, safety, and logistical support. Essential for assessment methodology improvement, enumerator training refinement, and volun',
    `data_collection_tool_id` BIGINT COMMENT 'Identifier of the specific survey instrument, questionnaire, or feedback form used to collect this feedback. Enables tracking of feedback methodology and version control.',
    `distribution_event_id` BIGINT COMMENT 'Foreign key linking to field.distribution_event. Business justification: Volunteer feedback often references specific distribution events they supported. Critical for event-level volunteer satisfaction analysis, operational improvement, and identifying systemic issues in d',
    `field_deployment_id` BIGINT COMMENT 'Identifier of the specific volunteer deployment or assignment this feedback relates to. Links to volunteer_deployment product.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Links volunteer feedback requiring follow-up to responsible staff member. Essential for volunteer satisfaction management, issue resolution tracking, and staff accountability. Existing follow_up_assig',
    `internal_review_id` BIGINT COMMENT 'Foreign key linking to compliance.internal_review. Business justification: Internal compliance reviews sample volunteer feedback to assess program quality, safeguarding effectiveness, and volunteer management practices. Links feedback record to review where it was examined a',
    `intervention_id` BIGINT COMMENT 'Identifier of the program context in which the volunteer served when providing this feedback.',
    `project_site_id` BIGINT COMMENT 'Identifier of the specific project site or field location where the volunteer was deployed when this feedback was collected.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: Beneficiary feedback on volunteer-delivered services is essential for accountability (CHS compliance), program quality improvement, and volunteer performance management. Links beneficiary satisfaction',
    `system_platform_id` BIGINT COMMENT 'Foreign key linking to technology.system_platform. Business justification: Feedback is collected via specific platforms (SurveyMonkey, Kobo Toolbox, custom portals). Tracking the collection platform is essential for data quality audits, API integration, and understanding res',
    `training_enrollment_id` BIGINT COMMENT 'Foreign key linking to volunteer.training_enrollment. Business justification: Feedback can be about training experiences in addition to deployment experiences. The feedback table has training_quality_rating and feedback_type fields suggesting feedback can be training-related. T',
    `volunteer_id` BIGINT COMMENT 'Identifier of the volunteer who submitted this feedback. Links to the volunteer master record.',
    `areas_for_improvement` STRING COMMENT 'Specific areas for improvement, challenges, or concerns identified by the volunteer in their feedback.',
    `channel` STRING COMMENT 'The channel or method through which the volunteer submitted feedback. FGD = Focus Group Discussion, KII = Key Informant Interview. Supports MEAL (Monitoring Evaluation Accountability and Learning) data collection methodology tracking.. Valid values are `survey|fgd|kii|digital_form|mobile_app|email`',
    `communication_rating` STRING COMMENT 'Numeric rating of the effectiveness and clarity of communication between the organization and the volunteer.',
    `consent_to_follow_up` BOOLEAN COMMENT 'Boolean flag indicating whether the volunteer has consented to be contacted for follow-up discussion or clarification regarding their feedback.',
    `country_code` STRING COMMENT 'ISO 3166-1 alpha-3 three-letter country code indicating the country in which the volunteer was deployed or engaged when providing this feedback.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this feedback record was first created in the system. Audit trail field for data governance.',
    `data_source` STRING COMMENT 'Identifier of the source system or platform from which this feedback record originated (e.g., Microsoft Dynamics 365, KoboToolbox, CommCare, SurveyMonkey). Supports data lineage and integration tracking.',
    `escalation_required` BOOLEAN COMMENT 'Boolean flag indicating whether this feedback requires escalation to senior management or specialized teams (e.g., safeguarding, legal, HR) due to the nature or severity of issues raised.',
    `follow_up_assigned_to` STRING COMMENT 'Name or identifier of the staff member or team responsible for reviewing and acting on this feedback.',
    `follow_up_completed_date` DATE COMMENT 'The date on which follow-up actions related to this feedback were completed and the case was closed.',
    `follow_up_notes` STRING COMMENT 'Internal notes documenting actions taken, decisions made, or responses provided in relation to this volunteer feedback.',
    `follow_up_status` STRING COMMENT 'Current status of follow-up actions taken in response to this feedback. Tracks organizational accountability and responsiveness to volunteer voice.. Valid values are `pending|in_progress|completed|no_action_required|closed`',
    `impact_perception_rating` STRING COMMENT 'Numeric rating reflecting the volunteers perception of the impact and meaningfulness of their contribution to the program or mission.',
    `is_anonymous` BOOLEAN COMMENT 'Boolean flag indicating whether the volunteer submitted this feedback anonymously (True) or with their identity disclosed (False). Supports confidential feedback mechanisms per CHS accountability standards.',
    `is_sensitive` BOOLEAN COMMENT 'Boolean flag indicating whether this feedback contains sensitive content requiring special handling, such as complaints about harassment, safety concerns, or ethical violations.',
    `language_code` STRING COMMENT 'ISO 639-3 three-letter language code indicating the language in which the feedback was submitted. Supports multilingual feedback collection in international operations.. Valid values are `^[A-Z]{3}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this feedback record was last modified or updated in the system. Audit trail field for data governance.',
    `net_promoter_score` STRING COMMENT 'Net Promoter Score (NPS) rating provided by the volunteer, indicating likelihood to recommend the volunteer opportunity to others. Typically on a 0-10 scale.',
    `overall_satisfaction_rating` STRING COMMENT 'Numeric rating of the volunteers overall satisfaction with their experience. Typically on a scale of 1-5 or 1-10 depending on organizational standard.',
    `qualitative_comments` STRING COMMENT 'Free-text qualitative feedback and comments provided by the volunteer about their experience, suggestions for improvement, or specific observations.',
    `rating_scale_max` STRING COMMENT 'The maximum value of the rating scale used for this feedback submission (e.g., 5 for 1-5 scale, 10 for 1-10 scale). Enables normalization across different survey instruments.',
    `record_status` STRING COMMENT 'Current lifecycle status of this feedback record in the data management system. Supports data retention and archival policies.. Valid values are `active|archived|deleted|under_review`',
    `response_sent_date` DATE COMMENT 'The date on which a formal response or acknowledgment was sent to the volunteer regarding their feedback, if applicable and if the volunteer was not anonymous.',
    `safety_rating` STRING COMMENT 'Numeric rating of the volunteers perception of safety and security during their deployment or engagement.',
    `sentiment_score` DECIMAL(18,2) COMMENT 'Computed sentiment score derived from qualitative comments using natural language processing or manual coding. Range typically -1.0 (negative) to +1.0 (positive). Supports advanced analytics and trend analysis.',
    `strengths_noted` STRING COMMENT 'Specific strengths, positive aspects, or commendations noted by the volunteer in their feedback.',
    `submission_date` DATE COMMENT 'The date on which the volunteer submitted this feedback. Principal business event timestamp for this record.',
    `submission_timestamp` TIMESTAMP COMMENT 'The precise date and time when the volunteer submitted this feedback, including time zone information.',
    `suggestions` STRING COMMENT 'Specific suggestions or recommendations provided by the volunteer for improving volunteer experience, program delivery, or organizational processes.',
    `supervision_rating` STRING COMMENT 'Numeric rating of the quality of supervision and guidance provided to the volunteer during their engagement.',
    `support_quality_rating` STRING COMMENT 'Numeric rating of the quality of organizational support provided to the volunteer during their deployment or engagement.',
    `survey_version` STRING COMMENT 'Version number or identifier of the survey instrument used, enabling longitudinal analysis and accounting for changes in feedback collection methodology over time.',
    `training_quality_rating` STRING COMMENT 'Numeric rating of the quality and adequacy of training provided to the volunteer prior to or during their deployment.',
    `feedback_type` STRING COMMENT 'Categorization of the feedback subject area: deployment experience, training quality, organizational support, general satisfaction, or incident-related feedback.. Valid values are `deployment|training|support|general|incident`',
    `would_volunteer_again` BOOLEAN COMMENT 'Boolean flag indicating whether the volunteer expressed willingness to volunteer with the organization again in the future. Key retention indicator.',
    CONSTRAINT pk_feedback PRIMARY KEY(`feedback_id`)
) COMMENT 'Captures structured feedback submitted by volunteers about their deployment experience, training quality, organizational support, supervision, and overall satisfaction. Distinct from beneficiary feedback (owned by communication domain) — this product is exclusively for volunteer voice. Records feedback submission date, feedback channel (survey, FGD, KII, digital form), program or deployment context (FK to volunteer_deployment), satisfaction ratings across dimensions (support, communication, impact, safety), qualitative comments, anonymization flag, and follow-up action status. Supports MEAL accountability mechanisms, volunteer retention improvement, and CHS commitment to people management.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`stipend` (
    `stipend_id` BIGINT COMMENT 'Unique identifier for the stipend record. Primary key.',
    `staff_member_id` BIGINT COMMENT 'Foreign key linking to workforce.staff_member. Business justification: Tracks which staff member approved volunteer stipend payment. Required for financial controls, audit trail, segregation of duties compliance, and donor reporting on volunteer program costs. Existing a',
    `award_id` BIGINT COMMENT 'Reference to the grant or funding source that covers this stipend expense. Links to grant award record.',
    `budget_line_id` BIGINT COMMENT 'Reference to the specific budget line item against which this stipend is charged. Used for Budget versus Actual (BvA) tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Stipend payments are charged to cost centers for budget tracking and variance analysis. Provides direct allocation for stipends not tied to specific budget lines, supporting monthly budget-vs-actual r',
    `donor_fund_id` BIGINT COMMENT 'Reference to the fund or cost center that this stipend is charged against. Links to fund master record.',
    `field_deployment_id` BIGINT COMMENT 'Reference to the volunteer deployment context during which this stipend was earned or provided. Links to volunteer_deployment.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Stipend disbursements post to specific GL accounts (typically program expense or volunteer support accounts). Required for monthly GL reconciliation, audit trail, and financial statement preparation.',
    `intervention_id` BIGINT COMMENT 'Reference to the program or project under which this stipend is provided. Links to program master record.',
    `project_site_id` BIGINT COMMENT 'Reference to the field project site where the volunteer was deployed and earned this stipend. Links to project_site.',
    `regulatory_filing_id` BIGINT COMMENT 'Foreign key linking to compliance.regulatory_filing. Business justification: Volunteer stipends may require tax reporting (1099-MISC in US, equivalent elsewhere). Links stipend payment to the regulatory filing (annual information return) where it must be reported for tax compl',
    `volunteer_id` BIGINT COMMENT 'Reference to the volunteer receiving this stipend. Links to the volunteer master record.',
    `amount` DECIMAL(18,2) COMMENT 'Monetary value of the stipend provided. For in-kind support, represents the fair market value of goods or services provided.',
    `approval_status` STRING COMMENT 'Current approval status of the stipend request or transaction. Tracks workflow state from submission to final approval.. Valid values are `draft|pending_approval|approved|rejected|cancelled`',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this stipend. Used for accountability and audit trail.',
    `approved_date` DATE COMMENT 'Date on which the stipend was approved for payment.',
    `bank_account_number` STRING COMMENT 'Bank account number for direct bank transfer when payment_method is bank_transfer.',
    `bank_branch_code` STRING COMMENT 'Branch code or routing number for the bank account used for payment.',
    `bank_name` STRING COMMENT 'Name of the bank where the volunteer holds the account for bank transfer payments.',
    `compliance_check_status` STRING COMMENT 'Status of compliance verification for this stipend against donor conditions, regulatory requirements, and internal policies.. Valid values are `not_checked|passed|failed|pending_review`',
    `compliance_notes` STRING COMMENT 'Notes or findings from compliance review of this stipend. Documents any issues or exceptions identified during review.',
    `cost_category` STRING COMMENT 'Cost category or Chart of Accounts (CoA) classification for this stipend expense. Used for financial reporting and compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this stipend record was first created in the system. Audit field.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the stipend amount (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `disbursement_date` DATE COMMENT 'Actual date on which the stipend was disbursed to the volunteer. Key date for financial reporting and reconciliation.',
    `disbursement_reference` STRING COMMENT 'External reference number from the payment system or bank transaction. Used for reconciliation and audit.',
    `donor_reportable_flag` BOOLEAN COMMENT 'Indicates whether this stipend must be reported to the donor as part of grant reporting requirements. True if reportable, False otherwise.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied when converting the stipend amount from local currency to reporting currency. Used for multi-currency operations.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which this stipend was disbursed or accrued. Used for financial reporting and year-end reconciliation.',
    `in_kind_description` STRING COMMENT 'Detailed description of in-kind support provided when stipend_type is in_kind_support. Includes Non-Food Items (NFI), protective equipment, or other goods.',
    `justification` STRING COMMENT 'Business justification or reason for providing this stipend. Used for audit and compliance purposes.',
    `mobile_money_number` STRING COMMENT 'Mobile money account number or phone number used for mobile money transfer when payment_method is mobile_money.',
    `modified_by` STRING COMMENT 'User or system identifier of the person who last modified this stipend record. Used for audit trail.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this stipend record was last modified. Audit field for tracking changes.',
    `notes` STRING COMMENT 'Additional notes or comments related to this stipend transaction. Free-text field for operational context.',
    `number` STRING COMMENT 'Human-readable unique identifier or reference number for this stipend transaction, used for tracking and reconciliation.',
    `payment_frequency` STRING COMMENT 'Frequency at which this stipend is paid to the volunteer. Indicates whether it is a recurring or one-time payment.. Valid values are `one_time|daily|weekly|biweekly|monthly|quarterly`',
    `payment_method` STRING COMMENT 'Method by which the stipend is disbursed to the volunteer. Includes digital and physical payment channels.. Valid values are `mobile_money|bank_transfer|cash|check|in_kind`',
    `payment_period_end_date` DATE COMMENT 'End date of the period for which this stipend is provided. Used for per diem and periodic allowances.',
    `payment_period_start_date` DATE COMMENT 'Start date of the period for which this stipend is provided. Used for per diem and periodic allowances.',
    `reporting_currency_amount` DECIMAL(18,2) COMMENT 'Stipend amount converted to the organizations reporting currency using the exchange_rate. Used for consolidated financial reporting.',
    `reporting_period` STRING COMMENT 'Reporting period identifier (e.g., Q1-2024, Jan-2024) for donor reporting and Monitoring Evaluation and Learning (MEL) purposes.',
    `tax_form_type` STRING COMMENT 'Type of tax form required for reporting this stipend (e.g., 1099-MISC, W-2, local tax form). Applicable when tax_reportable_flag is True.',
    `tax_reportable_flag` BOOLEAN COMMENT 'Indicates whether this stipend is reportable for tax purposes in the applicable jurisdiction. True if reportable, False otherwise.',
    `stipend_type` STRING COMMENT 'Category of stipend provided to the volunteer. Distinguishes between cash allowances and in-kind support.. Valid values are `transport_allowance|meal_allowance|communication_stipend|per_diem|in_kind_support|training_allowance`',
    `created_by` STRING COMMENT 'User or system identifier of the person who created this stipend record. Used for audit trail.',
    CONSTRAINT pk_stipend PRIMARY KEY(`stipend_id`)
) COMMENT 'Manages non-salary financial support provided to volunteers including transport allowances, meal allowances, communication stipends, per diem, and in-kind support (NFIs, protective equipment). Captures stipend type, amount or in-kind value, currency, payment period and frequency, payment method (mobile money, bank transfer, cash), approval status, disbursement date, volunteer (FK), deployment context (FK to volunteer_deployment), and grant or fund source. Distinct from payroll (workforce domain) — stipends are non-employment compensation for volunteers. Supports BvA tracking, donor reporting on volunteer support costs, and tax reporting where applicable.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`consent` (
    `consent_id` BIGINT COMMENT 'Unique identifier for the volunteer consent record. Primary key.',
    `award_id` BIGINT COMMENT 'Identifier of the grant or funding source that requires this consent. Links consent to donor compliance requirements.',
    `donor_requirement_id` BIGINT COMMENT 'Foreign key linking to compliance.donor_requirement. Business justification: Donor agreements often require specific volunteer consents (photo release for visibility materials, data sharing for impact reporting, testimonial use). Links consent record to donor requirement it sa',
    `field_deployment_id` BIGINT COMMENT 'Identifier of the volunteer deployment associated with this consent. Links consent to specific field assignment.',
    `intervention_id` BIGINT COMMENT 'Identifier of the program or project context in which this consent was obtained. Links consent to specific operational context.',
    `registrant_id` BIGINT COMMENT 'Foreign key linking to beneficiary.registrant. Business justification: When volunteers collect beneficiary data or provide services, beneficiary consent must be linked to the volunteer interaction for GDPR compliance, safeguarding, and data protection. Tracks consent cha',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member who witnessed the consent. Links to staff master record for audit purposes.',
    `superseded_consent_id` BIGINT COMMENT 'Self-referencing FK on consent (superseded_consent_id)',
    `volunteer_id` BIGINT COMMENT 'Identifier of the volunteer who provided this consent. Links to the volunteer master record.',
    `audit_trail_reference` STRING COMMENT 'Reference identifier linking this consent record to detailed audit logs or blockchain ledger entries for immutable consent tracking.',
    `confirmation_sent` BOOLEAN COMMENT 'Indicates whether a confirmation notification was sent to the volunteer acknowledging receipt of their consent.',
    `confirmation_sent_date` DATE COMMENT 'Date on which the consent confirmation notification was sent to the volunteer.',
    `country_code` STRING COMMENT 'Three-letter ISO 3166-1 alpha-3 country code indicating the jurisdiction under which this consent was obtained. Determines applicable data protection laws.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was first created in the system. Used for audit trail and data lineage.',
    `consent_date` DATE COMMENT 'Date on which the volunteer provided this consent. Principal business event timestamp for consent lifecycle.',
    `device_identifier` STRING COMMENT 'Unique identifier of the device used to submit the consent, if obtained through mobile app or web portal. Used for audit and security purposes.',
    `document_reference` STRING COMMENT 'Reference identifier or URL to the stored consent document, form, or recording that evidences the volunteers agreement.',
    `donor_due_diligence_flag` BOOLEAN COMMENT 'Indicates whether this consent record is required for donor due diligence or compliance reporting purposes.',
    `expiry_date` DATE COMMENT 'Date on which this consent expires and must be renewed. Null for consents with no expiration.',
    `granting_method` STRING COMMENT 'Method by which the volunteer provided consent. Indicates the channel and format used to capture the consent.. Valid values are `digital_signature|wet_signature|verbal_recorded|electronic_checkbox|mobile_app|paper_form`',
    `guardian_name` STRING COMMENT 'Name of the parent or legal guardian who provided consent on behalf of a minor volunteer.',
    `guardian_relationship` STRING COMMENT 'Relationship of the guardian to the minor volunteer. Defines the legal authority to provide consent.. Valid values are `parent|legal_guardian|foster_parent|court_appointed_guardian`',
    `ip_address` STRING COMMENT 'IP address from which the consent was submitted, if obtained digitally. Used for audit trail and fraud prevention.',
    `language_code` STRING COMMENT 'Two-letter ISO 639-1 language code indicating the language in which the consent was presented and obtained.. Valid values are `^[a-z]{2}$`',
    `legal_basis` STRING COMMENT 'Legal basis under applicable data protection regulation that justifies the processing of volunteer data. References specific articles or provisions of GDPR, local Data Protection Acts, or other relevant legislation.',
    `minor_consent_flag` BOOLEAN COMMENT 'Indicates whether this consent was obtained for a volunteer who is a minor, requiring parental or guardian consent.',
    `modified_by` STRING COMMENT 'Identifier or username of the system user or process that last modified this consent record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this consent record was last modified in the system. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Additional free-text notes or comments related to this consent record. Captures context, special circumstances, or clarifications.',
    `number` STRING COMMENT 'Human-readable unique reference number for this consent record, used for tracking and audit purposes.',
    `retention_period_months` STRING COMMENT 'Number of months for which this consent record must be retained after withdrawal or expiry, as required by data protection regulations and organizational policy.',
    `safeguarding_category` STRING COMMENT 'Category of safeguarding policy or protection measure that this consent relates to. Used for safeguarding compliance tracking.',
    `scope` STRING COMMENT 'Detailed description of what the consent covers, including specific data categories, processing activities, or use cases authorized by the volunteer.',
    `source_system_code` STRING COMMENT 'Unique identifier of this consent record in the source operational system. Used for data lineage and reconciliation.',
    `consent_status` STRING COMMENT 'Current lifecycle status of the consent. Indicates whether the consent is currently valid and enforceable.. Valid values are `active|withdrawn|expired|pending|revoked`',
    `timestamp` TIMESTAMP COMMENT 'Precise timestamp when the consent was granted, including time zone information. Used for audit trail and legal compliance.',
    `consent_type` STRING COMMENT 'Category of consent provided by the volunteer. Defines the specific permission or acknowledgment being recorded.. Valid values are `data_processing|image_likeness_release|safeguarding_code_of_conduct|background_check_authorization|medical_information_sharing|emergency_contact_consent`',
    `version` STRING COMMENT 'Version identifier of the consent form or policy document that the volunteer agreed to. Tracks policy changes over time.',
    `withdrawal_date` DATE COMMENT 'Date on which the volunteer withdrew their consent. Null if consent has not been withdrawn.',
    `withdrawal_method` STRING COMMENT 'Channel through which the volunteer communicated their withdrawal of consent.. Valid values are `email|phone|in_person|web_portal|mobile_app|written_letter`',
    `withdrawal_reason` STRING COMMENT 'Reason provided by the volunteer for withdrawing consent. Captures free-text explanation or predefined category.',
    `witness_name` STRING COMMENT 'Name of the staff member or authorized person who witnessed the consent being provided. Used for verbal or in-person consents.',
    `created_by` STRING COMMENT 'Identifier or username of the system user or process that created this consent record.',
    CONSTRAINT pk_consent PRIMARY KEY(`consent_id`)
) COMMENT 'Records data protection consents, safeguarding declarations, and policy acknowledgments provided by volunteers. Captures consent type (data processing consent, image/likeness release, safeguarding code of conduct acknowledgment, background check authorization, medical information sharing consent), consent date, consent version, volunteer (FK), granting method (digital signature, wet signature, verbal recorded), consent status (active, withdrawn, expired), withdrawal date and reason, legal basis under applicable data protection regulation (GDPR, local DPA), retention period, and associated deployment or program context. Supports GDPR Article 7 compliance, organizational safeguarding policies, and donor due diligence requirements for volunteer data handling in humanitarian operations.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` (
    `volunteer_training_completion_id` BIGINT COMMENT 'Primary key for volunteer_training_completion',
    `staff_member_id` BIGINT COMMENT 'Identifier of the staff member (typically from safeguarding or volunteer management team) who assigned or enrolled the volunteer in this training program. Used for accountability and audit trail.',
    `training_id` BIGINT COMMENT 'add column training_id (BIGINT) with FK to volunteer.training.training_id - training completions must link to the specific training event, not just the safeguarding training program',
    `training_program_id` BIGINT COMMENT 'Foreign key linking to the safeguarding training program that was completed or is in progress',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to the volunteer who completed or is enrolled in the training program',
    `assessment_score_percentage` DECIMAL(18,2) COMMENT 'Percentage score achieved by the volunteer on the training assessment, if assessment_required_flag is true. Used to determine pass/fail status against training_program.passing_score_percentage.',
    `attempts_count` STRING COMMENT 'Number of times the volunteer has attempted to complete this training program. Relevant for programs with assessment requirements and retry policies.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued upon successful completion of the training program. Explicitly identified in detection reasoning as relationship data. Used for verification and audit purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was created in the system.',
    `volunteer_training_completion_date` DATE COMMENT 'Date when the volunteer successfully completed the training program and any required assessments. Explicitly identified in detection reasoning as relationship data.',
    `enrollment_date` DATE COMMENT 'Date when the volunteer enrolled in or was assigned to this training program. Explicitly identified in detection reasoning as relationship data.',
    `expiry_date` DATE COMMENT 'Date when this training certification expires and the volunteer must renew or retake the training. Explicitly identified in detection reasoning as relationship data. Calculated from completion_date plus training_program.validity_period_months.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was last modified.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether this specific training was mandatory for this volunteer at the time of enrollment. Explicitly identified in detection reasoning as relationship data. May differ from training_program.mandatory_flag if volunteer role or assignment changed.',
    `volunteer_training_completion_status` STRING COMMENT 'Current status of the volunteers progress through this training program. Explicitly identified in detection reasoning as relationship data. Values: enrolled (registered but not started), in_progress (started but not completed), completed (successfully finished), failed (did not pass assessment), expired (certification validity period has lapsed), waived (exempted by safeguarding officer).',
    `training_completion_code` BIGINT COMMENT 'Unique identifier for this training completion record. Primary key.',
    `waiver_reason` STRING COMMENT 'Explanation for why the training requirement was waived for this volunteer, if completion_status is waived. Requires safeguarding officer approval.',
    CONSTRAINT pk_volunteer_training_completion PRIMARY KEY(`volunteer_training_completion_id`)
) COMMENT 'This association product represents the completion record between volunteer and training_program. It captures the enrollment, completion, and certification lifecycle for each volunteers participation in a safeguarding training program. Each record links one volunteer to one training_program with attributes that track compliance status, certification validity, and completion evidence.. Existence Justification: In nonprofit operations, volunteers complete multiple safeguarding training programs over their tenure (PSEA awareness, child protection, code of conduct, investigation procedures), and each training program is completed by hundreds or thousands of volunteers across the organization. The business actively manages training completion records as a compliance obligation, tracking enrollment dates, completion status, certificate numbers, expiry dates, and renewal requirements for each volunteer-training combination. This is a recognized operational entity called training completion or training record that safeguarding officers query, update, and monitor for compliance reporting.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` (
    `volunteer_policy_acknowledgment_id` BIGINT COMMENT 'Primary key for volunteer_policy_acknowledgment',
    `psea_policy_id` BIGINT COMMENT 'Foreign key linking to the PSEA policy being acknowledged',
    `staff_member_id` BIGINT COMMENT 'add column staff_member_id (BIGINT) with FK to workforce.staff_member.staff_member_id - policy acknowledgments need a witness/verifier from staff',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to the volunteer who acknowledged the policy',
    `acknowledged_by_name` STRING COMMENT 'Full name of the volunteer at the time of acknowledgment for audit trail purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this acknowledgment record was created.',
    `volunteer_policy_acknowledgment_date` DATE COMMENT 'Date when the volunteer formally acknowledged the policy. Explicitly identified in detection phase relationship data.',
    `digital_signature` STRING COMMENT 'Digital signature or cryptographic hash of the volunteers acknowledgment for audit and legal purposes. Explicitly identified in detection phase relationship data.',
    `expiry_date` DATE COMMENT 'Date when this acknowledgment expires and requires renewal, based on policy review cycle. Explicitly identified in detection phase relationship data.',
    `method` STRING COMMENT 'Method by which the volunteer acknowledged the policy (e.g., Digital Signature, Paper Form, Email Confirmation). Explicitly identified in detection phase relationship data.',
    `notes` STRING COMMENT 'Additional notes or comments about the acknowledgment process, exceptions, or special circumstances.',
    `policy_acknowledgment_code` BIGINT COMMENT 'Unique identifier for this policy acknowledgment record. Primary key.',
    `policy_version_number` STRING COMMENT 'Version of the policy that was acknowledged (e.g., 1.0, 2.1). Critical for tracking which version the volunteer agreed to. Explicitly identified in detection phase relationship data.',
    `volunteer_policy_acknowledgment_status` STRING COMMENT 'Current status of the acknowledgment (Pending, Acknowledged, Expired, Renewed, Overdue). Explicitly identified in detection phase relationship data.',
    `training_completion_flag` BOOLEAN COMMENT 'Indicates whether associated training was completed as part of the acknowledgment process.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this acknowledgment record was last updated.',
    `witness_name` STRING COMMENT 'Name of staff member or witness who verified the acknowledgment, if applicable for paper-based processes.',
    CONSTRAINT pk_volunteer_policy_acknowledgment PRIMARY KEY(`volunteer_policy_acknowledgment_id`)
) COMMENT 'This association product represents the formal acknowledgment event between volunteer and psea_policy. It captures the organizational requirement that volunteers formally acknowledge and confirm understanding of PSEA policies, child safeguarding policies, and codes of conduct. Each record links one volunteer to one psea_policy version with attributes tracking when, how, and under what terms the acknowledgment was made, including digital signatures, expiry dates, and renewal requirements. This is a core compliance and safeguarding data product.. Existence Justification: In nonprofit safeguarding operations, volunteers must formally acknowledge multiple PSEA policies throughout their tenure: organizational policies, country-specific policies when deployed, and updated versions when policies are revised. Each policy is acknowledged by many volunteers across the organization. The acknowledgment itself is a managed compliance event with specific data (date, method, version, signature, expiry) that belongs to neither the volunteer nor the policy alone.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` (
    `tool_authorization_id` BIGINT COMMENT 'Unique identifier for this volunteer tool authorization record. Primary key.',
    `staff_member_id` BIGINT COMMENT 'Identifier of the MEL staff member who authorized this volunteer to use this tool, establishing accountability for authorization decisions.',
    `data_collection_tool_id` BIGINT COMMENT 'Foreign key linking to the data collection tool for which authorization is granted',
    `volunteer_id` BIGINT COMMENT 'Foreign key linking to the volunteer who is authorized to use the tool',
    `certification_status` STRING COMMENT 'Current certification status of the volunteer for this tool. Certified indicates full authorization, Provisional indicates supervised use only, Expired indicates recertification required, Revoked indicates authorization withdrawn. Sourced from detection phase relationship data.',
    `created_at` TIMESTAMP COMMENT 'Timestamp when this authorization record was created in the system.',
    `tool_authorization_date` DATE COMMENT 'Date when the volunteer was officially authorized to administer this data collection tool independently. Sourced from detection phase relationship data.',
    `deployment_count` STRING COMMENT 'Number of times this volunteer has been deployed to use this specific tool in field data collection activities, tracking experience level.',
    `expiry_date` DATE COMMENT 'Date when the volunteers authorization to use this tool expires and recertification is required. Critical for compliance and data quality control. Sourced from detection phase relationship data.',
    `last_refresher_training_date` DATE COMMENT 'Date of the most recent refresher training session completed by the volunteer for this tool, used to track ongoing competency maintenance.',
    `notes` STRING COMMENT 'Free-text notes regarding special conditions, restrictions, or observations related to this volunteers authorization for this tool.',
    `proficiency_level` STRING COMMENT 'Assessed proficiency level of the volunteer in administering this specific data collection tool. Used for deployment planning and quality assurance. Trainer level indicates ability to train other volunteers. Sourced from detection phase relationship data.',
    `training_completion_date` DATE COMMENT 'Date when the volunteer completed training on this specific data collection tool. Sourced from detection phase relationship data.',
    `updated_at` TIMESTAMP COMMENT 'Timestamp when this authorization record was last updated.',
    CONSTRAINT pk_tool_authorization PRIMARY KEY(`tool_authorization_id`)
) COMMENT 'This association product represents the Authorization between data_collection_tool and volunteer. It captures the training, certification, and authorization lifecycle for volunteers to administer specific MEL data collection instruments. Each record links one data_collection_tool to one volunteer with attributes that track training completion, certification status, authorization validity periods, and proficiency levels - essential for quality control, compliance, and volunteer deployment planning.. Existence Justification: In nonprofit field operations, volunteers are trained and authorized to administer multiple data collection tools (ODK surveys, MUAC screening forms, KII guides, DHIS2 forms), and each tool is administered by multiple trained volunteers across different geographic locations and programs. The organization actively manages volunteer tool authorizations as a compliance and quality control process, tracking training completion, certification status, authorization validity periods, and proficiency levels for each volunteer-tool combination. This is an operational business process where MEL staff create authorization records after training, monitor expiry dates, and revoke authorizations when quality issues arise.';

CREATE OR REPLACE TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` (
    `volunteer_redeployment_id` BIGINT COMMENT 'Primary key for volunteer_deployment2',
    `volunteer_deployment_id` BIGINT COMMENT 'FK to the original volunteer deployment this redeployment derives from.',
    `volunteer_id` BIGINT COMMENT 'Auto-generated FK linking siloed deployment to volunteer',
    CONSTRAINT pk_volunteer_redeployment PRIMARY KEY(`volunteer_redeployment_id`)
) COMMENT 'This association product represents the deployment assignment between a volunteer and a partner organization. It captures the operational assignment of volunteers to partner organizations for specific roles, time periods, and performance tracking. Each record links one volunteer to one partner organization with attributes that exist only in the context of this deployment relationship, including role, dates, hours contributed, and performance assessment.. Existence Justification: In nonprofit operations, volunteers are deployed to multiple partner organizations over time for different projects, field placements, and programs, and each partner organization works with multiple volunteers simultaneously. The deployment relationship is an operational business entity that program coordinators actively create, manage, and track with specific attributes including role assignments, time periods, hours contributed, and performance assessments. This is not a simple reference but a managed assignment process central to volunteer coordination.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ADD CONSTRAINT `fk_volunteer_application_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ADD CONSTRAINT `fk_volunteer_volunteer_deployment_volunteer_team_id` FOREIGN KEY (`volunteer_team_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_team`(`volunteer_team_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`schedule`(`schedule_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ADD CONSTRAINT `fk_volunteer_hour_log_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ADD CONSTRAINT `fk_volunteer_schedule_role_id` FOREIGN KEY (`role_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`role`(`role_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ADD CONSTRAINT `fk_volunteer_schedule_volunteer_deployment_id` FOREIGN KEY (`volunteer_deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ADD CONSTRAINT `fk_volunteer_schedule_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_training_id` FOREIGN KEY (`training_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`training`(`training_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ADD CONSTRAINT `fk_volunteer_training_enrollment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ADD CONSTRAINT `fk_volunteer_certification_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ADD CONSTRAINT `fk_volunteer_recognition_volunteer_deployment_id` FOREIGN KEY (`volunteer_deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ADD CONSTRAINT `fk_volunteer_recognition_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ADD CONSTRAINT `fk_volunteer_volunteer_team_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_schedule_id` FOREIGN KEY (`schedule_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`schedule`(`schedule_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ADD CONSTRAINT `fk_volunteer_incident_report_volunteer_team_id` FOREIGN KEY (`volunteer_team_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_team`(`volunteer_team_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_training_enrollment_id` FOREIGN KEY (`training_enrollment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`training_enrollment`(`training_enrollment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ADD CONSTRAINT `fk_volunteer_feedback_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ADD CONSTRAINT `fk_volunteer_stipend_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ADD CONSTRAINT `fk_volunteer_consent_superseded_consent_id` FOREIGN KEY (`superseded_consent_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`consent`(`consent_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ADD CONSTRAINT `fk_volunteer_consent_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ADD CONSTRAINT `fk_volunteer_volunteer_training_completion_training_id` FOREIGN KEY (`training_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`training`(`training_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ADD CONSTRAINT `fk_volunteer_volunteer_training_completion_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ADD CONSTRAINT `fk_volunteer_volunteer_policy_acknowledgment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ADD CONSTRAINT `fk_volunteer_tool_authorization_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` ADD CONSTRAINT `fk_volunteer_volunteer_redeployment_volunteer_deployment_id` FOREIGN KEY (`volunteer_deployment_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer_deployment`(`volunteer_deployment_id`);
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` ADD CONSTRAINT `fk_volunteer_volunteer_redeployment_volunteer_id` FOREIGN KEY (`volunteer_id`) REFERENCES `vibe_ngo_v1`.`volunteer`.`volunteer`(`volunteer_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_ngo_v1`.`volunteer` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_ngo_v1`.`volunteer` SET TAGS ('dbx_domain' = 'volunteer');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` SET TAGS ('dbx_subdomain' = 'volunteer_registry');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Identifier');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Address Line 1');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Address Line 2');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `availability_hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Availability Hours Per Week');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Availability Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|unavailable|on assignment|on leave|inactive');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not required|pending|in progress|cleared|flagged|expired');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `certifications` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Certifications');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Volunteer City');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Country Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Date of Birth');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Email Address');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Emergency Contact Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Emergency Contact Phone Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Emergency Contact Relationship');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `external_volunteer_code` SET TAGS ('dbx_business_glossary_term' = 'External Volunteer Identifier');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Volunteer First Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `first_volunteer_date` SET TAGS ('dbx_business_glossary_term' = 'First Volunteer Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Gender');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|non-binary|prefer not to say|other');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `gender` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `geographic_base` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Geographic Base');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Last Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `last_volunteer_date` SET TAGS ('dbx_business_glossary_term' = 'Last Volunteer Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Middle Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Mobile Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Nationality');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `nationality` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `onboarding_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Onboarding Completion Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Onboarding Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'pending|in progress|completed|expired|inactive');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Phone Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Postal Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Preferred Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Primary Language');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `primary_language` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `recognition_level` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Recognition Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `recognition_level` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum|lifetime');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `secondary_languages` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Secondary Languages');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `secondary_languages` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `skills` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Skills');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Volunteer State or Province');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `total_volunteer_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Volunteer Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `volunteer_type` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `volunteer_type` SET TAGS ('dbx_value_regex' = 'community health worker|field volunteer|event-based supporter|skilled professional|youth volunteer|corporate volunteer');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer` ALTER COLUMN `willing_to_travel` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Willing to Travel');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` SET TAGS ('dbx_subdomain' = 'volunteer_registry');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Application ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Psea Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `sanctions_screening_id` SET TAGS ('dbx_business_glossary_term' = 'Sanctions Screening Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Completed Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_outcome` SET TAGS ('dbx_business_glossary_term' = 'Background Check Outcome');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_outcome` SET TAGS ('dbx_value_regex' = 'cleared|conditional|not_cleared');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_business_glossary_term' = 'Background Check Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `background_check_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|cleared|failed|expired');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `code_of_conduct_signed` SET TAGS ('dbx_business_glossary_term' = 'Code of Conduct Signed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `commitment_duration_months` SET TAGS ('dbx_business_glossary_term' = 'Commitment Duration (Months)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Application Submission Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `decision_made_by` SET TAGS ('dbx_business_glossary_term' = 'Decision Made By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `decision_status` SET TAGS ('dbx_business_glossary_term' = 'Decision Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `decision_status` SET TAGS ('dbx_value_regex' = 'pending|accepted|rejected|waitlisted');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `emergency_contact_provided` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Provided');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `emergency_contact_provided` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `hours_per_week` SET TAGS ('dbx_business_glossary_term' = 'Hours Per Week');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Completed Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_notes` SET TAGS ('dbx_business_glossary_term' = 'Interview Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_notes` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_outcome` SET TAGS ('dbx_business_glossary_term' = 'Interview Outcome');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_outcome` SET TAGS ('dbx_value_regex' = 'recommended|not_recommended|conditional');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_required` SET TAGS ('dbx_business_glossary_term' = 'Interview Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `interview_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Interview Scheduled Date and Time');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_business_glossary_term' = 'Languages Spoken');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `languages_spoken` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `motivation_statement` SET TAGS ('dbx_business_glossary_term' = 'Motivation Statement');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Application Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^VA-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `onboarding_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Completed Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `onboarding_start_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `onboarding_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|incomplete');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `orientation_completed` SET TAGS ('dbx_business_glossary_term' = 'Orientation Completed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `preferred_start_date` SET TAGS ('dbx_business_glossary_term' = 'Preferred Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `previous_volunteer_experience` SET TAGS ('dbx_business_glossary_term' = 'Previous Volunteer Experience');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `recruitment_channel` SET TAGS ('dbx_business_glossary_term' = 'Recruitment Channel');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `recruitment_channel` SET TAGS ('dbx_value_regex' = 'website|social_media|referral|event|partner_organization|direct_outreach');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `reference_check_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Reference Check Completed Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `reference_check_status` SET TAGS ('dbx_business_glossary_term' = 'Reference Check Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `reference_check_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|satisfactory|unsatisfactory');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `safeguarding_policy_acknowledged` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Policy Acknowledged');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `screening_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Screening Completed Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `screening_status` SET TAGS ('dbx_business_glossary_term' = 'Screening Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `screening_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|cleared|flagged');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `skills_offered` SET TAGS ('dbx_business_glossary_term' = 'Skills Offered');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`application` ALTER COLUMN `training_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Completed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` SET TAGS ('dbx_subdomain' = 'volunteer_registry');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Required Safeguarding Training Program Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `background_check_required` SET TAGS ('dbx_business_glossary_term' = 'Background Check Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_code` SET TAGS ('dbx_business_glossary_term' = 'Role Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `deployment_context` SET TAGS ('dbx_business_glossary_term' = 'Deployment Context');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_description` SET TAGS ('dbx_business_glossary_term' = 'Role Description');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `estimated_time_commitment_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Time Commitment Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `insurance_coverage_required` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `insurance_coverage_required` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `language_requirements` SET TAGS ('dbx_business_glossary_term' = 'Language Requirements');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `language_requirements` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `maximum_concurrent_assignments` SET TAGS ('dbx_business_glossary_term' = 'Maximum Concurrent Assignments');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_business_glossary_term' = 'Minimum Age Requirement');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `minimum_age_requirement` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `minimum_certification_requirements` SET TAGS ('dbx_business_glossary_term' = 'Minimum Certification Requirements');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `physical_demands` SET TAGS ('dbx_business_glossary_term' = 'Physical Demands');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `physical_demands` SET TAGS ('dbx_value_regex' = 'None|Light|Moderate|Heavy|Extreme');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `preferred_skills` SET TAGS ('dbx_business_glossary_term' = 'Preferred Skills');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `recognition_program_eligible` SET TAGS ('dbx_business_glossary_term' = 'Recognition Program Eligible');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `remote_work_eligible` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Eligible');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `reporting_requirements` SET TAGS ('dbx_business_glossary_term' = 'Reporting Requirements');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `required_skills` SET TAGS ('dbx_business_glossary_term' = 'Required Skills');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `safeguarding_training_required` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Training Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_status` SET TAGS ('dbx_business_glossary_term' = 'Role Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_status` SET TAGS ('dbx_value_regex' = 'Active|Inactive|Suspended|Under Review|Archived');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `stipend_amount` SET TAGS ('dbx_business_glossary_term' = 'Stipend Amount');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `stipend_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `stipend_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Stipend Currency Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `stipend_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `stipend_eligible` SET TAGS ('dbx_business_glossary_term' = 'Stipend Eligible');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `supervision_level` SET TAGS ('dbx_business_glossary_term' = 'Supervision Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `supervision_level` SET TAGS ('dbx_value_regex' = 'Independent|Minimal|Moderate|Close|Intensive');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `time_commitment_unit` SET TAGS ('dbx_business_glossary_term' = 'Time Commitment Unit');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `time_commitment_unit` SET TAGS ('dbx_value_regex' = 'Per Week|Per Month|Per Assignment|Per Event|Total');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Role Title');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `travel_required` SET TAGS ('dbx_business_glossary_term' = 'Travel Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Role Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'Field|Office|Remote|Hybrid|Event-Based|Ongoing');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `typical_assignment_duration_days` SET TAGS ('dbx_business_glossary_term' = 'Typical Assignment Duration Days');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`role` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `volunteer_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Deployment ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `chs_self_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Chs Self Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `field_team_id` SET TAGS ('dbx_business_glossary_term' = 'Field Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `meal_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Mel Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `partnership_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Partnership Agreement Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Risk Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Supervising Staff ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `statutory_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Statutory Registration Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `volunteer_team_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Deployment Country Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment End Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `fte_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Contribution');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `hours_contributed` SET TAGS ('dbx_business_glossary_term' = 'Hours Contributed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Deployment Location Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deployment Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Deployment Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^VD-[0-9]{6,10}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `orientation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Orientation Completed Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `orientation_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Orientation Completed Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Deployment Priority');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical|emergency');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `recognition_awarded_flag` SET TAGS ('dbx_business_glossary_term' = 'Recognition Awarded Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Deployment Region');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `remote_deployment_flag` SET TAGS ('dbx_business_glossary_term' = 'Remote Deployment Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Deployment Role');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_business_glossary_term' = 'Security Clearance Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_value_regex' = 'none|basic|standard|enhanced|critical');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `security_clearance_level` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Conditions');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Deployment Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `volunteer_deployment_status` SET TAGS ('dbx_business_glossary_term' = 'Deployment Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `volunteer_deployment_status` SET TAGS ('dbx_value_regex' = 'active|completed|withdrawn|suspended|pending|cancelled');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `volunteer_deployment_type` SET TAGS ('dbx_business_glossary_term' = 'Deployment Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `volunteer_deployment_type` SET TAGS ('dbx_value_regex' = 'emergency_response|development_program|event_support|capacity_building|advocacy_campaign|disaster_relief');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_deployment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `hour_log_id` SET TAGS ('dbx_business_glossary_term' = 'Hour Log ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `distribution_order_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Order Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `field_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Deployment ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `indicator_id` SET TAGS ('dbx_business_glossary_term' = 'Indicator Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `mobile_health_outreach_id` SET TAGS ('dbx_business_glossary_term' = 'Mobile Health Outreach Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `mobile_health_outreach_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `mobile_health_outreach_id` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Supervisor ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `wash_intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Wash Intervention Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'direct_service|administrative_support|fundraising_event|training_facilitation|community_outreach|monitoring_evaluation');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|under_review|auto_approved');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `beneficiary_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiary Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `hour_log_date` SET TAGS ('dbx_business_glossary_term' = 'Log Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Device ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `device_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `device_code` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `donor_report_eligible` SET TAGS ('dbx_business_glossary_term' = 'Donor Report Eligible');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'End Time');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `fair_market_value_rate` SET TAGS ('dbx_business_glossary_term' = 'Fair Market Value (FMV) Rate');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `grant_allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Grant Allocation Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `hours_claimed` SET TAGS ('dbx_business_glossary_term' = 'Hours Claimed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `hours_verified` SET TAGS ('dbx_business_glossary_term' = 'Hours Verified');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `in_kind_value` SET TAGS ('dbx_business_glossary_term' = 'In-Kind Value');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `is_group_activity` SET TAGS ('dbx_business_glossary_term' = 'Is Group Activity');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `is_overtime` SET TAGS ('dbx_business_glossary_term' = 'Is Overtime');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Is Virtual');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `recognition_milestone_triggered` SET TAGS ('dbx_business_glossary_term' = 'Recognition Milestone Triggered');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Start Time');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'mobile_app|web_portal|paper_form|sms|email|kiosk');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submitted Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`hour_log` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'supervisor_signoff|digital_checkin|gps_verification|self_reported|biometric_scan|event_roster');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `role_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Role Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Coordinator ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `volunteer_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Deployment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Activity Description');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `assigned_volunteer_count` SET TAGS ('dbx_business_glossary_term' = 'Assigned Volunteer Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `attendance_status` SET TAGS ('dbx_business_glossary_term' = 'Attendance Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancelled Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `check_out_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-Out Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `conflict_flag` SET TAGS ('dbx_business_glossary_term' = 'Conflict Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `conflict_reason` SET TAGS ('dbx_business_glossary_term' = 'Conflict Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_address` SET TAGS ('dbx_business_glossary_term' = 'Location Address');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_city` SET TAGS ('dbx_business_glossary_term' = 'Location City');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_city` SET TAGS ('dbx_pii_location' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_country_code` SET TAGS ('dbx_business_glossary_term' = 'Location Country Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Location Latitude');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Location Longitude');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `location_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `override_approved` SET TAGS ('dbx_business_glossary_term' = 'Override Approved');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `override_reason` SET TAGS ('dbx_business_glossary_term' = 'Override Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `planned_hours` SET TAGS ('dbx_business_glossary_term' = 'Planned Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `recurrence_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recurrence End Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'none|daily|weekly|biweekly|monthly|custom');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `required_volunteer_count` SET TAGS ('dbx_business_glossary_term' = 'Required Volunteer Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `shift_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift End Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `shift_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'shift|event|field_assignment|ongoing|ad_hoc|emergency_response');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` SET TAGS ('dbx_subdomain' = 'capacity_building');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `governance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Governance Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `accrediting_body` SET TAGS ('dbx_business_glossary_term' = 'Accrediting Body');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'written_exam|practical_demonstration|project_submission|peer_review|no_assessment');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `available_languages` SET TAGS ('dbx_business_glossary_term' = 'Available Languages');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `available_languages` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'safety_and_security|technical_skills|chs_orientation|sphere_standards|gbv_awareness|psea');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `certification_awarded` SET TAGS ('dbx_business_glossary_term' = 'Certification Awarded');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `certification_validity_months` SET TAGS ('dbx_business_glossary_term' = 'Certification Validity in Months');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `chs_standard_alignment` SET TAGS ('dbx_business_glossary_term' = 'Core Humanitarian Standard (CHS) Alignment');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_code` SET TAGS ('dbx_business_glossary_term' = 'Training Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_business_glossary_term' = 'Cost per Participant');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_business_glossary_term' = 'Delivery Modality');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `delivery_modality` SET TAGS ('dbx_value_regex' = 'in_person|e_learning|blended|virtual_instructor_led|self_paced');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_description` SET TAGS ('dbx_business_glossary_term' = 'Training Description');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration in Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `effective_until_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_business_glossary_term' = 'Facilitator Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `facilitator_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Training');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Training Language');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `language` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `mandatory_for_roles` SET TAGS ('dbx_business_glossary_term' = 'Mandatory for Roles');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `materials_url` SET TAGS ('dbx_business_glossary_term' = 'Training Materials URL');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `materials_url` SET TAGS ('dbx_value_regex' = '^https?://.*$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `max_participants` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participants');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `prerequisites` SET TAGS ('dbx_business_glossary_term' = 'Training Prerequisites');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `sdg_alignment` SET TAGS ('dbx_business_glossary_term' = 'Sustainable Development Goal (SDG) Alignment');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `sphere_standard_alignment` SET TAGS ('dbx_business_glossary_term' = 'SPHERE Standard Alignment');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|retired|under_review');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Training Title');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Training Version');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `version` SET TAGS ('dbx_value_regex' = '^[0-9]+.[0-9]+$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` SET TAGS ('dbx_subdomain' = 'capacity_building');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `partner_org_id` SET TAGS ('dbx_business_glossary_term' = 'Partner Org Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `user_account_id` SET TAGS ('dbx_business_glossary_term' = 'User Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `assessment_attempts` SET TAGS ('dbx_business_glossary_term' = 'Assessment Attempts');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certificate_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certificate_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issue Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `certification_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `compliance_training_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Category');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `continuing_education_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Credits');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cost');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Currency Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `feedback_rating` SET TAGS ('dbx_business_glossary_term' = 'Feedback Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `mandatory_training_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `recertification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Required Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `source` SET TAGS ('dbx_value_regex' = 'self_enrolled|manager_assigned|program_required|hr_assigned|system_triggered');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_enrollment_status` SET TAGS ('dbx_value_regex' = 'registered|in_progress|completed|failed|withdrawn|cancelled');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_delivery_mode` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Mode');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_delivery_mode` SET TAGS ('dbx_value_regex' = 'in_person|online|hybrid|self_paced|webinar|workshop');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_language` SET TAGS ('dbx_business_glossary_term' = 'Training Language');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_language` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_start_date` SET TAGS ('dbx_business_glossary_term' = 'Training Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `training_withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Training Withdrawal Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`training_enrollment` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Withdrawal Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` SET TAGS ('dbx_subdomain' = 'volunteer_registry');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `commodity_id` SET TAGS ('dbx_business_glossary_term' = 'Commodity Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `governance_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Governance Policy Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Verified By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `accreditation_body` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Body');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `assessment_passing_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Passing Score');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `continuing_education_hours` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `country_of_issue` SET TAGS ('dbx_business_glossary_term' = 'Country of Issue');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `deployment_eligible` SET TAGS ('dbx_business_glossary_term' = 'Deployment Eligible');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `evidence_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document Reference');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Body');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `language_of_certification` SET TAGS ('dbx_business_glossary_term' = 'Language of Certification');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `language_of_certification` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `last_verified_date` SET TAGS ('dbx_business_glossary_term' = 'Last Verified Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `mandatory_for_role` SET TAGS ('dbx_business_glossary_term' = 'Mandatory for Role');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certification Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_value_regex' = 'beginner|intermediate|advanced|expert|master');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `recognized_by_organization` SET TAGS ('dbx_business_glossary_term' = 'Recognized by Organization');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `reimbursed_by_organization` SET TAGS ('dbx_business_glossary_term' = 'Reimbursed by Organization');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `renewal_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Frequency (Months)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_category` SET TAGS ('dbx_business_glossary_term' = 'Skill Category');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_name` SET TAGS ('dbx_business_glossary_term' = 'Skill Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `skill_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'professional_license|certificate|training_completion|self_assessed|verified_competency|compliance_certificate');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|self_reported|expired|revoked|not_verified');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` SET TAGS ('dbx_subdomain' = 'engagement_welfare');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `recognition_id` SET TAGS ('dbx_business_glossary_term' = 'Recognition ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `constituent_id` SET TAGS ('dbx_business_glossary_term' = 'Constituent Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `recognition_nominator_staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Nominator ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `recognition_nominator_staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `recognition_nominator_staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `volunteer_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Deployment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `nominating_staff_member_id` SET TAGS ('dbx_renamed_from' = 'staff_member_id');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `award_description` SET TAGS ('dbx_business_glossary_term' = 'Award Description');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `award_title` SET TAGS ('dbx_business_glossary_term' = 'Award Title');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `certificate_number` SET TAGS ('dbx_value_regex' = '^CERT-[0-9]{10}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Recognition Channel');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'ceremony|newsletter|social_media|certificate|email|internal_portal');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `hours_milestone_threshold` SET TAGS ('dbx_business_glossary_term' = 'Hours Milestone Threshold');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `monetary_value` SET TAGS ('dbx_business_glossary_term' = 'Monetary Value');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `monetary_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `nomination_date` SET TAGS ('dbx_business_glossary_term' = 'Nomination Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `nominator_type` SET TAGS ('dbx_business_glossary_term' = 'Nominator Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `nominator_type` SET TAGS ('dbx_value_regex' = 'staff|volunteer|partner|beneficiary|system');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Recognition Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Recognition Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `number` SET TAGS ('dbx_value_regex' = '^REC-[0-9]{8}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `public_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Acknowledgment Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `skills_category` SET TAGS ('dbx_business_glossary_term' = 'Skills Category');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `recognition_status` SET TAGS ('dbx_business_glossary_term' = 'Recognition Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `recognition_status` SET TAGS ('dbx_value_regex' = 'nominated|approved|awarded|declined|revoked');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `recognition_type` SET TAGS ('dbx_business_glossary_term' = 'Recognition Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`recognition` ALTER COLUMN `recognition_type` SET TAGS ('dbx_value_regex' = 'length_of_service_award|outstanding_contribution|skills_milestone|program_completion_certificate|public_acknowledgment|peer_nomination');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` SET TAGS ('dbx_subdomain' = 'volunteer_registry');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_team_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Team ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `country_office_id` SET TAGS ('dbx_business_glossary_term' = 'Country Office Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `finance_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Finance Fund Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Team Lead Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Team Lead Staff ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `beneficiaries_served_count` SET TAGS ('dbx_business_glossary_term' = 'Beneficiaries Served Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_business_glossary_term' = 'Budget Allocation');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `budget_allocation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_team_code` SET TAGS ('dbx_business_glossary_term' = 'Team Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `communication_channel` SET TAGS ('dbx_business_glossary_term' = 'Primary Communication Channel');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `current_member_count` SET TAGS ('dbx_business_glossary_term' = 'Current Member Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `dissolution_date` SET TAGS ('dbx_business_glossary_term' = 'Team Dissolution Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `equipment_assigned` SET TAGS ('dbx_business_glossary_term' = 'Equipment Assigned');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `formation_date` SET TAGS ('dbx_business_glossary_term' = 'Team Formation Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `geographic_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Area of Operation');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meeting Frequency');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `meeting_frequency` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|as_needed|none');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_team_name` SET TAGS ('dbx_business_glossary_term' = 'Team Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_team_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Team Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `operational_hours` SET TAGS ('dbx_business_glossary_term' = 'Operational Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Team Performance Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|satisfactory|needs_improvement|not_rated');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `primary_language` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `recognition_awards_count` SET TAGS ('dbx_business_glossary_term' = 'Recognition Awards Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `safety_incidents_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incidents Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `secondary_languages` SET TAGS ('dbx_business_glossary_term' = 'Secondary Languages');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `secondary_languages` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_team_status` SET TAGS ('dbx_business_glossary_term' = 'Team Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_team_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|disbanded|on_hold|forming');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `target_member_count` SET TAGS ('dbx_business_glossary_term' = 'Target Member Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `total_volunteer_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Volunteer Hours');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `training_completion_required` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Required');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `volunteer_team_type` SET TAGS ('dbx_business_glossary_term' = 'Team Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_team` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` SET TAGS ('dbx_subdomain' = 'engagement_welfare');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `incident_report_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `compliance_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `component_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `corrective_action_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `field_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Deployment Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Staff Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Identifier (ID)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `safeguarding_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `security_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Security Incident Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `volunteer_team_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Team Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Confidentiality Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions Recommended');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `incident_report_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Submission Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `immediate_response_actions` SET TAGS ('dbx_business_glossary_term' = 'Immediate Response Actions Taken');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Narrative Description');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `incident_location` SET TAGS ('dbx_business_glossary_term' = 'Incident Location Description');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{6,10}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Occurrence Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type Classification');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'security_threat|accident|health_emergency|harassment|psea_violation|natural_hazard');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `injury_type` SET TAGS ('dbx_business_glossary_term' = 'Injury or Harm Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `insurance_claim_filed` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Filed Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Reference Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `investigation_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `investigation_findings` SET TAGS ('dbx_business_glossary_term' = 'Investigation Findings Summary');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `investigation_required` SET TAGS ('dbx_business_glossary_term' = 'Investigation Required Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `investigation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|closed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Incident Latitude Coordinate');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Incident Longitude Coordinate');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `medical_attention_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Attention Required Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `medical_attention_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `medical_attention_required` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `medical_attention_required` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_business_glossary_term' = 'Medical Facility Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `medical_facility_name` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `police_report_filed` SET TAGS ('dbx_business_glossary_term' = 'Police Report Filed Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `police_report_number` SET TAGS ('dbx_business_glossary_term' = 'Police Report Reference Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `referral_to_support_services` SET TAGS ('dbx_business_glossary_term' = 'Referral to Support Services Description');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Resolution Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Incident Resolution Outcome');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `incident_report_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `incident_report_status` SET TAGS ('dbx_value_regex' = 'open|under_review|resolved|closed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Report Submission Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`incident_report` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` SET TAGS ('dbx_subdomain' = 'engagement_welfare');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `feedback_id` SET TAGS ('dbx_business_glossary_term' = 'Feedback ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Assessment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Instrument ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `distribution_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Event Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `field_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Deployment ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Assigned To Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `internal_review_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `system_platform_id` SET TAGS ('dbx_business_glossary_term' = 'System Platform Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `training_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Training Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `areas_for_improvement` SET TAGS ('dbx_business_glossary_term' = 'Areas for Improvement');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Feedback Channel');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'survey|fgd|kii|digital_form|mobile_app|email');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `communication_rating` SET TAGS ('dbx_business_glossary_term' = 'Communication Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `consent_to_follow_up` SET TAGS ('dbx_business_glossary_term' = 'Consent to Follow-Up');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `escalation_required` SET TAGS ('dbx_business_glossary_term' = 'Escalation Required Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `follow_up_assigned_to` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Assigned To');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `follow_up_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Completed Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `follow_up_notes` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Action Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `follow_up_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|no_action_required|closed');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `impact_perception_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Perception Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `is_anonymous` SET TAGS ('dbx_business_glossary_term' = 'Anonymous Feedback Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `is_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Sensitive Feedback Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `net_promoter_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `overall_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Satisfaction Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `qualitative_comments` SET TAGS ('dbx_business_glossary_term' = 'Qualitative Comments');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `rating_scale_max` SET TAGS ('dbx_business_glossary_term' = 'Rating Scale Maximum');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|archived|deleted|under_review');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `response_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Response Sent Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `safety_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `sentiment_score` SET TAGS ('dbx_business_glossary_term' = 'Sentiment Score');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `strengths_noted` SET TAGS ('dbx_business_glossary_term' = 'Strengths Noted');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Feedback Submission Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Feedback Submission Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `suggestions` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Suggestions');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `supervision_rating` SET TAGS ('dbx_business_glossary_term' = 'Supervision Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `support_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Support Quality Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `training_quality_rating` SET TAGS ('dbx_business_glossary_term' = 'Training Quality Rating');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `feedback_type` SET TAGS ('dbx_business_glossary_term' = 'Feedback Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `feedback_type` SET TAGS ('dbx_value_regex' = 'deployment|training|support|general|incident');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`feedback` ALTER COLUMN `would_volunteer_again` SET TAGS ('dbx_business_glossary_term' = 'Would Volunteer Again');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `stipend_id` SET TAGS ('dbx_business_glossary_term' = 'Stipend ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Staff Member Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `donor_fund_id` SET TAGS ('dbx_business_glossary_term' = 'Fund ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `field_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Deployment ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `project_site_id` SET TAGS ('dbx_business_glossary_term' = 'Project Site ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `regulatory_filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Stipend Amount');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|rejected|cancelled');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `bank_branch_code` SET TAGS ('dbx_business_glossary_term' = 'Bank Branch Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `bank_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Check Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `compliance_check_status` SET TAGS ('dbx_value_regex' = 'not_checked|passed|failed|pending_review');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `cost_category` SET TAGS ('dbx_business_glossary_term' = 'Cost Category');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `disbursement_date` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `disbursement_reference` SET TAGS ('dbx_business_glossary_term' = 'Disbursement Reference');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `donor_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Reportable Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `in_kind_description` SET TAGS ('dbx_business_glossary_term' = 'In-Kind Description');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `justification` SET TAGS ('dbx_business_glossary_term' = 'Stipend Justification');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `mobile_money_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Money Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `mobile_money_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `mobile_money_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Stipend Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Stipend Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'one_time|daily|weekly|biweekly|monthly|quarterly');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'mobile_money|bank_transfer|cash|check|in_kind');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `payment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Period End Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `payment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Period Start Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `reporting_currency_amount` SET TAGS ('dbx_business_glossary_term' = 'Reporting Currency Amount');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `tax_form_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Form Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `tax_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Reportable Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `stipend_type` SET TAGS ('dbx_business_glossary_term' = 'Stipend Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `stipend_type` SET TAGS ('dbx_value_regex' = 'transport_allowance|meal_allowance|communication_stipend|per_diem|in_kind_support|training_allowance');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`stipend` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` SET TAGS ('dbx_subdomain' = 'engagement_welfare');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `consent_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Consent ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `award_id` SET TAGS ('dbx_business_glossary_term' = 'Grant ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `donor_requirement_id` SET TAGS ('dbx_business_glossary_term' = 'Donor Compliance Req Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `field_deployment_id` SET TAGS ('dbx_business_glossary_term' = 'Deployment ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `intervention_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `registrant_id` SET TAGS ('dbx_business_glossary_term' = 'Registrant Id (Foreign Key)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Witness Staff ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `superseded_consent_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded Consent Id');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `superseded_consent_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `audit_trail_reference` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail Reference');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `confirmation_sent` SET TAGS ('dbx_business_glossary_term' = 'Consent Confirmation Sent Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `confirmation_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Sent Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `consent_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `device_identifier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `device_identifier` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Consent Document Reference');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `donor_due_diligence_flag` SET TAGS ('dbx_business_glossary_term' = 'Donor Due Diligence Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `granting_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Granting Method');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `granting_method` SET TAGS ('dbx_value_regex' = 'digital_signature|wet_signature|verbal_recorded|electronic_checkbox|mobile_app|paper_form');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `guardian_name` SET TAGS ('dbx_business_glossary_term' = 'Guardian Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `guardian_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `guardian_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `guardian_relationship` SET TAGS ('dbx_business_glossary_term' = 'Guardian Relationship');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `guardian_relationship` SET TAGS ('dbx_value_regex' = 'parent|legal_guardian|foster_parent|court_appointed_guardian');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'Internet Protocol (IP) Address');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `ip_address` SET TAGS ('dbx_pii_ip' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `language_code` SET TAGS ('dbx_business_glossary_term' = 'Language Code');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `language_code` SET TAGS ('dbx_value_regex' = '^[a-z]{2}$');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `language_code` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `legal_basis` SET TAGS ('dbx_business_glossary_term' = 'Legal Basis for Processing');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `minor_consent_flag` SET TAGS ('dbx_business_glossary_term' = 'Minor Consent Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Modified By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Consent Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `number` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `retention_period_months` SET TAGS ('dbx_business_glossary_term' = 'Consent Retention Period (Months)');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `safeguarding_category` SET TAGS ('dbx_business_glossary_term' = 'Safeguarding Category');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `scope` SET TAGS ('dbx_business_glossary_term' = 'Consent Scope');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_business_glossary_term' = 'Consent Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `consent_status` SET TAGS ('dbx_value_regex' = 'active|withdrawn|expired|pending|revoked');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_business_glossary_term' = 'Consent Type');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `consent_type` SET TAGS ('dbx_value_regex' = 'data_processing|image_likeness_release|safeguarding_code_of_conduct|background_check_authorization|medical_information_sharing|emergency_contact_consent');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Consent Version');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `withdrawal_method` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Method');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `withdrawal_method` SET TAGS ('dbx_value_regex' = 'email|phone|in_person|web_portal|mobile_app|written_letter');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Consent Withdrawal Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`consent` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` SET TAGS ('dbx_subdomain' = 'capacity_building');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` SET TAGS ('dbx_association_edges' = 'volunteer.volunteer,safeguarding.training_program');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `volunteer_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'volunteer_training_completion Identifier');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned By Staff ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `training_program_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Training Program Id');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Volunteer Id');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `assessment_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score Percentage');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `assessment_score_percentage` SET TAGS ('dbx_pii_demographic' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `attempts_count` SET TAGS ('dbx_business_glossary_term' = 'Attempts Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `volunteer_training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `volunteer_training_completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `training_completion_code` SET TAGS ('dbx_business_glossary_term' = 'Training Completion ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_training_completion` ALTER COLUMN `waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Waiver Reason');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` SET TAGS ('dbx_subdomain' = 'engagement_welfare');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` SET TAGS ('dbx_association_edges' = 'volunteer.volunteer,safeguarding.psea_policy');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `volunteer_policy_acknowledgment_id` SET TAGS ('dbx_business_glossary_term' = 'volunteer_policy_acknowledgment Identifier');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `psea_policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Acknowledgment - Psea Policy Id');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Acknowledgment - Volunteer Id');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `acknowledged_by_name` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged By Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `acknowledged_by_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `acknowledged_by_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `volunteer_policy_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `digital_signature` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `digital_signature` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `digital_signature` SET TAGS ('dbx_pii_biometric' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `method` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Method');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `policy_acknowledgment_code` SET TAGS ('dbx_business_glossary_term' = 'Policy Acknowledgment ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `policy_version_number` SET TAGS ('dbx_business_glossary_term' = 'Policy Version Number');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `volunteer_policy_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Acknowledgment Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `training_completion_flag` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Flag');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Name');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_policy_acknowledgment` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` SET TAGS ('dbx_subdomain' = 'capacity_building');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` SET TAGS ('dbx_association_edges' = 'mel.data_collection_tool,volunteer.volunteer');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `tool_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Tool Authorization ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Staff Member ID');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `staff_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `data_collection_tool_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Tool Authorization - Data Collection Tool Id');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Volunteer Tool Authorization - Volunteer Id');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `created_at` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `tool_authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `deployment_count` SET TAGS ('dbx_business_glossary_term' = 'Deployment Count');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiry Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `last_refresher_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Refresher Training Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Authorization Notes');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`tool_authorization` ALTER COLUMN `updated_at` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` SET TAGS ('dbx_association_edges' = 'volunteer.volunteer,partnership.partner_org');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` ALTER COLUMN `volunteer_redeployment_id` SET TAGS ('dbx_business_glossary_term' = 'volunteer_deployment2 Identifier');
ALTER TABLE `vibe_ngo_v1`.`volunteer`.`volunteer_redeployment` ALTER COLUMN `volunteer_id` SET TAGS ('dbx_business_glossary_term' = 'Reference to volunteer');
