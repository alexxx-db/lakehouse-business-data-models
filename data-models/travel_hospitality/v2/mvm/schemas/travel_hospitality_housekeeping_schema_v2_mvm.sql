-- Schema for Domain: housekeeping | Business: Travel_Hospitality | Version: v2_mvm
-- Generated on: 2026-06-27 02:37:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`housekeeping` COMMENT 'Room cleaning operations, maintenance scheduling, and service quality management. Manages room status transitions (dirty, clean, inspected, out-of-order), housekeeping assignments, cleaning schedules, quality inspections, linen and supply consumption, and maintenance request handoffs. Integrates with Oracle OPERA PMS for real-time room status updates. Tracks CPOR (Cost Per Occupied Room) for housekeeping labor and supplies.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` (
    `hk_assignment_id` BIGINT COMMENT 'Unique identifier for the housekeeping assignment record. Primary key.',
    `attendant_id` BIGINT COMMENT 'Identifier of the housekeeping attendant assigned to perform the work.',
    `benefit_entitlement_id` BIGINT COMMENT 'Foreign key linking to loyalty.benefit_entitlement. Business justification: Elite member benefit fulfillment tracking: when a loyalty benefit (e.g., complimentary turndown, room refresh, amenity delivery) triggers a housekeeping assignment, linking benefit_entitlement_id enab',
    `beo_id` BIGINT COMMENT 'Foreign key linking to event.beo. Business justification: The BEO (Banquet Event Order) is the primary operational document driving function space housekeeping setup — specifying setup_style, setup_time, and special_instructions. Linking hk_assignment direct',
    `function_space_id` BIGINT COMMENT 'Foreign key linking to event.function_space. Business justification: Function spaces require housekeeping assignments for event preparation, maintenance, and post-event restoration. Critical for scheduling attendants to specific event venues and tracking service delive',
    `hk_schedule_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_schedule. Business justification: Daily housekeeping assignments are created based on the master schedule. This links individual room assignments to the shift structure. Many assignments are part of one schedule (N:1). The shift col',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Housekeeping assignments for meeting room cleaning (pre-event setup, post-event turnover) are a core hotel operations process. hk_assignment requires a FK to meeting_space to schedule and track attend',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: Room attendants require guest profile data (VIP status, allergies, preferences) for personalized service delivery. Pre-service briefing process depends on profile link. hk_assignment has vip_indicator',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.property_facility. Business justification: Housekeeping attendant assignments for facility cleaning (pool deck, fitness center, spa) are a named hotel operations process. hk_assignment needs a FK to property_facility to track which attendant i',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the assignment is located.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Housekeeping assignments must link to active reservations to coordinate DND flags, preferred service times, VIP protocols, allergy flags, and guest-present status during room servicing. Essential for ',
    `room_id` BIGINT COMMENT 'Identifier of the specific room assigned for cleaning or service.',
    `special_request_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_special_request. Business justification: VIP and special request fulfillment is operationally managed through housekeeping assignments. Linking hk_assignment to reservation_special_request enables fulfillment status tracking, priority escala',
    `actual_end_time` TIMESTAMP COMMENT 'The actual timestamp when the attendant completed work on this assignment, captured from mobile device or PMS entry.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual timestamp when the attendant began work on this assignment, captured from mobile device or PMS entry.',
    `amenity_replenishment_flag` BOOLEAN COMMENT 'Indicates whether guest amenities (toiletries, coffee, water, etc.) were replenished during this assignment.',
    `assignment_date` DATE COMMENT 'The business date on which the housekeeping assignment is scheduled to be performed.',
    `assignment_number` STRING COMMENT 'Human-readable business identifier for the housekeeping assignment, typically formatted as property-date-sequence.',
    `assignment_type` STRING COMMENT 'The type of housekeeping service to be performed: stayover (occupied room refresh), departure (checkout cleaning), deep clean (thorough cleaning), turndown (evening service), VIP prep (special preparation), or inspection (quality check).. Valid values are `stayover|departure|deep_clean|turndown|vip_prep|inspection`',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the assignment was cancelled, if applicable (e.g., guest extended stay, room out of order, early checkout).',
    `completion_status` STRING COMMENT 'The current lifecycle status of the assignment: assigned (not yet started), in_progress (attendant working), completed (attendant finished), inspected (supervisor approved), rejected (failed inspection), or cancelled (assignment voided).. Valid values are `assigned|in_progress|completed|inspected|rejected|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this assignment record was first created in the system.',
    `dnd_flag` BOOLEAN COMMENT 'Indicates whether the guest has activated the Do Not Disturb indicator at the time of assignment. True if DND is active; attendant should skip or defer service.',
    `estimated_end_time` TIMESTAMP COMMENT 'The planned timestamp when the attendant is expected to complete work on this assignment.',
    `estimated_start_time` TIMESTAMP COMMENT 'The planned timestamp when the attendant is expected to begin work on this assignment.',
    `inspection_notes` STRING COMMENT 'Free-text notes from the inspector documenting quality issues, deficiencies, or commendations observed during inspection.',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this assignment requires supervisor or quality assurance inspection before the room can be released to clean status.',
    `inspection_result` STRING COMMENT 'The outcome of the quality inspection: passed (meets standards), failed (requires rework), or conditional (minor issues noted but room released).. Valid values are `passed|failed|conditional`',
    `inspection_timestamp` TIMESTAMP COMMENT 'The timestamp when the quality inspection was completed by the supervisor or inspector.',
    `linen_change_flag` BOOLEAN COMMENT 'Indicates whether a full linen change (sheets, pillowcases, duvet covers) was performed during this assignment.',
    `maintenance_request_description` STRING COMMENT 'Free-text description of the maintenance issue identified by the attendant (e.g., leaking faucet, broken lamp, HVAC not cooling).',
    `maintenance_request_flag` BOOLEAN COMMENT 'Indicates whether the attendant identified a maintenance issue during service that requires a work order handoff to the maintenance department.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this assignment record was last modified in the system.',
    `preferred_service_time` TIMESTAMP COMMENT 'Guest-requested time window for housekeeping service (e.g., after 2pm, morning only), captured from guest profile or front desk communication.',
    `priority_level` STRING COMMENT 'The urgency level of the assignment: urgent (immediate attention required), high (priority guest or early arrival), normal (standard schedule), or low (can be deferred).. Valid values are `urgent|high|normal|low`',
    `reassignment_count` STRING COMMENT 'The number of times this assignment has been reassigned to a different attendant, indicating scheduling changes or workload rebalancing.',
    `room_credits` DECIMAL(18,2) COMMENT 'The number of room credits assigned to this task for productivity tracking and labor allocation. Standard departure cleaning typically equals 1.0 credit; stayovers may be 0.5; deep cleans may be 1.5-2.0.',
    `room_status_after` STRING COMMENT 'The room status after the attendant completes the assignment and updates the system.. Valid values are `dirty|clean|inspected|pickup|out_of_order|out_of_service`',
    `room_status_before` STRING COMMENT 'The room status at the time the assignment was created, before the attendant begins work.. Valid values are `dirty|clean|inspected|pickup|out_of_order|out_of_service`',
    `special_cleaning_code` STRING COMMENT 'Code indicating special cleaning protocols applied (e.g., COVID-19, biohazard, pet cleanup, smoke remediation).',
    `towel_change_flag` BOOLEAN COMMENT 'Indicates whether towels were replaced during this assignment.',
    CONSTRAINT pk_hk_assignment PRIMARY KEY(`hk_assignment_id`)
) COMMENT 'Transactional record of daily housekeeping work assignments, mapping attendants to specific rooms for a given shift. Captures assignment type (stayover, departure, deep clean, turndown, VIP prep), priority level, estimated and actual start/end times, room credits, completion status, and any guest preference instructions (DND, preferred time, allergy flags). Sourced from OPERA PMS housekeeping module. Serves as the primary labor allocation record for CPOR calculation and attendant productivity tracking.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` (
    `cleaning_task_id` BIGINT COMMENT 'Unique identifier for the cleaning task. Primary key.',
    `attendant_id` BIGINT COMMENT 'Reference to the housekeeping attendant assigned to perform this task.',
    `function_space_id` BIGINT COMMENT 'Foreign key linking to event.function_space. Business justification: Function spaces generate recurring cleaning tasks based on event schedules, usage intensity, and space type. Essential for task scheduling, labor allocation, and ensuring spaces meet cleanliness stand',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Cleaning tasks are granular work items performed within the context of a housekeeping assignment. The assignment is the work order; tasks are the line items. This link enables tracking of task-level p',
    `hk_schedule_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_schedule. Business justification: Cleaning tasks are performed during specific housekeeping shifts/schedules. This links operational task execution to the master schedule. Many cleaning tasks occur during one schedule (N:1). No bidire',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Meeting room turnover cleaning is a named housekeeping process in hotels. cleaning_task needs a FK to meeting_space to track pre/post-event and routine cleaning assignments for meeting rooms, distinct',
    `preference_id` BIGINT COMMENT 'Foreign key linking to guest.preference. Business justification: Preference Fulfillment Tracking per Cleaning Task: operational report linking each executed cleaning task to the guest preference record it fulfills (e.g., allergy-safe cleaning, specific schedule). E',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.property_facility. Business justification: Cleaning tasks for hotel facilities (pool, gym, spa, lobby) are a core housekeeping operational process. cleaning_task needs a FK to property_facility to schedule and track cleaning assignments for no',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where this cleaning task is performed.',
    `room_assignment_id` BIGINT COMMENT 'Reference to the parent housekeeping room assignment that contains this task.',
    `room_id` BIGINT COMMENT 'Reference to the specific room being cleaned.',
    `special_request_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_special_request. Business justification: Reservation special requests (hypoallergenic bedding, extra towels, accessibility setup) directly generate specific cleaning tasks. This link enables fulfillment tracking, SLA compliance reporting on ',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Post-treatment turnaround cleaning tasks are assigned per spa treatment room to meet appointment scheduling SLAs. Linking cleaning_task to treatment_room enables spa operations to track room-ready sta',
    `actual_end_time` TIMESTAMP COMMENT 'Actual timestamp when the attendant completed or stopped performing this task.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual timestamp when the attendant began performing this task, captured from mobile device or PMS entry.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cleaning task record was first created in the system.',
    `credit_weight` DECIMAL(18,2) COMMENT 'Numeric credit value assigned to this task contributing to the attendants total room credits for workload balancing and productivity tracking.',
    `duration_minutes` STRING COMMENT 'Total time spent performing this task in minutes, calculated from actual start and end times or manually entered.',
    `exception_flag` BOOLEAN COMMENT 'Indicates whether this task encountered an exception condition requiring supervisor attention or follow-up action.',
    `exception_notes` STRING COMMENT 'Free-text notes describing any exceptions, issues, or special circumstances encountered during task execution.',
    `guest_present` BOOLEAN COMMENT 'Indicates whether the guest was present in the room during task execution, affecting service approach and privacy considerations.',
    `guest_request_flag` BOOLEAN COMMENT 'Indicates whether this task was performed in response to a specific guest request rather than standard cleaning schedule.',
    `inspection_required` BOOLEAN COMMENT 'Indicates whether this task requires formal inspection by a supervisor or quality control team member.',
    `inspection_timestamp` TIMESTAMP COMMENT 'Timestamp when the task was inspected and quality verified.',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this task is required for the room to be marked as clean and ready for guest occupancy.',
    `is_quality_checkpoint` BOOLEAN COMMENT 'Indicates whether this task requires supervisor inspection or quality verification before the room can be released.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cleaning task record was last updated, used for audit trail and data synchronization.',
    `maintenance_request_generated` BOOLEAN COMMENT 'Indicates whether this task resulted in a maintenance request being created for repair or follow-up work.',
    `quality_score` STRING COMMENT 'Numeric quality rating assigned to this task during inspection, typically on a scale of 1-5 or 1-10, used for attendant performance evaluation.',
    `room_type_code` STRING COMMENT 'Code identifying the room type (e.g., KING, QUEEN, SUITE, DELUXE) which determines the applicable cleaning standard and task list.. Valid values are `^[A-Z0-9]{2,6}$`',
    `scheduled_start_time` TIMESTAMP COMMENT 'Planned timestamp when the task should begin based on the room assignment schedule.',
    `service_type` STRING COMMENT 'Type of room service being performed which determines the scope and depth of cleaning tasks required.. Valid values are `checkout|stayover|arrival|deep_clean|turndown|refresh`',
    `skip_reason_code` STRING COMMENT 'Standardized code indicating why the task was skipped or not completed (e.g., REFUSE for guest refused service, UNAVAIL for item unavailable, MAINT for maintenance required, DND for do not disturb).. Valid values are `^[A-Z0-9]{2,6}$`',
    `skip_reason_description` STRING COMMENT 'Detailed explanation of why the task was skipped, providing context for exception reporting and service recovery.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether this task was completed within the defined SLA target time, used for performance reporting and operational KPI tracking.',
    `sla_target_minutes` STRING COMMENT 'Target time in minutes for completing this task per the propertys service level agreement and room turnaround time standards.',
    `standard_duration_minutes` STRING COMMENT 'Expected time in minutes to complete this task per the cleaning standard, used for performance benchmarking and labor planning.',
    `supply_item_code` STRING COMMENT 'Code identifying the primary supply or consumable item used in this task (e.g., cleaning chemical, linen type, amenity SKU).. Valid values are `^[A-Z0-9]{2,10}$`',
    `supply_quantity_used` DECIMAL(18,2) COMMENT 'Quantity of the supply item consumed during this task, used for inventory tracking and CPOR (Cost Per Occupied Room) calculation.',
    `supply_unit_of_measure` STRING COMMENT 'Unit of measure for the supply quantity used (e.g., each, bottle, sheet, towel, roll, ounce, liter, set). [ENUM-REF-CANDIDATE: each|bottle|sheet|towel|roll|ounce|liter|set — 8 candidates stripped; promote to reference product]',
    `task_code` STRING COMMENT 'Standardized code identifying the type of cleaning task (e.g., BED for bed making, BATH for bathroom sanitization, VAC for vacuuming, LINEN for linen change, MINI for minibar restock, AMEN for amenity placement).. Valid values are `^[A-Z0-9]{2,10}$`',
    `task_name` STRING COMMENT 'Human-readable name of the cleaning task (e.g., Bed Making, Bathroom Sanitization, Vacuuming, Linen Change, Minibar Restock, Amenity Placement).',
    `task_priority` STRING COMMENT 'Priority level assigned to this task based on guest arrival time, room status urgency, or special requests.. Valid values are `standard|high|urgent|rush`',
    `task_sequence` STRING COMMENT 'Order in which this task should be performed within the room assignment per the cleaning standard operating procedure.',
    `task_status` STRING COMMENT 'Current completion status of the cleaning task within its lifecycle.. Valid values are `pending|in_progress|completed|skipped|failed|exception`',
    `task_type` STRING COMMENT 'Category of the cleaning task indicating the nature of work performed.. Valid values are `cleaning|sanitization|restocking|inspection|maintenance_prep|turndown`',
    `training_indicator` BOOLEAN COMMENT 'Indicates whether this task was performed as part of attendant training or onboarding, affecting performance evaluation and quality expectations.',
    CONSTRAINT pk_cleaning_task PRIMARY KEY(`cleaning_task_id`)
) COMMENT 'Granular operational record of individual cleaning tasks performed within a room assignment, including task type (bed making, bathroom sanitization, vacuuming, linen change, minibar restock, amenity placement), task sequence per cleaning standard, completion status, time spent (minutes), supplies consumed with quantities, and any exceptions or skip reasons (guest refused, item unavailable, maintenance required). Each task carries a credit weight contributing to the assignments total room credits. Enables quality control tracking, SLA compliance for room turnaround time standards, and provides task-level data for attendant training, performance coaching, and cleaning standard refinement.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` (
    `inspection_id` BIGINT COMMENT 'Unique identifier for the quality inspection record. Primary key for the inspection entity.',
    `attendant_id` BIGINT COMMENT 'Reference to the housekeeper who cleaned the room prior to this inspection. Links to workforce/employee master data for performance tracking.',
    `function_space_id` BIGINT COMMENT 'Foreign key linking to event.function_space. Business justification: Function spaces require quality inspections before event release and after cleaning completion. Essential for quality assurance, deficiency tracking, and ensuring spaces meet brand standards before hi',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Inspections verify the quality of work completed in housekeeping assignments. Linking inspection to the assignment that triggered it enables quality tracking per attendant and assignment, supports per',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Pre-event and post-cleaning QA inspections of meeting spaces are a named hotel operations process. inspection needs a FK to meeting_space to record cleanliness scores, deficiency counts, and release s',
    `property_id` BIGINT COMMENT 'Reference to the property where the inspection occurred. Links to the property master data.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Pre-arrival inspections must link to incoming reservations to verify room readiness against guest arrival time, VIP status, and special requests. Critical for room release workflow and ensuring room m',
    `room_assignment_id` BIGINT COMMENT 'Foreign key linking to reservation.room_assignment. Business justification: Pre-arrival and post-departure room readiness inspections must be tied to the specific room assignment to confirm the correct room is cleared and ready for the assigned guest. Operations teams use thi',
    `room_id` BIGINT COMMENT 'Reference to the specific room that was inspected. Links to the room inventory master data.',
    `amenity_check_flag` BOOLEAN COMMENT 'Boolean indicator whether the inspector verified that all required room amenities are present and properly stocked (toiletries, linens, coffee supplies, etc.).',
    `bathroom_quality_flag` BOOLEAN COMMENT 'Boolean indicator whether the bathroom meets cleanliness and quality standards, including fixtures, surfaces, and amenities, a critical GSS (Guest Satisfaction Score) driver.',
    `cleanliness_score` DECIMAL(18,2) COMMENT 'Sub-score specifically measuring cleanliness standards (surfaces, bathroom, floors, linens), a key component of overall quality score and GSS (Guest Satisfaction Score).',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this inspection record was first created in the system, used for audit trail and data lineage tracking.',
    `critical_deficiency_count` STRING COMMENT 'Number of critical deficiencies identified that directly impact guest safety or satisfaction (e.g., cleanliness issues, safety hazards), requiring immediate remediation.',
    `deficiency_count` STRING COMMENT 'Total number of deficiency items or quality issues identified during the inspection, used for quality scoring and housekeeper performance evaluation.',
    `deficiency_description` STRING COMMENT 'Detailed free-text description of all deficiencies and quality issues identified during the inspection, used for corrective action and training purposes.',
    `duration_minutes` STRING COMMENT 'Total time in minutes spent conducting the inspection, calculated from start to end timestamps, used for labor productivity analysis and CPOR (Cost Per Occupied Room) calculations.',
    `end_timestamp` TIMESTAMP COMMENT 'The actual date and time when the inspector completed the room inspection, used for duration calculation and productivity tracking.',
    `guest_arrival_date` DATE COMMENT 'The scheduled arrival date of the next guest for this room, used to prioritize inspection urgency and ensure room readiness for check-in.',
    `inspection_number` STRING COMMENT 'Human-readable business identifier for the inspection, typically formatted as property code, date, and sequence number for operational tracking and reference.',
    `inspection_status` STRING COMMENT 'Current lifecycle state of the inspection: scheduled (assigned but not started), in_progress (inspector actively reviewing), completed (inspection finished and passed), failed (deficiencies found requiring re-clean), or cancelled (inspection voided).. Valid values are `scheduled|in_progress|completed|failed|cancelled`',
    `inspection_type` STRING COMMENT 'Classification of the inspection based on its purpose: routine (standard post-cleaning check), deep_clean (periodic thorough inspection), turndown (evening service check), checkout (post-guest departure), maintenance_follow_up (verification after repair), or quality_audit (supervisory quality control).. Valid values are `routine|deep_clean|turndown|checkout|maintenance_follow_up|quality_audit`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this inspection record was last updated, used for audit trail and change tracking.',
    `linen_quality_flag` BOOLEAN COMMENT 'Boolean indicator whether linens (sheets, towels, pillowcases) meet quality standards with no stains, tears, or wear, critical for guest satisfaction.',
    `maintenance_issue_flag` BOOLEAN COMMENT 'Boolean indicator whether maintenance issues were identified during the inspection that require handoff to the maintenance department (e.g., broken fixtures, HVAC problems, plumbing issues).',
    `notes` STRING COMMENT 'Additional free-text notes and observations recorded by the inspector, including positive feedback, special conditions, or contextual information for operational reference.',
    `outcome` STRING COMMENT 'Final result of the inspection: pass (room meets quality standards and is released), fail (room requires re-clean), or conditional_pass (minor issues noted but room released with follow-up required).. Valid values are `pass|fail|conditional_pass`',
    `priority_level` STRING COMMENT 'Priority classification for the inspection based on guest arrival time, room type, and operational needs: urgent (VIP or immediate check-in), high (same-day arrival), normal (next-day arrival), or low (future availability).. Valid values are `urgent|high|normal|low`',
    `quality_score` DECIMAL(18,2) COMMENT 'Numerical quality score assigned to the room based on inspection criteria, typically on a 0-100 scale, used for GSS (Guest Satisfaction Score) correlation and housekeeper performance tracking.',
    `reclean_required_flag` BOOLEAN COMMENT 'Boolean indicator whether the room requires re-cleaning due to deficiencies identified during inspection. True indicates the room failed inspection and must be re-cleaned before guest occupancy.',
    `room_release_flag` BOOLEAN COMMENT 'Boolean indicator whether the room has been formally released as inspected and made available for guest check-in. True indicates the room is ready for sale and occupancy.',
    `room_release_timestamp` TIMESTAMP COMMENT 'The precise date and time when the room was released as inspected and made available for guest occupancy, critical for RevPAR (Revenue Per Available Room) and inventory availability tracking.',
    `room_status_after` STRING COMMENT 'The room status set after the inspection is completed, typically inspected (if passed) or dirty (if failed and requires re-clean), critical for PMS (Property Management System) room availability updates.. Valid values are `dirty|clean|inspected|occupied|out_of_order|out_of_service`',
    `room_status_before` STRING COMMENT 'The room status immediately prior to the inspection, typically clean (post-housekeeping) or dirty (pre-cleaning), used for status transition tracking and operational workflow validation.. Valid values are `dirty|clean|inspected|occupied|out_of_order|out_of_service`',
    `scheduled_date` DATE COMMENT 'The date on which the inspection was scheduled to occur, used for planning and workload management.',
    `scheduled_time` TIMESTAMP COMMENT 'The precise date and time when the inspection was scheduled to begin, enabling time-based operational coordination.',
    `special_request_notes` STRING COMMENT 'Free-text notes capturing any special guest requests or room preparation requirements that the inspector must verify (e.g., hypoallergenic bedding, extra amenities, accessibility features).',
    `start_timestamp` TIMESTAMP COMMENT 'The actual date and time when the inspector began the room inspection, used for duration calculation and operational analytics.',
    `vip_flag` BOOLEAN COMMENT 'Boolean indicator whether this inspection is for a room assigned to a VIP guest, requiring enhanced quality standards and expedited inspection processing.',
    CONSTRAINT pk_inspection PRIMARY KEY(`inspection_id`)
) COMMENT 'Quality inspection record capturing the formal review of a cleaned room by a housekeeping supervisor or inspector before the room is released as inspected and made available for guest check-in. Records inspection outcome (pass/fail), deficiency items identified, re-clean required flag, inspector identity, inspection timestamp, and final room release status. Critical for GSS (Guest Satisfaction Score) and service quality management.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` (
    `hk_schedule_id` BIGINT COMMENT 'Unique identifier for the housekeeping schedule record. Primary key.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to revenue.revenue_budget. Business justification: Annual revenue budgeting sets CPOR (Cost Per Occupied Room) targets that directly govern hk_schedule.cpor_target and labor_budget_amount. Hotel controllers and revenue managers align housekeeping labo',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property to which this housekeeping schedule applies.',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: HK schedules for spa-dedicated cleaning staff must reference the spa facility to enable labor budgeting, headcount planning, and CPOR tracking specific to the spa operation. Spa facilities have distin',
    `assignment_method` STRING COMMENT 'The method used to assign sections to attendants for this schedule (seniority bidding, rotation, manager assignment, or fixed assignment).. Valid values are `seniority_bidding|rotation|manager_assignment|fixed`',
    `break_duration_minutes` STRING COMMENT 'The length of the scheduled break in minutes. Nullable if no break is scheduled.',
    `break_start_time` TIMESTAMP COMMENT 'The scheduled start time for the break window during the shift. Nullable if no formal break is scheduled.',
    `consecutive_days_worked` STRING COMMENT 'The number of consecutive days worked by attendants assigned to this schedule, tracked for union CBA compliance (maximum consecutive days before mandatory rest).',
    `cpor_target` DECIMAL(18,2) COMMENT 'The target Cost Per Occupied Room for housekeeping labor and supplies for this schedule, used for performance tracking and labor planning.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this housekeeping schedule record was first created in the system.',
    `labor_budget_amount` DECIMAL(18,2) COMMENT 'The budgeted labor cost for this shift in the propertys operating currency, aligned to CPOR (Cost Per Occupied Room) targets.',
    `modified_timestamp` TIMESTAMP COMMENT 'The date and time when this housekeeping schedule record was last modified.',
    `notes` STRING COMMENT 'Free-text notes or special instructions related to this housekeeping schedule (e.g., VIP arrivals, special events, maintenance windows).',
    `occupancy_forecast_tier` STRING COMMENT 'The forecasted occupancy level tier for the schedule date, used to calibrate staffing levels (low, medium, high, peak).. Valid values are `low|medium|high|peak`',
    `overtime_threshold_hours` DECIMAL(18,2) COMMENT 'The number of hours beyond which overtime pay applies for attendants on this shift, per union CBA or local labor law.',
    `pip_compliance_flag` BOOLEAN COMMENT 'Indicates whether this schedule meets Property Improvement Plan (PIP) staffing requirements (True if compliant, False otherwise).',
    `planned_headcount` STRING COMMENT 'The number of housekeeping attendants planned to work during this shift, calibrated to occupancy forecast and room count.',
    `published_timestamp` TIMESTAMP COMMENT 'The date and time when the schedule was published and made available to housekeeping staff. Nullable if not yet published.',
    `schedule_date` DATE COMMENT 'The specific date for which this housekeeping schedule is defined. Used for daily operational planning.',
    `schedule_status` STRING COMMENT 'The current lifecycle status of the housekeeping schedule (draft, published, active, completed, or cancelled).. Valid values are `draft|published|active|completed|cancelled`',
    `section_code` STRING COMMENT 'The housekeeping section or zone code assigned for this schedule (e.g., floor grouping, wing, building). Used for section-to-attendant assignment.',
    `section_credit_value` DECIMAL(18,2) COMMENT 'The total credit value assigned to the section, representing the workload complexity (e.g., suite rooms may have higher credit values than standard rooms).',
    `section_room_count` STRING COMMENT 'The total number of rooms in the assigned housekeeping section.',
    `shift_end_time` TIMESTAMP COMMENT 'The scheduled end time for the housekeeping shift on the schedule date.',
    `shift_start_time` TIMESTAMP COMMENT 'The scheduled start time for the housekeeping shift on the schedule date.',
    `shift_type` STRING COMMENT 'The type of housekeeping shift being scheduled (AM morning shift, PM afternoon shift, overnight night shift, or split shift).. Valid values are `AM|PM|overnight|split`',
    `turndown_end_time` TIMESTAMP COMMENT 'The scheduled end time for turndown service during this shift. Nullable if turndown service is not scheduled.',
    `turndown_service_flag` BOOLEAN COMMENT 'Indicates whether turndown service is scheduled for this shift (True if turndown service is included, False otherwise).',
    `turndown_start_time` TIMESTAMP COMMENT 'The scheduled start time for turndown service during this shift. Nullable if turndown service is not scheduled.',
    CONSTRAINT pk_hk_schedule PRIMARY KEY(`hk_schedule_id`)
) COMMENT 'Master record of housekeeping operational scheduling at the property level, defining daily shift structures (AM/PM/overnight with start/end times and break windows), weekly section-to-attendant assignments (based on seniority bidding or rotation), and staffing levels calibrated to occupancy forecast tiers. Captures planned headcount per shift, section configurations (floor/zone groupings with room counts and credit values), turndown service windows, and shift-level labor budgets aligned to CPOR targets. Used for labor planning, union CBA scheduling compliance (consecutive days, overtime thresholds), and PIP staffing requirements. Deep clean rotation scheduling is managed separately in deep_clean_plan.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` (
    `attendant_id` BIGINT COMMENT 'Unique identifier for the housekeeping attendant record. Primary key for the attendant entity in the housekeeping domain.',
    `property_id` BIGINT COMMENT 'Reference to the property where this attendant is primarily assigned. Supports multi-property workforce management.',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: Spa-dedicated housekeeping attendants are assigned to a specific spa facility for scheduling, performance tracking, and labor cost allocation. Formalizing this FK enables spa-specific staffing reports',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this attendant record is currently active and available for scheduling and room assignments. Inactive records are retained for historical reporting but excluded from operational workflows.',
    `ada_accommodation_flag` BOOLEAN COMMENT 'Indicates whether the attendant has an approved reasonable accommodation under the Americans with Disabilities Act. Accommodations may include modified duty assignments, assistive equipment, or adjusted productivity targets. Details of specific accommodations are maintained in confidential HR records.',
    `attendance_points` STRING COMMENT 'Current attendance point balance under the propertys attendance policy. Points are typically assigned for absences, tardiness, and early departures, with progressive discipline triggered at defined thresholds. Points may expire after a rolling period (e.g., 12 months).',
    `average_credits_per_shift` DECIMAL(18,2) COMMENT 'Rolling average of actual room credits completed per shift over the most recent evaluation period (typically 30 or 90 days). Used to track individual productivity trends and identify training needs or performance issues.',
    `attendant_code` STRING COMMENT 'Business identifier for the attendant used in daily operations, room assignment sheets, and housekeeping reports. Typically a short alphanumeric code displayed on badges and mobile devices.. Valid values are `^[A-Z0-9]{4,12}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this attendant record was first created in the housekeeping system. Used for audit trail and data lineage tracking.',
    `emergency_contact_name` STRING COMMENT 'Name of the person to contact in case of workplace emergency or injury. Maintained for employee safety and OSHA compliance.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact person. Critical for rapid communication in case of workplace accidents or medical emergencies.',
    `employment_status` STRING COMMENT 'Current employment lifecycle status of the attendant. Active attendants are available for scheduling. On-leave includes FMLA, medical, and personal leave. Seasonal workers are employed during peak periods. Probationary status applies to new hires during their initial evaluation period.. Valid values are `active|on_leave|suspended|terminated|seasonal|probationary`',
    `hire_date` DATE COMMENT 'Date the attendant was hired into the housekeeping department. Used to calculate seniority for union section bidding, vacation accrual, and tenure-based benefits.',
    `language_skills` STRING COMMENT 'Comma-separated list of languages the attendant can speak and understand. Important for guest interaction, safety communication, and team coordination in multilingual properties. Format: ISO 639-1 language codes (e.g., en,es,fr).',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review. Most properties conduct annual or semi-annual reviews aligned with merit increase cycles.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this attendant record was most recently modified. Tracks the recency of data for change data capture and incremental processing.',
    `locker_number` STRING COMMENT 'Assigned locker number in the employee locker room where the attendant stores personal belongings, uniform, and equipment during their shift.',
    `mobile_device_code` STRING COMMENT 'Identifier of the mobile device (smartphone or tablet) assigned to the attendant for receiving room assignments, updating room status, reporting maintenance issues, and communicating with supervisors. Integrates with property management system mobile housekeeping applications.',
    `notes` STRING COMMENT 'Free-text field for operational notes about the attendant, such as special skills, assignment preferences, equipment needs, or temporary restrictions. Used by supervisors for day-to-day workforce management.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating for the attendant. Based on quality inspections, productivity metrics, guest feedback, attendance, and adherence to standards. Used for merit increases, promotion decisions, and performance improvement plans.. Valid values are `exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated`',
    `role_type` STRING COMMENT 'Primary housekeeping role classification. Determines work assignment types, productivity benchmarks, and labor cost allocation. Room attendants clean guest rooms, turndown attendants provide evening service, house persons handle heavy cleaning and linen transport, supervisors oversee sections, inspectors perform quality checks, and public area cleaners maintain lobbies and common spaces.. Valid values are `room_attendant|turndown_attendant|house_person|supervisor|inspector|public_area_cleaner`',
    `section_assignment` STRING COMMENT 'Current section or floor assignment within the property. Sections are typically organized by floor, wing, or building. Section assignments may be permanent (based on seniority bidding) or rotational.',
    `seniority_date` DATE COMMENT 'Date used for calculating seniority ranking within the housekeeping department. May differ from hire date due to transfers, breaks in service, or union contract provisions. Critical for section bidding rights and shift preference allocation.',
    `shift_assignment` STRING COMMENT 'Current shift assignment for the attendant. AM shift typically covers morning checkout cleaning, PM shift handles afternoon turnovers and turndown service, night shift performs deep cleaning and public area maintenance. Split shifts cover peak periods. On-call attendants fill in for absences.. Valid values are `am_shift|pm_shift|night_shift|split_shift|on_call|rotating`',
    `target_credits_per_shift` DECIMAL(18,2) COMMENT 'Productivity benchmark expressed as the target number of room credits the attendant should complete per shift. Room credits vary by room type: standard rooms = 1.0 credit, suites = 1.5-2.0 credits, checkout rooms = 1.2 credits, stayover rooms = 0.7 credits. Used for performance evaluation and labor cost per occupied room (CPOR) calculation.',
    `termination_date` DATE COMMENT 'Date the attendants employment ended. Null for active employees. Used for historical workforce analysis and rehire eligibility determination.',
    `uniform_size` STRING COMMENT 'Uniform size for the attendant used for ordering and inventory management of housekeeping uniforms. Format varies by property (e.g., S/M/L/XL or numeric sizing).',
    `union_classification` STRING COMMENT 'Union job classification code as defined in the collective bargaining agreement. Determines pay grade, work rules, and assignment restrictions. Examples include classifications for different room types, shift differentials, and specialized duties.',
    `union_member_flag` BOOLEAN COMMENT 'Indicates whether the attendant is a member of a labor union. Determines applicability of collective bargaining agreement provisions, grievance procedures, and union-specific benefits.',
    CONSTRAINT pk_attendant PRIMARY KEY(`attendant_id`)
) COMMENT 'Housekeeping-domain operational profile of a room attendant or housekeeping staff member, capturing their role (room attendant, turndown attendant, house person, supervisor, inspector, public area cleaner), section certifications (suite-qualified, VIP-certified), language skills, productivity benchmarks (target credits per shift by room type mix), seniority date for union section bidding, union membership status and CBA classification, training completion records for chemical handling and blood-borne pathogen protocols, and current shift assignment status. This is a domain-specific operational view — the full employee master record (payroll, benefits, personal details) is owned by the workforce domain.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` (
    `lost_and_found_id` BIGINT COMMENT 'Unique identifier for the lost and found record. Primary key.',
    `appointment_id` BIGINT COMMENT 'Foreign key linking to spa.appointment. Business justification: Items found in spa treatment rooms or locker areas are linked to the specific appointment during which they were lost, enabling precise guest notification, claim processing, and liability tracking for',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Guests leave personal items in F&B outlets (restaurants, bars, banquet halls). Housekeeping and F&B staff log these with the specific outlet as discovery location for guest retrieval and liability tra',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Lost and found items are discovered during specific housekeeping assignments. This links item discovery to the operational context (who found it, when, during which room service). Many lost items can ',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Lost items discovered in meeting rooms during post-event cleaning are a common hotel operations scenario. lost_and_found needs a FK to meeting_space to properly record discovery location, enabling acc',
    `profile_id` BIGINT COMMENT 'Identifier of the guest associated with the room or area where the item was found, if known.',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.property_facility. Business justification: Lost items found in hotel facilities (pool, gym, spa, restaurant) during cleaning are a common operational scenario. lost_and_found needs a FK to property_facility to precisely record discovery locati',
    `property_id` BIGINT COMMENT 'Identifier of the property where the item was discovered.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Items found during an active stay must link to the current reservation booking for real-time guest notification and claim processing. The existing stay_history_id covers historical stays only; active-',
    `room_id` BIGINT COMMENT 'Identifier of the specific room where the item was found, if applicable.',
    `stay_history_id` BIGINT COMMENT 'Foreign key linking to guest.stay_history. Business justification: Items found during specific stays need stay context for accurate guest notification, claim validation, and shipping coordination. Lost item recovery workflow depends on stay-level detail (dates, room,',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Items found in spa treatment rooms must reference the specific treatment room for precise discovery location tracking, storage assignment, and guest claim processing. Existing room_id targets hotel gu',
    `claim_date` DATE COMMENT 'Date when the item was claimed by the guest or authorized party.',
    `claim_status` STRING COMMENT 'Status of the claim process indicating whether the item has been claimed by a guest or remains unclaimed.. Valid values are `unclaimed|claim_pending|claimed|claim_denied`',
    `claimant_identification_number` STRING COMMENT 'Identification document number presented by the claimant for audit trail and verification.',
    `claimant_identification_type` STRING COMMENT 'Type of identification document presented by the claimant for verification purposes.. Valid values are `drivers_license|passport|national_id|employee_badge|other`',
    `claimant_name` STRING COMMENT 'Full name of the person who claimed the item, which may differ from the original guest if authorized representative.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this lost and found record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated value amount.. Valid values are `^[A-Z]{3}$`',
    `discovery_date` DATE COMMENT 'Date when the item was discovered by staff.',
    `discovery_location_detail` STRING COMMENT 'Specific location details within the location type (e.g., under bed, in closet, on table) to aid in verification during claim process.',
    `discovery_location_type` STRING COMMENT 'Type of location where the item was discovered. [ENUM-REF-CANDIDATE: guest_room|public_area|restaurant|meeting_room|fitness_center|pool|parking|lobby|other — 9 candidates stripped; promote to reference product]',
    `discovery_timestamp` TIMESTAMP COMMENT 'Precise date and time when the item was discovered and logged into the lost and found system.',
    `disposition_date` DATE COMMENT 'Date when the final disposition action was completed.',
    `disposition_notes` STRING COMMENT 'Additional notes regarding the disposition action including recipient organization for donations or authority contact for turned-over items.',
    `disposition_type` STRING COMMENT 'Final disposition action taken for the item after the retention period or claim resolution.. Valid values are `returned_to_guest|donated|discarded|turned_over_to_authorities|shipped_to_guest|pending`',
    `estimated_value_amount` DECIMAL(18,2) COMMENT 'Estimated monetary value of the item in the propertys base currency for liability and insurance purposes.',
    `guest_notification_date` DATE COMMENT 'Date when the guest was successfully notified about the found item.',
    `guest_notification_method` STRING COMMENT 'Communication channel used to notify the guest about the found item.. Valid values are `email|phone|sms|mail|in_person`',
    `guest_notification_status` STRING COMMENT 'Status of attempts to notify the guest about the discovered item.. Valid values are `not_attempted|attempted|notified|unable_to_contact`',
    `is_high_value_item` BOOLEAN COMMENT 'Flag indicating whether the item exceeds the propertys high-value threshold requiring special handling and management approval.',
    `item_brand` STRING COMMENT 'Brand or manufacturer name of the item, if identifiable.',
    `item_category` STRING COMMENT 'High-level classification of the lost item type for inventory and reporting purposes. [ENUM-REF-CANDIDATE: electronics|jewelry|clothing|documents|keys|wallet|luggage|personal_care|other — 9 candidates stripped; promote to reference product]',
    `item_color` STRING COMMENT 'Primary color of the item for identification purposes.',
    `item_description` STRING COMMENT 'Detailed textual description of the lost item including brand, color, size, distinguishing features, and condition at time of discovery.',
    `item_number` STRING COMMENT 'Externally-visible unique tracking number assigned to the lost and found item for guest reference and claim processing.. Valid values are `^LF-[0-9]{8}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this lost and found record was last updated.',
    `lost_and_found_status` STRING COMMENT 'Current lifecycle status of the lost and found item tracking its progression from discovery through final disposition. [ENUM-REF-CANDIDATE: logged|guest_notified|claimed|pending_disposition|returned_to_guest|donated|discarded|turned_over_to_authorities — 8 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'General notes and comments regarding the item, discovery circumstances, guest interactions, or special considerations.',
    `photo_url` STRING COMMENT 'URL or file path to photograph of the item for identification and verification purposes.',
    `requires_special_handling` BOOLEAN COMMENT 'Flag indicating whether the item requires special storage conditions or handling procedures (e.g., refrigeration, secure vault).',
    `retention_expiry_date` DATE COMMENT 'Date when the retention period expires and the item becomes eligible for disposition.',
    `retention_period_days` STRING COMMENT 'Number of days the item must be retained before disposition per property policy and local regulations.',
    `shipping_cost_amount` DECIMAL(18,2) COMMENT 'Cost charged to the guest for shipping the item to their location.',
    `shipping_tracking_number` STRING COMMENT 'Carrier tracking number if the item was shipped to the guest at their request.',
    `special_handling_instructions` STRING COMMENT 'Specific instructions for handling, storing, or preserving the item.',
    `storage_location` STRING COMMENT 'Secure storage location identifier where the item is being held (e.g., safe number, locker ID, storage room shelf).',
    CONSTRAINT pk_lost_and_found PRIMARY KEY(`lost_and_found_id`)
) COMMENT 'Operational record of lost and found items discovered during room cleaning or public area maintenance. Captures item description, category, estimated value, discovery location, discovery date/time, finder (attendant) identity, secure storage location, guest notification status, claim status, claim date, disposition (returned/donated/discarded/turned over to authorities), and retention period compliance. Supports guest service recovery, property liability management, and jurisdictional unclaimed property regulations.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Primary key for work_order',
    `benefit_entitlement_id` BIGINT COMMENT 'Foreign key linking to loyalty.benefit_entitlement. Business justification: Loyalty benefit fulfillment via work order: complimentary amenity delivery or room setup benefits for elite members are executed as work orders. Linking benefit_entitlement_id to work_order enables be',
    `event_booking_id` BIGINT COMMENT 'Foreign key linking to event.event_booking. Business justification: Work orders for function space repairs or setup issues (broken equipment, damaged fixtures) discovered during event execution must be attributed to the event booking for damage cost recovery, attritio',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Maintenance work orders are routinely raised against F&B outlets for commercial kitchen equipment, bar refrigeration, and restaurant HVAC failures. Linking work_order to fnb_outlet enables equipment m',
    `follow_up_work_order_id` BIGINT COMMENT 'Self-referencing FK on work_order (follow_up_work_order_id)',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: A work order is frequently generated as a result of a housekeeping assignment — when a maintenance issue is flagged during room cleaning (hk_assignment.maintenance_request_flag = true), a work order i',
    `maintenance_request_id` BIGINT COMMENT 'Reference to the maintenance request created as a result of issues identified during this housekeeping work order.',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Work orders for meeting space issues (damaged furniture, AV equipment, HVAC, spills) are a real hotel operations process. work_order needs a FK to meeting_space to track labor/supply costs and resolut',
    `profile_id` BIGINT COMMENT 'Reference to the guest currently occupying the room or who requested the service, if applicable.',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.property_facility. Business justification: Work orders for facility issues (broken gym equipment, pool chemical systems, spa fixtures) are a named hotel engineering/housekeeping process. work_order needs a FK to property_facility to track labo',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or vacation property where this work order is assigned.',
    `room_amenity_id` BIGINT COMMENT 'Foreign key linking to inventory.room_amenity. Business justification: Work orders are raised for specific amenity repairs (broken TV, faulty AC unit). Linking work_order to room_amenity enables amenity-level maintenance history, warranty claim processing (warranty_claim',
    `room_assignment_id` BIGINT COMMENT 'Foreign key linking to reservation.room_assignment. Business justification: Guest-reported maintenance issues during a stay must be tied to the specific room assignment period to support service recovery decisions, compensation eligibility, and post-stay dispute resolution. T',
    `room_id` BIGINT COMMENT 'Reference to the specific guest room or space that requires housekeeping or maintenance service.',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Work orders for spa treatment room maintenance (broken heated tables, plumbing, chromotherapy) must reference the specific treatment room to block appointments, track room-out-of-service status, and r',
    `actual_completion_time` TIMESTAMP COMMENT 'The actual timestamp when the work order was completed by the assigned staff member, used for calculating service duration and labor costs.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual timestamp when the assigned staff member began working on this work order, captured for labor tracking and performance analysis.',
    `amenity_replenishment_required` BOOLEAN COMMENT 'Boolean flag indicating whether guest amenities (toiletries, coffee, water) need to be replenished during this service.',
    `cancellation_reason` STRING COMMENT 'Free-text explanation of why the work order was cancelled, such as guest checkout, do-not-disturb request, or operational changes.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this work order record was first created in the system, used for audit trails and operational reporting.',
    `guest_request_notes` STRING COMMENT 'Notes capturing specific requests made by the guest related to this work order, such as extra towels, hypoallergenic products, or do-not-disturb preferences.',
    `inspection_result` STRING COMMENT 'Outcome of the quality inspection indicating whether the work met quality standards, failed inspection, or passed with conditions.',
    `inspection_score` DECIMAL(18,2) COMMENT 'Numerical quality score assigned during inspection, typically on a scale of 0-100, used for performance tracking and quality metrics.',
    `inspection_time` TIMESTAMP COMMENT 'The timestamp when the completed work was inspected by a supervisor or quality assurance team member.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'The calculated labor cost for this work order based on employee hourly rates and service duration, used for Cost Per Occupied Room (CPOR) calculations.',
    `linen_change_required` BOOLEAN COMMENT 'Boolean flag indicating whether full linen change (sheets, pillowcases, towels) is required for this work order, used for linen inventory planning.',
    `maintenance_handoff_required` BOOLEAN COMMENT 'Boolean flag indicating whether this work order identified issues requiring handoff to the maintenance department, such as broken fixtures or equipment malfunctions.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this work order record was last modified, capturing any updates to status, assignments, or other attributes.',
    `priority` STRING COMMENT 'Priority level assigned to the work order based on guest arrival times, room status, and operational urgency.',
    `room_status_after` STRING COMMENT 'The room status after the work order was completed and inspected, reflecting the final state for property management system updates.',
    `room_status_before` STRING COMMENT 'The room status at the time the work order was created, capturing the initial state for status transition tracking.',
    `scheduled_completion_time` TIMESTAMP COMMENT 'The target timestamp by which the work order should be completed, often driven by guest check-in times or operational deadlines.',
    `scheduled_start_date` DATE COMMENT 'The date when the work order is scheduled to begin, used for planning and resource allocation.',
    `scheduled_start_time` TIMESTAMP COMMENT 'The precise timestamp when the work order is scheduled to begin, enabling time-block scheduling and shift management.',
    `service_duration_minutes` STRING COMMENT 'The total time in minutes spent completing the work order, calculated from actual start and completion times, used for labor productivity analysis.',
    `source_system_code` STRING COMMENT 'The unique identifier for this work order in the source operational system, used for data lineage and reconciliation.',
    `special_instructions` STRING COMMENT 'Free-text field containing specific instructions or notes for the housekeeping staff, such as guest preferences, allergy alerts, or special cleaning requirements.',
    `supply_cost_amount` DECIMAL(18,2) COMMENT 'The total cost of housekeeping supplies and amenities consumed during this work order, including linens, toiletries, and cleaning materials, used for CPOR tracking.',
    `vip_service` BOOLEAN COMMENT 'Boolean flag indicating whether this work order is for a VIP guest requiring enhanced service standards, premium amenities, or special attention.',
    `work_order_number` STRING COMMENT 'Externally-visible unique work order number used for tracking and reference by housekeeping staff and property management systems.',
    `work_order_status` STRING COMMENT 'Current lifecycle status of the work order tracking its progression from creation through completion and inspection.',
    `work_order_type` STRING COMMENT 'Classification of the work order indicating the nature of service required: routine cleaning, deep cleaning, quality inspection, maintenance handoff, turndown service, or mid-stay refresh.',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Master reference table for work_order. Referenced by work_order_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` (
    `maintenance_request_id` BIGINT COMMENT 'Primary key for maintenance_request',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Maintenance requests originate from F&B outlets for equipment failures (ovens, dishwashers, POS terminals, refrigeration). Linking maintenance_request to fnb_outlet enables outlet-level equipment fail',
    `follow_up_maintenance_request_id` BIGINT COMMENT 'Self-referencing FK on maintenance_request (follow_up_maintenance_request_id)',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Maintenance requests are commonly originated during housekeeping assignments — the hk_assignment table carries maintenance_request_flag and maintenance_request_description fields indicating that a mai',
    `meeting_space_id` BIGINT COMMENT 'Foreign key linking to property.meeting_space. Business justification: Maintenance requests originating from meeting spaces (broken AV, HVAC failures, fixture damage) are a named engineering/housekeeping process. maintenance_request needs a FK to meeting_space to track i',
    `cleaning_task_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_task. Business justification: The cleaning_task table carries a maintenance_request_generated boolean flag, indicating that individual cleaning tasks can trigger maintenance requests at a granular level. Linking maintenance_reques',
    `profile_id` BIGINT COMMENT 'Reference to the guest who reported the maintenance issue, if applicable.',
    `property_facility_id` BIGINT COMMENT 'Foreign key linking to property.property_facility. Business justification: Maintenance requests for facility defects (pool equipment failure, gym machine breakdown, spa HVAC) are a named hotel operations process. maintenance_request needs a FK to property_facility to track s',
    `property_id` BIGINT COMMENT 'Reference to the property where the maintenance request originated.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Guest-reported maintenance issues must be traceable to the originating reservation booking for service recovery, loyalty compensation, and post-stay follow-up. Maintenance_request has profile_id and r',
    `room_amenity_id` BIGINT COMMENT 'Foreign key linking to inventory.room_amenity. Business justification: Maintenance requests are raised against specific amenities (e.g., broken fixture, faulty appliance). Direct FK enables warranty_claim_flag processing against amenity warranty_expiration_date, recurrin',
    `room_id` BIGINT COMMENT 'Reference to the specific room where maintenance is required.',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Maintenance requests for spa treatment room defects (equipment failure, wet area plumbing) must link to the specific treatment room to trigger appointment blocking, track room-out-of-order status, and',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance request was acknowledged by the maintenance team.',
    `actual_cost_amount` DECIMAL(18,2) COMMENT 'Actual total cost incurred for completing the maintenance work, including labor and materials.',
    `actual_duration_minutes` STRING COMMENT 'Actual time in minutes spent completing the maintenance work.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when maintenance work began.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance request was assigned to a technician or vendor.',
    `maintenance_request_category` STRING COMMENT 'Functional area or trade specialty required to address the maintenance issue.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance request was formally closed in the system.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance work was completed.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the maintenance request record was first created in the database.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this request.',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Estimated total cost for completing the maintenance work, including labor and materials.',
    `estimated_duration_minutes` STRING COMMENT 'Estimated time in minutes required to complete the maintenance work.',
    `guest_impact_flag` BOOLEAN COMMENT 'Indicates whether the maintenance issue impacts guest experience or room availability.',
    `inspection_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the post-maintenance quality inspection was completed.',
    `inspection_notes` STRING COMMENT 'Notes and observations recorded during the post-maintenance quality inspection.',
    `inspection_passed_flag` BOOLEAN COMMENT 'Indicates whether the completed maintenance work passed the quality inspection.',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether a quality inspection is required after maintenance work is completed.',
    `issue_description` STRING COMMENT 'Detailed narrative description of the maintenance problem or issue reported.',
    `labor_cost_amount` DECIMAL(18,2) COMMENT 'Cost of labor for the maintenance work performed.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the maintenance request record was last updated in the database.',
    `location_description` STRING COMMENT 'Detailed description of the specific location within the property or room where maintenance is needed (e.g., bathroom sink, ceiling near window).',
    `maintenance_request_status` STRING COMMENT 'Current lifecycle state of the maintenance request in the workflow from creation through completion.',
    `materials_cost_amount` DECIMAL(18,2) COMMENT 'Cost of materials and supplies used in the maintenance work.',
    `priority` STRING COMMENT 'Urgency level assigned to the maintenance request, determining response time and resource allocation.',
    `recurring_issue_flag` BOOLEAN COMMENT 'Indicates whether this is a recurring maintenance issue that has been reported multiple times.',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance issue was first reported or the request was created.',
    `request_number` STRING COMMENT 'Externally-visible unique business identifier for the maintenance request, typically displayed to staff and used in communications.',
    `request_type` STRING COMMENT 'Classification of the maintenance request based on the nature of work required.',
    `resolution_description` STRING COMMENT 'Detailed narrative of the actions taken to resolve the maintenance issue.',
    `room_out_of_order_flag` BOOLEAN COMMENT 'Indicates whether the maintenance issue requires the room to be marked as out-of-order and unavailable for occupancy.',
    `safety_hazard_flag` BOOLEAN COMMENT 'Indicates whether the maintenance issue presents a safety hazard requiring immediate attention.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when maintenance work is scheduled to begin.',
    `target_completion_timestamp` TIMESTAMP COMMENT 'Service Level Agreement (SLA) target date and time by which the maintenance request should be completed based on priority.',
    `warranty_claim_flag` BOOLEAN COMMENT 'Indicates whether the maintenance work is covered under equipment or vendor warranty.',
    CONSTRAINT pk_maintenance_request PRIMARY KEY(`maintenance_request_id`)
) COMMENT 'Master reference table for maintenance_request. Referenced by maintenance_request_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_hk_schedule_id` FOREIGN KEY (`hk_schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule`(`hk_schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_hk_schedule_id` FOREIGN KEY (`hk_schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule`(`hk_schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_follow_up_work_order_id` FOREIGN KEY (`follow_up_work_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_maintenance_request_id` FOREIGN KEY (`maintenance_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request`(`maintenance_request_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_follow_up_maintenance_request_id` FOREIGN KEY (`follow_up_maintenance_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request`(`maintenance_request_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_cleaning_task_id` FOREIGN KEY (`cleaning_task_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task`(`cleaning_task_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`housekeeping` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`housekeeping` SET TAGS ('dbx_domain' = 'housekeeping');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Assignment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Attendant ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `benefit_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Entitlement Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `beo_id` SET TAGS ('dbx_business_glossary_term' = 'Beo Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `hk_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Schedule Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Property Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `special_request_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Special Request Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `amenity_replenishment_flag` SET TAGS ('dbx_business_glossary_term' = 'Amenity Replenishment Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `assignment_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'stayover|departure|deep_clean|turndown|vip_prep|inspection');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'assigned|in_progress|completed|inspected|rejected|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `dnd_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Disturb (DND) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `estimated_end_time` SET TAGS ('dbx_business_glossary_term' = 'Estimated End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `estimated_start_time` SET TAGS ('dbx_business_glossary_term' = 'Estimated Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `linen_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Linen Change Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `maintenance_request_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `maintenance_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `preferred_service_time` SET TAGS ('dbx_business_glossary_term' = 'Preferred Service Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `reassignment_count` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_credits` SET TAGS ('dbx_business_glossary_term' = 'Room Credits');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_status_after` SET TAGS ('dbx_business_glossary_term' = 'Room Status After');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_status_after` SET TAGS ('dbx_value_regex' = 'dirty|clean|inspected|pickup|out_of_order|out_of_service');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_status_before` SET TAGS ('dbx_business_glossary_term' = 'Room Status Before');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_status_before` SET TAGS ('dbx_value_regex' = 'dirty|clean|inspected|pickup|out_of_order|out_of_service');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `special_cleaning_code` SET TAGS ('dbx_business_glossary_term' = 'Special Cleaning Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `towel_change_flag` SET TAGS ('dbx_business_glossary_term' = 'Towel Change Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `cleaning_task_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Task ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Attendant ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `hk_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Schedule Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `preference_id` SET TAGS ('dbx_business_glossary_term' = 'Preference Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Property Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `room_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Room Assignment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `special_request_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Special Request Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `credit_weight` SET TAGS ('dbx_business_glossary_term' = 'Credit Weight');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `exception_flag` SET TAGS ('dbx_business_glossary_term' = 'Exception Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `exception_notes` SET TAGS ('dbx_business_glossary_term' = 'Exception Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `guest_present` SET TAGS ('dbx_business_glossary_term' = 'Guest Present');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `guest_request_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Request Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `inspection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `is_quality_checkpoint` SET TAGS ('dbx_business_glossary_term' = 'Is Quality Checkpoint');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `maintenance_request_generated` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Generated');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Room Type Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `room_type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'checkout|stayover|arrival|deep_clean|turndown|refresh');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `skip_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Skip Reason Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `skip_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `skip_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Skip Reason Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `sla_target_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `standard_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `supply_item_code` SET TAGS ('dbx_business_glossary_term' = 'Supply Item Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `supply_item_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `supply_quantity_used` SET TAGS ('dbx_business_glossary_term' = 'Supply Quantity Used');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `supply_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Supply Unit of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_code` SET TAGS ('dbx_business_glossary_term' = 'Task Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_name` SET TAGS ('dbx_business_glossary_term' = 'Task Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_priority` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|rush');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_sequence` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|skipped|failed|exception');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'cleaning|sanitization|restocking|inspection|maintenance_prep|turndown');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `training_indicator` SET TAGS ('dbx_business_glossary_term' = 'Training Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeper ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `room_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Room Assignment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `amenity_check_flag` SET TAGS ('dbx_business_glossary_term' = 'Amenity Check Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `bathroom_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Bathroom Quality Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `cleanliness_score` SET TAGS ('dbx_business_glossary_term' = 'Cleanliness Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `critical_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Deficiency Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `guest_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Guest Arrival Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|failed|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine|deep_clean|turndown|checkout|maintenance_follow_up|quality_audit');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `linen_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Linen Quality Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `maintenance_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Issue Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional_pass');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Inspection Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'urgent|high|normal|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `quality_score` SET TAGS ('dbx_business_glossary_term' = 'Quality Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `reclean_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Re-Clean Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `room_release_flag` SET TAGS ('dbx_business_glossary_term' = 'Room Release Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `room_release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Room Release Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `room_status_after` SET TAGS ('dbx_business_glossary_term' = 'Room Status After Inspection');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `room_status_after` SET TAGS ('dbx_value_regex' = 'dirty|clean|inspected|occupied|out_of_order|out_of_service');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `room_status_before` SET TAGS ('dbx_business_glossary_term' = 'Room Status Before Inspection');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `room_status_before` SET TAGS ('dbx_value_regex' = 'dirty|clean|inspected|occupied|out_of_order|out_of_service');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `scheduled_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Inspection Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `special_request_notes` SET TAGS ('dbx_business_glossary_term' = 'Special Request Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `vip_flag` SET TAGS ('dbx_business_glossary_term' = 'VIP (Very Important Person) Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` SET TAGS ('dbx_subdomain' = 'staff_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `hk_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Schedule ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Budget Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `assignment_method` SET TAGS ('dbx_business_glossary_term' = 'Assignment Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `assignment_method` SET TAGS ('dbx_value_regex' = 'seniority_bidding|rotation|manager_assignment|fixed');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration in Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `break_start_time` SET TAGS ('dbx_business_glossary_term' = 'Break Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `consecutive_days_worked` SET TAGS ('dbx_business_glossary_term' = 'Consecutive Days Worked');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `cpor_target` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Occupied Room (CPOR) Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `cpor_target` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `labor_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Budget Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `labor_budget_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `occupancy_forecast_tier` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Forecast Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `occupancy_forecast_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|peak');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `overtime_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Threshold Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `pip_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `planned_headcount` SET TAGS ('dbx_business_glossary_term' = 'Planned Headcount');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|published|active|completed|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `section_code` SET TAGS ('dbx_business_glossary_term' = 'Section Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `section_credit_value` SET TAGS ('dbx_business_glossary_term' = 'Section Credit Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `section_room_count` SET TAGS ('dbx_business_glossary_term' = 'Section Room Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'AM|PM|overnight|split');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `turndown_end_time` SET TAGS ('dbx_business_glossary_term' = 'Turndown Service End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `turndown_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Turndown Service Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `turndown_start_time` SET TAGS ('dbx_business_glossary_term' = 'Turndown Service Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` SET TAGS ('dbx_subdomain' = 'staff_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Attendant Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `ada_accommodation_flag` SET TAGS ('dbx_business_glossary_term' = 'ADA (Americans with Disabilities Act) Accommodation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `attendance_points` SET TAGS ('dbx_business_glossary_term' = 'Attendance Points');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `average_credits_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Average Credits Per Shift');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `average_credits_per_shift` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `attendant_code` SET TAGS ('dbx_business_glossary_term' = 'Attendant Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `attendant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|suspended|terminated|seasonal|probationary');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `language_skills` SET TAGS ('dbx_business_glossary_term' = 'Language Skills');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `language_skills` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `locker_number` SET TAGS ('dbx_business_glossary_term' = 'Locker Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_business_glossary_term' = 'Mobile Device Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Attendant Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Performance Rating');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `performance_rating` SET TAGS ('dbx_value_regex' = 'exceeds_expectations|meets_expectations|needs_improvement|unsatisfactory|not_rated');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `role_type` SET TAGS ('dbx_business_glossary_term' = 'Attendant Role Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `role_type` SET TAGS ('dbx_value_regex' = 'room_attendant|turndown_attendant|house_person|supervisor|inspector|public_area_cleaner');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `section_assignment` SET TAGS ('dbx_business_glossary_term' = 'Section Assignment');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `seniority_date` SET TAGS ('dbx_business_glossary_term' = 'Seniority Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_business_glossary_term' = 'Shift Assignment');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `shift_assignment` SET TAGS ('dbx_value_regex' = 'am_shift|pm_shift|night_shift|split_shift|on_call|rotating');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `target_credits_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Target Credits Per Shift');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `uniform_size` SET TAGS ('dbx_business_glossary_term' = 'Uniform Size');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `union_classification` SET TAGS ('dbx_business_glossary_term' = 'Union Classification Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `union_member_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Member Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `lost_and_found_id` SET TAGS ('dbx_business_glossary_term' = 'Lost and Found ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `appointment_id` SET TAGS ('dbx_business_glossary_term' = 'Appointment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Property Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `claim_date` SET TAGS ('dbx_business_glossary_term' = 'Claim Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `claim_status` SET TAGS ('dbx_business_glossary_term' = 'Claim Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `claim_status` SET TAGS ('dbx_value_regex' = 'unclaimed|claim_pending|claimed|claim_denied');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Claimant Identification Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_identification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_identification_type` SET TAGS ('dbx_business_glossary_term' = 'Claimant Identification Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_identification_type` SET TAGS ('dbx_value_regex' = 'drivers_license|passport|national_id|employee_badge|other');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_name` SET TAGS ('dbx_business_glossary_term' = 'Claimant Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `claimant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `discovery_location_detail` SET TAGS ('dbx_business_glossary_term' = 'Discovery Location Detail');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `discovery_location_type` SET TAGS ('dbx_business_glossary_term' = 'Discovery Location Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `disposition_type` SET TAGS ('dbx_business_glossary_term' = 'Disposition Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `disposition_type` SET TAGS ('dbx_value_regex' = 'returned_to_guest|donated|discarded|turned_over_to_authorities|shipped_to_guest|pending');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `estimated_value_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Value Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `estimated_value_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `guest_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Guest Notification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `guest_notification_method` SET TAGS ('dbx_business_glossary_term' = 'Guest Notification Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `guest_notification_method` SET TAGS ('dbx_value_regex' = 'email|phone|sms|mail|in_person');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `guest_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Guest Notification Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `guest_notification_status` SET TAGS ('dbx_value_regex' = 'not_attempted|attempted|notified|unable_to_contact');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `is_high_value_item` SET TAGS ('dbx_business_glossary_term' = 'High Value Item Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `item_brand` SET TAGS ('dbx_business_glossary_term' = 'Item Brand');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `item_color` SET TAGS ('dbx_business_glossary_term' = 'Item Color');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `item_number` SET TAGS ('dbx_business_glossary_term' = 'Lost and Found Item Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `item_number` SET TAGS ('dbx_value_regex' = '^LF-[0-9]{8}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `lost_and_found_status` SET TAGS ('dbx_business_glossary_term' = 'Lost and Found Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lost and Found Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `photo_url` SET TAGS ('dbx_business_glossary_term' = 'Item Photo URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `requires_special_handling` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `retention_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `retention_period_days` SET TAGS ('dbx_business_glossary_term' = 'Retention Period Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `shipping_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Shipping Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `shipping_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Shipping Tracking Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `storage_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `storage_location` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` SET TAGS ('dbx_subdomain' = 'staff_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `benefit_entitlement_id` SET TAGS ('dbx_business_glossary_term' = 'Benefit Entitlement Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `event_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Event Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `follow_up_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Work Order Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `follow_up_work_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `maintenance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Property Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `room_amenity_id` SET TAGS ('dbx_business_glossary_term' = 'Room Amenity Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `room_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Room Assignment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `actual_completion_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `amenity_replenishment_required` SET TAGS ('dbx_business_glossary_term' = 'Amenity Replenishment Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `guest_request_notes` SET TAGS ('dbx_business_glossary_term' = 'Guest Request Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `inspection_score` SET TAGS ('dbx_business_glossary_term' = 'Inspection Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `inspection_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `linen_change_required` SET TAGS ('dbx_business_glossary_term' = 'Linen Change Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `maintenance_handoff_required` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Handoff Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `room_status_after` SET TAGS ('dbx_business_glossary_term' = 'Room Status After');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `room_status_before` SET TAGS ('dbx_business_glossary_term' = 'Room Status Before');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `scheduled_completion_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Completion Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `scheduled_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `service_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Service Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `supply_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Supply Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `supply_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `vip_service` SET TAGS ('dbx_business_glossary_term' = 'Vip Service');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` SET TAGS ('dbx_subdomain' = 'staff_management');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `maintenance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `follow_up_maintenance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Maintenance Request Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `follow_up_maintenance_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `meeting_space_id` SET TAGS ('dbx_business_glossary_term' = 'Meeting Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `cleaning_task_id` SET TAGS ('dbx_business_glossary_term' = 'Originating Cleaning Task Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Guest Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `property_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Property Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `room_amenity_id` SET TAGS ('dbx_business_glossary_term' = 'Room Amenity Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Treatment Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `actual_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `maintenance_request_category` SET TAGS ('dbx_business_glossary_term' = 'Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `guest_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Impact Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `inspection_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Completed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `inspection_passed_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Passed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `issue_description` SET TAGS ('dbx_business_glossary_term' = 'Issue Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `labor_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `maintenance_request_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `materials_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Materials Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `recurring_issue_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurring Issue Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `room_out_of_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Room Out Of Order Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `safety_hazard_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Hazard Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `target_completion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `warranty_claim_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claim Flag');
