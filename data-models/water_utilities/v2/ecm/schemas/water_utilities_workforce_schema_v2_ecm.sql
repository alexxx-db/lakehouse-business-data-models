-- Schema for Domain: workforce | Business: Water_Utilities | Version: v2_ecm
-- Generated on: 2026-07-10 18:43:53

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_water_utilities_v1`.`workforce` COMMENT 'Human capital management for utility operations including employee records, certifications and licensing (water/wastewater operator licenses), training compliance, shift scheduling, crew assignments, field service management, labor tracking, OSHA safety incident tracking, and workforce planning. Integrates with SAP HR and Microsoft Dynamics 365 Field Service.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Unique identifier for the utility employee. Primary key for the employee master record.',
    `supervisor_employee_id` BIGINT COMMENT 'Employee identifier of the direct supervisor or manager. Establishes reporting hierarchy for organizational structure and approval workflows.',
    `cdl_class` STRING COMMENT 'CDL classification level. Class A for combination vehicles over 26,001 lbs, Class B for single vehicles over 26,001 lbs, Class C for vehicles designed to transport 16+ passengers or hazardous materials.. Valid values are `class_a|class_b|class_c`',
    `cdl_expiration_date` DATE COMMENT 'Expiration date of the CDL license. Used for compliance tracking to ensure field service technicians maintain valid licenses for vehicle operation.',
    `cdl_license_number` STRING COMMENT 'Commercial Driver License number for employees authorized to operate utility vehicles requiring CDL certification. Nullable for employees without CDL requirements.',
    `confined_space_certified_flag` BOOLEAN COMMENT 'Indicates whether the employee is certified for confined space entry operations. Required for employees working in tanks, vaults, manholes, and other confined spaces per OSHA 1910.146.',
    `cost_center` STRING COMMENT 'SAP Financial Controlling (FI/CO) cost center code for labor cost allocation and financial reporting. Used to track operational expenditure (OPEX) by organizational unit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was first created in the system. Used for data lineage and audit trail purposes.',
    `department_code` STRING COMMENT 'Code identifying the organizational department or division to which the employee is assigned. Examples include WTP (Water Treatment Plant), DIST (Distribution), WWTP (Wastewater Treatment Plant), LAB (Laboratory), MAINT (Maintenance), ENG (Engineering).',
    `department_name` STRING COMMENT 'Full name of the organizational department or division. Examples include Water Treatment Operations, Distribution Network Maintenance, Wastewater Treatment Operations, Water Quality Laboratory, Asset Management, Customer Service.',
    `email_address` STRING COMMENT 'Primary corporate email address for the employee. Used for official communications, system access, and Microsoft Dynamics 365 integration.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `emergency_contact_name` STRING COMMENT 'Full name of the employees designated emergency contact person. Used for notification in case of workplace incidents or emergencies.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the employees designated emergency contact. Critical for incident response and employee safety management.',
    `emergency_contact_relationship` STRING COMMENT 'Relationship of the emergency contact to the employee (e.g., spouse, parent, sibling, friend). Provides context for emergency notification protocols.',
    `employment_status` STRING COMMENT 'Current employment status of the employee. Active indicates currently working, inactive for temporary status, leave for approved absence, suspended for disciplinary hold, terminated for ended employment, retired for retirement status.. Valid values are `active|inactive|leave|suspended|terminated|retired`',
    `employment_type` STRING COMMENT 'Classification of employment arrangement. Full-time for standard 40-hour week employees, part-time for reduced hours, contract for fixed-term contractors, temporary for short-term assignments, seasonal for peak-demand periods, intern for training programs.. Valid values are `full_time|part_time|contract|temporary|seasonal|intern`',
    `first_name` STRING COMMENT 'Legal first name of the employee as recorded in official employment records.',
    `hazmat_certified_flag` BOOLEAN COMMENT 'Indicates whether the employee is certified to handle hazardous materials including treatment chemicals (chlorine, sodium hypochlorite, alum, polymers). Required for chemical handling and storage operations.',
    `hire_date` DATE COMMENT 'Date the employee was originally hired by the utility. Used for seniority calculations, benefit eligibility, and tenure reporting.',
    `job_classification` STRING COMMENT 'Standardized job classification code used for pay grade determination, union contract alignment, and workforce planning. Aligns with utility industry job classification frameworks.',
    `job_title` STRING COMMENT 'Official job title or position name. Examples include Water Treatment Plant Operator, Distribution System Technician, Wastewater Engineer, Field Service Supervisor, SCADA Specialist, Laboratory Analyst.',
    `last_name` STRING COMMENT 'Legal last name (surname) of the employee as recorded in official employment records.',
    `middle_name` STRING COMMENT 'Middle name or initial of the employee. Nullable field for employees without a middle name.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was last modified. Used for change tracking and data governance audit trails.',
    `operator_license_class` STRING COMMENT 'Classification level of the operator license (e.g., Class I, Class II, Class III, Class IV). Higher classes authorize operation of larger or more complex treatment facilities. Varies by state primacy agency.',
    `operator_license_expiration_date` DATE COMMENT 'Date the operator license expires. Critical for compliance tracking to ensure only licensed operators are assigned to treatment plant operations per SDWA and CWA requirements.',
    `operator_license_issue_date` DATE COMMENT 'Date the current operator license was issued by the state primacy agency. Used for tracking license validity and renewal scheduling.',
    `operator_license_number` STRING COMMENT 'State-issued water or wastewater treatment operator license number. Required for employees operating Water Treatment Plant (WTP) or Wastewater Treatment Plant (WWTP) facilities per Safe Drinking Water Act (SDWA) and Clean Water Act (CWA) requirements.',
    `operator_license_type` STRING COMMENT 'Type of operator certification held. Water treatment for WTP operations, water distribution for distribution network operations, wastewater treatment for WWTP operations, wastewater collection for collection system operations.. Valid values are `water_treatment|water_distribution|wastewater_treatment|wastewater_collection`',
    `osha_training_current_flag` BOOLEAN COMMENT 'Indicates whether the employee has completed all required OSHA safety training and certifications are current. True for compliant employees, False for employees requiring training updates.',
    `pay_grade` STRING COMMENT 'Compensation pay grade or band assigned to the employee. Determines salary range and is aligned with job classification and union contract provisions.',
    `personnel_number` STRING COMMENT 'SAP HR system personnel number. Eight-digit unique identifier assigned by SAP ERP HR module for payroll and human capital management integration.. Valid values are `^[0-9]{8}$`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee. Used for emergency contact, field service dispatch, and crew coordination.',
    `shift_assignment` STRING COMMENT 'Standard shift schedule assignment for the employee. Day for standard business hours, evening for second shift, night for third shift, rotating for alternating shift patterns, on_call for emergency response personnel.. Valid values are `day|evening|night|rotating|on_call`',
    `termination_date` DATE COMMENT 'Date the employees employment ended. Nullable for active employees. Used for final payroll processing, benefit termination, and workforce turnover analysis.',
    `termination_reason` STRING COMMENT 'Classification of the reason for employment termination. Voluntary for employee-initiated resignation, involuntary for employer-initiated termination, retirement for age or service-based retirement, layoff for workforce reduction, end_of_contract for contract completion.. Valid values are `voluntary|involuntary|retirement|layoff|end_of_contract`',
    `union_local` STRING COMMENT 'Identifier for the specific union local chapter to which the employee belongs. Nullable for non-union employees. Used for collective bargaining agreement administration.',
    `union_membership_flag` BOOLEAN COMMENT 'Indicates whether the employee is a member of a labor union. True for union members, False for non-union employees. Used for contract compliance and labor relations management.',
    `work_location_code` STRING COMMENT 'Code identifying the primary physical work location or facility. Examples include WTP-01 (Water Treatment Plant 1), WWTP-02 (Wastewater Treatment Plant 2), DIST-NORTH (North Distribution Yard), LAB-CENTRAL (Central Laboratory).',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master record for all utility employees including operators, field technicians, engineers, and administrative staff. Captures personal details, employment status, job classification, department assignment, hire date, termination date, employment type (full-time, part-time, contract), pay grade, union membership, and SAP HR personnel number. Serves as the SSOT for all workforce identity data integrated from SAP HR module.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` (
    `operator_license_id` BIGINT COMMENT 'Unique identifier for the operator license record. Primary key.',
    `employee_id` BIGINT COMMENT 'Reference to the employee who holds this operator license. Links to the employee master record in SAP HR.',
    `facility_id` BIGINT COMMENT 'Reference to the primary Water Treatment Plant (WTP) or Wastewater Treatment Plant (WWTP) where this operator is currently assigned. Links to the facility master record.',
    `backup_operator_flag` BOOLEAN COMMENT 'Indicates whether this operator is designated as a backup or relief operator for their assigned facility. Backup operators provide coverage during absences of the primary ORC.',
    `continuing_education_hours_completed` DECIMAL(18,2) COMMENT 'Total number of continuing education hours the operator has completed toward the current renewal cycle. Tracked to ensure compliance with renewal requirements.',
    `continuing_education_hours_required` DECIMAL(18,2) COMMENT 'Total number of continuing education hours required for license renewal as mandated by the issuing agency. Typically ranges from 12 to 48 hours per renewal cycle.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this operator license record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `exam_date` DATE COMMENT 'The date the operator successfully passed the certification exam for this license grade. Format: yyyy-MM-dd.',
    `exam_score` DECIMAL(18,2) COMMENT 'The score achieved by the operator on the certification exam, typically expressed as a percentage (0-100). Null if score is not recorded.',
    `expiration_date` DATE COMMENT 'The date the operator license expires and must be renewed. Critical for compliance tracking to ensure only licensed operators manage WTP/WWTP operations. Format: yyyy-MM-dd.',
    `facility_classification_authorized` STRING COMMENT 'The maximum facility classification or complexity level the operator is authorized to manage based on their license grade (e.g., Class 1 WTP, Class 4 WWTP). Aligns with state facility classification systems.',
    `issue_date` DATE COMMENT 'The date the operator license was originally issued by the primacy agency. Format: yyyy-MM-dd.',
    `issuing_agency_name` STRING COMMENT 'Full name of the state primacy agency or regulatory body that issued the license (e.g., California State Water Resources Control Board, Texas Commission on Environmental Quality).',
    `issuing_state` STRING COMMENT 'Two-letter state code of the primacy agency that issued the license (e.g., CA, TX, NY). Follows USPS state abbreviation standard.. Valid values are `^[A-Z]{2}$`',
    `license_document_url` STRING COMMENT 'URL or file path to the scanned copy of the physical operator license certificate stored in the document management system. Used for audit and verification purposes.',
    `license_grade` STRING COMMENT 'The grade or class of the operator license (e.g., Grade 1, Grade 2, Grade 3, Grade 4 for water; Class A, Class B, Class C, Class D for wastewater). Grade indicates the complexity and size of facilities the operator is qualified to manage. [ENUM-REF-CANDIDATE: grade_1|grade_2|grade_3|grade_4|class_a|class_b|class_c|class_d|trainee|provisional — promote to reference product]',
    `license_number` STRING COMMENT 'The unique license number issued by the state primacy agency. This is the official identifier on the physical license certificate.',
    `license_status` STRING COMMENT 'Current status of the operator license in its lifecycle. Active licenses are valid for operations; expired, suspended, or revoked licenses require immediate action to maintain regulatory compliance.. Valid values are `active|expired|suspended|revoked|pending_renewal|inactive`',
    `license_type` STRING COMMENT 'The category of operator license indicating the operational domain (e.g., Water Treatment, Water Distribution, Wastewater Treatment, Wastewater Collection, Dual Certification, Backflow Prevention).. Valid values are `water_treatment|water_distribution|wastewater_treatment|wastewater_collection|dual_certification|backflow_prevention`',
    `license_verification_date` DATE COMMENT 'The date the license was last verified with the issuing state agency. Regular verification is required for audit and compliance purposes. Format: yyyy-MM-dd.',
    `license_verification_method` STRING COMMENT 'The method used to verify the license status with the issuing agency (e.g., online portal, phone verification, email confirmation, physical document review, third-party verification service).. Valid values are `online_portal|phone_verification|email_confirmation|physical_document|third_party_service`',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the operator license (e.g., restrictions, endorsements, special certifications).',
    `operator_in_responsible_charge_flag` BOOLEAN COMMENT 'Indicates whether this operator is designated as the Operator in Responsible Charge (ORC) for their assigned facility. ORC designation is a regulatory requirement under SDWA and state primacy rules.',
    `reciprocity_state` STRING COMMENT 'Two-letter state code indicating if this license is recognized in another state through reciprocity agreements. Null if no reciprocity applies.. Valid values are `^[A-Z]{2}$`',
    `renewal_application_submitted_date` DATE COMMENT 'The date the operator submitted their license renewal application to the issuing agency. Null if renewal has not been initiated. Format: yyyy-MM-dd.',
    `renewal_date` DATE COMMENT 'The date the license was last renewed. Null if the license has never been renewed. Format: yyyy-MM-dd.',
    `renewal_fee_amount` DECIMAL(18,2) COMMENT 'The fee amount charged by the issuing agency for license renewal. Expressed in USD. Null if no fee applies or if not yet determined.',
    `renewal_fee_paid_date` DATE COMMENT 'The date the renewal fee was paid to the issuing agency. Null if fee has not been paid. Format: yyyy-MM-dd.',
    `renewal_notification_sent_date` DATE COMMENT 'The date a renewal reminder notification was sent to the operator and their supervisor. Typically sent 60-90 days before expiration. Format: yyyy-MM-dd.',
    `revocation_date` DATE COMMENT 'The date the license was permanently revoked. Null if license has never been revoked. Format: yyyy-MM-dd.',
    `revocation_reason` STRING COMMENT 'The reason the license was permanently revoked by the issuing agency (e.g., serious regulatory violation, fraud, criminal conviction). Null if license has never been revoked.',
    `suspension_end_date` DATE COMMENT 'The date the license suspension was lifted and the license was reinstated. Null if suspension is ongoing or if license has never been suspended. Format: yyyy-MM-dd.',
    `suspension_reason` STRING COMMENT 'The reason the license was suspended by the issuing agency (e.g., failure to complete continuing education, disciplinary action, non-payment of renewal fee). Null if license has never been suspended.',
    `suspension_start_date` DATE COMMENT 'The date the license suspension became effective. Null if license has never been suspended. Format: yyyy-MM-dd.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this operator license record was last updated in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_operator_license PRIMARY KEY(`operator_license_id`)
) COMMENT 'Tracks state-issued water and wastewater operator licenses and certifications required by primacy agencies. Captures license type (e.g., Grade 1-4 Water Treatment, Grade 1-4 Distribution, Class A-D Wastewater), issuing state agency, license number, issue date, expiration date, renewal status, and associated employee. Critical for regulatory compliance with SDWA and state primacy agency requirements ensuring only licensed operators run WTP/WWTP processes.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`certification` (
    `certification_id` BIGINT COMMENT 'Unique identifier for the certification record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who holds this certification. Links to the employee master record in SAP HR.',
    `training_course_id` BIGINT COMMENT 'add column training_course_id (BIGINT) with FK to workforce.training_course.training_course_id - certifications are earned through specific training courses',
    `attachment_url` STRING COMMENT 'URL or file path to the scanned certificate document, training completion certificate, or other supporting documentation stored in the document management system.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number issued by the certifying body. Used for verification and audit purposes.',
    `certification_status` STRING COMMENT 'Current lifecycle status of the certification: active (valid and current), expired (past expiration date), suspended (temporarily invalid), revoked (permanently invalid), pending (awaiting approval or verification), in_progress (training underway but not yet certified).. Valid values are `active|expired|suspended|revoked|pending|in_progress`',
    `certification_type` STRING COMMENT 'Category of certification: safety (OSHA, confined space, HAZWOPER), technical (backflow, instrumentation), operational (forklift, equipment), regulatory (state operator license), professional (AWWA, WEF credentials), or driver (CDL).. Valid values are `safety|technical|operational|regulatory|professional|driver`',
    `certifying_body` STRING COMMENT 'Name of the organization or agency that issued the certification (e.g., OSHA, American Red Cross, State Department of Transportation, AWWA, American Backflow Prevention Association, National Safety Council).',
    `ceu_earned` DECIMAL(18,2) COMMENT 'Number of Continuing Education Units (CEUs) or contact hours the employee has earned toward renewal of this certification. Null if not applicable.',
    `ceu_required` DECIMAL(18,2) COMMENT 'Number of Continuing Education Units (CEUs) or contact hours required for renewal of this certification. Null if no CEU requirement exists.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for obtaining or renewing this certification, including training fees, exam fees, and certification fees. Null if not tracked.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amount. Defaults to USD for U.S. water utilities.. Valid values are `USD`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was first created in the system.',
    `expiration_date` DATE COMMENT 'Date the certification expires and must be renewed. Null if the certification does not expire.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this certification is mandatory for the employees current role or job function (True) or optional/recommended (False).',
    `is_regulatory_required` BOOLEAN COMMENT 'Indicates whether this certification is required by federal, state, or local regulation (True) or is a voluntary professional credential (False).',
    `issue_date` DATE COMMENT 'Date the certification was originally issued to the employee.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this certification record was last modified in the system.',
    `certification_name` STRING COMMENT 'Full name of the certification, credential, or qualification (e.g., OSHA 30-Hour Construction, Confined Space Entry, CDL Class A, Backflow Prevention Tester, HAZWOPER 40-Hour, First Aid/CPR, Forklift Operator, AWWA Water Distribution Operator Grade 3).',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, restrictions, or comments related to this certification (e.g., certification valid only for specific equipment types, renewal pending exam results).',
    `reimbursement_status` STRING COMMENT 'Status of employee reimbursement for certification costs: not_applicable (employer-paid), pending (reimbursement requested), approved (approved for payment), reimbursed (payment completed), denied (reimbursement denied).. Valid values are `not_applicable|pending|approved|reimbursed|denied`',
    `renewal_date` DATE COMMENT 'Date the certification was last renewed. Null if never renewed.',
    `training_completion_date` DATE COMMENT 'Date the employee completed the training course or program that led to this certification. May differ from issue_date if there is a delay in certification issuance.',
    `training_hours` DECIMAL(18,2) COMMENT 'Total number of training hours completed for this certification (e.g., OSHA 10-Hour, OSHA 30-Hour, HAZWOPER 40-Hour). Null if not applicable.',
    `training_provider` STRING COMMENT 'Name of the organization or institution that provided the training leading to this certification (e.g., local community college, AWWA training center, in-house training department, third-party safety training vendor).',
    `verification_date` DATE COMMENT 'Date the certification was last verified with the certifying body. Null if never verified.',
    `verification_status` STRING COMMENT 'Status of third-party verification of the certification with the issuing body: verified (confirmed with certifying body), pending_verification (verification in progress), not_verified (not yet checked), failed_verification (could not be confirmed).. Valid values are `verified|pending_verification|not_verified|failed_verification`',
    CONSTRAINT pk_certification PRIMARY KEY(`certification_id`)
) COMMENT 'Tracks professional certifications, safety credentials, technical qualifications, and operational competencies for utility employees beyond state operator licenses. Includes OSHA 10/30, confined space entry, CDL, backflow prevention tester, HAZWOPER, first aid/CPR, forklift, AWWA-recognized credentials, and operational skill proficiencies (SCADA operation, pipe repair, chemical handling, GIS mapping). Captures certifying body or assessor, certificate number, issue date, expiration date, proficiency level (trainee, qualified, expert), CEU requirements, renewal tracking, and qualification type discriminator. Enables compliance tracking, skills-based crew assignment, and workforce development gap analysis.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` (
    `training_course_id` BIGINT COMMENT 'Unique identifier for the training course record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee responsible for maintaining the training course content, scheduling offerings, and ensuring regulatory compliance. Typically a training coordinator, subject matter expert, or department manager.',
    `vendor_id` BIGINT COMMENT 'Unique identifier or accreditation number assigned to the approved training provider by the regulatory or certifying body. Used to verify provider credentials and course eligibility for CEU credits.',
    `training_vendor_id` BIGINT COMMENT 'Unique identifier or accreditation number assigned to the approved training provider by the regulatory or certifying body. Used to verify provider credentials and course eligibility for CEU credits.',
    `accessibility_accommodations` STRING COMMENT 'Description of accessibility features and accommodations available for this training course to support participants with disabilities. May include closed captioning, sign language interpretation, wheelchair accessibility, assistive technology, or alternative formats.',
    `assessment_required_flag` BOOLEAN COMMENT 'Indicates whether participants must pass a test, exam, or practical assessment to successfully complete the training course. True if assessment required; false if completion based on attendance only.',
    `certification_awarded` STRING COMMENT 'Name of the professional certification, license, or credential awarded upon successful completion of this training course. Examples include Water Treatment Operator Grade I, OSHA 10-Hour Construction, Confined Space Entry Certification. Null if no formal certification awarded.',
    `ceu_credits` DECIMAL(18,2) COMMENT 'Number of Continuing Education Unit credits awarded upon successful completion of the course. CEUs are required for maintaining water and wastewater operator licenses and professional certifications. One CEU equals 10 contact hours of participation in an organized continuing education experience.',
    `cmms_system_flag` BOOLEAN COMMENT 'Indicates whether this training course covers CMMS software operation, work order management, or asset maintenance workflows. True if CMMS-related; false otherwise.',
    `cost_per_participant` DECIMAL(18,2) COMMENT 'Standard cost in US dollars charged per participant for enrollment in this training course. Includes tuition, materials, and certification fees. May be zero for internal courses or subsidized programs.',
    `course_category` STRING COMMENT 'Primary classification of the training course by subject area. Regulatory compliance includes EPA, OSHA, and state requirements; operations and maintenance covers WTP, WWTP, and distribution; safety includes OSHA and utility-specific programs; technical skills covers SCADA, CMMS, GIS, and equipment operation; leadership development includes supervisory and management training; system-specific covers proprietary systems and equipment.. Valid values are `regulatory_compliance|operations_maintenance|safety|technical_skills|leadership_development|system_specific`',
    `course_code` STRING COMMENT 'Unique alphanumeric code assigned to the training course for identification and registration purposes. Used in training management systems and employee records.. Valid values are `^[A-Z0-9]{4,12}$`',
    `course_description` STRING COMMENT 'Detailed description of the training course content, learning objectives, target audience, and prerequisites.',
    `course_materials_url` STRING COMMENT 'Web address or file path where course materials, handouts, presentations, and reference documents are stored and accessible to participants. May link to learning management system (LMS) or document repository.',
    `course_status` STRING COMMENT 'Current lifecycle status of the training course in the catalog. Active courses are available for enrollment; inactive courses are temporarily unavailable; under development courses are being created or updated; retired courses are no longer offered; suspended courses are on hold pending review or regulatory changes.. Valid values are `active|inactive|under_development|retired|suspended`',
    `course_title` STRING COMMENT 'Full official title of the training course as it appears in the training catalog and on certificates.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this training course record was first created in the system.',
    `delivery_method` STRING COMMENT 'Method by which the training course is delivered to participants. Classroom is instructor-led in-person; online is virtual instructor-led; hybrid combines classroom and online; on-the-job (OJT) is hands-on field training; webinar is live virtual session; self-paced is asynchronous online learning.. Valid values are `classroom|online|hybrid|on_the_job|webinar|self_paced`',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total instructional time required to complete the training course, measured in hours. Includes classroom time, online modules, and hands-on practice but excludes breaks and meals.',
    `effective_end_date` DATE COMMENT 'Date on which this training course will be or was retired from the training catalog and no longer available for enrollment. Null if no planned end date.',
    `effective_start_date` DATE COMMENT 'Date on which this training course became or will become available in the training catalog and eligible for enrollment.',
    `gis_system_flag` BOOLEAN COMMENT 'Indicates whether this training course covers GIS software operation, network mapping, or spatial analysis. True if GIS-related; false otherwise.',
    `language` STRING COMMENT 'Three-letter ISO 639-2 language code indicating the primary language in which the training course is delivered. Examples: ENG for English, SPA for Spanish.. Valid values are `^[A-Z]{3}$`',
    `last_content_review_date` DATE COMMENT 'Date on which the training course content, materials, and curriculum were last reviewed and validated for accuracy, relevance, and regulatory compliance. Used to ensure training materials remain current.',
    `maximum_enrollment` STRING COMMENT 'Maximum number of participants that can be enrolled in a single offering of this training course. Driven by classroom capacity, instructor-to-student ratios, or equipment availability. Null if no enrollment limit.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this training course record was last updated or modified.',
    `next_review_due_date` DATE COMMENT 'Scheduled date by which the training course content must be reviewed and updated to maintain quality and compliance standards. Typically annual or biennial review cycles.',
    `passing_score_percentage` DECIMAL(18,2) COMMENT 'Minimum percentage score required on the course assessment to achieve successful completion and receive credit or certification. Null if no assessment required.',
    `prerequisite_courses` STRING COMMENT 'Comma-separated list of course codes that must be completed before enrolling in this training course. Null if no prerequisites required.',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory agency or governing body that mandates this training course, if applicable. Examples include EPA, OSHA, state environmental agencies, or public utilities commissions. Null if not regulatory-mandated.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether this training course is mandated by federal, state, or local regulations. True if required by EPA, OSHA, state drinking water programs, or other regulatory agencies; false if voluntary or utility-discretionary.',
    `required_frequency_months` STRING COMMENT 'Interval in months at which employees must retake or refresh this training course to maintain compliance or certification. For example, 12 for annual training, 36 for triennial. Null if one-time or no recurring requirement.',
    `safety_training_flag` BOOLEAN COMMENT 'Indicates whether this training course addresses workplace safety, hazard recognition, personal protective equipment (PPE), or emergency response. True if safety-related; false otherwise. Used to track OSHA compliance training.',
    `scada_system_flag` BOOLEAN COMMENT 'Indicates whether this training course covers SCADA system operation, monitoring, or troubleshooting. True if SCADA-related; false otherwise. Used to track critical infrastructure training compliance.',
    `target_audience` STRING COMMENT 'Description of the employee roles, job functions, or departments for which this training course is designed. Examples include water treatment operators, distribution technicians, maintenance crews, supervisors, laboratory staff, or all employees.',
    `vendor_contract_number` STRING COMMENT 'Reference number of the contract or purchase order with the external training provider, if applicable. Used for procurement tracking and invoice reconciliation. Null for internal courses.',
    CONSTRAINT pk_training_course PRIMARY KEY(`training_course_id`)
) COMMENT 'Catalog of all training courses available to utility workforce including regulatory compliance training, O&M skills, safety programs, leadership development, and system-specific training (SCADA, CMMS, GIS). Captures course code, title, delivery method (classroom, online, OJT), duration, required frequency, CEU credits, regulatory mandate flag, and approved training providers. Reference entity managed by HR/Training department.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` (
    `training_record_id` BIGINT COMMENT 'Unique identifier for the training record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Training costs (course fees, travel, instructor time) are allocated to departmental cost centers for training budget tracking and cost recovery. Water utilities track training costs by department for',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who completed the training. Links to employee master data in SAP HR.',
    `training_course_id` BIGINT COMMENT 'Identifier of the training course completed. Links to course catalog.',
    `approval_date` DATE COMMENT 'Date on which the training enrollment was approved by the supervisor or manager.',
    `approved_by` STRING COMMENT 'Name or identifier of the supervisor or manager who approved the employees enrollment in the training.',
    `assessment_method` STRING COMMENT 'Method used to assess the employees understanding and competency following the training (e.g., written exam, practical test, observation, quiz, project, none).. Valid values are `written_exam|practical_test|observation|quiz|project|none`',
    `attendance_percentage` DECIMAL(18,2) COMMENT 'Percentage of the training session that the employee attended, used to determine eligibility for completion credit.',
    `certification_expiration_date` DATE COMMENT 'Date on which the certification or credential earned from this training expires and requires renewal.',
    `certification_issued` STRING COMMENT 'Name or identifier of the certification or credential issued upon successful completion of the training (e.g., Water Treatment Operator Grade II, OSHA 10-Hour Safety).',
    `ceu_credits_earned` DECIMAL(18,2) COMMENT 'Number of Continuing Education Unit credits earned upon successful completion of the training. Required for maintaining water and wastewater operator licenses.',
    `comments` STRING COMMENT 'Free-text comments or notes regarding the training event, employee performance, or special circumstances.',
    `completion_date` DATE COMMENT 'Date on which the employee successfully completed the training course.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred for the employee to attend the training, including tuition, materials, travel, and lodging expenses.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the training cost amount (e.g., USD, CAD, EUR).. Valid values are `^[A-Z]{3}$`',
    `course_code` STRING COMMENT 'Standardized code or catalog number for the training course.',
    `course_name` STRING COMMENT 'Full name of the training course completed by the employee.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was first created in the system.',
    `delivery_method` STRING COMMENT 'Method by which the training was delivered to the employee (e.g., classroom, online, webinar, on-the-job, blended, self-paced).. Valid values are `classroom|online|webinar|on_the_job|blended|self_paced`',
    `enrollment_date` DATE COMMENT 'Date on which the employee was enrolled or registered for the training course.',
    `funding_source` STRING COMMENT 'Source of funding for the training expense (e.g., operating budget, capital improvement program, grant, employee reimbursement).',
    `instructor_name` STRING COMMENT 'Name of the instructor or facilitator who conducted the training session.',
    `is_compliance_required` BOOLEAN COMMENT 'Flag indicating whether this training satisfies internal compliance requirements, safety protocols, or operational standards.',
    `is_regulatory_required` BOOLEAN COMMENT 'Flag indicating whether this training is mandated by regulatory agencies such as EPA, state primacy agencies, or OSHA for compliance purposes.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this training record was last modified or updated in the system.',
    `score` DECIMAL(18,2) COMMENT 'Numeric score or grade achieved by the employee on the training assessment, typically expressed as a percentage or points.',
    `start_date` DATE COMMENT 'Date on which the training session or course began.',
    `training_category` STRING COMMENT 'High-level category or classification of the training content (e.g., technical, safety, regulatory, leadership, operational, customer service).. Valid values are `technical|safety|regulatory|leadership|operational|customer_service`',
    `training_hours` DECIMAL(18,2) COMMENT 'Total number of hours spent in the training session, including classroom, lab, and field time.',
    `training_location` STRING COMMENT 'Physical or virtual location where the training was conducted (e.g., facility name, city, online platform).',
    `training_materials_provided` BOOLEAN COMMENT 'Flag indicating whether training materials (manuals, handouts, digital resources) were provided to the employee.',
    `training_provider` STRING COMMENT 'Name of the organization or vendor that delivered the training (e.g., AWWA, WEF, internal training department).',
    `training_result` STRING COMMENT 'Outcome of the training event indicating whether the employee passed, failed, or did not complete the training.. Valid values are `pass|fail|incomplete|waived|exempt`',
    `training_status` STRING COMMENT 'Current status of the training record in its lifecycle (e.g., scheduled, in progress, completed, cancelled, no show).. Valid values are `scheduled|in_progress|completed|cancelled|no_show`',
    `training_type` STRING COMMENT 'Type of training event indicating whether it is initial training, a refresher, recertification, advanced, or specialized training.. Valid values are `initial|refresher|recertification|advanced|specialized`',
    CONSTRAINT pk_training_record PRIMARY KEY(`training_record_id`)
) COMMENT 'Transactional record of each training event completed by an employee. Captures employee, course, completion date, training provider, instructor, pass/fail result, score, CEU credits earned, training hours, delivery method, and whether the training satisfies a regulatory or compliance requirement. Integrates with SAP HR training module and supports CCR and regulatory audit documentation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` (
    `shift_assignment_id` BIGINT COMMENT 'Unique identifier for the shift assignment record. Primary key.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where the shift is assigned. May reference a Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), pumping station, or operations center.',
    `metering_dma_zone_id` BIGINT COMMENT 'Identifier of the District Metered Area (DMA) zone assigned for this shift. Used for distribution network operations and field service assignments.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee assigned to this shift. Links to the employee master record in SAP HR.',
    `shift_approved_by_employee_id` BIGINT COMMENT 'Identifier of the user who approved this shift assignment or any changes to it. Used for audit trail and accountability.',
    `shift_employee_id` BIGINT COMMENT 'Identifier of the user who created this shift assignment record. Used for audit trail.',
    `shift_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this shift assignment record. Used for audit trail.',
    `shift_schedule_id` BIGINT COMMENT 'Identifier of the shift schedule template or pattern this assignment belongs to. Links to the shift schedule master.',
    `shift_supervisor_employee_id` BIGINT COMMENT 'Identifier of the supervisor or manager responsible for this shift assignment. Used for approval workflows and escalation.',
    `swap_request_id` BIGINT COMMENT 'Identifier of the shift swap request if this assignment resulted from an approved employee shift exchange.',
    `tertiary_shift_supervisor_employee_id` BIGINT COMMENT 'Identifier of the supervisor or manager responsible for this shift assignment. Used for approval workflows and escalation.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Field crews pick up materials, tools, and equipment from assigned warehouses at shift start. Dispatchers and supervisors need to track which warehouse location each shift assignment originates from fo',
    `work_order_id` BIGINT COMMENT 'Identifier of the work order associated with this shift assignment. Links shift labor to specific maintenance or project tasks.',
    `absence_notes` STRING COMMENT 'Free-text notes providing additional context about an absence or shift assignment change.',
    `absence_reason` STRING COMMENT 'The reason code if the employee was absent for this scheduled shift. Used for attendance tracking and leave management. [ENUM-REF-CANDIDATE: sick_leave|vacation|personal|bereavement|jury_duty|military|fmla|no_show|other — 9 candidates stripped; promote to reference product]',
    `actual_end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the employee clocked out or completed the shift. Used for actual hours worked calculation.',
    `actual_hours` DECIMAL(18,2) COMMENT 'The actual duration worked in hours. Calculated from actual start and end timestamps. Used for payroll and labor cost tracking.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the employee clocked in or began the shift. May differ from scheduled start due to early arrival or tardiness.',
    `approved_timestamp` TIMESTAMP COMMENT 'The date and time when this shift assignment was approved by the supervisor or scheduling manager.',
    `assigned_date` DATE COMMENT 'The calendar date for which this shift is assigned. Used for daily staffing planning and reporting.',
    `assignment_notes` STRING COMMENT 'Free-text notes providing additional context, special instructions, or operational details about this shift assignment.',
    `assignment_number` STRING COMMENT 'Human-readable business identifier for the shift assignment. Format: SA-YYYYMMDD-NNNN where YYYYMMDD is the assignment date and NNNN is a sequence number.. Valid values are `^SA-[0-9]{8}-[0-9]{4}$`',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the shift assignment. Tracks progression from scheduling through completion or cancellation. [ENUM-REF-CANDIDATE: scheduled|confirmed|in_progress|completed|swapped|cancelled|absent|no_show — 8 candidates stripped; promote to reference product]',
    `certification_required` STRING COMMENT 'The operator certification or license level required for this shift role. Examples: Grade 1 Water Operator, Grade 3 Wastewater Operator, Backflow Prevention Certification.',
    `certification_verified_flag` BOOLEAN COMMENT 'Indicates whether the assigned employee holds valid certification for the required role. True if certification is current and verified.',
    `cost_center_code` STRING COMMENT 'The financial cost center code to which this shift labor cost is allocated. Used for departmental expense tracking in SAP FI/CO.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this shift assignment record was first created in the system.',
    `emergency_callout_flag` BOOLEAN COMMENT 'Indicates whether this shift was an unscheduled emergency callout. True for emergency response assignments outside regular schedule.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'The total labor cost for this shift assignment including base pay, overtime premium, and shift differentials. Used for operational cost tracking and Capital Improvement Program (CIP) labor allocation.',
    `labor_cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the labor cost amount. Typically USD for U.S. water utilities.. Valid values are `^[A-Z]{3}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this shift assignment record was last modified.',
    `on_call_flag` BOOLEAN COMMENT 'Indicates whether this is an on-call shift assignment. True if the employee is on standby for emergency response.',
    `overtime_flag` BOOLEAN COMMENT 'Indicates whether this shift qualifies as overtime under labor regulations or collective bargaining agreements. True if overtime applies.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'The number of hours within this shift that qualify as overtime. Used for premium pay calculation.',
    `project_code` STRING COMMENT 'The Capital Improvement Program (CIP) project code if this shift labor is allocated to a capital project. Used for CAPEX tracking in SAP PS.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'The planned duration of the shift in hours. Calculated from shift start and end timestamps.',
    `shift_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the shift is scheduled to end. Used for time and attendance tracking and overtime calculation.',
    `shift_role` STRING COMMENT 'The functional role the employee performs during this shift. Determines responsibilities and required certifications. [ENUM-REF-CANDIDATE: lead_operator|assistant_operator|field_technician|maintenance_crew|on_call|supervisor|lab_technician — 7 candidates stripped; promote to reference product]',
    `shift_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the shift is scheduled to begin. Used for time and attendance tracking.',
    `shift_type` STRING COMMENT 'Classification of the shift assignment type. Determines pay rules and scheduling constraints.. Valid values are `regular|overtime|on_call|emergency|training|standby`',
    CONSTRAINT pk_shift_assignment PRIMARY KEY(`shift_assignment_id`)
) COMMENT 'Comprehensive shift management product for 24/7 utility operations covering both schedule templates and individual employee shift assignments. Schedule template aspects capture shift type (day/evening/night/on-call/split), rotation pattern (fixed, rotating, 12-hour continental, Panama), start/end times, facility or DMA zone assignment, minimum staffing requirements, and effective date ranges. Assignment aspects capture individual employee, assigned date, start/end datetime, role during shift (lead operator, assistant, on-call primary/backup), overtime flag, assignment status (scheduled, confirmed, swapped, absent), on-call activation history, and coverage gap alerts. Supports WTP, WWTP, distribution, collection, and field service crew staffing continuity including emergency response roster management and mutual aid callout coordination.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`crew` (
    `crew_id` BIGINT COMMENT 'Unique identifier for the field service crew. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Field crews are budget units tracked by cost center for labor and equipment cost control. Water utilities manage crew budgets for maintenance, repair, and emergency response operations. Removes denorm',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created this crew record.',
    `crew_last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who most recently modified this crew record.',
    `territory_id` BIGINT COMMENT 'Identifier of the geographic service area or DMA (District Metered Area) primarily served by this crew.',
    `crew_territory_id` BIGINT COMMENT 'Identifier of the geographic service area or DMA (District Metered Area) primarily served by this crew.',
    `location_id` BIGINT COMMENT 'Identifier of the primary depot, yard, or operations center where the crew is based and reports for duty.',
    `primary_crew_employee_id` BIGINT COMMENT 'Identifier of the system user who created this crew record.',
    `registry_id` BIGINT COMMENT 'Identifier of the primary vehicle or mobile equipment unit assigned to this crew for field operations.',
    `warehouse_location_id` BIGINT COMMENT 'Identifier of the primary depot, yard, or operations center where the crew is based and reports for duty.',
    `average_response_time_minutes` DECIMAL(18,2) COMMENT 'Average time in minutes from dispatch to on-site arrival for this crew, used for SLA (Service Level Agreement) tracking and crew performance evaluation.',
    `certification_level` STRING COMMENT 'Highest water/wastewater operator certification level held by crew members, determining complexity of work authorized. Levels align with state operator licensing requirements.. Valid values are `level_1|level_2|level_3|level_4|specialized`',
    `crew_code` STRING COMMENT 'Business identifier code for the crew used in field service dispatch and work order assignment. Typically alphanumeric format used in Microsoft Dynamics 365 Field Service.. Valid values are `^[A-Z0-9]{4,12}$`',
    `confined_space_certified` BOOLEAN COMMENT 'Indicates whether all crew members hold valid confined space entry certification required for work in manholes, vaults, and tanks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was first created in the system.',
    `crew_status` STRING COMMENT 'Current operational status of the crew: active (available for dispatch), inactive (temporarily unavailable), on_leave (scheduled time off), or disbanded (permanently decommissioned).. Valid values are `active|inactive|on_leave|disbanded`',
    `crew_type` STRING COMMENT 'Classification of crew by specialized function: leak repair, main break response, meter installation/replacement, CIPP (Cured-in-Place Pipe) lining, pump maintenance, or valve maintenance.. Valid values are `leak_repair|main_break|meter_crew|cipp_lining|pump_maintenance|valve_maintenance`',
    `effective_end_date` DATE COMMENT 'Date when this crew configuration was deactivated or disbanded. Null for currently active crews.',
    `effective_start_date` DATE COMMENT 'Date when this crew configuration became active and available for work assignment.',
    `emergency_response_qualified` BOOLEAN COMMENT 'Indicates whether crew is qualified and equipped for emergency response including main breaks, SSO (Sanitary Sewer Overflow), and water quality incidents.',
    `equipment_inventory_complete` BOOLEAN COMMENT 'Indicates whether the crew has a complete inventory of required tools, safety equipment, and materials as defined in crew type standards.',
    `excavation_certified` BOOLEAN COMMENT 'Indicates whether crew members hold valid excavation and trenching safety certification for underground utility work.',
    `gps_tracking_enabled` BOOLEAN COMMENT 'Indicates whether real-time GPS tracking is enabled for this crews vehicle for dispatch optimization and safety monitoring.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether crew members hold valid hazardous materials handling certification for chemical treatment and spill response.',
    `hourly_labor_rate` DECIMAL(18,2) COMMENT 'Standard hourly labor rate for this crew used in work order costing and budget planning. Represents blended rate for all crew members.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was most recently updated.',
    `last_safety_training_date` DATE COMMENT 'Date of the most recent safety training completed by all crew members, used to ensure compliance with annual or periodic training requirements.',
    `mobile_device_code` STRING COMMENT 'Identifier of the mobile device (tablet, rugged handheld) assigned to crew for field data capture, work order updates, and GIS (Geographic Information System) access.',
    `crew_name` STRING COMMENT 'Human-readable name of the crew for identification in dispatch and scheduling systems.',
    `notes` STRING COMMENT 'Free-text notes capturing special instructions, crew capabilities, equipment limitations, or other operational information relevant to dispatch and scheduling.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether crew members are eligible for overtime compensation under labor agreements and regulations.',
    `safety_incident_count_ytd` STRING COMMENT 'Count of OSHA recordable safety incidents involving this crew in the current calendar year, tracked for safety performance and compliance reporting.',
    `shift_schedule` STRING COMMENT 'Standard shift assignment for the crew: day shift (typically 7am-3pm), night shift (typically 11pm-7am), rotating schedule, on-call availability, or dedicated emergency response.. Valid values are `day_shift|night_shift|rotating|on_call|emergency_response`',
    `size` STRING COMMENT 'Number of employees assigned to this crew. Typical water utility field crews range from 2 to 6 members depending on crew type and task complexity.',
    `union_affiliation` STRING COMMENT 'Labor union or collective bargaining unit affiliation for crew members, relevant for scheduling, overtime rules, and labor relations.',
    `vehicle_code` BIGINT COMMENT 'Identifier of the primary vehicle or mobile equipment unit assigned to this crew for field operations.',
    `work_orders_completed_ytd` STRING COMMENT 'Count of work orders completed by this crew in the current calendar year, used for productivity tracking and resource planning.',
    CONSTRAINT pk_crew PRIMARY KEY(`crew_id`)
) COMMENT 'Master record for field service crews including crew definition, membership rosters, and work order assignments for distribution maintenance, wastewater collection, meter installation, and infrastructure repair. Captures crew name/code, crew type (leak repair, main break, meter crew, CIPP lining, pump maintenance, hydrant crew, valve crew), crew lead employee, home depot/yard, vehicle assignment, crew size, active status, and detailed crew member roster (employee, role on crew such as lead/operator/helper/apprentice, assignment period, work order reference, hours worked per assignment). Supports crew-to-work-order labor tracking and integrates with Microsoft Dynamics 365 Field Service for crew dispatch and IBM Maximo CMMS for O&M cost allocation per work order.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` (
    `labor_timesheet_id` BIGINT COMMENT 'Unique identifier for the labor timesheet record.',
    `cip_project_id` BIGINT COMMENT 'Identifier of the CIP project against which labor hours are charged. Links to SAP PS project or capital project registry. Null if labor is charged to O&M work order.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Timesheets allocate labor costs to cost centers for departmental budget tracking and variance analysis. Essential for monthly financial close and departmental performance reporting in water utilities.',
    `general_ledger_id` BIGINT COMMENT 'Foreign key linking to finance.general_ledger. Business justification: Labor costs must post to specific GL accounts for financial reporting, GASB compliance, and rate case cost documentation. Water utilities track labor by GL account for regulatory cost-of-service studi',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor who approved this timesheet entry. Links to SAP HR employee master data.',
    `primary_labor_employee_id` BIGINT COMMENT 'Identifier of the employee who performed the work. Links to SAP HR employee master data.',
    `work_order_id` BIGINT COMMENT 'Identifier of the work order against which labor hours are charged. Links to SAP PM work order or Maximo work order.',
    `activity_type` STRING COMMENT 'Classification of the work activity performed. Used to distinguish OPEX vs CAPEX labor allocation and operational reporting.. Valid values are `operations|maintenance|capital|emergency|training|administrative`',
    `approval_status` STRING COMMENT 'Current approval status of the timesheet entry. Controls whether labor costs are posted to financial accounting and payroll.. Valid values are `pending|approved|rejected|submitted`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet entry was approved by the supervisor. Null if not yet approved.',
    `billable_flag` BOOLEAN COMMENT 'Indicates whether labor hours are billable to external customer or capital project. True if billable, False if internal O&M. Used for revenue recognition and cost recovery.',
    `call_out_hours` DECIMAL(18,2) COMMENT 'Number of hours worked during emergency call-out outside regular shift. Typically compensated at premium rate with minimum guarantee.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet record was first created in the system.',
    `crew_assignment` STRING COMMENT 'Identifier of the crew or work team to which the employee was assigned for this work period. Used for crew productivity analysis.',
    `equipment_used` STRING COMMENT 'Identifier or description of equipment or vehicle used during the work period. Used for equipment utilization tracking and cost allocation.',
    `hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours worked by the employee on the specified date and activity. Includes regular and overtime hours.',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total labor cost for this timesheet entry (hours_worked × labor_rate). Used for O&M expense tracking and CAPEX project cost accumulation. Confidential business data.',
    `labor_rate` DECIMAL(18,2) COMMENT 'Hourly labor rate applied for cost calculation. May include base wage plus burden (benefits, taxes, overhead). Confidential business data.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the timesheet record was last modified. Updated whenever any field changes.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the timesheet entry. May include supervisor comments, exception explanations, or audit notes.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked at premium pay rate. Typically hours exceeding 40 per week or 8 per day per FLSA and union agreements.',
    `pay_code` STRING COMMENT 'Payroll system code that determines compensation rate and benefits treatment. Maps to SAP HR wage type or payroll category.',
    `payroll_period` STRING COMMENT 'Identifier of the payroll period to which this timesheet entry belongs. Format typically YYYY-PP where PP is period number.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular hours worked at standard pay rate. Typically up to 8 hours per day or 40 hours per week per FLSA.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether a safety incident occurred during this work period. True if incident occurred, False otherwise. Links to OSHA incident tracking.',
    `shift_type` STRING COMMENT 'Classification of the work shift. Determines pay rate multiplier and labor cost allocation rules.. Valid values are `regular|overtime|standby|call_out|holiday|weekend`',
    `standby_hours` DECIMAL(18,2) COMMENT 'Number of hours employee was on standby or on-call status. May be compensated at a different rate than regular hours.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the employee submitted the timesheet entry for approval.',
    `task_description` STRING COMMENT 'Free-text description of the work task or activity performed. Provides operational detail for labor tracking and audit purposes.',
    `timesheet_date` DATE COMMENT 'The calendar date on which the labor hours were worked. Used for payroll period assignment and labor cost allocation.',
    `training_hours` DECIMAL(18,2) COMMENT 'Number of hours spent on training or certification activities during this work period. Used for operator license compliance tracking.',
    `work_location` STRING COMMENT 'Physical location or facility where work was performed (e.g., WTP, WWTP, Distribution Zone, Field). Used for geographic labor cost analysis.',
    CONSTRAINT pk_labor_timesheet PRIMARY KEY(`labor_timesheet_id`)
) COMMENT 'Captures actual labor hours worked by employees against work orders, projects, or operational activities. Records employee, date, work order or CIP project reference, activity type (regular, overtime, standby, call-out), hours worked, pay code, cost center, and supervisor approval status. Feeds SAP HR payroll and SAP PM/PS for O&M and CAPEX labor cost allocation. Supports OPEX vs CAPEX labor classification.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the organizational position. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Positions are budgeted within cost centers for headcount planning and salary budget allocation. Essential for position control, budget approval workflows, and FTE tracking in water utilities. Removes',
    `facility_id` BIGINT COMMENT 'Reference to the primary facility or work location where this position is based (e.g., Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), district office, field operations center).',
    `org_unit_id` BIGINT COMMENT 'Reference to the organizational department or division to which this position is assigned (e.g., Water Treatment Operations, Distribution Maintenance, Wastewater Collections).',
    `position_org_unit_id` BIGINT COMMENT 'Reference to the organizational department or division to which this position is assigned (e.g., Water Treatment Operations, Distribution Maintenance, Wastewater Collections).',
    `supervisor_position_id` BIGINT COMMENT 'Reference to the position that supervises this position in the organizational hierarchy. Enables reporting structure and span-of-control analysis.',
    `approval_date` DATE COMMENT 'Date when this position was officially approved by the governing authority. Used for audit trails and compliance documentation.',
    `approved_by` STRING COMMENT 'Name or identifier of the executive or governing body that approved the creation or modification of this position (e.g., Utility Director, Board of Commissioners).',
    `bargaining_unit` STRING COMMENT 'Name or code of the collective bargaining unit to which this position belongs, if applicable (e.g., AFSCME Local 123, Teamsters Local 456). Null for non-union positions.',
    `position_code` STRING COMMENT 'Business identifier for the position used in SAP HR and workforce planning systems. Unique alphanumeric code assigned to each authorized position.. Valid values are `^[A-Z0-9]{6,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was first created in the system. Used for audit trails and data lineage tracking.',
    `position_description` STRING COMMENT 'Detailed narrative description of the positions responsibilities, duties, and accountabilities. Typically includes essential functions, working conditions, and physical requirements.',
    `effective_end_date` DATE COMMENT 'Date when this position was eliminated or became inactive. Null for active positions. Used for historical workforce analysis and organizational change tracking.',
    `effective_start_date` DATE COMMENT 'Date when this position was created or became effective in the organizational structure. Used for workforce planning and historical analysis.',
    `flsa_status` STRING COMMENT 'Classification under the Fair Labor Standards Act. Exempt positions are salaried and not eligible for overtime pay; non-exempt positions are eligible for overtime compensation for hours worked beyond 40 per week.. Valid values are `exempt|non_exempt`',
    `fte_count` DECIMAL(18,2) COMMENT 'Number of full-time equivalent employees authorized for this position. Typically 1.0 for full-time positions; may be fractional for part-time or shared positions (e.g., 0.5 FTE).',
    `job_code` STRING COMMENT 'Standardized job classification code linking the position to a job family and career ladder. Used for compensation benchmarking and workforce analytics.. Valid values are `^[A-Z0-9]{4,10}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this position record was last updated. Used for change tracking and audit compliance.',
    `organizational_level` STRING COMMENT 'Hierarchical level of this position within the organizational structure. Level 1 is typically executive leadership; higher numbers represent deeper levels in the hierarchy. Used for span-of-control analysis and reporting structure visualization.',
    `pay_grade` STRING COMMENT 'Compensation grade or band assigned to this position. Links to the utilitys compensation structure and defines the salary range for the position.. Valid values are `^[A-Z0-9]{2,6}$`',
    `pay_range_maximum` DECIMAL(18,2) COMMENT 'Maximum annual salary or hourly wage for this position in USD. Defines the top of the compensation band for this position.',
    `pay_range_minimum` DECIMAL(18,2) COMMENT 'Minimum annual salary or hourly wage for this position in USD. Used for budgeting and compensation planning.',
    `position_status` STRING COMMENT 'Current lifecycle status of the position. Active positions are authorized and may be filled or vacant; frozen positions are temporarily unfunded; eliminated positions are closed and no longer part of the organizational structure.. Valid values are `active|vacant|frozen|eliminated|pending_approval`',
    `position_type` STRING COMMENT 'Classification of the position by employment type. Full-time positions are permanent and year-round; seasonal positions support peak demand periods (e.g., summer water demand); temporary positions are project-based.. Valid values are `full_time|part_time|temporary|seasonal|contract`',
    `required_certifications` STRING COMMENT 'Comma-separated list of mandatory professional certifications or licenses required for this position (e.g., CDL Class A, OSHA 30-Hour, Confined Space Entry, Backflow Prevention Certification, SCADA System Operator). Used for compliance tracking and training planning.',
    `required_operator_license_grade` STRING COMMENT 'Minimum water or wastewater operator license grade required for this position as mandated by state drinking water or wastewater discharge programs. Grades typically range from 1 (entry-level) to 4 (advanced treatment plant operations). Critical for regulatory compliance under Safe Drinking Water Act (SDWA) and Clean Water Act (CWA).. Valid values are `^(Grade [1-4]|Class [A-D]|None)$`',
    `requires_cdl` BOOLEAN COMMENT 'Indicates whether this position requires a valid Commercial Driver License (CDL) for operating utility vehicles (e.g., tanker trucks, heavy equipment). CDL class and endorsements are specified in required_certifications.',
    `requires_confined_space_entry` BOOLEAN COMMENT 'Indicates whether this position requires confined space entry certification and training for work in tanks, manholes, vaults, and other permit-required confined spaces. Critical for safety compliance under OSHA 1910.146.',
    `requires_on_call` BOOLEAN COMMENT 'Indicates whether this position requires 24/7 on-call availability for emergency response (e.g., water main breaks, treatment plant alarms, wastewater overflows). Critical for Operations and Maintenance (O&M) workforce planning.',
    `safety_sensitive` BOOLEAN COMMENT 'Indicates whether this position is classified as safety-sensitive under OSHA or Department of Transportation (DOT) regulations, requiring enhanced safety training, drug testing, and incident tracking.',
    `shift_rotation_required` BOOLEAN COMMENT 'Indicates whether this position requires rotating shift work (e.g., 24/7 treatment plant operations with day/evening/night shifts). Used for crew scheduling and workforce planning.',
    `succession_criticality` STRING COMMENT 'Assessment of the criticality of this position for succession planning. Critical positions have limited internal talent pools and require proactive succession planning (e.g., licensed operators, specialized engineers).. Valid values are `critical|high|medium|low`',
    `title` STRING COMMENT 'Official job title for the position as defined in the organizational structure (e.g., Water Treatment Plant Operator II, Distribution System Supervisor, Wastewater Compliance Manager).',
    `union_classification` STRING COMMENT 'Indicates whether this position is covered by a collective bargaining agreement. Union positions are subject to negotiated labor contracts; management positions are typically excluded from union representation.. Valid values are `union|non_union|management`',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Organizational position master defining authorized roles within the utilitys workforce structure. Captures position title, job code, department, facility, required operator license grade, required certifications, pay grade range, FTE count authorized, union classification, FLSA status (exempt/non-exempt), and whether the position requires 24/7 on-call availability. Supports workforce planning and succession management. Sourced from SAP HR Organizational Management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` (
    `org_unit_id` BIGINT COMMENT 'Unique identifier for the organizational unit. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Organizational units map to cost centers for budget allocation, financial planning, and departmental P&L reporting. Standard practice in water utilities for organizational budget management and financ',
    `location_id` BIGINT COMMENT 'Reference to the primary physical facility or location where this organizational unit operates (e.g., Water Treatment Plant (WTP), Wastewater Treatment Plant (WWTP), administrative office).',
    `employee_id` BIGINT COMMENT 'Reference to the employee who manages this organizational unit. Used for reporting hierarchy and approval workflows.',
    `parent_org_unit_id` BIGINT COMMENT 'Reference to the parent organizational unit in the hierarchy. Enables multi-level organizational structure modeling.',
    `address_line_1` STRING COMMENT 'Primary street address of the organizational unit office or facility.',
    `address_line_2` STRING COMMENT 'Secondary address information (suite, building, floor) for the organizational unit.',
    `budget_amount_annual` DECIMAL(18,2) COMMENT 'Total annual operating budget allocated to this organizational unit in US dollars.',
    `budget_fiscal_year` STRING COMMENT 'Fiscal year for which the annual budget amount applies.',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether employees in this organizational unit are required to hold professional certifications (e.g., water/wastewater operator licenses).',
    `city` STRING COMMENT 'City where the organizational unit is located.',
    `country_code` STRING COMMENT 'Three-letter ISO country code for the organizational unit location.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was first created in the system.',
    `org_unit_description` STRING COMMENT 'Detailed description of the organizational units mission, responsibilities, and scope of operations.',
    `effective_end_date` DATE COMMENT 'Date when this organizational unit was or will be dissolved or reorganized. Null for active units.',
    `effective_start_date` DATE COMMENT 'Date when this organizational unit became or will become operational.',
    `email_address` STRING COMMENT 'Primary email address for the organizational unit for official communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `fax_number` STRING COMMENT 'Fax number for the organizational unit, if applicable.. Valid values are `^+?[0-9]{10,15}$`',
    `functional_area` STRING COMMENT 'Primary business function or operational domain of the organizational unit aligned with core utility processes. [ENUM-REF-CANDIDATE: water_operations|wastewater_operations|engineering|customer_service|finance|human_resources|information_technology|regulatory_compliance|asset_management|laboratory|supply_chain|capital_projects — 12 candidates stripped; promote to reference product]',
    `headcount_actual` STRING COMMENT 'Current number of filled full-time equivalent (FTE) positions in this organizational unit.',
    `headcount_authorized` STRING COMMENT 'Number of authorized full-time equivalent (FTE) positions allocated to this organizational unit.',
    `hierarchy_level` STRING COMMENT 'Numeric level of this organizational unit in the overall hierarchy (1 = top level, higher numbers = deeper levels).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this organizational unit record was last modified.',
    `operates_24_7` BOOLEAN COMMENT 'Indicates whether this organizational unit operates on a 24-hour, 7-day-per-week schedule (typical for Water Treatment Plant (WTP) and Wastewater Treatment Plant (WWTP) operations).',
    `phone_number` STRING COMMENT 'Primary contact phone number for the organizational unit.. Valid values are `^+?[0-9]{10,15}$`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the organizational unit location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `regulatory_oversight_agency` STRING COMMENT 'Primary regulatory agency with oversight authority over this organizational unit (e.g., U.S. Environmental Protection Agency (EPA), state primacy agency, Public Utilities Commission (PUC)).',
    `safety_sensitive_flag` BOOLEAN COMMENT 'Indicates whether this organizational unit performs safety-sensitive functions requiring enhanced Occupational Safety and Health Administration (OSHA) compliance and monitoring.',
    `shift_schedule_type` STRING COMMENT 'Type of shift schedule used by this organizational unit (standard business hours, rotating shifts, fixed shifts, on-call, flexible).. Valid values are `standard|rotating|fixed|on_call|flexible`',
    `state_province` STRING COMMENT 'Two-letter state or province code where the organizational unit is located.. Valid values are `^[A-Z]{2}$`',
    `union_representation` BOOLEAN COMMENT 'Indicates whether employees in this organizational unit are represented by a labor union.',
    `unit_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the organizational unit. Used for reporting and system integration.. Valid values are `^[A-Z0-9]{2,10}$`',
    `unit_name` STRING COMMENT 'Full business name of the organizational unit (e.g., Water Operations Division, Wastewater Treatment Department).',
    `unit_short_name` STRING COMMENT 'Abbreviated name of the organizational unit for display in constrained UI contexts and reports.',
    `unit_status` STRING COMMENT 'Current lifecycle status of the organizational unit. Active units are operational; planned units are future; dissolved units are historical.. Valid values are `active|inactive|planned|dissolved`',
    `unit_type` STRING COMMENT 'Classification of the organizational unit within the hierarchy (division, department, work group, section, team, cost center).. Valid values are `division|department|work_group|section|team|cost_center`',
    CONSTRAINT pk_org_unit PRIMARY KEY(`org_unit_id`)
) COMMENT 'Organizational unit hierarchy for the utility including divisions (Water Operations, Wastewater Operations, Engineering, Customer Service, Finance), departments, and work groups. Captures unit name, unit code, parent unit, unit type, cost center reference, facility location, and manager employee reference. Provides the organizational backbone for workforce reporting, cost allocation, and access control. Sourced from SAP HR Organizational Management.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` (
    `safety_incident_id` BIGINT COMMENT 'Unique identifier for the safety incident record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Safety incidents generate costs (workers compensation, medical, repairs, lost time) that must be charged to departmental cost centers for safety cost tracking, insurance rate justification, and depart',
    `facility_id` BIGINT COMMENT 'Identifier of the facility where the incident occurred, if applicable. Links to asset registry for WTP, WWTP, pump stations, or other fixed facilities.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee involved in or affected by the incident. Links to SAP HR employee master.',
    `process_unit_id` BIGINT COMMENT 'Foreign key linking to treatment.process_unit. Business justification: Safety incidents at treatment facilities often occur at specific process units (filters, clarifiers, chemical feed systems). Linking to process_unit enables equipment-specific safety trend analysis, t',
    `registry_id` BIGINT COMMENT 'Identifier of the utility vehicle involved in the incident, if applicable. Links to fleet asset registry.',
    `safety_employee_id` BIGINT COMMENT 'Identifier of the supervisor responsible for the employee or work area at the time of the incident. Links to SAP HR employee master.',
    `tertiary_safety_reported_by_employee_id` BIGINT COMMENT 'Identifier of the employee who reported the incident. May be the affected employee, a witness, or a supervisor.',
    `work_order_id` BIGINT COMMENT 'Identifier of the work order the employee was performing at the time of the incident, if applicable. Links to IBM Maximo work order.',
    `body_part_affected` STRING COMMENT 'Body part or region affected by the injury (e.g., hand, back, leg, eye, head). Required for OSHA 300 log if injury occurred.',
    `corrective_action_completed_date` DATE COMMENT 'Actual date when corrective actions were completed and verified.',
    `corrective_action_description` STRING COMMENT 'Description of corrective actions taken or planned to prevent recurrence of similar incidents (e.g., procedure revision, equipment repair, additional training, engineering control).',
    `corrective_action_due_date` DATE COMMENT 'Target completion date for corrective actions. Used for tracking and accountability.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Indicates whether corrective actions are required to prevent recurrence. True if corrective actions are needed, False if no actions required.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was first created in the system.',
    `days_away_from_work` STRING COMMENT 'Number of calendar days the employee was unable to work as a result of the incident. Used for OSHA 300 log and lost-time injury rate calculation.',
    `days_of_restricted_duty` STRING COMMENT 'Number of calendar days the employee was on restricted or light duty as a result of the incident. Used for OSHA 300 log.',
    `department` STRING COMMENT 'Department or organizational unit where the employee was assigned at the time of the incident (e.g., Water Treatment, Distribution Operations, Wastewater Collection).',
    `environmental_release_flag` BOOLEAN COMMENT 'Indicates whether the incident involved an environmental release (spill, discharge, or emission). True if release occurred, False if no release.',
    `environmental_release_volume` DECIMAL(18,2) COMMENT 'Volume of environmental release in gallons, if applicable. Used for regulatory reporting and environmental impact assessment.',
    `field_location_description` STRING COMMENT 'Textual description of the field location where the incident occurred, if not at a fixed facility (e.g., intersection of Main St and Oak Ave, water main break site at 123 Elm Street).',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the incident location in decimal degrees. Used for spatial analysis and mapping.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the incident location in decimal degrees. Used for spatial analysis and mapping.',
    `incident_date` DATE COMMENT 'Date when the safety incident occurred.',
    `incident_description` STRING COMMENT 'Detailed narrative description of how the incident occurred, including sequence of events, conditions, and contributing factors.',
    `incident_number` STRING COMMENT 'Business-facing unique incident number used for tracking and reporting. Format: INC-YYYYMMDD.. Valid values are `^INC-[0-9]{8}$`',
    `incident_time` TIMESTAMP COMMENT 'Precise timestamp when the safety incident occurred, including time zone.',
    `incident_type` STRING COMMENT 'Classification of the safety incident: injury (physical harm to employee), near-miss (potential incident with no harm), property damage (damage to utility assets or equipment), environmental release (spill or discharge), vehicle accident (fleet-related collision), or occupational illness (work-related disease).. Valid values are `injury|near_miss|property_damage|environmental_release|vehicle_accident|occupational_illness`',
    `injury_nature` STRING COMMENT 'Nature or type of injury sustained (e.g., laceration, contusion, fracture, sprain, burn, chemical exposure, respiratory illness).',
    `injury_severity` STRING COMMENT 'Severity classification of the injury: first aid (minor treatment only), medical treatment (beyond first aid), lost time (days away from work), restricted duty (work restrictions applied), fatality (death), or none (no injury, e.g., near-miss or property damage).. Valid values are `first_aid|medical_treatment|lost_time|restricted_duty|fatality|none`',
    `investigation_completed_date` DATE COMMENT 'Date when the incident investigation was completed and the investigation report was finalized.',
    `investigation_status` STRING COMMENT 'Current status of the incident investigation: pending (not yet started), in progress (investigation underway), completed (investigation finished, report submitted), or closed (all corrective actions completed and verified).. Valid values are `pending|in_progress|completed|closed`',
    `job_title` STRING COMMENT 'Job title or position of the employee at the time of the incident (e.g., Water Treatment Operator, Field Service Technician, Maintenance Mechanic).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the incident record was last updated in the system.',
    `location_type` STRING COMMENT 'Type of location where the incident occurred: facility (WTP, WWTP, pump station), field site (distribution/collection network), vehicle (utility fleet), office (administrative building), customer site (on customer property), or public right-of-way (street, sidewalk).. Valid values are `facility|field_site|vehicle|office|customer_site|public_right_of_way`',
    `osha_log_reference` STRING COMMENT 'Reference to the OSHA 300 log entry number if the incident is OSHA-recordable. Format varies by utility (e.g., 2024-001, 300-2024-0015).',
    `osha_recordable_flag` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA criteria for recordability on the OSHA 300 log. True if recordable, False if not recordable.',
    `property_damage_amount` DECIMAL(18,2) COMMENT 'Estimated or actual cost of property damage resulting from the incident, in US dollars. Includes damage to utility assets, equipment, vehicles, or third-party property.',
    `regulatory_notification_date` DATE COMMENT 'Date when regulatory agencies were notified of the incident, if notification was required.',
    `regulatory_notification_required_flag` BOOLEAN COMMENT 'Indicates whether the incident requires notification to regulatory agencies (OSHA, EPA, state agencies). True if notification required, False if not required.',
    `reported_date` DATE COMMENT 'Date when the incident was formally reported to management or safety personnel.',
    `root_cause_category` STRING COMMENT 'Primary root cause category determined through incident investigation: human error (operator mistake), equipment failure (mechanical/electrical failure), environmental condition (weather, terrain), procedural gap (missing or inadequate procedure), inadequate training (lack of competency), or PPE failure (personal protective equipment deficiency).. Valid values are `human_error|equipment_failure|environmental_condition|procedural_gap|inadequate_training|ppe_failure`',
    `root_cause_description` STRING COMMENT 'Detailed description of the root cause identified through incident investigation, including contributing factors and systemic issues.',
    `supervisor_name` STRING COMMENT 'Name of the supervisor responsible for the employee or work area at the time of the incident.',
    `vehicle_code` BIGINT COMMENT 'Identifier of the utility vehicle involved in the incident, if applicable. Links to fleet asset registry.',
    `witness_count` STRING COMMENT 'Number of witnesses to the incident. Used for investigation completeness tracking.',
    CONSTRAINT pk_safety_incident PRIMARY KEY(`safety_incident_id`)
) COMMENT 'Comprehensive EHS (Environment, Health & Safety) records for utility workforce covering OSHA-recordable and non-recordable safety incidents, near-misses, workplace safety inspections, and inspection findings. Incident aspects capture incident date/time, location (facility, field site, GIS coordinates), incident type (injury, near-miss, property damage, environmental release, vehicle accident), OSHA recordability determination, body part affected, root cause classification, corrective actions, days away from work, restricted duty days, and OSHA 300/300A log reference. Inspection aspects capture inspection date, inspector, facility/location, inspection type (routine, pre-task, regulatory, third-party), checklist items evaluated, findings/deficiencies, severity rating, corrective action required, and closure status. Mandatory for OSHA compliance, utility safety program management, and regulatory audit documentation.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` (
    `leave_request_id` BIGINT COMMENT 'Unique identifier for the leave request record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor or manager who approved or denied the leave request. Links to employee master data.',
    `primary_leave_employee_id` BIGINT COMMENT 'Identifier of the employee submitting the leave request. Links to employee master data in SAP HR.',
    `tertiary_leave_backup_employee_id` BIGINT COMMENT 'Identifier of the employee assigned to cover the absent employees duties during the leave period. Links to employee master data.',
    `location_id` BIGINT COMMENT 'Identifier of the employees primary work location (e.g., WTP (Water Treatment Plant), WWTP (Wastewater Treatment Plant), field service area) affected by the leave. Used for shift coverage planning.',
    `accrual_balance_after` DECIMAL(18,2) COMMENT 'Employees leave accrual balance (in hours) after this leave request is applied. Used to prevent negative balances and enforce policy limits.',
    `accrual_balance_before` DECIMAL(18,2) COMMENT 'Employees leave accrual balance (in hours) before this leave request is applied. Snapshot for audit and verification purposes.',
    `advance_notice_days` STRING COMMENT 'Number of calendar days between request submission and requested start date. Used to assess compliance with advance notice policies.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the leave request was approved or denied by the supervisor. Used for audit trail and SLA (Service Level Agreement) tracking.',
    `approved_end_date` DATE COMMENT 'The actual last date of absence approved by the supervisor. May differ from requested end date based on operational needs.',
    `approved_start_date` DATE COMMENT 'The actual first date of absence approved by the supervisor. May differ from requested start date based on operational needs.',
    `attachment_url` STRING COMMENT 'URL or file path to supporting documentation (e.g., medical certificate, FMLA certification form, jury duty summons) stored in the document management system.',
    `certification_received` BOOLEAN COMMENT 'Flag indicating whether the required certification documentation has been received and verified by HR.',
    `certification_received_date` DATE COMMENT 'Date when the supporting certification documentation was received by HR. Used to track compliance with submission deadlines.',
    `certification_required` BOOLEAN COMMENT 'Indicates whether medical or other official certification is required to support the leave request (e.g., doctors note for sick leave, FMLA certification form).',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which the leave hours and any associated costs (e.g., backfill overtime) are charged. Used for labor cost tracking and budgeting.',
    `coverage_plan` STRING COMMENT 'Description of how the employees absence will be covered, including backfill assignments, overtime scheduling, or workload redistribution. Feeds shift scheduling system.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the leave request record was first created in the system. Used for audit trail and data lineage.',
    `denial_reason` STRING COMMENT 'Explanation provided by the supervisor for denying the leave request. Required for transparency and potential grievance resolution.',
    `fmla_case_number` STRING COMMENT 'Unique case identifier for FMLA-protected leave, used to track the 12-week entitlement period and ensure compliance with federal regulations.',
    `hours_approved` DECIMAL(18,2) COMMENT 'Total number of work hours approved by the supervisor for the leave period. Used for payroll deduction and accrual balance updates.',
    `hours_requested` DECIMAL(18,2) COMMENT 'Total number of work hours the employee is requesting as leave. Calculated based on the employees standard work schedule and requested date range.',
    `is_emergency_leave` BOOLEAN COMMENT 'Flag indicating whether this is an emergency or unplanned leave request (e.g., sudden illness, family emergency) that may bypass standard advance notice requirements.',
    `is_fmla_eligible` BOOLEAN COMMENT 'Flag indicating whether this leave request qualifies for FMLA protection based on employee tenure, hours worked, and reason for leave. Critical for compliance reporting.',
    `is_paid` BOOLEAN COMMENT 'Indicates whether the approved leave is paid (true) or unpaid (false). Determines payroll processing treatment.',
    `leave_subtype` STRING COMMENT 'Detailed classification within the leave type, such as continuous FMLA, intermittent FMLA, short-term disability, or personal leave. Provides granular categorization for reporting and compliance.',
    `leave_type` STRING COMMENT 'Category of leave being requested: vacation (paid time off), sick (illness or medical appointments), FMLA (Family and Medical Leave Act protected leave), military (active duty or reserve service), bereavement (death of family member), or jury duty (civic obligation).. Valid values are `vacation|sick|fmla|military|bereavement|jury_duty`',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the leave request record was last updated. Tracks changes to status, approval, or other attributes.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special circumstances, or instructions related to the leave request. May include employee explanations or supervisor guidance.',
    `payroll_period` STRING COMMENT 'The payroll period (YYYY-MM format) in which the leave hours will be processed for payroll deduction or payment. Links to payroll processing cycles.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])$`',
    `request_number` STRING COMMENT 'Business-facing unique identifier for the leave request, formatted as LR-YYYYNNNN for tracking and reference.. Valid values are `^LR-[0-9]{8}$`',
    `request_status` STRING COMMENT 'Current lifecycle state of the leave request: draft (being prepared), submitted (awaiting review), pending_approval (under supervisor review), approved (authorized for absence), denied (rejected by supervisor), cancelled (system-cancelled due to business rule), or withdrawn (employee retracted request). [ENUM-REF-CANDIDATE: draft|submitted|pending_approval|approved|denied|cancelled|withdrawn — 7 candidates stripped; promote to reference product]',
    `request_submission_timestamp` TIMESTAMP COMMENT 'Date and time when the employee submitted the leave request. Used to track advance notice compliance and approval SLA (Service Level Agreement).',
    `requested_end_date` DATE COMMENT 'The last date of absence requested by the employee. Defines the duration of the leave period.',
    `requested_start_date` DATE COMMENT 'The first date of absence requested by the employee. Used for shift coverage planning and payroll processing.',
    `shift_coverage_impact` STRING COMMENT 'Assessment of the operational impact of the leave on shift coverage and crew availability. Used by supervisors to evaluate approval feasibility and plan backfill resources.. Valid values are `none|minimal|moderate|significant|critical`',
    CONSTRAINT pk_leave_request PRIMARY KEY(`leave_request_id`)
) COMMENT 'Employee leave and absence management records including vacation, sick leave, FMLA, military leave, bereavement, and jury duty. Captures employee, leave type, requested start and end dates, approved dates, approval status, approving supervisor, hours requested, hours approved, FMLA eligibility flag, and impact on shift coverage. Integrates with SAP HR Absence Management (Infotype 2001) and feeds shift scheduling for coverage planning.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` (
    `performance_review_id` BIGINT COMMENT 'Unique identifier for the performance review record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Performance reviews drive merit increases and promotions that impact cost center salary budgets. Water utilities require cost center approval for merit increases to ensure budget availability before H',
    `employee_id` BIGINT COMMENT 'Identifier of the employee being reviewed. Links to the employee master record in SAP HR.',
    `reviewer_employee_id` BIGINT COMMENT 'Identifier of the supervisor or manager conducting the performance review.',
    `areas_for_improvement` STRING COMMENT 'Narrative description of areas where the employee needs development, improvement, or additional training.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when the performance review record was first created in the system.',
    `customer_service_rating` STRING COMMENT 'Performance rating for customer interaction quality, responsiveness, and service delivery to utility customers and stakeholders.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `customer_service_score` DECIMAL(18,2) COMMENT 'Numeric score for customer service competency assessment.',
    `development_plan_notes` STRING COMMENT 'Detailed notes on the employee development plan, including training recommendations, skill-building activities, and career progression guidance.',
    `employee_acknowledgment_date` DATE COMMENT 'The date on which the employee acknowledged the performance review.',
    `employee_acknowledgment_status` STRING COMMENT 'Status indicating whether the employee has acknowledged receipt and review of the performance evaluation.. Valid values are `pending|acknowledged|disputed`',
    `employee_comments` STRING COMMENT 'Comments or feedback provided by the employee in response to the performance review.',
    `goal_achievement_rating` STRING COMMENT 'Performance rating for achievement of individual goals and Key Performance Indicators (KPIs) set for the review period.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `goal_achievement_score` DECIMAL(18,2) COMMENT 'Numeric score representing the percentage or level of goal achievement during the review period.',
    `merit_increase_percentage` DECIMAL(18,2) COMMENT 'The recommended percentage increase in salary based on performance, if applicable.',
    `merit_increase_recommended_flag` BOOLEAN COMMENT 'Indicates whether a merit-based salary increase is recommended based on the performance review outcome.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when the performance review record was last modified or updated.',
    `next_review_due_date` DATE COMMENT 'The scheduled date for the next performance review cycle.',
    `overall_rating` STRING COMMENT 'The overall performance rating assigned to the employee for the review period.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `overall_rating_score` DECIMAL(18,2) COMMENT 'Numeric score representing the overall performance rating, typically on a scale (e.g., 1.0 to 5.0).',
    `promotion_recommended_flag` BOOLEAN COMMENT 'Indicates whether the employee is recommended for promotion based on performance and readiness for increased responsibility.',
    `regulatory_knowledge_rating` STRING COMMENT 'Performance rating for understanding and application of Safe Drinking Water Act (SDWA), Clean Water Act (CWA), and Environmental Protection Agency (EPA) regulations.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `regulatory_knowledge_score` DECIMAL(18,2) COMMENT 'Numeric score for regulatory knowledge competency assessment.',
    `review_date` DATE COMMENT 'The date on which the performance review meeting or evaluation was conducted.',
    `review_document_url` STRING COMMENT 'URL or file path to the stored performance review document or attachment in the document management system.',
    `review_period_end_date` DATE COMMENT 'The end date of the performance evaluation period being assessed.',
    `review_period_start_date` DATE COMMENT 'The start date of the performance evaluation period being assessed.',
    `review_status` STRING COMMENT 'Current workflow status of the performance review (draft, in progress, pending employee acknowledgment, completed, or cancelled).. Valid values are `draft|in_progress|pending_employee_acknowledgment|completed|cancelled`',
    `review_type` STRING COMMENT 'The type or category of performance review being conducted (annual, mid-year, probationary, project-based, or ad-hoc).. Valid values are `annual|mid_year|probationary|project_based|ad_hoc`',
    `reviewer_comments` STRING COMMENT 'Additional comments or observations provided by the reviewer or supervisor regarding the employees performance.',
    `safety_compliance_rating` STRING COMMENT 'Performance rating for adherence to Occupational Safety and Health Administration (OSHA) safety protocols and utility safety procedures.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `safety_compliance_score` DECIMAL(18,2) COMMENT 'Numeric score for safety compliance competency assessment.',
    `strengths_summary` STRING COMMENT 'Narrative summary of the employees key strengths, accomplishments, and positive contributions during the review period.',
    `succession_planning_candidate_flag` BOOLEAN COMMENT 'Indicates whether the employee is identified as a candidate for succession planning for critical roles within the utility.',
    `teamwork_rating` STRING COMMENT 'Performance rating for collaboration, communication, and teamwork with colleagues and cross-functional teams.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `teamwork_score` DECIMAL(18,2) COMMENT 'Numeric score for teamwork and collaboration competency assessment.',
    `technical_skills_rating` STRING COMMENT 'Performance rating for technical competencies and job-specific skills required for water and wastewater operations.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory`',
    `technical_skills_score` DECIMAL(18,2) COMMENT 'Numeric score for technical skills competency assessment.',
    CONSTRAINT pk_performance_review PRIMARY KEY(`performance_review_id`)
) COMMENT 'Annual and mid-year employee performance evaluation records. Captures review period, employee, reviewer/supervisor, overall rating, competency ratings (technical skills, safety compliance, regulatory knowledge, teamwork), goal achievement scores, development plan notes, merit increase recommendation, and acknowledgment status. Supports workforce development, succession planning, and merit-based compensation decisions in SAP HR.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` (
    `field_service_dispatch_id` BIGINT COMMENT 'Unique identifier for the field service dispatch record. Primary key.',
    `crew_id` BIGINT COMMENT 'Identifier for the crew assigned to this dispatch. Nullable if dispatch is assigned to an individual technician instead of a crew.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with this dispatch. Nullable for non-customer-specific work such as main breaks or infrastructure maintenance.',
    `registry_id` BIGINT COMMENT 'Reference to the specific asset (meter, valve, hydrant, pipe segment) that is the subject of this dispatch. Links to asset registry.',
    `employee_id` BIGINT COMMENT 'Identifier for the individual technician assigned to this dispatch. Nullable if dispatch is assigned to a crew. Links to employee record.',
    `field_registry_id` BIGINT COMMENT 'Reference to the specific asset (meter, valve, hydrant, pipe segment) that is the subject of this dispatch. Links to asset registry.',
    `warehouse_location_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse_location. Business justification: Dispatchers direct field crews to specific warehouse locations to pick up parts, meters, or specialized equipment before proceeding to service addresses. Critical for emergency repair dispatch workflo',
    `primary_field_employee_id` BIGINT COMMENT 'Identifier for the individual technician assigned to this dispatch. Nullable if dispatch is assigned to a crew. Links to employee record.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that this dispatch is fulfilling. Links to the work order in IBM Maximo or Microsoft Dynamics 365 Field Service.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to treatment.facility. Business justification: Field service dispatches for treatment facility maintenance, emergency response, and regulatory compliance work require facility context for crew routing, operator certification verification, and perm',
    `actual_arrival_datetime` TIMESTAMP COMMENT 'Actual date and time when the crew or technician arrived on-site. Captured via mobile device or field service app.',
    `actual_departure_datetime` TIMESTAMP COMMENT 'Actual date and time when the crew or technician departed from the service site after completing or suspending work.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Actual duration in hours spent on-site performing the field service work. Calculated from arrival and departure timestamps.',
    `cancellation_datetime` TIMESTAMP COMMENT 'Date and time when the dispatch was cancelled. Nullable if dispatch was not cancelled.',
    `cancellation_reason` STRING COMMENT 'Reason for dispatch cancellation (e.g., duplicate dispatch, customer unavailable, work no longer required, weather delay).',
    `completion_datetime` TIMESTAMP COMMENT 'Date and time when the dispatch was marked as completed in the field service system. Indicates successful closure of the dispatch.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this dispatch record was first created in the system. Used for audit trail and data lineage.',
    `customer_contact_name` STRING COMMENT 'Name of the customer or on-site contact person for the dispatch. Used for coordination and access to the service location.',
    `customer_contact_phone` STRING COMMENT 'Phone number for the customer or on-site contact. Used by field crew to coordinate arrival and access.. Valid values are `^+?[0-9]{10,15}$`',
    `dispatch_datetime` TIMESTAMP COMMENT 'Date and time when the dispatch was created and assigned to a crew or technician. Primary business event timestamp.',
    `dispatch_number` STRING COMMENT 'Human-readable unique dispatch identifier generated by the field service management system. Format: DISP-YYYYMMDD-NNNN.. Valid values are `^DISP-[0-9]{8}$`',
    `dispatch_status` STRING COMMENT 'Current lifecycle status of the dispatch. Tracks progression from initial dispatch through completion or cancellation.. Valid values are `dispatched|en_route|on_site|completed|cancelled|deferred`',
    `dispatch_type` STRING COMMENT 'Classification of the field service activity being dispatched. Aligns with work order type and determines required skills and equipment. [ENUM-REF-CANDIDATE: leak_repair|meter_install|meter_replacement|service_call|main_break|valve_maintenance|hydrant_repair — 7 candidates stripped; promote to reference product]',
    `dispatcher_notes` STRING COMMENT 'Free-text notes entered by the dispatcher providing additional context, special instructions, safety warnings, or customer information for the field crew.',
    `dma_zone_code` STRING COMMENT 'District Metered Area zone identifier for the dispatch location. Used for hydraulic isolation and non-revenue water tracking.. Valid values are `^DMA-[A-Z0-9]{3,6}$`',
    `equipment_required` STRING COMMENT 'Comma-separated list or description of specialized equipment required for this dispatch (e.g., backhoe, leak detection equipment, meter testing kit).',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours for completing the field service work. Used for scheduling and resource planning.',
    `estimated_travel_time_minutes` STRING COMMENT 'Estimated travel time in minutes from the crew or technicians current location to the service site. Calculated by routing engine.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this dispatch record was last modified. Updated on any change to dispatch status, assignment, or other attributes.',
    `priority_level` STRING COMMENT 'Priority classification for the dispatch. Emergency typically indicates main breaks or service outages; urgent for leak repairs; normal for routine maintenance.. Valid values are `emergency|urgent|high|normal|low`',
    `safety_requirements` STRING COMMENT 'Safety protocols and requirements for this dispatch (e.g., confined space entry, traffic control, hazmat precautions). Aligns with OSHA standards.',
    `scheduled_arrival_end_datetime` TIMESTAMP COMMENT 'End of the scheduled arrival window. Defines the latest expected arrival time within the service level agreement.',
    `scheduled_arrival_start_datetime` TIMESTAMP COMMENT 'Start of the scheduled arrival window communicated to the customer or stakeholder. Defines the earliest expected arrival time.',
    `service_address_line1` STRING COMMENT 'Primary street address line for the service location where field work is to be performed.',
    `service_address_line2` STRING COMMENT 'Secondary address line (apartment, suite, unit number) for the service location.',
    `service_city` STRING COMMENT 'City name for the service location.',
    `service_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service location in decimal degrees. Used for routing and GIS integration.',
    `service_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service location in decimal degrees. Used for routing and GIS integration.',
    `service_postal_code` STRING COMMENT 'ZIP or postal code for the service location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `service_state` STRING COMMENT 'Two-letter state code for the service location.. Valid values are `^[A-Z]{2}$`',
    `service_territory_code` STRING COMMENT 'Geographic service territory or zone code where the dispatch is located. Used for crew assignment and routing optimization.. Valid values are `^[A-Z]{2,4}-[0-9]{2,4}$`',
    `sla_actual_response_minutes` STRING COMMENT 'Actual response time in minutes from dispatch creation to on-site arrival. Used for SLA compliance tracking.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether the dispatch met the SLA target response time. True if compliant, False if SLA was breached.',
    `sla_target_response_minutes` STRING COMMENT 'Target response time in minutes as defined by the service level agreement for this dispatch priority level.',
    `technician_notes` STRING COMMENT 'Free-text notes entered by the technician or crew documenting field observations, work performed, issues encountered, or follow-up actions required.',
    CONSTRAINT pk_field_service_dispatch PRIMARY KEY(`field_service_dispatch_id`)
) COMMENT 'Dispatch records for field service activities assigned to crews or individual technicians via Microsoft Dynamics 365 Field Service. Captures dispatch datetime, work order reference, assigned crew or technician, priority level, service territory/DMA zone, estimated travel time, scheduled arrival window, actual arrival datetime, dispatch status (dispatched, en-route, on-site, completed), and dispatcher notes. Supports real-time field operations management for leak repairs, meter installs, and service calls.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` (
    `labor_relations_case_id` BIGINT COMMENT 'Primary key for labor_relations_case',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Every labor relations case (whether disciplinary action or grievance) involves an employee as the subject. The product description states it encompasses both employer-initiated disciplinary actions a',
    `org_unit_id` BIGINT COMMENT 'add column org_unit_id (BIGINT) with FK to workforce.org_unit.org_unit_id - labor relations cases involve specific organizational units for grievance tracking',
    CONSTRAINT pk_labor_relations_case PRIMARY KEY(`labor_relations_case_id`)
) COMMENT 'Labor relations case records encompassing both employer-initiated disciplinary actions (verbal/written warnings, suspensions, terminations) and employee-initiated formal grievances under collective bargaining agreements. Captures case number, subject employee, filing/action date, case type (disciplinary or grievance), union steward involvement, CBA article cited, policy violated, progressive discipline step or grievance procedure step (Step 1-4, arbitration), issuing supervisor, HR representative, resolution outcome, settlement terms, appeal status, and expungement date. Supports progressive discipline management, grievance resolution tracking, labor relations compliance, and CBA administration.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` (
    `shift_schedule_id` BIGINT COMMENT 'Primary key for shift_schedule',
    `previous_shift_schedule_id` BIGINT COMMENT 'Self-referencing FK on shift_schedule (previous_shift_schedule_id)',
    `break_duration_minutes` STRING COMMENT 'Total minutes allocated for breaks within the shift.',
    `shift_schedule_description` STRING COMMENT 'Free‑form description providing additional context about the schedule.',
    `effective_from` DATE COMMENT 'Date when the shift schedule becomes active.',
    `effective_until` DATE COMMENT 'Date when the shift schedule expires or is superseded (null if open‑ended).',
    `is_paid_shift` BOOLEAN COMMENT 'True if the shift is compensated; false for volunteer or unpaid shifts.',
    `labor_category` STRING COMMENT 'Primary labor category that the schedule is designed for.',
    `max_employees` STRING COMMENT 'Maximum number of employees that can be assigned to the shift.',
    `min_employees` STRING COMMENT 'Minimum number of employees required for the shift to be staffed.',
    `notes` STRING COMMENT 'Supplemental notes or remarks related to the schedule.',
    `osha_compliant` BOOLEAN COMMENT 'Indicates whether the shift schedule meets OSHA safety requirements.',
    `pay_rate_per_hour` DECIMAL(18,2) COMMENT 'Standard hourly pay rate applicable to the shift (if paid).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    `schedule_code` STRING COMMENT 'Business code used to reference the schedule in operational systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name of the shift schedule (e.g., "Day Shift").',
    `schedule_type` STRING COMMENT 'Category of the shift schedule defining its purpose.',
    `shift_duration_minutes` STRING COMMENT 'Planned total duration of the shift in minutes, excluding breaks.',
    `shift_end_time` TIMESTAMP COMMENT 'Scheduled end time of the shift (HH:mm, 24‑hour clock).',
    `shift_group` STRING COMMENT 'Logical grouping name for related shift schedules (e.g., "Night Crew").',
    `shift_location` STRING COMMENT 'Identifier of the physical location or facility where the shift occurs.',
    `shift_pattern_code` STRING COMMENT 'Code representing a reusable pattern of shift timings.',
    `shift_start_time` TIMESTAMP COMMENT 'Scheduled start time of the shift (HH:mm, 24‑hour clock).',
    `shift_schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.',
    `timezone` STRING COMMENT 'IANA timezone identifier for the schedule (e.g., "America/Los_Angeles").',
    `updated_by` STRING COMMENT 'Identifier of the user or process that last updated the schedule record.',
    `work_day` STRING COMMENT 'Indicates which days the schedule applies to.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the schedule record.',
    CONSTRAINT pk_shift_schedule PRIMARY KEY(`shift_schedule_id`)
) COMMENT 'Master reference table for shift_schedule. Referenced by shift_schedule_id.';

CREATE OR REPLACE TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` (
    `swap_request_id` BIGINT COMMENT 'Primary key for swap_request',
    `employee_id` BIGINT COMMENT 'Identifier of the manager or supervisor who approved the swap request.',
    `location_id` BIGINT COMMENT 'Identifier of the work location associated with the shift being swapped.',
    `original_swap_request_id` BIGINT COMMENT 'Self-referencing FK on swap_request (original_swap_request_id)',
    `swap_employee_id` BIGINT COMMENT 'Identifier of the employee who initiates the swap request.',
    `target_employee_id` BIGINT COMMENT 'Identifier of the employee with whom the shift/crew is being swapped.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time when the swap request was approved or denied.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the swap request record was first created in the system.',
    `effective_date` DATE COMMENT 'Calendar date on which the approved swap takes effect.',
    `hours_swapped` DECIMAL(18,2) COMMENT 'Number of work hours being exchanged between the two employees.',
    `notes` STRING COMMENT 'Additional comments or special instructions attached to the swap request.',
    `overtime_flag` BOOLEAN COMMENT 'Indicates whether the swap results in overtime for either employee (true/false).',
    `reason_code` STRING COMMENT 'Standard code describing the business reason for the swap request.',
    `reason_description` STRING COMMENT 'Free‑text description providing additional context for the swap reason.',
    `request_number` STRING COMMENT 'Human‑readable business identifier assigned to the swap request (e.g., SR‑2023‑0001).',
    `request_timestamp` TIMESTAMP COMMENT 'Date‑time when the swap request was submitted.',
    `shift_end_time` TIMESTAMP COMMENT 'Scheduled end time of the original shift before the swap.',
    `shift_start_time` TIMESTAMP COMMENT 'Scheduled start time of the original shift before the swap.',
    `swap_request_status` STRING COMMENT 'Current lifecycle status of the swap request.',
    `swap_type` STRING COMMENT 'Category of the swap request indicating what is being exchanged (e.g., shift, crew, equipment, location).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the swap request record.',
    CONSTRAINT pk_swap_request PRIMARY KEY(`swap_request_id`)
) COMMENT 'Master reference table for swap_request. Referenced by swap_request_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ADD CONSTRAINT `fk_workforce_operator_license_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ADD CONSTRAINT `fk_workforce_certification_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ADD CONSTRAINT `fk_workforce_training_course_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ADD CONSTRAINT `fk_workforce_training_record_training_course_id` FOREIGN KEY (`training_course_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`training_course`(`training_course_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_shift_approved_by_employee_id` FOREIGN KEY (`shift_approved_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_shift_employee_id` FOREIGN KEY (`shift_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_shift_modified_by_user_employee_id` FOREIGN KEY (`shift_modified_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_shift_schedule_id` FOREIGN KEY (`shift_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_shift_supervisor_employee_id` FOREIGN KEY (`shift_supervisor_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_swap_request_id` FOREIGN KEY (`swap_request_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`swap_request`(`swap_request_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ADD CONSTRAINT `fk_workforce_shift_assignment_tertiary_shift_supervisor_employee_id` FOREIGN KEY (`tertiary_shift_supervisor_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_crew_last_modified_by_user_employee_id` FOREIGN KEY (`crew_last_modified_by_user_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_primary_crew_employee_id` FOREIGN KEY (`primary_crew_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ADD CONSTRAINT `fk_workforce_labor_timesheet_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ADD CONSTRAINT `fk_workforce_labor_timesheet_primary_labor_employee_id` FOREIGN KEY (`primary_labor_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_position_org_unit_id` FOREIGN KEY (`position_org_unit_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ADD CONSTRAINT `fk_workforce_position_supervisor_position_id` FOREIGN KEY (`supervisor_position_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`position`(`position_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ADD CONSTRAINT `fk_workforce_org_unit_parent_org_unit_id` FOREIGN KEY (`parent_org_unit_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_safety_employee_id` FOREIGN KEY (`safety_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ADD CONSTRAINT `fk_workforce_safety_incident_tertiary_safety_reported_by_employee_id` FOREIGN KEY (`tertiary_safety_reported_by_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_primary_leave_employee_id` FOREIGN KEY (`primary_leave_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ADD CONSTRAINT `fk_workforce_leave_request_tertiary_leave_backup_employee_id` FOREIGN KEY (`tertiary_leave_backup_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ADD CONSTRAINT `fk_workforce_performance_review_reviewer_employee_id` FOREIGN KEY (`reviewer_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ADD CONSTRAINT `fk_workforce_field_service_dispatch_primary_field_employee_id` FOREIGN KEY (`primary_field_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ADD CONSTRAINT `fk_workforce_labor_relations_case_org_unit_id` FOREIGN KEY (`org_unit_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`org_unit`(`org_unit_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ADD CONSTRAINT `fk_workforce_shift_schedule_previous_shift_schedule_id` FOREIGN KEY (`previous_shift_schedule_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`shift_schedule`(`shift_schedule_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ADD CONSTRAINT `fk_workforce_swap_request_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ADD CONSTRAINT `fk_workforce_swap_request_original_swap_request_id` FOREIGN KEY (`original_swap_request_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`swap_request`(`swap_request_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ADD CONSTRAINT `fk_workforce_swap_request_swap_employee_id` FOREIGN KEY (`swap_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ADD CONSTRAINT `fk_workforce_swap_request_target_employee_id` FOREIGN KEY (`target_employee_id`) REFERENCES `vibe_water_utilities_v1`.`workforce`.`employee`(`employee_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_water_utilities_v1`.`workforce` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `vibe_water_utilities_v1`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `cdl_class` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Class');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `cdl_class` SET TAGS ('dbx_value_regex' = 'class_a|class_b|class_c');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `cdl_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `confined_space_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Entry Certification Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `department_name` SET TAGS ('dbx_business_glossary_term' = 'Department Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `department_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Relationship');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `emergency_contact_relationship` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|leave|suspended|terminated|retired');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|seasonal|intern');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `hazmat_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certification Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `job_classification` SET TAGS ('dbx_business_glossary_term' = 'Job Classification Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Middle Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `operator_license_class` SET TAGS ('dbx_business_glossary_term' = 'Operator License Class');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `operator_license_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Operator License Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `operator_license_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Operator License Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `operator_license_number` SET TAGS ('dbx_business_glossary_term' = 'Water or Wastewater Operator License Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `operator_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `operator_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `operator_license_type` SET TAGS ('dbx_business_glossary_term' = 'Operator License Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `operator_license_type` SET TAGS ('dbx_value_regex' = 'water_treatment|water_distribution|wastewater_treatment|wastewater_collection');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `osha_training_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Training Current Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `personnel_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Human Resources (HR) Personnel Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `personnel_number` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|on_call');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'voluntary|involuntary|retirement|layoff|end_of_contract');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `union_local` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `union_membership_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Membership Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`employee` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `operator_license_id` SET TAGS ('dbx_business_glossary_term' = 'Operator License ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Assignment Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `backup_operator_flag` SET TAGS ('dbx_business_glossary_term' = 'Backup Operator Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `continuing_education_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Hours Completed');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `continuing_education_hours_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Hours Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `exam_date` SET TAGS ('dbx_business_glossary_term' = 'Exam Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `exam_score` SET TAGS ('dbx_business_glossary_term' = 'Exam Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `facility_classification_authorized` SET TAGS ('dbx_business_glossary_term' = 'Facility Classification Authorized');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `issuing_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `issuing_agency_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `issuing_state` SET TAGS ('dbx_business_glossary_term' = 'Issuing State');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `issuing_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `issuing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_document_url` SET TAGS ('dbx_business_glossary_term' = 'License Document URL');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_document_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_grade` SET TAGS ('dbx_business_glossary_term' = 'License Grade');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'License Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_status` SET TAGS ('dbx_business_glossary_term' = 'License Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending_renewal|inactive');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'water_treatment|water_distribution|wastewater_treatment|wastewater_collection|dual_certification|backflow_prevention');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_verification_date` SET TAGS ('dbx_business_glossary_term' = 'License Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_verification_method` SET TAGS ('dbx_business_glossary_term' = 'License Verification Method');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `license_verification_method` SET TAGS ('dbx_value_regex' = 'online_portal|phone_verification|email_confirmation|physical_document|third_party_service');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `operator_in_responsible_charge_flag` SET TAGS ('dbx_business_glossary_term' = 'Operator in Responsible Charge (ORC) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `reciprocity_state` SET TAGS ('dbx_business_glossary_term' = 'Reciprocity State');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `reciprocity_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `reciprocity_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `renewal_application_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Submitted Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `renewal_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Amount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `renewal_fee_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Fee Paid Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `renewal_notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Sent Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `revocation_date` SET TAGS ('dbx_business_glossary_term' = 'Revocation Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `revocation_reason` SET TAGS ('dbx_business_glossary_term' = 'Revocation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `suspension_end_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `suspension_start_date` SET TAGS ('dbx_business_glossary_term' = 'Suspension Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`operator_license` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certification_id` SET TAGS ('dbx_business_glossary_term' = 'Certification ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Certification Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'active|expired|suspended|revoked|pending|in_progress');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_business_glossary_term' = 'Certification Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certification_type` SET TAGS ('dbx_value_regex' = 'safety|technical|operational|regulatory|professional|driver');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `ceu_earned` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Units (CEU) Earned');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `ceu_required` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Units (CEU) Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Cost Amount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `is_regulatory_required` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_business_glossary_term' = 'Certification Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `certification_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_business_glossary_term' = 'Reimbursement Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `reimbursement_status` SET TAGS ('dbx_value_regex' = 'not_applicable|pending|approved|reimbursed|denied');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`certification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending_verification|not_verified|failed_verification');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Course Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Course Owner Employee Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Provider Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `training_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Approved Provider Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `accessibility_accommodations` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Accommodations');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `assessment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Assessment Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `certification_awarded` SET TAGS ('dbx_business_glossary_term' = 'Certification Awarded');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `ceu_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Unit (CEU) Credits');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `cmms_system_flag` SET TAGS ('dbx_business_glossary_term' = 'Computerized Maintenance Management System (CMMS) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `cost_per_participant` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Participant');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_category` SET TAGS ('dbx_business_glossary_term' = 'Course Category');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_category` SET TAGS ('dbx_value_regex' = 'regulatory_compliance|operations_maintenance|safety|technical_skills|leadership_development|system_specific');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_description` SET TAGS ('dbx_business_glossary_term' = 'Course Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_materials_url` SET TAGS ('dbx_business_glossary_term' = 'Course Materials Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_business_glossary_term' = 'Course Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_status` SET TAGS ('dbx_value_regex' = 'active|inactive|under_development|retired|suspended');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `course_title` SET TAGS ('dbx_business_glossary_term' = 'Course Title');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|online|hybrid|on_the_job|webinar|self_paced');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration in Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `gis_system_flag` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Language');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `last_content_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Content Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `maximum_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Maximum Enrollment');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `passing_score_percentage` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `prerequisite_courses` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Courses');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `required_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Required Frequency in Months');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `safety_training_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `scada_system_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) System Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `target_audience` SET TAGS ('dbx_business_glossary_term' = 'Target Audience');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_course` ALTER COLUMN `vendor_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Contract Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_record_id` SET TAGS ('dbx_business_glossary_term' = 'Training Record Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_course_id` SET TAGS ('dbx_business_glossary_term' = 'Course Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'written_exam|practical_test|observation|quiz|project|none');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `attendance_percentage` SET TAGS ('dbx_business_glossary_term' = 'Attendance Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `certification_issued` SET TAGS ('dbx_business_glossary_term' = 'Certification Issued');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `ceu_credits_earned` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Unit (CEU) Credits Earned');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Training Comments');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Training Cost Amount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Course Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `course_name` SET TAGS ('dbx_business_glossary_term' = 'Course Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `course_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Method');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'classroom|online|webinar|on_the_job|blended|self_paced');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `instructor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `is_compliance_required` SET TAGS ('dbx_business_glossary_term' = 'Is Compliance Required Training');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `is_regulatory_required` SET TAGS ('dbx_business_glossary_term' = 'Is Regulatory Required Training');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Training Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Training Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'technical|safety|regulatory|leadership|operational|customer_service');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_materials_provided` SET TAGS ('dbx_business_glossary_term' = 'Training Materials Provided');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_result` SET TAGS ('dbx_business_glossary_term' = 'Training Result');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_result` SET TAGS ('dbx_value_regex' = 'pass|fail|incomplete|waived|exempt');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|no_show');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`training_record` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'initial|refresher|recertification|advanced|specialized');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `metering_dma_zone_id` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Zone Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_approved_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_approved_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `swap_request_id` SET TAGS ('dbx_business_glossary_term' = 'Swap Request Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `tertiary_shift_supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `tertiary_shift_supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `tertiary_shift_supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `absence_notes` SET TAGS ('dbx_business_glossary_term' = 'Absence Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `absence_reason` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `actual_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Hours Worked');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `assigned_date` SET TAGS ('dbx_business_glossary_term' = 'Assigned Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^SA-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `certification_verified_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Verified Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `emergency_callout_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Callout Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `labor_cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Currency Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `labor_cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `on_call_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Call Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `project_code` SET TAGS ('dbx_business_glossary_term' = 'Project Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift End Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_role` SET TAGS ('dbx_business_glossary_term' = 'Shift Role');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_assignment` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|on_call|emergency|training|standby');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Home Depot Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `primary_crew_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `primary_crew_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `primary_crew_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Home Depot Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `average_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Response Time (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Crew Certification Level');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `certification_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3|level_4|specialized');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_code` SET TAGS ('dbx_business_glossary_term' = 'Crew Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `confined_space_certified` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Certified');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_status` SET TAGS ('dbx_business_glossary_term' = 'Crew Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|disbanded');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_type` SET TAGS ('dbx_business_glossary_term' = 'Crew Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_type` SET TAGS ('dbx_value_regex' = 'leak_repair|main_break|meter_crew|cipp_lining|pump_maintenance|valve_maintenance');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `emergency_response_qualified` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Qualified');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `equipment_inventory_complete` SET TAGS ('dbx_business_glossary_term' = 'Equipment Inventory Complete');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `excavation_certified` SET TAGS ('dbx_business_glossary_term' = 'Excavation Certified');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `gps_tracking_enabled` SET TAGS ('dbx_business_glossary_term' = 'GPS (Global Positioning System) Tracking Enabled');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `hourly_labor_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Labor Rate');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `hourly_labor_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `last_safety_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Safety Training Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_business_glossary_term' = 'Mobile Device Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_name` SET TAGS ('dbx_business_glossary_term' = 'Crew Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `crew_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Crew Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `safety_incident_count_ytd` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count Year-to-Date (YTD)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `shift_schedule` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `shift_schedule` SET TAGS ('dbx_value_regex' = 'day_shift|night_shift|rotating|on_call|emergency_response');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Crew Size');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`crew` ALTER COLUMN `work_orders_completed_ytd` SET TAGS ('dbx_business_glossary_term' = 'Work Orders Completed Year-to-Date (YTD)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `labor_timesheet_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Timesheet ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `cip_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Improvement Program (CIP) Project ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `general_ledger_id` SET TAGS ('dbx_business_glossary_term' = 'General Ledger Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `primary_labor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Activity Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'operations|maintenance|capital|emergency|training|administrative');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|submitted');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `billable_flag` SET TAGS ('dbx_business_glossary_term' = 'Billable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `call_out_hours` SET TAGS ('dbx_business_glossary_term' = 'Call-Out Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `crew_assignment` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `equipment_used` SET TAGS ('dbx_business_glossary_term' = 'Equipment Used');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Hours Worked');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `labor_rate` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `labor_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `pay_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `payroll_period` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'regular|overtime|standby|call_out|holiday|weekend');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `standby_hours` SET TAGS ('dbx_business_glossary_term' = 'Standby Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `timesheet_date` SET TAGS ('dbx_business_glossary_term' = 'Timesheet Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_timesheet` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `supervisor_position_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Position Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `bargaining_unit` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_business_glossary_term' = 'Position Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_description` SET TAGS ('dbx_business_glossary_term' = 'Position Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non_exempt');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `fte_count` SET TAGS ('dbx_business_glossary_term' = 'Full-Time Equivalent (FTE) Count');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `job_code` SET TAGS ('dbx_business_glossary_term' = 'Job Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `job_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `organizational_level` SET TAGS ('dbx_business_glossary_term' = 'Organizational Level');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `pay_range_maximum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Maximum');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `pay_range_maximum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `pay_range_minimum` SET TAGS ('dbx_business_glossary_term' = 'Pay Range Minimum');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `pay_range_minimum` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'active|vacant|frozen|eliminated|pending_approval');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|temporary|seasonal|contract');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `required_certifications` SET TAGS ('dbx_business_glossary_term' = 'Required Certifications');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `required_operator_license_grade` SET TAGS ('dbx_business_glossary_term' = 'Required Operator License Grade');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `required_operator_license_grade` SET TAGS ('dbx_value_regex' = '^(Grade [1-4]|Class [A-D]|None)$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `requires_cdl` SET TAGS ('dbx_business_glossary_term' = 'Requires Commercial Driver License (CDL)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `requires_confined_space_entry` SET TAGS ('dbx_business_glossary_term' = 'Requires Confined Space Entry');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `requires_on_call` SET TAGS ('dbx_business_glossary_term' = 'Requires On-Call Availability');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `safety_sensitive` SET TAGS ('dbx_business_glossary_term' = 'Safety-Sensitive Position');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `shift_rotation_required` SET TAGS ('dbx_business_glossary_term' = 'Shift Rotation Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `succession_criticality` SET TAGS ('dbx_business_glossary_term' = 'Succession Criticality');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `succession_criticality` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Position Title');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `union_classification` SET TAGS ('dbx_business_glossary_term' = 'Union Classification');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`position` ALTER COLUMN `union_classification` SET TAGS ('dbx_value_regex' = 'union|non_union|management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Manager Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `parent_org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Organizational Unit ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_amount_annual` SET TAGS ('dbx_business_glossary_term' = 'Annual Budget Amount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_amount_annual` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `budget_fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Fiscal Year');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_personal' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `org_unit_description` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `fax_number` SET TAGS ('dbx_business_glossary_term' = 'Fax Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `fax_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `fax_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `fax_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `functional_area` SET TAGS ('dbx_business_glossary_term' = 'Functional Area');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Headcount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `headcount_authorized` SET TAGS ('dbx_business_glossary_term' = 'Authorized Headcount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `operates_24_7` SET TAGS ('dbx_business_glossary_term' = 'Operates 24/7 Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `regulatory_oversight_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Oversight Agency');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `safety_sensitive_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Sensitive Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `shift_schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `shift_schedule_type` SET TAGS ('dbx_value_regex' = 'standard|rotating|fixed|on_call|flexible');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `union_representation` SET TAGS ('dbx_business_glossary_term' = 'Union Representation Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_short_name` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Short Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_short_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|dissolved');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`org_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_value_regex' = 'division|department|work_group|section|team|cost_center');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `process_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Process Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `safety_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `safety_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `safety_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `tertiary_safety_reported_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `tertiary_safety_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `tertiary_safety_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `body_part_affected` SET TAGS ('dbx_business_glossary_term' = 'Body Part Affected');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Completed Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `days_away_from_work` SET TAGS ('dbx_business_glossary_term' = 'Days Away From Work');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `days_of_restricted_duty` SET TAGS ('dbx_business_glossary_term' = 'Days of Restricted Duty');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `environmental_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Release Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `environmental_release_volume` SET TAGS ('dbx_business_glossary_term' = 'Environmental Release Volume');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `field_location_description` SET TAGS ('dbx_business_glossary_term' = 'Field Location Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_date` SET TAGS ('dbx_business_glossary_term' = 'Incident Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_value_regex' = '^INC-[0-9]{8}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_time` SET TAGS ('dbx_business_glossary_term' = 'Incident Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_value_regex' = 'injury|near_miss|property_damage|environmental_release|vehicle_accident|occupational_illness');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `injury_nature` SET TAGS ('dbx_business_glossary_term' = 'Injury Nature');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_value_regex' = 'first_aid|medical_treatment|lost_time|restricted_duty|fatality|none');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `investigation_completed_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completed Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|closed');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `location_type` SET TAGS ('dbx_value_regex' = 'facility|field_site|vehicle|office|customer_site|public_right_of_way');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `osha_log_reference` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Log Reference');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `osha_recordable_flag` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `property_damage_amount` SET TAGS ('dbx_business_glossary_term' = 'Property Damage Amount');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `regulatory_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `regulatory_notification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `reported_date` SET TAGS ('dbx_business_glossary_term' = 'Reported Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'human_error|equipment_failure|environmental_condition|procedural_gap|inadequate_training|ppe_failure');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`safety_incident` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_request_id` SET TAGS ('dbx_business_glossary_term' = 'Leave Request ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Supervisor ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `primary_leave_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_backup_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Employee ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_backup_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `tertiary_leave_backup_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `accrual_balance_after` SET TAGS ('dbx_business_glossary_term' = 'Accrual Balance After');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `accrual_balance_before` SET TAGS ('dbx_business_glossary_term' = 'Accrual Balance Before');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `advance_notice_days` SET TAGS ('dbx_business_glossary_term' = 'Advance Notice Days');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_end_date` SET TAGS ('dbx_business_glossary_term' = 'Approved End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `approved_start_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `certification_received` SET TAGS ('dbx_business_glossary_term' = 'Certification Received');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `certification_received_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Received Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `coverage_plan` SET TAGS ('dbx_business_glossary_term' = 'Coverage Plan');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Denial Reason');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_business_glossary_term' = 'FMLA (Family and Medical Leave Act) Case Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `hours_approved` SET TAGS ('dbx_business_glossary_term' = 'Hours Approved');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `hours_requested` SET TAGS ('dbx_business_glossary_term' = 'Hours Requested');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `is_emergency_leave` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Leave');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `is_fmla_eligible` SET TAGS ('dbx_business_glossary_term' = 'Is FMLA (Family and Medical Leave Act) Eligible');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `is_paid` SET TAGS ('dbx_business_glossary_term' = 'Is Paid Leave');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_subtype` SET TAGS ('dbx_business_glossary_term' = 'Leave Subtype');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_business_glossary_term' = 'Leave Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `leave_type` SET TAGS ('dbx_value_regex' = 'vacation|sick|fmla|military|bereavement|jury_duty');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_period` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `payroll_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Leave Request Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^LR-[0-9]{8}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `request_submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `requested_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `shift_coverage_impact` SET TAGS ('dbx_business_glossary_term' = 'Shift Coverage Impact');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`leave_request` ALTER COLUMN `shift_coverage_impact` SET TAGS ('dbx_value_regex' = 'none|minimal|moderate|significant|critical');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` SET TAGS ('dbx_subdomain' = 'personnel_management');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `performance_review_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Review Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Employee Identifier (ID)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `areas_for_improvement` SET TAGS ('dbx_business_glossary_term' = 'Areas for Improvement');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `customer_service_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `customer_service_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `customer_service_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `development_plan_notes` SET TAGS ('dbx_business_glossary_term' = 'Development Plan Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgment_date` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgment_status` SET TAGS ('dbx_business_glossary_term' = 'Employee Acknowledgment Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_acknowledgment_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|disputed');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `employee_comments` SET TAGS ('dbx_business_glossary_term' = 'Employee Comments');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_rating` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `goal_achievement_score` SET TAGS ('dbx_business_glossary_term' = 'Goal Achievement Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Percentage');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_percentage` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `merit_increase_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Merit Increase Recommended Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `next_review_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Due Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `overall_rating_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Rating Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `promotion_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Promotion Recommended Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `regulatory_knowledge_rating` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Knowledge Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `regulatory_knowledge_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `regulatory_knowledge_score` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Knowledge Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_document_url` SET TAGS ('dbx_business_glossary_term' = 'Review Document Uniform Resource Locator (URL)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period End Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Review Period Start Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_business_glossary_term' = 'Review Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_status` SET TAGS ('dbx_value_regex' = 'draft|in_progress|pending_employee_acknowledgment|completed|cancelled');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_business_glossary_term' = 'Review Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `review_type` SET TAGS ('dbx_value_regex' = 'annual|mid_year|probationary|project_based|ad_hoc');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `reviewer_comments` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Comments');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `safety_compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Safety Compliance Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `safety_compliance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `safety_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Safety Compliance Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `strengths_summary` SET TAGS ('dbx_business_glossary_term' = 'Strengths Summary');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `succession_planning_candidate_flag` SET TAGS ('dbx_business_glossary_term' = 'Succession Planning Candidate Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `teamwork_rating` SET TAGS ('dbx_business_glossary_term' = 'Teamwork and Collaboration Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `teamwork_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `teamwork_score` SET TAGS ('dbx_business_glossary_term' = 'Teamwork and Collaboration Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `technical_skills_rating` SET TAGS ('dbx_business_glossary_term' = 'Technical Skills Rating');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `technical_skills_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`performance_review` ALTER COLUMN `technical_skills_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Skills Score');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `field_service_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'Field Service Dispatch ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Crew ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `field_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `warehouse_location_id` SET TAGS ('dbx_business_glossary_term' = 'Pickup Warehouse Location Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `primary_field_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `primary_field_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `primary_field_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) ID');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Wtp Facility Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `actual_arrival_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `actual_departure_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `cancellation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `completion_datetime` SET TAGS ('dbx_business_glossary_term' = 'Completion Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dispatch_datetime` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dispatch_number` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dispatch_number` SET TAGS ('dbx_value_regex' = '^DISP-[0-9]{8}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dispatch_status` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dispatch_status` SET TAGS ('dbx_value_regex' = 'dispatched|en_route|on_site|completed|cancelled|deferred');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dispatch_type` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dispatcher_notes` SET TAGS ('dbx_business_glossary_term' = 'Dispatcher Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dma_zone_code` SET TAGS ('dbx_business_glossary_term' = 'District Metered Area (DMA) Zone Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `dma_zone_code` SET TAGS ('dbx_value_regex' = '^DMA-[A-Z0-9]{3,6}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (Hours)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `estimated_travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Travel Time (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'emergency|urgent|high|normal|low');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `scheduled_arrival_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival End Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `scheduled_arrival_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Arrival Start Date and Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 1');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_latitude` SET TAGS ('dbx_business_glossary_term' = 'Service Location Latitude');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_longitude` SET TAGS ('dbx_business_glossary_term' = 'Service Location Longitude');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Service Postal Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_state` SET TAGS ('dbx_business_glossary_term' = 'Service State');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{2,4}$');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `sla_actual_response_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Response Time (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `sla_target_response_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Response Time (Minutes)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`field_service_dispatch` ALTER COLUMN `technician_notes` SET TAGS ('dbx_business_glossary_term' = 'Technician Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` SET TAGS ('dbx_subdomain' = 'employee_relations');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `labor_relations_case_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Relations Case Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`labor_relations_case` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Schedule Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `previous_shift_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Shift Schedule Id');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `previous_shift_schedule_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `is_paid_shift` SET TAGS ('dbx_business_glossary_term' = 'Is Paid Shift');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `labor_category` SET TAGS ('dbx_business_glossary_term' = 'Labor Category');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `max_employees` SET TAGS ('dbx_business_glossary_term' = 'Max Employees');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `min_employees` SET TAGS ('dbx_business_glossary_term' = 'Min Employees');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `osha_compliant` SET TAGS ('dbx_business_glossary_term' = 'Osha Compliant');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `pay_rate_per_hour` SET TAGS ('dbx_business_glossary_term' = 'Pay Rate Per Hour');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration Minutes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_group` SET TAGS ('dbx_business_glossary_term' = 'Shift Group');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_location` SET TAGS ('dbx_business_glossary_term' = 'Shift Location');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_pattern_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `shift_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Timezone');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `work_day` SET TAGS ('dbx_business_glossary_term' = 'Work Day');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`shift_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` SET TAGS ('dbx_subdomain' = 'field_operations');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `swap_request_id` SET TAGS ('dbx_business_glossary_term' = 'Swap Request Identifier');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `original_swap_request_id` SET TAGS ('dbx_business_glossary_term' = 'Original Swap Request Id');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `original_swap_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `swap_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `swap_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `swap_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `target_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Target Employee Id');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `target_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `target_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `hours_swapped` SET TAGS ('dbx_business_glossary_term' = 'Hours Swapped');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `overtime_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Flag');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `swap_request_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `swap_type` SET TAGS ('dbx_business_glossary_term' = 'Swap Type');
ALTER TABLE `vibe_water_utilities_v1`.`workforce`.`swap_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
