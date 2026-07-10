-- Schema for Domain: scheduling | Business: Healthcare | Version: v2_mvm
-- Generated on: 2026-07-10 16:21:51

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_healthcare_v1`.`scheduling` COMMENT 'Appointment and resource scheduling across all care settings. Includes outpatient appointments (Epic Cadence), surgical scheduling (OpTime), procedure scheduling, resource allocation (rooms, equipment, staff), waitlist management, appointment reminders, no-show tracking, and capacity planning. Supports patient access and operational throughput optimization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` (
    `scheduling_appointment_id` BIGINT COMMENT 'Unique identifier for the scheduled appointment. Primary key for the appointment record across all care settings and modalities.',
    `appointment_type_id` BIGINT COMMENT 'FK to scheduling.appointment_type',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.billing_coverage. Business justification: At appointment check-in, front-desk staff verify the patients active billing coverage to confirm copay amount, network status, and authorization requirements before charge capture. scheduling_appoint',
    `clinician_id` BIGINT COMMENT 'Unique identifier for the primary provider scheduled to deliver care during this appointment.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Appointments must comply with scheduling policies governing no-show penalties, cancellation windows, authorization requirements, and billing eligibility. Healthcare operations require policy enforceme',
    `dea_registration_id` BIGINT COMMENT 'Foreign key linking to provider.dea_registration. Business justification: Appointments involving controlled substance prescribing require active DEA registration verification at scheduling time per federal regulations. Enables real-time validation of prescribing authority a',
    `demographics_id` BIGINT COMMENT 'Unique identifier for the patient associated with this appointment. Links to the patient master record.',
    `eligibility_id` BIGINT COMMENT 'Foreign key linking to claim.eligibility. Business justification: Real-time eligibility verification at appointment booking confirms active coverage, copay amounts, and authorization requirements. Schedulers perform eligibility checks before confirming appointments ',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Appointments are associated with a group practice for billing, revenue reporting, and group contract compliance. Group-level appointment volume, quality measure reporting, and MIPS group reporting req',
    `guarantor_id` BIGINT COMMENT 'Foreign key linking to patient.guarantor. Business justification: Pre-service financial clearance requires identifying the guarantor responsible for the appointment before check-in. Scheduling staff verify financial responsibility as a named operational workflow. No',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Appointments for DME delivery, infusion therapy, and outpatient services require HCPCS coding for billing and prior authorization submission. Billing teams and coders expect the scheduled service to c',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Appointments require consent verification before procedures. Schedulers and clinical staff verify consent status during booking and check-in workflows. Essential for regulatory compliance, patient saf',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Appointments occur at a specific provider_location. Patient-facing scheduling, appointment reminders, CMS directory accuracy requirements, and no-show analysis all require knowing the exact location w',
    `mpi_record_id` BIGINT COMMENT 'Foreign key linking to patient.mpi_record. Business justification: Appointments must verify active enrollment status at scheduled date to prevent scheduling patients without coverage. Schedulers check enrollment effective/termination dates and PCP assignment requirem',
    `open_slot_id` BIGINT COMMENT 'Foreign key linking to scheduling.open_slot. Business justification: An appointment is booked from a specific open slot. Adding open_slot_id to scheduling_appointment captures which availability slot was consumed when the appointment was created. This enables slot util',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.network_affiliation. Business justification: Network status determines patient cost-sharing and appointment eligibility per payer contracts. Links appointment to specific network tier and panel status, enabling real-time verification of in-netwo',
    `payer_enrollment_id` BIGINT COMMENT 'Foreign key linking to provider.payer_enrollment. Business justification: Insurance verification at appointment scheduling requires active payer enrollment status to confirm provider is in-network and eligible to bill. Prevents scheduling with terminated enrollments, suppor',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Appointments are scheduled to address a specific active problem (e.g., hypertension follow-up, diabetes management). Linking appointment to problem enables care gap closure tracking, chronic disease m',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: Every appointment is conducted in a specific room, at a specific piece of equipment, or with a specific resource (e.g., exam room, telehealth station). Adding schedulable_resource_id to scheduling_app',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Clinical trial visits are scheduled as regular appointments. Research coordinators book protocol-mandated study visits through the scheduling system, requiring direct linkage to track research vs. sta',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Visit reason codes require ICD-10 validation for clinical accuracy, insurance authorization, billing compliance, and quality reporting. Essential for appointment booking workflows and claim submission',
    `appointment_number` STRING COMMENT 'Human-readable business identifier for the appointment, typically displayed to patients and staff. May follow facility-specific numbering conventions.',
    `appointment_status` STRING COMMENT 'Current lifecycle status of the appointment. Tracks progression from scheduling through completion or cancellation. [ENUM-REF-CANDIDATE: scheduled|confirmed|checked-in|roomed|arrived|in-progress|completed|cancelled|no-show|rescheduled — 10 candidates stripped; promote to reference product]',
    `arrival_timestamp` TIMESTAMP COMMENT 'The date and time when the patient physically arrived at the facility or joined the virtual waiting room for telehealth appointments.',
    `billing_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the appointment is eligible for billing based on completion status, documentation, and payer rules. Used by revenue cycle to determine billable encounters.',
    `booking_channel` STRING COMMENT 'The channel or interface through which the appointment was originally scheduled. Used for patient access analytics and channel optimization.. Valid values are `phone|online-portal|mobile-app|in-person|referral|system-generated`',
    `booking_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment was originally created or booked in the scheduling system.',
    `cancellation_reason` STRING COMMENT 'Free-text or coded explanation for why the appointment was cancelled. May indicate patient-initiated, provider-initiated, or system-initiated cancellation.',
    `cancellation_reason_code` STRING COMMENT 'Standardized code representing the cancellation reason category (e.g., patient request, provider unavailable, weather, no-show conversion).',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when the appointment was cancelled. Null for non-cancelled appointments.',
    `cancelled_by` STRING COMMENT 'Indicates which party initiated the cancellation of the appointment.. Valid values are `patient|provider|facility|system`',
    `care_setting` STRING COMMENT 'The physical or virtual care environment where the appointment will take place. [ENUM-REF-CANDIDATE: outpatient|emergency|inpatient-consult|procedural|surgical|telehealth|home-health — 7 candidates stripped; promote to reference product]',
    `check_in_timestamp` TIMESTAMP COMMENT 'The date and time when the patient checked in for the appointment, either at a kiosk, front desk, or via mobile check-in.',
    `confirmation_status` STRING COMMENT 'Indicates whether the patient has confirmed their intent to attend the appointment. Separate from appointment status to track patient engagement.. Valid values are `pending|confirmed|declined|needs-action`',
    `confirmation_timestamp` TIMESTAMP COMMENT 'The date and time when the patient confirmed the appointment, either through automated reminder response or manual confirmation.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this appointment record was first created in the scheduling system. Audit trail for record creation.',
    `duration_minutes` STRING COMMENT 'The planned duration of the appointment in minutes. Calculated from scheduled start and end times or set by appointment type template.',
    `end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the clinical encounter concluded and the patient was discharged from the appointment.',
    `insurance_verification_status` STRING COMMENT 'Indicates whether patient insurance eligibility and benefits have been verified for this appointment. Critical for revenue cycle and patient financial counseling.. Valid values are `verified|pending|failed|not-required|expired`',
    `insurance_verification_timestamp` TIMESTAMP COMMENT 'The date and time when insurance eligibility was last verified for this appointment.',
    `no_show_flag` BOOLEAN COMMENT 'Indicates whether the patient failed to attend the scheduled appointment without prior cancellation. Used for no-show tracking and patient access policies.',
    `patient_device_type` STRING COMMENT 'The type of device the patient used to access the telehealth appointment (e.g., smartphone, tablet, desktop, laptop). Used for technical support and quality improvement.',
    `priority` STRING COMMENT 'Clinical urgency or priority level assigned to the appointment. Influences scheduling order and resource allocation.. Valid values are `routine|urgent|stat|elective|emergent`',
    `provider_attestation_flag` BOOLEAN COMMENT 'Indicates whether the provider has attested that the telehealth visit met all clinical and regulatory requirements for billing and documentation. Required for telehealth reimbursement.',
    `roomed_timestamp` TIMESTAMP COMMENT 'The date and time when the patient was placed in an exam room or virtual consultation room and is ready to be seen by the provider.',
    `scheduled_date` DATE COMMENT 'The calendar date on which the appointment is scheduled to occur.',
    `scheduled_end_time` TIMESTAMP COMMENT 'The precise date and time when the appointment is scheduled to end, including timezone.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise date and time when the appointment is scheduled to begin, including timezone.',
    `start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the provider began the clinical encounter. May differ from scheduled start time.',
    `telehealth_access_code` STRING COMMENT 'The meeting ID, access code, or PIN required to join the telehealth session. Used for platforms that require separate authentication.',
    `telehealth_connection_status` STRING COMMENT 'Real-time or final status of the telehealth session connection. Tracks technical success of the virtual visit.. Valid values are `not-started|connected|disconnected|failed|completed`',
    `telehealth_platform` STRING COMMENT 'The technology platform or vendor used to conduct the virtual visit (e.g., Epic Video Visit, Zoom for Healthcare, Amwell, Doxy.me). Null for in-person appointments.',
    `telehealth_session_url` STRING COMMENT 'The unique web link or meeting URL provided to the patient and provider to join the virtual visit. Contains session-specific access credentials.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this appointment record was last modified. Audit trail for record changes.',
    `visit_modality` STRING COMMENT 'The mode of interaction for the appointment. Distinguishes traditional in-person visits from telehealth and asynchronous digital encounters.. Valid values are `in-person|video|phone|e-visit|asynchronous`',
    `visit_reason` STRING COMMENT 'Free-text or coded description of the clinical reason or chief complaint for the appointment as stated by the patient or referring provider.',
    `visit_reason_code` STRING COMMENT 'Standardized clinical code representing the reason for the visit. May use ICD-10, SNOMED CT, or internal reason code taxonomy.',
    CONSTRAINT pk_scheduling_appointment PRIMARY KEY(`scheduling_appointment_id`)
) COMMENT 'Core master record for every scheduled patient encounter across all care settings (outpatient, ED, procedural, inpatient consult) and all visit modalities (in-person, video/telehealth, phone, e-visit/asynchronous). Captures appointment type, visit reason, care setting, scheduled date/time, duration, status (scheduled, confirmed, checked-in, roomed, arrived, in-progress, completed, cancelled, no-show), priority, booking channel, originating order/referral reference, and insurance verification status. For telehealth/virtual modalities: captures platform (Zoom, Amwell, Epic Video Visit), session URL/access code, connection status, patient device type, provider attestation, and billing eligibility. SSOT for all scheduled patient encounters regardless of modality — aligns with HL7 FHIR Appointment resource. Sourced from Epic Cadence, Cerner Millennium, and telehealth platform integrations.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` (
    `appointment_type_id` BIGINT COMMENT 'Unique identifier for the appointment type. Primary key.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: Appointment types map to CDM entries for automated charge capture. When appointment is completed, system posts charges based on this mapping. Standard revenue cycle configuration in healthcare to ensu',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Each appointment type governed by policies defining referral requirements, prior authorization rules, billing class restrictions, and patient eligibility criteria. Standard healthcare governance model',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Appointment types map to CPT codes for RVU calculation, billing class determination, default duration estimation, and reimbursement forecasting. Core to scheduling configuration and revenue cycle.',
    `drug_master_id` BIGINT COMMENT 'Foreign key linking to pharmacy.drug_master. Business justification: Infusion clinic and chemotherapy scheduling: appointment types (e.g., Rituximab Infusion, Iron Infusion) are defined by the specific drug administered. Scheduling coordinators and pharmacy must al',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Appointment types for infusion, DME, and outpatient procedures are mapped to HCPCS codes for CDM configuration and billing rules. Revenue cycle teams configure appointment types with HCPCS codes to dr',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: FHIR ServiceType and HL7 interoperability standards require appointment types to be mapped to SNOMED clinical concepts. EHR integration and patient portal scheduling workflows depend on this mapping f',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Appointment types are specialty-specific (e.g., Cardiology New Patient Visit). Specialty-based scheduling routing, HEDIS measure tracking, and network adequacy configuration require a proper FK. The',
    `allows_self_scheduling` BOOLEAN COMMENT 'Indicates whether patients can self-schedule this appointment type through patient portals or online booking systems (e.g., Epic MyChart).',
    `allows_telehealth` BOOLEAN COMMENT 'Indicates whether this appointment type can be conducted via telehealth or virtual visit platforms. Supports remote care delivery and patient access expansion.',
    `appointment_type_status` STRING COMMENT 'Current lifecycle status of the appointment type. Inactive or retired types are not available for new scheduling.. Valid values are `active|inactive|suspended|retired`',
    `billing_class` STRING COMMENT 'The billing classification for this appointment type (professional, facility, technical, or global). Determines charge capture and claim submission rules.. Valid values are `professional|facility|technical|global`',
    `cancellation_notice_hours` STRING COMMENT 'Minimum number of hours notice required for appointment cancellation without penalty. Supports scheduling policy enforcement and capacity optimization.',
    `care_setting` STRING COMMENT 'The care delivery setting where this appointment type is applicable (e.g., outpatient clinic, emergency department, telehealth platform).. Valid values are `outpatient|inpatient|emergency|telehealth|home_health|ambulatory_surgery`',
    `appointment_type_category` STRING COMMENT 'High-level classification of the appointment type for grouping and reporting purposes. [ENUM-REF-CANDIDATE: office_visit|telehealth|surgical|procedural|diagnostic|wellness|urgent_care — 7 candidates stripped; promote to reference product]',
    `appointment_type_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the appointment type across scheduling systems. Used in Epic Cadence and Cerner Millennium for booking logic.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this appointment type record was first created in the system. Supports audit trail and data lineage.',
    `default_duration_minutes` STRING COMMENT 'Standard duration in minutes allocated for this appointment type. Used by scheduling systems for capacity planning and slot allocation.',
    `appointment_type_description` STRING COMMENT 'Detailed description of the appointment type, including clinical purpose, patient preparation instructions, and scheduling guidelines.',
    `effective_end_date` DATE COMMENT 'The date when this appointment type was retired or discontinued. Null for currently active types.',
    `effective_start_date` DATE COMMENT 'The date when this appointment type became available for scheduling. Supports historical tracking and compliance reporting.',
    `equipment_required` STRING COMMENT 'Specialized equipment or resources required for this appointment type (e.g., ultrasound machine, EKG, surgical instruments). Supports resource scheduling and capacity planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this appointment type record was last updated. Supports change tracking and audit compliance.',
    `maximum_duration_minutes` STRING COMMENT 'Maximum allowable duration in minutes for this appointment type. Prevents over-allocation of provider time and supports throughput optimization.',
    `minimum_duration_minutes` STRING COMMENT 'Minimum allowable duration in minutes for this appointment type. Enforces scheduling constraints to ensure adequate time for clinical activities.',
    `appointment_type_name` STRING COMMENT 'Human-readable name of the appointment type (e.g., New Patient Visit, Follow-Up, Annual Wellness Visit, Pre-Op Consultation, Telehealth Visit).',
    `no_show_penalty_applies` BOOLEAN COMMENT 'Indicates whether a no-show penalty or fee applies to this appointment type. Supports revenue protection and patient accountability.',
    `patient_class` STRING COMMENT 'Classification of the patient relationship for this appointment type (e.g., new patient, established patient, return visit). Impacts billing and documentation requirements.. Valid values are `new_patient|established_patient|return_patient|referral`',
    `preparation_instructions` STRING COMMENT 'Instructions provided to patients before the appointment (e.g., fasting requirements, medication holds, forms to complete). Supports patient education and visit readiness.',
    `quality_measure_applicable` BOOLEAN COMMENT 'Indicates whether this appointment type is subject to quality measurement and reporting requirements (e.g., HEDIS, MIPS, CAHPS).',
    `reminder_lead_time_days` STRING COMMENT 'Number of days before the appointment when automated reminders should be sent to patients. Supports no-show reduction and patient engagement.',
    `requires_interpreter` BOOLEAN COMMENT 'Indicates whether this appointment type typically requires interpreter services. Supports resource allocation and compliance with language access requirements.',
    `requires_referral` BOOLEAN COMMENT 'Indicates whether this appointment type requires a referral from a Primary Care Physician (PCP) or other provider. Used for authorization and scheduling validation.',
    `room_type_required` STRING COMMENT 'The type of clinical room or facility space required for this appointment type (e.g., exam room, procedure room, operating room, telehealth station).',
    `rvu_malpractice` DECIMAL(18,2) COMMENT 'Malpractice RVU assigned to this appointment type. Reflects professional liability insurance costs.',
    `rvu_practice_expense` DECIMAL(18,2) COMMENT 'Practice expense RVU assigned to this appointment type. Reflects overhead costs associated with delivering the service.',
    `rvu_work` DECIMAL(18,2) COMMENT 'Work RVU assigned to this appointment type for physician productivity tracking and compensation. Based on CMS Physician Fee Schedule.',
    `staff_roles_required` STRING COMMENT 'Clinical and administrative staff roles required to support this appointment type (e.g., physician, nurse, medical assistant, anesthesiologist). Comma-separated list.',
    `visit_type_code` STRING COMMENT 'Standard visit type code used for billing and revenue cycle integration. Maps to charge capture and claim submission workflows.',
    `waitlist_eligible` BOOLEAN COMMENT 'Indicates whether patients can be placed on a waitlist for this appointment type when no slots are available. Supports access optimization and patient satisfaction.',
    CONSTRAINT pk_appointment_type PRIMARY KEY(`appointment_type_id`)
) COMMENT 'Reference catalog of all appointment types defined across care settings (e.g., new patient visit, follow-up, annual wellness, pre-op, post-op, telehealth, urgent care). Includes CPT/visit type code mapping, default duration, care setting applicability, specialty association, and scheduling rules. Drives appointment booking logic and capacity planning in Epic Cadence and Cerner Millennium.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` (
    `schedule_template_id` BIGINT COMMENT 'Unique identifier for the schedule template record. Primary key.',
    `appointment_type_id` BIGINT COMMENT 'Foreign key linking to scheduling.appointment_type. Business justification: schedule_template currently stores appointment_type_code as a plain STRING, creating a denormalized reference to the appointment_type catalog. Adding appointment_type_id as a proper FK normalizes this',
    `clinician_id` BIGINT COMMENT 'Identifier of the user or system account that created this schedule template record.',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Schedule templates must comply with regulatory policies governing work hour limits, rest periods, credentialing requirements, and fair access rules. Real compliance need in healthcare scheduling.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Schedule templates may be defined at the group level for multi-physician group practices. Group-level scheduling management, network adequacy reporting, and group contract compliance require linking t',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Schedule templates are location-specific — a clinicians template at one clinic differs from another. Scheduling configuration, network adequacy reporting, and patient access management require linkin',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Schedule templates are facility-specific — a clinicians template at Hospital A differs from Hospital B. Network adequacy reporting, credentialing, and scheduling configuration require linking templat',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Schedule templates for procedure-specific blocks (colonoscopy, cardiac cath, joint injection) are built around a primary CPT code to define session duration, staffing, and equipment requirements. OR a',
    `schedulable_resource_id` BIGINT COMMENT 'Identifier for the resource (room, equipment, facility) to which this template applies. Null if template applies to a provider.',
    `approval_status` STRING COMMENT 'Approval status of the schedule template. Templates may require administrative or clinical approval before becoming active.. Valid values are `pending|approved|rejected|expired`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule template was approved. Null if not yet approved or approval is not required.',
    `auto_confirm_flag` BOOLEAN COMMENT 'Indicates whether appointments scheduled under this template are automatically confirmed or require manual confirmation. True auto-confirms; False requires manual review.',
    `buffer_time_minutes` STRING COMMENT 'Buffer time in minutes added between consecutive appointment slots to allow for provider preparation, documentation, or patient transition.',
    `cancellation_policy_code` STRING COMMENT 'Code identifying the cancellation policy applicable to appointments scheduled under this template (e.g., 24_HOUR, 48_HOUR, NO_SHOW_FEE).',
    `care_setting` STRING COMMENT 'The care delivery setting where this schedule template is used (outpatient clinic, surgical suite, emergency department, telehealth, etc.).. Valid values are `outpatient|inpatient|emergency|surgical|telehealth|home_health`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule template record was first created in the system.',
    `day_of_week` STRING COMMENT 'Comma-separated list of days of the week this template applies to (e.g., Monday,Wednesday,Friday). Used for weekly recurrence patterns. [ENUM-REF-CANDIDATE: Monday|Tuesday|Wednesday|Thursday|Friday|Saturday|Sunday — promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when this schedule template expires and stops generating appointment slots. Null indicates open-ended template.',
    `effective_start_date` DATE COMMENT 'Date when this schedule template becomes active and begins generating appointment slots.',
    `insurance_type_accepted` STRING COMMENT 'Comma-separated list of insurance types accepted for appointments scheduled under this template (e.g., MEDICARE,MEDICAID,COMMERCIAL). [ENUM-REF-CANDIDATE: medicare|medicaid|commercial|self_pay|workers_comp|tricare|va — promote to reference product]',
    `max_slots_per_session` STRING COMMENT 'Maximum number of appointment slots that can be scheduled within a single session. Used for capacity planning and overbooking control.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when this schedule template record was last modified.',
    `no_show_tracking_enabled_flag` BOOLEAN COMMENT 'Indicates whether no-show events are tracked for appointments scheduled under this template. True enables tracking; False does not.',
    `notes` STRING COMMENT 'Free-text notes or comments about this schedule template, including special instructions, restrictions, or administrative remarks.',
    `overbooking_allowed_flag` BOOLEAN COMMENT 'Indicates whether overbooking (scheduling beyond max_slots_per_session) is permitted for this template. True allows overbooking; False enforces strict capacity limits.',
    `overbooking_limit` STRING COMMENT 'Maximum number of additional slots that can be overbooked beyond max_slots_per_session. Null if overbooking is not allowed.',
    `patient_class` STRING COMMENT 'Classification of patients eligible for appointments under this template (e.g., NEW, ESTABLISHED, REFERRAL, SELF_PAY). [ENUM-REF-CANDIDATE: new|established|referral|self_pay|medicare|medicaid|commercial — promote to reference product]',
    `priority_level` STRING COMMENT 'Priority classification for appointments scheduled under this template. Determines scheduling urgency and slot allocation rules.. Valid values are `routine|urgent|emergent|elective`',
    `provider_npi` STRING COMMENT 'Ten-digit National Provider Identifier for the provider to whom this template applies. Null if template applies to a non-provider resource.. Valid values are `^[0-9]{10}$`',
    `recurrence_pattern` STRING COMMENT 'Defines how the template recurs over time: daily, weekly, biweekly, monthly, rotating shift, or custom pattern.. Valid values are `daily|weekly|biweekly|monthly|rotating|custom`',
    `recurrence_rule` STRING COMMENT 'Detailed recurrence rule in iCalendar RRULE format or system-specific notation defining the exact repeat logic (e.g., FREQ=WEEKLY;BYDAY=MO,WE,FR).',
    `reminder_enabled_flag` BOOLEAN COMMENT 'Indicates whether automated appointment reminders (SMS, email, phone) are sent for appointments scheduled under this template. True enables reminders; False disables.',
    `reminder_lead_time_hours` STRING COMMENT 'Number of hours before the appointment when the reminder is sent. Null if reminders are not enabled.',
    `session_duration_minutes` STRING COMMENT 'Total duration of the scheduled session in minutes. Calculated as the difference between session start and end times.',
    `session_end_time` TIMESTAMP COMMENT 'Time of day when the scheduled session ends, in HH:MM 24-hour format (e.g., 17:00, 21:00).',
    `session_start_time` TIMESTAMP COMMENT 'Time of day when the scheduled session begins, in HH:MM 24-hour format (e.g., 08:00, 13:30).',
    `slot_duration_minutes` STRING COMMENT 'Duration of each individual appointment slot within the session, in minutes (e.g., 15, 30, 60). Determines how many slots are generated per session.',
    `source_system_code` STRING COMMENT 'Unique identifier for this schedule template in the source system. Used for data lineage and reconciliation.',
    `telehealth_enabled_flag` BOOLEAN COMMENT 'Indicates whether this schedule template supports telehealth/virtual appointments. True enables telehealth; False restricts to in-person only.',
    `template_name` STRING COMMENT 'Business-friendly name for the schedule template (e.g., Dr. Smith Monday Clinic, OR 3 Weekday Block).',
    `template_status` STRING COMMENT 'Current lifecycle status of the schedule template. Active templates are used for slot generation; inactive/retired templates are historical.. Valid values are `active|inactive|draft|suspended|retired|pending`',
    `template_type` STRING COMMENT 'Classification of the schedule template indicating whether it applies to a provider, resource, facility, equipment, room, or staff member.. Valid values are `provider|resource|facility|equipment|room|staff`',
    `waitlist_enabled_flag` BOOLEAN COMMENT 'Indicates whether a waitlist is maintained for this schedule template when all slots are filled. True enables waitlist management; False does not.',
    CONSTRAINT pk_schedule_template PRIMARY KEY(`schedule_template_id`)
) COMMENT 'Provider and resource schedule templates defining recurring availability patterns (daily, weekly, rotating) plus real-time availability exceptions, overrides, and leave records. For templates: captures template name, effective date range, applicable provider or resource, time block definitions, appointment type slots, session duration, and recurrence rules. For availability exceptions: captures provider NPI, exception type (vacation, CME, administrative, on-call, blocked, emergency override), start/end datetime, care setting, reason for unavailability, and approval status. SSOT for all provider/resource availability — both the recurring blueprint and its real-time modifications. Aligns with HL7 FHIR Schedule resource. Used by Epic Cadence and OpTime to generate open scheduling slots.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` (
    `open_slot_id` BIGINT COMMENT 'Unique identifier for the open scheduling slot. Primary key for the open_slot data product.',
    `clinician_id` BIGINT COMMENT 'Reference to the healthcare provider (physician, nurse practitioner, therapist) assigned to this slot. Links to the provider master data product. Used for provider-specific appointment booking.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Open slots designated for specific procedure types (e.g., procedure slots reserved for colonoscopies or injections) are typed by CPT code to enable intelligent slot-matching during scheduling. Schedul',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Open slots may be restricted to a specific groups patients or clinicians. Group-level slot management, scheduling configuration, and network adequacy reporting require linking open slots to the ownin',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Open slots are at a specific provider_location. Patient self-scheduling, appointment booking systems, and CMS provider directory requirements need the exact location of available slots for patient rou',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Open slots exist at a specific facility. Facility-level slot management, capacity planning, and patient access reporting require knowing which org_provider the slot belongs to. Healthcare scheduling s',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: Open slots are generated for specific schedulable resources (providers, rooms, equipment). While open_slot already has clinician_id and specialty_id, it lacks a direct FK to the schedulable_resource e',
    `schedule_template_id` BIGINT COMMENT 'Reference to the parent schedule template from which this slot was generated. Links to the schedule data product that defines recurring availability patterns for providers, rooms, or equipment.',
    `appointment_type_eligibility` STRING COMMENT 'Comma-separated list of appointment types that are eligible to be booked in this slot. Examples include new patient, follow-up, annual physical, procedure. Enforces business rules for slot utilization.',
    `block_reason` STRING COMMENT 'Free-text explanation for why the slot is blocked or unavailable. Examples include provider time off, equipment maintenance, facility closure, administrative time. Null if slot is available for booking.',
    `block_type` STRING COMMENT 'Categorization of the reason the slot is blocked. Used for reporting on non-clinical time utilization and capacity planning. Null if slot is not blocked.. Valid values are `administrative|personal|maintenance|training|meeting|other`',
    `care_setting` STRING COMMENT 'The care delivery environment where the slot is available. Distinguishes between outpatient clinics, inpatient units, emergency department (ED), operating room (OR), telehealth, and home health settings.. Valid values are `outpatient|inpatient|emergency|surgical|telehealth|home_health`',
    `comment` STRING COMMENT 'Free-text notes or special instructions associated with the slot. May include preparation requirements, patient instructions, or scheduling coordinator notes. Visible to scheduling staff and potentially to patients.',
    `created_datetime` TIMESTAMP COMMENT 'The date and time when this slot record was first created in the scheduling system. Used for audit trail and slot generation tracking.',
    `hold_expiration_datetime` TIMESTAMP COMMENT 'The date and time when a held slot will automatically be released if not confirmed. Null if slot is not currently held. Used to prevent indefinite slot blocking and optimize capacity utilization.',
    `hold_reason` STRING COMMENT 'Free-text explanation for why the slot is held. Examples include pending insurance authorization, awaiting patient callback, reserved for urgent referral. Null if slot is not held.',
    `hold_status` STRING COMMENT 'Indicates whether the slot is currently held for a specific patient or referral. Held slots are temporarily reserved pending confirmation. Expired holds are automatically released after a configured timeout period.. Valid values are `available|held|released|expired`',
    `insurance_eligibility` STRING COMMENT 'Comma-separated list of insurance types or payer groups accepted for this slot. Examples include Medicare, Medicaid, commercial, self-pay. Used for payer-specific access management and network compliance.',
    `last_modified_datetime` TIMESTAMP COMMENT 'The date and time when this slot record was last updated. Tracks changes to slot status, capacity, or configuration. Critical for real-time slot availability synchronization.',
    `max_capacity` STRING COMMENT 'The maximum number of appointments that can be booked in this slot. Typically 1 for individual provider appointments, but may be higher for group visits, classes, or high-volume clinics.',
    `online_booking_cutoff_hours` STRING COMMENT 'The minimum number of hours in advance that a patient must book this slot online. Prevents same-day or last-minute online bookings. Null if no cutoff applies or online booking is disabled.',
    `online_booking_enabled_flag` BOOLEAN COMMENT 'Indicates whether this slot is available for patient self-scheduling through online portals such as Epic MyChart or Cerner patient portal. False restricts booking to staff-assisted scheduling only.',
    `overbook_allowed_flag` BOOLEAN COMMENT 'Indicates whether this slot can be overbooked beyond its max_capacity. True allows scheduling additional appointments when slot is full, typically used for urgent or walk-in patients. False enforces strict capacity limits.',
    `patient_type_eligibility` STRING COMMENT 'Defines which patient types can book this slot. Examples include established patient only, new patient only, pediatric, adult, geriatric. Used to enforce age restrictions and patient relationship requirements.',
    `remaining_capacity` STRING COMMENT 'The number of appointments that can still be booked in this slot. Supports overbooking scenarios where multiple patients can be scheduled in the same time slot. Value of 0 indicates slot is fully booked.',
    `slot_category` STRING COMMENT 'Broad categorization of the slot for grouping and filtering purposes. Examples include outpatient, surgical, diagnostic, telehealth, emergency. Used for capacity planning and reporting.',
    `slot_duration_minutes` STRING COMMENT 'The length of the slot in minutes, calculated as the difference between slot_end_datetime and slot_start_datetime. Standard durations vary by appointment type and provider specialty.',
    `slot_end_datetime` TIMESTAMP COMMENT 'The date and time when the slot ends. Represents the latest time an appointment can conclude in this slot. Used to calculate slot duration and prevent overbooking.',
    `slot_identifier` STRING COMMENT 'Human-readable business identifier for the slot, typically generated from schedule template and date/time. Used for external reference and display in Epic Cadence and Cerner scheduling interfaces.',
    `slot_start_datetime` TIMESTAMP COMMENT 'The date and time when the slot begins. Represents the earliest time an appointment can start in this slot. Critical for patient scheduling and resource allocation.',
    `slot_status` STRING COMMENT 'Current availability status of the slot. Free indicates bookable, busy indicates occupied, busy-unavailable indicates blocked, busy-tentative indicates held pending confirmation. Aligns with HL7 FHIR SlotStatus value set.. Valid values are `free|busy|busy-unavailable|busy-tentative|entered-in-error`',
    `slot_type` STRING COMMENT 'Classification of the slot indicating the kind of appointment or service that can be booked. Examples include new patient visit, follow-up, procedure, telehealth, walk-in. Sourced from Epic Cadence visit type or Cerner appointment type configuration.',
    `source_system_identifier` STRING COMMENT 'The unique identifier for this slot in the source operational system. Used for data lineage, reconciliation, and bidirectional synchronization between lakehouse and operational systems.',
    `specialty` STRING COMMENT 'The medical specialty or service line associated with this slot. Examples include cardiology, orthopedics, primary care, radiology. Used for specialty-specific appointment routing and capacity analysis.',
    `waitlist_enabled_flag` BOOLEAN COMMENT 'Indicates whether patients can be added to a waitlist for this slot if it is fully booked. True enables waitlist management for high-demand slots. Used for cancellation backfill and access optimization.',
    CONSTRAINT pk_open_slot PRIMARY KEY(`open_slot_id`)
) COMMENT 'Individual available scheduling slots generated from schedule templates for providers, rooms, and equipment. Captures slot date/time, duration, slot type, care setting, resource assignment, appointment type eligibility, hold status, and remaining capacity. Represents the real-time inventory of bookable time — aligns with HL7 FHIR Slot resource. Consumed by appointment booking workflows, patient self-scheduling (Epic MyChart), and patient access teams in Epic Cadence and Cerner scheduling.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` (
    `surgical_case_id` BIGINT COMMENT 'Unique identifier for the surgical or procedural case. Primary key for the surgical case record. System-generated surrogate key used across Epic OpTime and Cerner SurgiNet modules.',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.billing_coverage. Business justification: Surgical financial clearance requires verifying billing coverage (network status, authorization_required_flag, deductible met) before a case is scheduled. This is a mandatory pre-surgical workflow in ',
    `clinician_id` BIGINT COMMENT 'Foreign key linking to provider.clinician. Business justification: Surgical cases mandate informed consent verification. OR teams check consent status on pre-operative checklists before case start. Required for Joint Commission compliance, CMS conditions of participa',
    `code_set_version_id` BIGINT COMMENT 'Foreign key linking to reference.code_set_version. Business justification: Surgical cases governed by OR policies mandating timeout procedures, consent requirements, site marking, and implant tracking. Joint Commission and CMS Conditions of Participation requirement.',
    `consent_reference_id` BIGINT COMMENT 'Foreign key linking to patient.consent_reference. Business justification: Joint Commission and CMS require surgical consent documentation linked to the surgical case. surgical_case has denormalized consent_obtained_indicator and consent_timestamp; a proper FK to consent_ref',
    `credentialing_application_id` BIGINT COMMENT 'Foreign key linking to provider.malpractice_coverage. Business justification: Surgical case scheduling requires current malpractice insurance verification per hospital medical staff bylaws and risk management policies. Links case to active policy covering procedure specialty an',
    `demographics_id` BIGINT COMMENT 'Foreign key linking to patient.demographics. Business justification: Surgical case planning requires patient demographic data (sex at birth, age, language, advance directive) for pre-op documentation, anesthesia risk stratification, and regulatory reporting. Surgical c',
    `drg_id` BIGINT COMMENT 'Foreign key linking to reference.drg. Business justification: DRG assignment at case scheduling enables reimbursement forecasting, case costing, length-of-stay estimation, and OR block value analysis. Essential for surgical service line financial planning.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Surgical cases are performed by clinicians belonging to specific group practices. Group-level surgical volume reporting, group contract compliance, and credentialing management require linking surgica',
    `hcpcs_code_id` BIGINT COMMENT 'Foreign key linking to reference.hcpcs_code. Business justification: Surgical cases involving implants, prosthetics, or surgical supplies require HCPCS coding for billing and implant tracking compliance. OR billing teams and supply chain coordinators use HCPCS codes on',
    `insurance_coverage_id` BIGINT COMMENT 'Foreign key linking to patient.insurance_coverage. Business justification: Pre-surgical financial clearance requires linking the surgical case to the specific insurance coverage record for prior authorization and benefit verification. This is a named operational workflow in ',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Surgical cases occur at a specific provider_location (OR suite within a facility). OR scheduling, case management, post-surgical care coordination, and billing require knowing the exact location where',
    `or_block_id` BIGINT COMMENT 'Foreign key linking to scheduling.or_block. Business justification: A surgical case is scheduled within an OR block time allocation. surgical_case has block_time_indicator (BOOLEAN) and block_owner_npi (STRING) indicating block-based scheduling, but lacks a proper FK ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Surgical cases occur at a specific hospital/facility. OR scheduling, facility-level surgical volume reporting, CMS certification compliance, and billing require knowing which org_provider the case is ',
    `mpi_record_id` BIGINT COMMENT 'add column patient_mpi_record_id (BIGINT) with FK to patient.mpi_record.mpi_record_id - surgical cases lack a direct patient identifier FK; patient is only reachable through encounter.visit indirection',
    `snomed_concept_id` BIGINT COMMENT 'Foreign key linking to reference.snomed_concept. Business justification: Post-operative diagnosis SNOMED mapping is required for clinical documentation interoperability, FHIR Condition resources, and quality measure reporting. Surgical case post-op diagnoses must be SNOMED',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Pre-operative diagnosis ICD code required for surgical authorization, medical necessity validation, DRG assignment, and clinical documentation. Essential for case scheduling approval and compliance.',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Primary procedure CPT lookup required for OR block allocation, case costing, anesthesia base unit calculation, equipment requirements, and surgical billing. Critical for perioperative scheduling and r',
    `privileging_id` BIGINT COMMENT 'Foreign key linking to provider.privileging. Business justification: Surgical case scheduling requires verification of procedure-specific clinical privileges per Joint Commission MS standards. Links case to exact privilege record covering the CPT code, ensuring surgeon',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Surgical cases are performed to resolve specific problems on the patients problem list (e.g., cholecystectomy for cholelithiasis). Direct FK supports surgical quality reporting, problem resolution tr',
    `set_id` BIGINT COMMENT 'Foreign key linking to order.set. Business justification: Every surgical case follows a procedure-specific bill of materials defining required supplies, instruments, and implants. Core OR operations dependency for case preparation, cost estimation, and suppl',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Surgical procedures performed as part of clinical trials (device studies, surgical technique trials) must be tracked for coverage analysis, research billing determination, protocol deviation monitorin',
    `actual_duration_minutes` STRING COMMENT 'Actual length of the surgical procedure in minutes. Calculated from actual start and end times. Used for performance benchmarking and future duration estimation refinement.',
    `actual_end_time` TIMESTAMP COMMENT 'Actual date and time when the surgical procedure concluded. Captured when the patient exits the OR or when closure is complete. Used for duration variance analysis and turnover time calculation.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual date and time when the surgical procedure began. Captured when the patient enters the operating room or when incision occurs, depending on institutional policy. Used for on-time start performance measurement.',
    `add_on_case_indicator` BOOLEAN COMMENT 'Indicates whether this case was added to the schedule after the initial scheduling deadline. Add-on cases may indicate urgent needs or scheduling inefficiencies.',
    `anesthesia_type` STRING COMMENT 'Type of anesthesia planned or administered for the surgical case. Determines anesthesia staffing requirements, billing codes, and patient preparation protocols.. Valid values are `general|regional|local|monitored_anesthesia_care|sedation|none`',
    `asa_classification` STRING COMMENT 'ASA physical status classification representing the patients pre-anesthesia medical condition. Ranges from I (healthy) to VI (brain-dead organ donor). Used for risk stratification and anesthesia planning.. Valid values are `I|II|III|IV|V|VI`',
    `block_owner_npi` STRING COMMENT 'National Provider Identifier of the surgeon or service that owns the block time during which this case is scheduled. Used for block utilization and release tracking.. Valid values are `^[0-9]{10}$`',
    `block_time_indicator` BOOLEAN COMMENT 'Indicates whether this case is scheduled within a surgeons allocated block time. Block time is pre-reserved OR time assigned to specific surgeons or services. Used for block utilization reporting.',
    `cancellation_reason` STRING COMMENT 'Reason for case cancellation if status is cancelled. Categorized into patient-related, physician-related, facility-related, or administrative reasons. Used for quality improvement and scheduling optimization.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the surgical case was cancelled. Used to measure cancellation lead time and assess impact on OR utilization.',
    `case_number` STRING COMMENT 'Business identifier for the surgical case. Human-readable case number assigned by the surgical scheduling system. Used for operational tracking and communication between surgical staff.. Valid values are `^[A-Z0-9]{8,20}$`',
    `case_status` STRING COMMENT 'Current lifecycle status of the surgical case. Tracks progression from initial request through completion or cancellation. Critical for operational dashboards and capacity planning. [ENUM-REF-CANDIDATE: requested|scheduled|confirmed|in_progress|completed|cancelled|postponed|on_hold — 8 candidates stripped; promote to reference product]',
    `case_type` STRING COMMENT 'Classification of the surgical case based on patient status and urgency. Determines scheduling priority, resource allocation, and billing rules.. Valid values are `inpatient|outpatient|ambulatory|emergency|trauma|transplant`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the surgical case record was first created in the system. Used for audit trail and data lineage tracking.',
    `equipment_requirements` STRING COMMENT 'Special equipment or instrumentation required for the surgical case. Free-text or structured list of equipment codes. Used for equipment scheduling and availability verification.',
    `estimated_duration_minutes` STRING COMMENT 'Estimated length of the surgical procedure in minutes. Based on historical averages for the procedure type, surgeon, and patient complexity. Used for block time allocation and scheduling optimization.',
    `implant_required` BOOLEAN COMMENT 'Indicates whether the surgical case requires implantable devices or hardware. Triggers supply chain coordination and implant tracking requirements.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the surgical case record was last updated. Used for audit trail, change tracking, and data quality monitoring.',
    `laterality` STRING COMMENT 'Anatomical side on which the procedure is performed. Critical for surgical site verification and wrong-site surgery prevention. Part of the Universal Protocol.. Valid values are `left|right|bilateral|not_applicable`',
    `mrn` STRING COMMENT 'Patient medical record number. Unique identifier for the patient undergoing the surgical procedure. Links to the patient master index.. Valid values are `^[A-Z0-9]{6,12}$`',
    `patient_class` STRING COMMENT 'Patient classification for the surgical encounter. Determines billing rules, bed assignment requirements, and post-operative care pathways.. Valid values are `inpatient|outpatient|observation|same_day_surgery|extended_recovery`',
    `post_op_diagnosis` STRING COMMENT 'Final clinical diagnosis documented after the surgical procedure. May differ from pre-operative diagnosis based on intra-operative findings. Used for billing and clinical documentation.',
    `requires_blood_products` BOOLEAN COMMENT 'Indicates whether the surgical case requires blood products to be available. Triggers blood bank coordination and type-and-screen orders.',
    `requires_icu_bed` BOOLEAN COMMENT 'Indicates whether the patient will require an ICU bed post-operatively. Used for bed management and capacity planning coordination between OR and ICU.',
    `scheduled_date` DATE COMMENT 'Date on which the surgical procedure is scheduled to occur. Used for day-level capacity planning and patient preparation scheduling.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Anticipated date and time when the surgical case is expected to conclude. Calculated from scheduled start time plus estimated duration. Used for downstream resource planning.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Precise date and time when the surgical case is scheduled to begin. Used for minute-level OR scheduling, staff coordination, and patient arrival instructions.',
    `service_line` STRING COMMENT 'Clinical service line or specialty department responsible for the surgical case (e.g., Orthopedics, Cardiothoracic, General Surgery, Neurosurgery). Used for departmental reporting and resource allocation.',
    `site_marked_indicator` BOOLEAN COMMENT 'Indicates whether the surgical site has been marked by the surgeon. Required by the Universal Protocol for procedures involving laterality or multiple structures. Used for pre-operative safety checklist.',
    `specialty` STRING COMMENT 'Medical specialty of the primary surgeon or the procedure type. More granular than service line. Used for surgeon credentialing and case mix analysis.',
    `timeout_completed_indicator` BOOLEAN COMMENT 'Indicates whether the surgical team completed the mandatory pre-incision timeout. Timeout verifies patient identity, procedure, site, and team readiness. Required by The Joint Commission.',
    `urgency_level` STRING COMMENT 'Clinical urgency classification of the surgical case. Determines scheduling priority and resource allocation. Emergent cases may displace elective cases.. Valid values are `elective|urgent|emergent|trauma`',
    CONSTRAINT pk_surgical_case PRIMARY KEY(`surgical_case_id`)
) COMMENT 'Master record for every scheduled surgical or procedural case managed through OpTime or Cerner SurgiNet. Captures case type, procedure codes (CPT/ICD-10-PCS), scheduled OR suite, primary surgeon, anesthesia type, estimated duration, case status (requested, scheduled, in-progress, completed, cancelled), ASA classification, and block time utilization. SSOT for surgical scheduling distinct from outpatient appointments.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` (
    `or_block_id` BIGINT COMMENT 'Unique identifier for the operating room block time allocation record.',
    `cdm_entry_id` BIGINT COMMENT 'Foreign key linking to billing.cdm_entry. Business justification: OR blocks map to facility charges in CDM for OR time billing. Block type determines facility fee structure (prime time vs. off-hours). Needed for automated OR facility charge capture and block utiliza',
    `clinician_id` BIGINT COMMENT 'Identifier of the individual surgeon who owns the block, if block_owner_type is surgeon. References provider master data.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: OR blocks can be owned by a physician group (group block time allocation). Group-level OR utilization reporting, block management, and surgical volume tracking by group require this link.',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: OR blocks are assigned to a specific physical OR suite/location within a facility. OR utilization reporting, block management, and surgical scheduling require knowing the exact provider_location of ea',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: OR blocks are assigned to a specific hospital/facility. OR utilization reporting, block management, and facility-level surgical capacity planning require knowing which org_provider owns the block. A h',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to scheduling.schedulable_resource. Business justification: An OR block is allocated to a specific operating room or procedural suite, which is a schedulable_resource of type room/OR. or_block currently has no FK to the schedulable_resource entity, making it i',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: OR blocks allocated by procedure type require CPT reference for duration estimation, equipment planning, anesthesia type determination, and block utilization analysis. Core to perioperative capacity m',
    `allows_overbooking` BOOLEAN COMMENT 'Indicates whether cases can be scheduled beyond the allocated block end time, allowing for extended use of the OR suite.',
    `allows_sharing` BOOLEAN COMMENT 'Indicates whether the block owner permits other surgeons or services to share unused portions of the block time.',
    `anesthesia_type_required` STRING COMMENT 'Type of anesthesia typically required for cases scheduled in this block (e.g., general, regional, local, MAC). Used for resource planning.',
    `block_duration_minutes` STRING COMMENT 'Total duration of the OR block in minutes, calculated from start to end time.',
    `block_end_time` TIMESTAMP COMMENT 'Time of day when the OR block ends, in HH:mm format (e.g., 15:30). Represents the scheduled end of the allocated time window.',
    `block_name` STRING COMMENT 'Descriptive name of the OR block, often including the service or surgeon name for easy identification.',
    `block_number` STRING COMMENT 'Business identifier or code for the OR block allocation, used for scheduling and reporting purposes.',
    `block_owner_type` STRING COMMENT 'Type of entity that owns or controls the block time allocation (service line, individual surgeon, specialty, department, or open block).. Valid values are `service|surgeon|specialty|department|open`',
    `block_start_time` TIMESTAMP COMMENT 'Time of day when the OR block begins, in HH:mm format (e.g., 07:30). Represents the scheduled start of the allocated time window.',
    `block_status` STRING COMMENT 'Current operational status of the OR block allocation indicating whether it is available for scheduling.. Valid values are `active|suspended|cancelled|expired|pending`',
    `block_type` STRING COMMENT 'Classification of the block allocation indicating priority and usage rules (primary block has first priority, secondary is backup, open is available to all, flex is flexible allocation, call is for on-call cases).. Valid values are `primary|secondary|tertiary|open|flex|call`',
    `cancellation_reason` STRING COMMENT 'Reason why the block allocation was permanently cancelled (e.g., surgeon departure, service line closure, contract termination).',
    `cost_center_code` STRING COMMENT 'Financial cost center code to which OR block time and associated costs are allocated for accounting and budgeting purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the OR block allocation record was first created in the system.',
    `day_of_week` STRING COMMENT 'Day of the week on which this block time is allocated (recurring weekly schedule). [ENUM-REF-CANDIDATE: monday|tuesday|wednesday|thursday|friday|saturday|sunday — 7 candidates stripped; promote to reference product]',
    `effective_end_date` DATE COMMENT 'Date when this block allocation expires or is no longer active. Null indicates an open-ended allocation.',
    `effective_start_date` DATE COMMENT 'Date when this block allocation becomes active and available for scheduling.',
    `equipment_set_required` STRING COMMENT 'Standard equipment set or configuration required for cases in this block (e.g., orthopedic, cardiac, robotic). Used for OR setup and resource allocation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the OR block allocation record was most recently updated or modified.',
    `minimum_utilization_threshold_pct` DECIMAL(18,2) COMMENT 'Minimum percentage of block time that must be utilized to maintain the block allocation. Used for performance monitoring and block reallocation decisions.',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to the block allocation, including scheduling preferences, restrictions, or coordination requirements.',
    `priority_rank` STRING COMMENT 'Numeric ranking indicating the priority of this block when multiple blocks overlap or compete for the same OR suite. Lower numbers indicate higher priority.',
    `recurring_pattern` STRING COMMENT 'Pattern describing how the block recurs over time (e.g., every week, every other week, first Monday of month). [ENUM-REF-CANDIDATE: weekly|biweekly|monthly|first_week|second_week|third_week|fourth_week|custom — 8 candidates stripped; promote to reference product]',
    `release_lead_time_days` STRING COMMENT 'Number of days before the block date that unused time must be released, if release_rule_type is days_before.',
    `release_lead_time_hours` STRING COMMENT 'Number of hours before the block start time that unused time must be released, if release_rule_type is hours_before.',
    `release_rule_type` STRING COMMENT 'Type of rule governing when unused block time is released back to the general pool for other surgeons or services to use.. Valid values are `days_before|hours_before|no_release|manual`',
    `staff_roles_required` STRING COMMENT 'Comma-separated list of staff roles or specialties required to support cases in this block (e.g., scrub nurse, circulating nurse, surgical tech, perfusionist).',
    `suspension_reason` STRING COMMENT 'Reason why the block was suspended or temporarily inactivated (e.g., low utilization, surgeon leave, facility maintenance).',
    `target_utilization_threshold_pct` DECIMAL(18,2) COMMENT 'Target percentage of block time utilization that the owner is expected to achieve for optimal OR capacity management.',
    CONSTRAINT pk_or_block PRIMARY KEY(`or_block_id`)
) COMMENT 'Operating room block time allocations assigned to surgical services, specialties, or individual surgeons. Captures block owner (service/surgeon), OR suite, day of week, start/end time, block type (primary, secondary, open), release rules, utilization thresholds, and effective date range. Drives OR capacity planning and block utilization reporting. Sourced from Epic OpTime block scheduling.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` (
    `schedulable_resource_id` BIGINT COMMENT 'Unique identifier for the schedulable resource. Primary key for the schedulable resource entity.',
    `clinician_id` BIGINT COMMENT 'Identifier of the user or system account that last modified this resource record. Supports audit trail and accountability.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: A schedulable resource (e.g., a dedicated procedure room) may be allocated to a specific physician group. Group-level resource allocation, scheduling management, and group contract compliance require ',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: A schedulable resource is physically located at a specific provider_location (e.g., Exam Room 3 at the downtown clinic). Patient routing, appointment booking, and directory accuracy require knowing ',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: A schedulable resource (OR room, exam room, equipment) physically belongs to a specific org_provider/facility. Facility asset management, accreditation reporting, and capacity planning require knowing',
    `specialty_id` BIGINT COMMENT 'Foreign key linking to provider.specialty. Business justification: Schedulable resources (e.g., cardiac cath lab, MRI suite, neurology exam room) are specialty-specific. Specialty-based resource allocation, scheduling routing, and network adequacy reporting require a',
    `accepts_new_patients` BOOLEAN COMMENT 'Indicates whether the provider resource is currently accepting new patient appointments. True if accepting new patients, False otherwise. Applicable only to provider resources.',
    `allows_overbooking` BOOLEAN COMMENT 'Indicates whether the resource permits overbooking (scheduling more appointments than standard capacity allows). True if overbooking is permitted, False otherwise.',
    `building` STRING COMMENT 'Building name or number within the facility where the resource is located. Applicable primarily to room and equipment resources.',
    `care_setting` STRING COMMENT 'Primary care setting or service delivery environment where the resource operates (e.g., inpatient, outpatient, emergency department, ambulatory surgery center, home health, telehealth).. Valid values are `inpatient|outpatient|emergency|ambulatory_surgery|home_health|telehealth`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this resource record was first created in the system. Supports audit trail and data lineage.',
    `credentialing_expiration_date` DATE COMMENT 'Date when the providers current credentialing and privileging expires and must be renewed. Applicable only to provider resources.',
    `credentialing_status` STRING COMMENT 'Current status of the providers credentialing and privileging process. Applicable only to provider resources. Active indicates fully credentialed and privileged; pending indicates credentialing in progress; expired, suspended, or revoked indicate loss of privileges.. Valid values are `active|pending|expired|suspended|revoked`',
    `default_slot_duration_minutes` STRING COMMENT 'Standard duration in minutes for a single scheduling slot or appointment block for this resource. Used as the default when creating schedules.',
    `effective_end_date` DATE COMMENT 'Date when the resource was retired or became unavailable for scheduling. Null for currently active resources. Supports historical tracking and temporal queries.',
    `effective_start_date` DATE COMMENT 'Date when the resource became active and available for scheduling. Supports historical tracking and temporal queries.',
    `floor` STRING COMMENT 'Floor number or level within the building where the resource is located. Applicable primarily to room and equipment resources.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this resource record was most recently updated. Supports audit trail and change tracking.',
    `license_number` STRING COMMENT 'State-issued professional license number for provider resources. Applicable only to provider resources. Null for non-provider resources.',
    `license_state` STRING COMMENT 'Two-letter state code where the provider license was issued. Applicable only to provider resources.. Valid values are `^[A-Z]{2}$`',
    `maintenance_window_end` TIMESTAMP COMMENT 'End date and time of scheduled maintenance or downtime window. Applicable primarily to equipment and room resources.',
    `maintenance_window_start` TIMESTAMP COMMENT 'Start date and time of scheduled maintenance or downtime window during which the resource is unavailable for scheduling. Applicable primarily to equipment and room resources.',
    `minimum_turnover_time_minutes` STRING COMMENT 'Minimum time in minutes required between consecutive appointments or uses of the resource. Includes cleaning, setup, and preparation time. Critical for scheduling optimization and capacity planning.',
    `npi` STRING COMMENT 'Ten-digit National Provider Identifier assigned by CMS. Applicable only to provider resources (physicians, APPs, therapists). Null for non-provider resources.. Valid values are `^[0-9]{10}$`',
    `overbooking_limit` STRING COMMENT 'Maximum number of additional appointments that can be overbooked beyond standard capacity. Applicable only when allows_overbooking is True.',
    `provider_type` STRING COMMENT 'Classification of provider role or credential level (e.g., physician, nurse practitioner, physician assistant, physical therapist, registered nurse). Applicable only to provider resources. Null for non-provider resources.',
    `resource_code` STRING COMMENT 'Unique business identifier or code for the resource. May be an internal system code, asset tag, or room number depending on resource type.',
    `resource_name` STRING COMMENT 'Human-readable name or title of the schedulable resource. For providers, this is the full name; for rooms, the room designation; for equipment, the equipment name or model.',
    `resource_type` STRING COMMENT 'Classification of the schedulable resource: provider (physicians, APPs, therapists), room (exam, OR suite, procedure, imaging, infusion bay), equipment (MRI, CT, C-arm, surgical robot, laser, perfusion pump), or care team.. Valid values are `provider|room|equipment|care_team`',
    `room_capacity` STRING COMMENT 'Maximum number of patients or occupants that can be accommodated in the room simultaneously. Applicable only to room resources. Null for non-room resources.',
    `room_configuration` STRING COMMENT 'Physical configuration or layout of the room (e.g., single-bed, multi-bed, open bay, private suite). Applicable only to room resources.',
    `scheduling_constraints` STRING COMMENT 'Free-text description of any special scheduling rules, restrictions, or constraints that apply to this resource (e.g., only available for specific appointment types, requires advance booking, limited to certain patient populations).',
    `scheduling_status` STRING COMMENT 'Current availability status of the resource for scheduling purposes. Active resources are available for scheduling; inactive resources are temporarily unavailable; maintenance resources are undergoing service; reserved resources are held for specific purposes; retired resources are permanently removed from service.. Valid values are `active|inactive|maintenance|reserved|retired`',
    `sterilization_cycle_required` BOOLEAN COMMENT 'Indicates whether the resource requires a sterilization cycle between uses. True if sterilization is required, False otherwise. Applicable primarily to equipment and room resources used in surgical or procedural settings.',
    `sterilization_duration_minutes` STRING COMMENT 'Duration in minutes required to complete the sterilization cycle for the resource. Applicable only when sterilization_cycle_required is True.',
    `telehealth_enabled` BOOLEAN COMMENT 'Indicates whether the resource supports telehealth or virtual visit appointments. True if telehealth is supported, False otherwise. Applicable primarily to provider resources.',
    `unit` STRING COMMENT 'Unit, wing, or zone designation within the floor where the resource is located. Applicable primarily to room and equipment resources.',
    CONSTRAINT pk_schedulable_resource PRIMARY KEY(`schedulable_resource_id`)
) COMMENT 'Master catalog of all resources that can be scheduled across care settings: providers (physicians, APPs, therapists), rooms (exam, OR suite, procedure, imaging, infusion bay), equipment (MRI, CT, C-arm, surgical robot, laser, perfusion pump), and care teams. Captures resource type, name, NPI (for providers), location/facility, building/floor/unit (for rooms), room capacity and configuration, specialty, equipment asset ID, maintenance windows, sterilization cycle requirements, minimum turnover time, active/inactive status, and scheduling constraints. SSOT for resource identity within the scheduling domain. Links to workforce domain (provider master), facility domain (location/room master), and supply domain (equipment asset master) via cross-domain FKs.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` (
    `waitlist_entry_id` BIGINT COMMENT 'Unique identifier for the waitlist entry record. Primary key.',
    `billing_coverage_id` BIGINT COMMENT 'Foreign key linking to billing.billing_coverage. Business justification: Waitlist prioritization and scheduling eligibility depend on verifying billing coverage (in-network status, authorization_required_flag, copay). waitlist_entry has authorization_required_flag and insu',
    `care_plan_id` BIGINT COMMENT 'Foreign key linking to clinical.care_plan. Business justification: Waitlist entries for care coordination visits are linked to active care plans requiring multidisciplinary follow-up. Critical for transitions of care management, readmission prevention, and complex ca',
    `prior_authorization_id` BIGINT COMMENT 'Foreign key linking to claim.prior_authorization. Business justification: Waitlist entries for authorization-required services track authorization status to prioritize patients with approved authorizations for scheduling. Care coordinators proactively obtain authorizations ',
    `cpt_code_id` BIGINT COMMENT 'Foreign key linking to reference.cpt_code. Business justification: Waitlist entries for specific procedures are identified by CPT code to match patients to appropriate open slots and to support prior authorization workflows. Access management teams use CPT-coded wait',
    `demographics_id` BIGINT COMMENT 'Foreign key linking to patient.demographics. Business justification: Waitlist outreach requires patient demographic data for language-appropriate communication, interpreter coordination, and transportation assistance. Scheduling coordinators managing waitlists need dir',
    `diagnosis_id` BIGINT COMMENT 'Foreign key linking to clinical.diagnosis. Business justification: Patients are waitlisted for specialist care driven by a specific diagnosis (e.g., oncology consult for cancer, orthopedic surgery for fracture). Direct FK to the clinical diagnosis record supports wai',
    `eligibility_id` BIGINT COMMENT 'Foreign key linking to claim.eligibility. Business justification: Waitlist management requires real-time eligibility verification to confirm active coverage before scheduling, preventing claim denials for lapsed insurance. Access management teams routinely verify el',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Waitlist entries may be for any clinician within a group practice. Group-level waitlist management, capacity planning, and patient access reporting require linking waitlist entries to the relevant gro',
    `insurance_coverage_id` BIGINT COMMENT 'Identifier for the patient insurance coverage to be used for the appointment. Links to insurance coverage master data.',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Waitlist entries may be location-specific — a patient prefers or is assigned to a specific clinic location. Patient access management, scheduling operations, and location-level waitlist capacity repor',
    `mpi_record_id` BIGINT COMMENT 'Unique identifier for the patient on the waitlist. Links to the patient master record.',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Waitlist entries are often facility-specific — a patient waiting for a procedure at a particular hospital. Facility-level waitlist management, capacity planning, and patient access reporting require t',
    `patient_account_id` BIGINT COMMENT 'Foreign key linking to billing.patient_account. Business justification: Research subjects waitlisted for protocol-required procedures (imaging, surgery, specialty consults) must be tracked to enrollment records. Study coordinators manage waitlists for study-specific servi',
    `clinician_id` BIGINT COMMENT 'Identifier for the specific provider requested by the patient or referring provider. Null if no specific provider preference. Links to provider master data.',
    `problem_id` BIGINT COMMENT 'Foreign key linking to clinical.problem. Business justification: Waitlist entries for specialty care are driven by specific clinical problems requiring intervention. Essential for specialty access tracking, care gap management, and prioritization of patients with h',
    `referral_order_id` BIGINT COMMENT 'Identifier for the clinical order that triggered this waitlist entry, if applicable. Null for non-order-based entries. Links to clinical order master data.',
    `appointment_type_id` BIGINT COMMENT 'Identifier for the type of appointment requested by the patient or ordering provider. Links to appointment type master data.',
    `scheduling_appointment_id` BIGINT COMMENT 'Identifier for the appointment that was successfully scheduled from this waitlist entry. Null if not yet scheduled. Links to scheduling appointment master data.',
    `specialty_id` BIGINT COMMENT 'Identifier for the individual scheduler user assigned to work this entry. Null if not yet assigned to a specific person. Links to user master data.',
    `icd_code_id` BIGINT COMMENT 'Foreign key linking to reference.icd_code. Business justification: Waitlist visit reason ICD codes enable clinical prioritization, authorization requirement determination, specialty matching, and quality measure tracking. Critical for access management and care gap c',
    `authorization_required_flag` BOOLEAN COMMENT 'Indicates whether prior authorization from the payer is required before scheduling the appointment. True if authorization must be obtained.',
    `care_setting` STRING COMMENT 'Type of care setting required for the appointment: outpatient clinic, inpatient admission, emergency department, ambulatory surgery center, telehealth virtual visit, home health visit.. Valid values are `outpatient|inpatient|emergency|ambulatory_surgery|telehealth|home_health`',
    `created_datetime` TIMESTAMP COMMENT 'Date and time when this waitlist entry record was first created in the system. Audit timestamp for record creation.',
    `entry_number` STRING COMMENT 'Business-facing unique identifier or tracking number for the waitlist entry, used for patient communication and scheduling team reference.',
    `entry_status` STRING COMMENT 'Current lifecycle status of the waitlist entry: active (awaiting action), offered (appointment offered to patient), accepted (patient accepted offer), expired (entry aged out or SLA missed), removed (manually removed from queue), pending (awaiting information or approval), in_progress (actively being worked by scheduling team), scheduled (appointment successfully scheduled), escalated (escalated due to aging or priority), closed (completed or resolved). [ENUM-REF-CANDIDATE: active|offered|accepted|expired|removed|pending|in_progress|scheduled|escalated|closed — 10 candidates stripped; promote to reference product]',
    `entry_type` STRING COMMENT 'Classification of the waitlist entry indicating the source or nature of the scheduling request: waitlist (patient-initiated or provider-requested appointment waitlist), referral_queue (unscheduled referral awaiting scheduling), order_based (pending order requiring appointment), recall (recall-driven request for follow-up), surgical_request (surgical scheduling request), work_queue (general scheduling department work item).. Valid values are `waitlist|referral_queue|order_based|recall|surgical_request|work_queue`',
    `escalation_datetime` TIMESTAMP COMMENT 'Date and time when the waitlist entry was escalated. Null if never escalated.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether this waitlist entry has been escalated due to aging, priority, or SLA breach. True if escalated for management attention.',
    `escalation_reason` STRING COMMENT 'Free-text or coded reason for escalation (e.g., SLA breach, high clinical priority, patient complaint, aging threshold exceeded).',
    `estimated_wait_time_days` STRING COMMENT 'Estimated number of days the patient will wait from queue entry to scheduled appointment, based on current capacity and demand forecasting.',
    `interpreter_required_flag` BOOLEAN COMMENT 'Indicates whether a medical interpreter is required for the appointment. True if interpreter services must be arranged.',
    `language_preference` STRING COMMENT 'Patient preferred language for communication and care delivery. ISO 639-2 three-letter language code (e.g., eng for English, spa for Spanish).',
    `last_modified_datetime` TIMESTAMP COMMENT 'Date and time when this waitlist entry record was last updated. Audit timestamp for record modification.',
    `last_outreach_datetime` TIMESTAMP COMMENT 'Date and time of the most recent outreach attempt to the patient. Null if no outreach has been attempted.',
    `last_outreach_method` STRING COMMENT 'Method used for the most recent outreach attempt: phone call, email, SMS text, patient portal message, postal mail.. Valid values are `phone|email|sms|portal|mail`',
    `notes` STRING COMMENT 'Free-text notes and comments from scheduling staff regarding patient preferences, special requirements, barriers to scheduling, or other relevant information.',
    `outreach_attempt_count` STRING COMMENT 'Number of times the scheduling team has attempted to contact the patient to schedule the appointment. Used for tracking patient engagement and no-contact protocols.',
    `preferred_contact_channel` STRING COMMENT 'Patient preferred method of contact for scheduling outreach and appointment notifications: phone, email, SMS text message, patient portal message, postal mail.. Valid values are `phone|email|sms|portal|mail`',
    `preferred_days_of_week` STRING COMMENT 'Patient preference for days of the week for scheduling (e.g., Monday, Wednesday, Friday). Stored as comma-separated list or coded representation.',
    `preferred_time_of_day` STRING COMMENT 'Patient preference for time of day for scheduling: morning (before noon), afternoon (noon to 5pm), evening (after 5pm), any (no preference).. Valid values are `morning|afternoon|evening|any`',
    `priority_level` STRING COMMENT 'Clinical or operational priority assigned to the waitlist entry, determining urgency of scheduling action. Values align with clinical acuity and access standards. [ENUM-REF-CANDIDATE: routine|urgent|emergent|stat|high|medium|low — 7 candidates stripped; promote to reference product]',
    `queue_entry_datetime` TIMESTAMP COMMENT 'Date and time when the patient was added to the waitlist or scheduling queue. Used for aging calculations and first-in-first-out queue management.',
    `removal_datetime` TIMESTAMP COMMENT 'Date and time when the waitlist entry was removed from the queue without scheduling (e.g., patient declined, no longer needed, duplicate entry). Null if not removed.',
    `removal_reason` STRING COMMENT 'Free-text or coded reason for removing the entry from the waitlist without scheduling (e.g., patient declined, no longer clinically indicated, duplicate entry, patient deceased, scheduled elsewhere).',
    `scheduled_datetime` TIMESTAMP COMMENT 'Date and time when the appointment was successfully scheduled and the waitlist entry was resolved. Null if not yet scheduled.',
    `sla_target_datetime` TIMESTAMP COMMENT 'Target date and time by which the scheduling action should be completed per organizational or regulatory service level agreement. Used for compliance monitoring and escalation triggers.',
    `source_system_identifier` STRING COMMENT 'Unique identifier for this waitlist entry in the source system. Used for data lineage and reconciliation.',
    `specialty_required` STRING COMMENT 'Clinical specialty required for the appointment (e.g., Cardiology, Orthopedics, Primary Care). Used for routing to appropriate scheduling queues.',
    `telehealth_eligible_flag` BOOLEAN COMMENT 'Indicates whether the patient is eligible and willing to receive care via telehealth modality for this appointment request. True if telehealth is an acceptable option.',
    `transportation_assistance_needed_flag` BOOLEAN COMMENT 'Indicates whether the patient requires transportation assistance to attend the appointment. True if transportation support is needed.',
    `visit_reason` STRING COMMENT 'Free-text description of the clinical reason or chief complaint for the requested appointment.',
    `visit_reason_code` STRING COMMENT 'Coded representation of the visit reason using standard clinical terminology (e.g., SNOMED CT, ICD-10).',
    CONSTRAINT pk_waitlist_entry PRIMARY KEY(`waitlist_entry_id`)
) COMMENT 'Tracks all scheduling work items awaiting action — including patients on scheduling waitlists, unscheduled referrals, pending orders, recall-driven requests, surgical scheduling requests, and scheduling department work queues. Captures entry type (waitlist, referral queue, order-based, recall, surgical request), priority level, requested appointment type, patient scheduling preferences (preferred provider, preferred care site/location, preferred days/times, preferred contact channel, language preference, transportation needs, telehealth eligibility), queue entry datetime, assigned scheduling team, SLA target datetime, estimated wait time, status (active, offered, accepted, expired, removed, pending, in-progress, scheduled, escalated, closed), escalation/aging flags, and outreach attempt history. SSOT for all scheduling queue, waitlist, and patient preference management. Supports patient access optimization, scheduling department workflow, demand management, access SLA compliance, and patient-centered scheduling.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` (
    `provider_availability_id` BIGINT COMMENT 'Unique identifier for the provider availability record. Primary key.',
    `clinician_id` BIGINT COMMENT 'Identifier of the provider whose availability is being recorded. Links to the provider master data.',
    `group_id` BIGINT COMMENT 'Foreign key linking to provider.group. Business justification: Provider availability can be managed at the group level for group practices. Group-level capacity planning, scheduling management, and network adequacy reporting require linking availability records t',
    `location_id` BIGINT COMMENT 'Foreign key linking to provider.provider_location. Business justification: Provider availability is location-specific — a clinicians availability at one clinic is independent of another. Scheduling systems, network adequacy reporting, and provider directory accuracy require',
    `org_provider_id` BIGINT COMMENT 'Foreign key linking to provider.org_provider. Business justification: Provider availability is facility-specific — a clinician may be available at one hospital but not another. Network adequacy reporting, provider directory accuracy, and facility-level capacity planning',
    `schedule_template_id` BIGINT COMMENT 'Identifier of the schedule template that this availability record modifies or overrides, if applicable.',
    `accepts_new_patients` BOOLEAN COMMENT 'Boolean indicator (True/False) whether the provider is accepting new patient appointments during this availability period.',
    `approval_timestamp` TIMESTAMP COMMENT 'The date and time when this availability record was approved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `availability_status` STRING COMMENT 'Current status of the availability record in its lifecycle.. Valid values are `active|cancelled|pending|expired`',
    `availability_type` STRING COMMENT 'The type of availability record: scheduled (normal working hours), on_call (available for urgent calls), blocked (time blocked for non-clinical work), vacation (time off), cme (Continuing Medical Education), administrative (administrative duties).. Valid values are `scheduled|on_call|blocked|vacation|cme|administrative`',
    `booked_appointments` STRING COMMENT 'The current count of appointments already booked during this availability period. Used for capacity management.',
    `cancellation_reason` STRING COMMENT 'Free-text description of why this availability record was cancelled.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'The date and time when this availability record was cancelled. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `care_setting` STRING COMMENT 'The care setting or service location where the provider is available: inpatient, outpatient, emergency department, surgical suite, telehealth, or home health.. Valid values are `inpatient|outpatient|emergency|surgical|telehealth|home_health`',
    `coverage_area` STRING COMMENT 'Geographic or organizational coverage area for on-call availability. Examples: entire hospital, specific units, regional coverage.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this availability record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `credentialing_status` STRING COMMENT 'The credentialing status of the provider at the facility during this availability period. Must be active for scheduling.. Valid values are `active|pending|expired|suspended`',
    `duration_minutes` STRING COMMENT 'The total duration of the availability period in minutes, calculated from start to end datetime.',
    `effective_end_date` DATE COMMENT 'The date when this availability record expires and is no longer valid for scheduling. Null indicates no expiration. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'The date when this availability record becomes effective for scheduling purposes. Format: yyyy-MM-dd.',
    `end_datetime` TIMESTAMP COMMENT 'The date and time when the provider availability period ends. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `insurance_type_accepted` STRING COMMENT 'Comma-separated list of insurance types or payer categories accepted during this availability period. Examples: Medicare, Medicaid, Commercial, Self-Pay.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this availability record was last updated or modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `max_appointments` STRING COMMENT 'The maximum number of appointments that can be scheduled during this availability period. Null indicates no specific limit.',
    `notes` STRING COMMENT 'Free-text notes or comments about this availability record. May include special instructions, constraints, or context.',
    `on_call_type` STRING COMMENT 'The type of on-call availability when availability_type is on_call: primary (first responder), backup (secondary coverage), home (available from home), hospital (on-site coverage).. Valid values are `primary|backup|home|hospital`',
    `overbooking_allowed` BOOLEAN COMMENT 'Boolean indicator (True/False) whether overbooking beyond max_appointments is permitted during this availability period.',
    `overbooking_limit` STRING COMMENT 'The maximum number of overbooked appointments allowed beyond the standard max_appointments capacity.',
    `override_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) that identifies whether this availability record is an exception or override to the providers standard schedule template.',
    `patient_class` STRING COMMENT 'The patient classification or visit type that this availability supports.. Valid values are `inpatient|outpatient|observation|emergency|surgical|same_day`',
    `priority_level` STRING COMMENT 'The priority level of appointments that can be scheduled during this availability period.. Valid values are `routine|urgent|emergency`',
    `privilege_code` STRING COMMENT 'The clinical privilege code or category that the provider holds at this facility, defining the scope of services they can provide.',
    `recurrence_end_date` DATE COMMENT 'The date when a recurring availability pattern ends. Null for one-time availability records. Format: yyyy-MM-dd.',
    `recurrence_pattern` STRING COMMENT 'Indicates whether this availability record is a one-time event or part of a recurring pattern.. Valid values are `once|daily|weekly|biweekly|monthly`',
    `remaining_capacity` STRING COMMENT 'The number of additional appointments that can still be scheduled during this availability period, calculated as max_appointments minus booked_appointments.',
    `source_system_identifier` STRING COMMENT 'The unique identifier for this availability record in the source system.',
    `start_datetime` TIMESTAMP COMMENT 'The date and time when the provider availability period begins. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `telehealth_enabled` BOOLEAN COMMENT 'Boolean indicator (True/False) whether the provider is available for telehealth appointments during this period.',
    `unavailability_reason` STRING COMMENT 'Free-text description of the reason for unavailability when availability_type is blocked, vacation, cme, or administrative. Examples: conference attendance, personal leave, training, committee meeting.',
    `unavailability_reason_code` STRING COMMENT 'Standardized code representing the reason for unavailability. Used for reporting and analytics.',
    CONSTRAINT pk_provider_availability PRIMARY KEY(`provider_availability_id`)
) COMMENT 'Real-time and planned provider availability records capturing when providers are available, unavailable, or on leave for scheduling purposes. Captures provider NPI, availability type (scheduled, on-call, blocked, vacation, CME, administrative), start/end datetime, care setting, and reason for unavailability. Distinct from schedule templates — this captures actual availability exceptions and overrides that modify the template-generated slots.';

CREATE OR REPLACE TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` (
    `surgical_resource_assignment_id` BIGINT COMMENT 'Unique identifier for this resource assignment record. Primary key.',
    `schedulable_resource_id` BIGINT COMMENT 'Foreign key linking to the resource assigned to the surgical case',
    `surgical_case_id` BIGINT COMMENT 'Foreign key linking to the surgical case being resourced',
    `actual_end_time` TIMESTAMP COMMENT 'Actual date and time when this resource completed involvement in the surgical case. Used for resource utilization tracking and variance analysis. Explicitly identified in detection reasoning.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual date and time when this resource began involvement in the surgical case. Used for resource utilization tracking and variance analysis. Explicitly identified in detection reasoning.',
    `assignment_priority` STRING COMMENT 'Priority level of this resource assignment indicating whether the resource is required, preferred, or backup for the surgical case.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this resource assignment record was first created in the system.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this resource assignment record was most recently updated.',
    `modified_by_user_code` BIGINT COMMENT 'Identifier of the user or system account that last modified this assignment record.',
    `resource_role` STRING COMMENT 'The role or function this resource serves in the surgical case (e.g., primary surgeon, assistant surgeon, anesthesiologist, circulating nurse, scrub tech, OR suite, equipment, care team). Explicitly identified in detection reasoning.',
    `resource_status` STRING COMMENT 'Current status of this resource assignment (e.g., requested, confirmed, in-use, completed, cancelled, substituted). Tracks the lifecycle of the assignment. Explicitly identified in detection reasoning.',
    `scheduled_end_time` TIMESTAMP COMMENT 'Scheduled date and time when this resource is expected to complete involvement in the surgical case. Explicitly identified in detection reasoning.',
    `scheduled_start_time` TIMESTAMP COMMENT 'Scheduled date and time when this resource is expected to begin involvement in the surgical case. Explicitly identified in detection reasoning.',
    `substitution_reason` STRING COMMENT 'Reason for resource substitution if the originally assigned resource was replaced. Null if no substitution occurred.',
    CONSTRAINT pk_surgical_resource_assignment PRIMARY KEY(`surgical_resource_assignment_id`)
) COMMENT 'This association product represents the assignment of schedulable resources (providers, rooms, equipment, care teams) to surgical cases. It captures the operational allocation of resources to specific surgical procedures, including scheduled and actual timing, resource role, and assignment status. Each record links one surgical case to one schedulable resource with attributes that exist only in the context of this assignment relationship. This is the SSOT for resource allocation in surgical operations.. Existence Justification: In surgical operations, a single surgical case requires multiple resources simultaneously (primary surgeon, assistant surgeon, anesthesiologist, circulating nurse, scrub tech, OR suite, surgical equipment, care teams), and each resource (especially providers and rooms) is assigned to multiple surgical cases throughout the day and over time. OR managers actively manage these assignments as a first-class operational entity, tracking scheduled vs. actual timing, resource roles, substitutions, and utilization metrics per case-resource pair.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_open_slot_id` FOREIGN KEY (`open_slot_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`open_slot`(`open_slot_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ADD CONSTRAINT `fk_scheduling_scheduling_appointment_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ADD CONSTRAINT `fk_scheduling_schedule_template_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ADD CONSTRAINT `fk_scheduling_open_slot_schedule_template_id` FOREIGN KEY (`schedule_template_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedule_template`(`schedule_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ADD CONSTRAINT `fk_scheduling_surgical_case_or_block_id` FOREIGN KEY (`or_block_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`or_block`(`or_block_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ADD CONSTRAINT `fk_scheduling_or_block_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_appointment_type_id` FOREIGN KEY (`appointment_type_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`appointment_type`(`appointment_type_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ADD CONSTRAINT `fk_scheduling_waitlist_entry_scheduling_appointment_id` FOREIGN KEY (`scheduling_appointment_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`(`scheduling_appointment_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ADD CONSTRAINT `fk_scheduling_provider_availability_schedule_template_id` FOREIGN KEY (`schedule_template_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedule_template`(`schedule_template_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ADD CONSTRAINT `fk_scheduling_surgical_resource_assignment_schedulable_resource_id` FOREIGN KEY (`schedulable_resource_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`schedulable_resource`(`schedulable_resource_id`);
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ADD CONSTRAINT `fk_scheduling_surgical_resource_assignment_surgical_case_id` FOREIGN KEY (`surgical_case_id`) REFERENCES `vibe_healthcare_v1`.`scheduling`.`surgical_case`(`surgical_case_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_healthcare_v1`.`scheduling` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_healthcare_v1`.`scheduling` SET TAGS ('dbx_domain' = 'scheduling');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Appointment ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `dea_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Dea Registration Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Patient ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Eligibility Verification Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `guarantor_id` SET TAGS ('dbx_business_glossary_term' = 'Guarantor Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Member Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Network Affiliation Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `payer_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Payer Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `appointment_number` SET TAGS ('dbx_business_glossary_term' = 'Appointment Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `appointment_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Arrival Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `billing_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Billing Eligibility Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `booking_channel` SET TAGS ('dbx_business_glossary_term' = 'Booking Channel');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `booking_channel` SET TAGS ('dbx_value_regex' = 'phone|online-portal|mobile-app|in-person|referral|system-generated');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `booking_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Booking Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_business_glossary_term' = 'Cancelled By');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_value_regex' = 'patient|provider|facility|system');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `cancelled_by` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `check_in_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Check-In Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|declined|needs-action');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appointment End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `insurance_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `insurance_verification_status` SET TAGS ('dbx_value_regex' = 'verified|pending|failed|not-required|expired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `insurance_verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Insurance Verification Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `no_show_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Show Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `patient_device_type` SET TAGS ('dbx_business_glossary_term' = 'Patient Device Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Appointment Priority');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'routine|urgent|stat|elective|emergent');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `provider_attestation_flag` SET TAGS ('dbx_business_glossary_term' = 'Provider Attestation Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `roomed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Roomed Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Appointment Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Access Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_access_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Connection Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_connection_status` SET TAGS ('dbx_value_regex' = 'not-started|connected|disconnected|failed|completed');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_platform` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Platform');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Session URL (Uniform Resource Locator)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `telehealth_session_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `visit_modality` SET TAGS ('dbx_business_glossary_term' = 'Visit Modality');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `visit_modality` SET TAGS ('dbx_value_regex' = 'in-person|video|phone|e-visit|asynchronous');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `visit_reason` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`scheduling_appointment` ALTER COLUMN `visit_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `drug_master_id` SET TAGS ('dbx_business_glossary_term' = 'Drug Master Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_self_scheduling` SET TAGS ('dbx_business_glossary_term' = 'Allows Self-Scheduling Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `allows_telehealth` SET TAGS ('dbx_business_glossary_term' = 'Allows Telehealth Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_status` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|retired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `billing_class` SET TAGS ('dbx_business_glossary_term' = 'Billing Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `billing_class` SET TAGS ('dbx_value_regex' = 'professional|facility|technical|global');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Notice Required in Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `cancellation_notice_hours` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|emergency|telehealth|home_health|ambulatory_surgery');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_category` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Category');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_code` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `default_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Default Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_description` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Description');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `maximum_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `minimum_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `appointment_type_name` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `no_show_penalty_applies` SET TAGS ('dbx_business_glossary_term' = 'No-Show Penalty Applies Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `patient_class` SET TAGS ('dbx_value_regex' = 'new_patient|established_patient|return_patient|referral');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `preparation_instructions` SET TAGS ('dbx_business_glossary_term' = 'Patient Preparation Instructions');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `quality_measure_applicable` SET TAGS ('dbx_business_glossary_term' = 'Quality Measure Applicable Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `reminder_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Reminder Lead Time in Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `requires_interpreter` SET TAGS ('dbx_business_glossary_term' = 'Requires Interpreter Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `requires_referral` SET TAGS ('dbx_business_glossary_term' = 'Requires Referral Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `room_type_required` SET TAGS ('dbx_business_glossary_term' = 'Room Type Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `rvu_malpractice` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Malpractice Component');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `rvu_practice_expense` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Practice Expense Component');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `rvu_work` SET TAGS ('dbx_business_glossary_term' = 'Relative Value Unit (RVU) Work Component');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `staff_roles_required` SET TAGS ('dbx_business_glossary_term' = 'Staff Roles Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `visit_type_code` SET TAGS ('dbx_business_glossary_term' = 'Visit Type Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`appointment_type` ALTER COLUMN `waitlist_eligible` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `schedule_template_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Template ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `clinician_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|expired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `auto_confirm_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Confirm Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `buffer_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Buffer Time Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Policy Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `cancellation_policy_code` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|emergency|surgical|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `insurance_type_accepted` SET TAGS ('dbx_business_glossary_term' = 'Insurance Type Accepted');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `max_slots_per_session` SET TAGS ('dbx_business_glossary_term' = 'Maximum Slots Per Session');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `no_show_tracking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'No Show Tracking Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `overbooking_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergent|elective');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `provider_npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'daily|weekly|biweekly|monthly|rotating|custom');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `recurrence_rule` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Rule');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `reminder_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Reminder Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `reminder_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Reminder Lead Time Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `session_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Session Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `session_end_time` SET TAGS ('dbx_business_glossary_term' = 'Session End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `session_start_time` SET TAGS ('dbx_business_glossary_term' = 'Session Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `slot_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Slot Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `telehealth_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_name` SET TAGS ('dbx_business_glossary_term' = 'Template Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_status` SET TAGS ('dbx_business_glossary_term' = 'Template Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|suspended|retired|pending');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_type` SET TAGS ('dbx_business_glossary_term' = 'Template Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `template_type` SET TAGS ('dbx_value_regex' = 'provider|resource|facility|equipment|room|staff');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedule_template` ALTER COLUMN `waitlist_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `open_slot_id` SET TAGS ('dbx_business_glossary_term' = 'Open Slot Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `schedule_template_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `appointment_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Appointment Type Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `block_reason` SET TAGS ('dbx_business_glossary_term' = 'Block Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `block_type` SET TAGS ('dbx_business_glossary_term' = 'Block Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `block_type` SET TAGS ('dbx_value_regex' = 'administrative|personal|maintenance|training|meeting|other');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|emergency|surgical|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `comment` SET TAGS ('dbx_business_glossary_term' = 'Slot Comment');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_expiration_datetime` SET TAGS ('dbx_business_glossary_term' = 'Hold Expiration Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Hold Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_status` SET TAGS ('dbx_business_glossary_term' = 'Hold Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `hold_status` SET TAGS ('dbx_value_regex' = 'available|held|released|expired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `insurance_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Insurance Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `max_capacity` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `online_booking_cutoff_hours` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Cutoff Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `online_booking_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Online Booking Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `overbook_allowed_flag` SET TAGS ('dbx_business_glossary_term' = 'Overbook Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `patient_type_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Patient Type Eligibility');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_category` SET TAGS ('dbx_business_glossary_term' = 'Slot Category');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Slot Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Slot End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_identifier` SET TAGS ('dbx_business_glossary_term' = 'Slot Business Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Slot Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_business_glossary_term' = 'Slot Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_status` SET TAGS ('dbx_value_regex' = 'free|busy|busy-unavailable|busy-tentative|entered-in-error');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `slot_type` SET TAGS ('dbx_business_glossary_term' = 'Slot Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Provider Specialty');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`open_slot` ALTER COLUMN `waitlist_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` SET TAGS ('dbx_subdomain' = 'surgical_operations');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Record Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `code_set_version_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `consent_reference_id` SET TAGS ('dbx_business_glossary_term' = 'Consent Reference Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `credentialing_application_id` SET TAGS ('dbx_business_glossary_term' = 'Malpractice Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `credentialing_application_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Demographics Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `drg_id` SET TAGS ('dbx_business_glossary_term' = 'Drg Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `hcpcs_code_id` SET TAGS ('dbx_business_glossary_term' = 'Hcpcs Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `or_block_id` SET TAGS ('dbx_business_glossary_term' = 'Or Block Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `snomed_concept_id` SET TAGS ('dbx_business_glossary_term' = 'Post Op Snomed Concept Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Pre Op Diagnosis Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `privileging_id` SET TAGS ('dbx_business_glossary_term' = 'Privileging Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `set_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Bom Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Research Study Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `add_on_case_indicator` SET TAGS ('dbx_business_glossary_term' = 'Add-On Case Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `anesthesia_type` SET TAGS ('dbx_value_regex' = 'general|regional|local|monitored_anesthesia_care|sedation|none');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `asa_classification` SET TAGS ('dbx_business_glossary_term' = 'American Society of Anesthesiologists (ASA) Physical Status Classification');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `asa_classification` SET TAGS ('dbx_value_regex' = 'I|II|III|IV|V|VI');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_owner_npi` SET TAGS ('dbx_business_glossary_term' = 'Block Owner National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_owner_npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `block_time_indicator` SET TAGS ('dbx_business_glossary_term' = 'Block Time Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Surgical Case Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|ambulatory|emergency|trauma|transplant');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `equipment_requirements` SET TAGS ('dbx_business_glossary_term' = 'Equipment Requirements');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `implant_required` SET TAGS ('dbx_business_glossary_term' = 'Implant Required Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `laterality` SET TAGS ('dbx_business_glossary_term' = 'Surgical Laterality');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `laterality` SET TAGS ('dbx_value_regex' = 'left|right|bilateral|not_applicable');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mrn` SET TAGS ('dbx_business_glossary_term' = 'Medical Record Number (MRN)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mrn` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mrn` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `mrn` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `patient_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|observation|same_day_surgery|extended_recovery');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_business_glossary_term' = 'Post-Operative Diagnosis');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `post_op_diagnosis` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_blood_products` SET TAGS ('dbx_business_glossary_term' = 'Requires Blood Products Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `requires_icu_bed` SET TAGS ('dbx_business_glossary_term' = 'Requires Intensive Care Unit (ICU) Bed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Surgery Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `service_line` SET TAGS ('dbx_business_glossary_term' = 'Surgical Service Line');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `site_marked_indicator` SET TAGS ('dbx_business_glossary_term' = 'Surgical Site Marked Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `specialty` SET TAGS ('dbx_business_glossary_term' = 'Surgical Specialty');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `timeout_completed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Surgical Timeout Completed Indicator');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Case Urgency Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_case` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'elective|urgent|emergent|trauma');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` SET TAGS ('dbx_subdomain' = 'surgical_operations');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `or_block_id` SET TAGS ('dbx_business_glossary_term' = 'Operating Room (OR) Block ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cdm_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Cdm Entry Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Owner Surgeon ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Target Procedure Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `allows_overbooking` SET TAGS ('dbx_business_glossary_term' = 'Allows Overbooking Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `allows_sharing` SET TAGS ('dbx_business_glossary_term' = 'Allows Sharing Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `anesthesia_type_required` SET TAGS ('dbx_business_glossary_term' = 'Anesthesia Type Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Block Duration Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_end_time` SET TAGS ('dbx_business_glossary_term' = 'Block End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_name` SET TAGS ('dbx_business_glossary_term' = 'Block Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_number` SET TAGS ('dbx_business_glossary_term' = 'Block Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_owner_type` SET TAGS ('dbx_business_glossary_term' = 'Block Owner Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_owner_type` SET TAGS ('dbx_value_regex' = 'service|surgeon|specialty|department|open');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_start_time` SET TAGS ('dbx_business_glossary_term' = 'Block Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_status` SET TAGS ('dbx_business_glossary_term' = 'Block Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_status` SET TAGS ('dbx_value_regex' = 'active|suspended|cancelled|expired|pending');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_type` SET TAGS ('dbx_business_glossary_term' = 'Block Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `block_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|tertiary|open|flex|call');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `day_of_week` SET TAGS ('dbx_business_glossary_term' = 'Day of Week');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `equipment_set_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Set Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `minimum_utilization_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Minimum Utilization Threshold Percentage');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `priority_rank` SET TAGS ('dbx_business_glossary_term' = 'Priority Rank');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `recurring_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurring Pattern');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `release_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Release Lead Time Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `release_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Release Lead Time Hours');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `release_rule_type` SET TAGS ('dbx_business_glossary_term' = 'Release Rule Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `release_rule_type` SET TAGS ('dbx_value_regex' = 'days_before|hours_before|no_release|manual');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `staff_roles_required` SET TAGS ('dbx_business_glossary_term' = 'Staff Roles Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`or_block` ALTER COLUMN `target_utilization_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Utilization Threshold Percentage');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` SET TAGS ('dbx_subdomain' = 'surgical_operations');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Schedulable Resource Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `clinician_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `clinician_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Specialty Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_business_glossary_term' = 'Accepts New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `allows_overbooking` SET TAGS ('dbx_business_glossary_term' = 'Allows Overbooking Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `building` SET TAGS ('dbx_business_glossary_term' = 'Building Name or Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|ambulatory_surgery|home_health|telehealth');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Expiration Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended|revoked');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `default_slot_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Default Slot Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `floor` SET TAGS ('dbx_business_glossary_term' = 'Floor Number or Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_business_glossary_term' = 'Professional License Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_business_glossary_term' = 'License State');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `license_state` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `maintenance_window_end` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window End Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `maintenance_window_start` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `minimum_turnover_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Turnover Time in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('dbx_business_glossary_term' = 'National Provider Identifier (NPI)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `provider_type` SET TAGS ('dbx_business_glossary_term' = 'Provider Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_code` SET TAGS ('dbx_business_glossary_term' = 'Resource Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_business_glossary_term' = 'Resource Name');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'provider|room|equipment|care_team');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('dbx_business_glossary_term' = 'Room Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_capacity` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `room_configuration` SET TAGS ('dbx_business_glossary_term' = 'Room Configuration Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_constraints` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Constraints');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_value_regex' = 'active|inactive|maintenance|reserved|retired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `sterilization_cycle_required` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Cycle Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `sterilization_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Sterilization Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`schedulable_resource` ALTER COLUMN `unit` SET TAGS ('dbx_business_glossary_term' = 'Unit or Wing');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `waitlist_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `billing_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Coverage Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Care Plan Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `prior_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Claim Prior Authorization Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `cpt_code_id` SET TAGS ('dbx_business_glossary_term' = 'Cpt Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `demographics_id` SET TAGS ('dbx_business_glossary_term' = 'Demographics Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_business_glossary_term' = 'Diagnosis Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `diagnosis_id` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `eligibility_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `insurance_coverage_id` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `mpi_record_id` SET TAGS ('dbx_business_glossary_term' = 'Patient Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `patient_account_id` SET TAGS ('dbx_business_glossary_term' = 'Subject Enrollment Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Requested Provider Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `problem_id` SET TAGS ('dbx_business_glossary_term' = 'Problem Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `referral_order_id` SET TAGS ('dbx_business_glossary_term' = 'Referring Order Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `appointment_type_id` SET TAGS ('dbx_business_glossary_term' = 'Requested Appointment Type Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `scheduling_appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Appointment Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `specialty_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Scheduler User Identifier (ID)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `specialty_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `specialty_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `icd_code_id` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason Icd Code Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `authorization_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Authorization Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'outpatient|inpatient|emergency|ambulatory_surgery|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `created_datetime` SET TAGS ('dbx_business_glossary_term' = 'Created Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_number` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Number');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_status` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `entry_type` SET TAGS ('dbx_value_regex' = 'waitlist|referral_queue|order_based|recall|surgical_request|work_queue');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_datetime` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `estimated_wait_time_days` SET TAGS ('dbx_business_glossary_term' = 'Estimated Wait Time in Days');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `interpreter_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Interpreter Required Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `language_preference` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_modified_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_datetime` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_method` SET TAGS ('dbx_business_glossary_term' = 'Last Outreach Method');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `last_outreach_method` SET TAGS ('dbx_value_regex' = 'phone|email|sms|portal|mail');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Waitlist Entry Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `outreach_attempt_count` SET TAGS ('dbx_business_glossary_term' = 'Outreach Attempt Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Channel');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_contact_channel` SET TAGS ('dbx_value_regex' = 'phone|email|sms|portal|mail');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_days_of_week` SET TAGS ('dbx_business_glossary_term' = 'Preferred Days of Week');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_time_of_day` SET TAGS ('dbx_business_glossary_term' = 'Preferred Time of Day');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `preferred_time_of_day` SET TAGS ('dbx_value_regex' = 'morning|afternoon|evening|any');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `queue_entry_datetime` SET TAGS ('dbx_business_glossary_term' = 'Queue Entry Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `removal_datetime` SET TAGS ('dbx_business_glossary_term' = 'Removal Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `removal_reason` SET TAGS ('dbx_business_glossary_term' = 'Removal Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `scheduled_datetime` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `sla_target_datetime` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `specialty_required` SET TAGS ('dbx_business_glossary_term' = 'Specialty Required');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `telehealth_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Eligible Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `transportation_assistance_needed_flag` SET TAGS ('dbx_business_glossary_term' = 'Transportation Assistance Needed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `visit_reason` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`waitlist_entry` ALTER COLUMN `visit_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Visit Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` SET TAGS ('dbx_subdomain' = 'appointment_management');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `provider_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Availability ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `clinician_id` SET TAGS ('dbx_business_glossary_term' = 'Provider ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `group_id` SET TAGS ('dbx_business_glossary_term' = 'Group Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Provider Location Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `org_provider_id` SET TAGS ('dbx_business_glossary_term' = 'Org Provider Id (Foreign Key)');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `schedule_template_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Template ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `accepts_new_patients` SET TAGS ('dbx_business_glossary_term' = 'Accepts New Patients Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'active|cancelled|pending|expired');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_type` SET TAGS ('dbx_business_glossary_term' = 'Availability Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `availability_type` SET TAGS ('dbx_value_regex' = 'scheduled|on_call|blocked|vacation|cme|administrative');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `booked_appointments` SET TAGS ('dbx_business_glossary_term' = 'Booked Appointments Count');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_pii_person_data' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('dbx_business_glossary_term' = 'Care Setting');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `care_setting` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|emergency|surgical|telehealth|home_health');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `coverage_area` SET TAGS ('dbx_business_glossary_term' = 'Coverage Area');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `coverage_area` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_business_glossary_term' = 'Credentialing Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `credentialing_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|suspended');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration in Minutes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Availability End Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `insurance_type_accepted` SET TAGS ('dbx_business_glossary_term' = 'Insurance Type Accepted');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `max_appointments` SET TAGS ('dbx_business_glossary_term' = 'Maximum Appointments');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `on_call_type` SET TAGS ('dbx_business_glossary_term' = 'On-Call Type');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `on_call_type` SET TAGS ('dbx_value_regex' = 'primary|backup|home|hospital');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `overbooking_allowed` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Allowed Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `overbooking_limit` SET TAGS ('dbx_business_glossary_term' = 'Overbooking Limit');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `override_flag` SET TAGS ('dbx_business_glossary_term' = 'Override Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `patient_class` SET TAGS ('dbx_business_glossary_term' = 'Patient Class');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `patient_class` SET TAGS ('dbx_value_regex' = 'inpatient|outpatient|observation|emergency|surgical|same_day');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergency');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `privilege_code` SET TAGS ('dbx_business_glossary_term' = 'Clinical Privilege Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `recurrence_end_date` SET TAGS ('dbx_business_glossary_term' = 'Recurrence End Date');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_business_glossary_term' = 'Recurrence Pattern');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `recurrence_pattern` SET TAGS ('dbx_value_regex' = 'once|daily|weekly|biweekly|monthly');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Capacity');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `remaining_capacity` SET TAGS ('dbx_pii_category' = 'person_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `source_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Date and Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `telehealth_enabled` SET TAGS ('dbx_business_glossary_term' = 'Telehealth Enabled Flag');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `unavailability_reason` SET TAGS ('dbx_business_glossary_term' = 'Unavailability Reason');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`provider_availability` ALTER COLUMN `unavailability_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Unavailability Reason Code');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` SET TAGS ('dbx_subdomain' = 'surgical_operations');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` SET TAGS ('dbx_association_edges' = 'scheduling.surgical_case,scheduling.schedulable_resource');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `surgical_resource_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Resource Assignment ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `schedulable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Resource Assignment - Schedulable Resource Id');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `surgical_case_id` SET TAGS ('dbx_business_glossary_term' = 'Surgical Resource Assignment - Surgical Case Id');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `assignment_priority` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `modified_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `resource_role` SET TAGS ('dbx_business_glossary_term' = 'Resource Role');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `resource_status` SET TAGS ('dbx_business_glossary_term' = 'Resource Status');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `scheduled_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_healthcare_v1`.`scheduling`.`surgical_resource_assignment` ALTER COLUMN `substitution_reason` SET TAGS ('dbx_business_glossary_term' = 'Substitution Reason');
