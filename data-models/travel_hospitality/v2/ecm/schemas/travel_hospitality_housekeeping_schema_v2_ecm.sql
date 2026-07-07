-- Schema for Domain: housekeeping | Business:  | Version: v2_ecm
-- Generated on: 2026-06-27 00:50:44

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `vibe_travel_hospitality_v1`.`housekeeping` COMMENT 'Room cleaning operations, maintenance scheduling, and service quality management. Manages room status transitions (dirty, clean, inspected, out-of-order), housekeeping assignments, cleaning schedules, quality inspections, linen and supply consumption, and maintenance request handoffs. Integrates with Oracle OPERA PMS for real-time room status updates. Tracks CPOR (Cost Per Occupied Room) for housekeeping labor and supplies.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` (
    `hk_assignment_id` BIGINT COMMENT 'Unique identifier for the housekeeping assignment record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Housekeeping assignments must be charged to departmental cost centers for USALI labor cost tracking, budget variance analysis, and departmental P&L reporting. Essential for rooms division financial ma',
    `attendant_id` BIGINT COMMENT 'Identifier of the housekeeping attendant assigned to perform the work.',
    `cleaning_standard_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_standard. Business justification: Daily housekeeping assignments should follow specific cleaning standards based on room type, guest segment, and brand tier. Many assignments reference one cleaning standard (N:1). Links operational as',
    `employee_id` BIGINT COMMENT 'Identifier of the housekeeping supervisor or inspector who performed the quality inspection, if applicable.',
    `experience_special_request_id` BIGINT COMMENT 'Foreign key linking to experience.experience_special_request. Business justification: Special housekeeping requests (extra cleaning, specific timing, hypoallergenic products) are tracked as special requests. Real business process: Guest preference fulfillment tracking for VIP service, ',
    `function_space_id` BIGINT COMMENT 'Foreign key linking to event.function_space. Business justification: Function spaces require housekeeping assignments for event preparation, maintenance, and post-event restoration. Critical for scheduling attendants to specific event venues and tracking service delive',
    `hk_schedule_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_schedule. Business justification: Daily housekeeping assignments are created based on the master schedule. This links individual room assignments to the shift structure. Many assignments are part of one schedule (N:1). The shift col',
    `pos_check_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check. Business justification: Housekeeping attendants report minibar consumption and chargeable amenities discovered during room cleaning. These must link to the POS check that bills the guest, enabling reconciliation of in-room F',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: Room attendants require guest profile data (VIP status, allergies, preferences) for personalized service delivery. Pre-service briefing process depends on profile link. hk_assignment has vip_indicator',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the assignment is located.',
    `reputation_alert_id` BIGINT COMMENT 'Foreign key linking to experience.reputation_alert. Business justification: Reputation alerts about room cleanliness reference specific assignments for issue tracking. Real business process: Linking negative guest feedback to specific housekeeping assignments for root cause a',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Housekeeping assignments must link to active reservations to coordinate DND flags, preferred service times, VIP protocols, allergy flags, and guest-present status during room servicing. Essential for ',
    `room_id` BIGINT COMMENT 'Identifier of the specific room assigned for cleaning or service.',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Guest complaints about room cleanliness generate service cases requiring reference to specific housekeeping assignment. Real business process: Service recovery tracking, attendant accountability, and ',
    `actual_end_time` TIMESTAMP COMMENT 'The actual timestamp when the attendant completed work on this assignment, captured from mobile device or PMS entry.',
    `actual_start_time` TIMESTAMP COMMENT 'The actual timestamp when the attendant began work on this assignment, captured from mobile device or PMS entry.',
    `allergy_flags` STRING COMMENT 'Comma-separated list of guest allergy or sensitivity flags that require special cleaning products or procedures (e.g., fragrance-free, latex-free, pet dander).',
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
    `guest_preference_instructions` STRING COMMENT 'Free-text instructions for the attendant regarding guest-specific preferences, special requests, or service notes (e.g., extra towels, hypoallergenic products, preferred pillow type).',
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
    `vip_indicator` BOOLEAN COMMENT 'Indicates whether the guest is flagged as a VIP, requiring enhanced service standards, special amenities, or supervisor inspection.',
    CONSTRAINT pk_hk_assignment PRIMARY KEY(`hk_assignment_id`)
) COMMENT 'Transactional record of daily housekeeping work assignments, mapping attendants to specific rooms for a given shift. Captures assignment type (stayover, departure, deep clean, turndown, VIP prep), priority level, estimated and actual start/end times, room credits, completion status, and any guest preference instructions (DND, preferred time, allergy flags). Sourced from OPERA PMS housekeeping module. Serves as the primary labor allocation record for CPOR calculation and attendant productivity tracking.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` (
    `cleaning_task_id` BIGINT COMMENT 'Unique identifier for the cleaning task. Primary key.',
    `attendant_id` BIGINT COMMENT 'Reference to the housekeeping attendant assigned to perform this task.',
    `cleaning_standard_id` BIGINT COMMENT 'Reference to the cleaning standard template that defines the task requirements and quality criteria.',
    `employee_id` BIGINT COMMENT 'Reference to the supervisor or inspector who verified the quality of this task.',
    `experience_special_request_id` BIGINT COMMENT 'Foreign key linking to experience.experience_special_request. Business justification: Special cleaning requests (hypoallergenic products, extra pillows, specific room setup) are special requests requiring task-level tracking. Real business process: Guest preference fulfillment at task ',
    `function_space_id` BIGINT COMMENT 'Foreign key linking to event.function_space. Business justification: Function spaces generate recurring cleaning tasks based on event schedules, usage intensity, and space type. Essential for task scheduling, labor allocation, and ensuring spaces meet cleanliness stand',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Cleaning tasks are granular work items performed within the context of a housekeeping assignment. The assignment is the work order; tasks are the line items. This link enables tracking of task-level p',
    `hk_schedule_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_schedule. Business justification: Cleaning tasks are performed during specific housekeeping shifts/schedules. This links operational task execution to the master schedule. Many cleaning tasks occur during one schedule (N:1). No bidire',
    `maintenance_handoff_id` BIGINT COMMENT 'Reference to the maintenance work order generated as a result of issues discovered during this task.',
    `property_id` BIGINT COMMENT 'Reference to the hotel property where this cleaning task is performed.',
    `room_assignment_id` BIGINT COMMENT 'Reference to the parent housekeeping room assignment that contains this task.',
    `room_id` BIGINT COMMENT 'Reference to the specific room being cleaned.',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Specific cleaning tasks (missed items, incomplete work) trigger guest complaints. Real business process: Task-level root cause analysis for service failures, identifying which specific cleaning steps ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual cleaning tasks drive labor cost allocation to departments. Required for USALI departmental expense reporting, labor productivity analysis (cost per credit), and operational budget tracking ',
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
    `audit_id` BIGINT COMMENT 'Foreign key linking to compliance.compliance_audit. Business justification: Room inspections may be part of broader compliance audits (health department, brand standards, safety regulations, quality certifications). Links inspection records to audit programs for evidence trai',
    `cleaning_standard_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_standard. Business justification: Inspections evaluate rooms against specific cleaning standards/SOPs. This links quality control to the standard being evaluated. Many inspections reference one cleaning standard (N:1). Essential for t',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Quality inspections are labor activities that must be allocated to housekeeping department cost centers for accurate departmental expense tracking and quality assurance program cost analysis per USALI',
    `function_space_id` BIGINT COMMENT 'Foreign key linking to event.function_space. Business justification: Function spaces require quality inspections before event release and after cleaning completion. Essential for quality assurance, deficiency tracking, and ensuring spaces meet brand standards before hi',
    `guest_feedback_id` BIGINT COMMENT 'Foreign key linking to experience.guest_feedback. Business justification: Guest feedback cleanliness ratings directly correlate with inspection outcomes. Real business process: Quality correlation analysis between housekeeping inspection scores and guest satisfaction rating',
    `health_safety_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.health_safety_incident. Business justification: Room inspections may discover safety hazards (exposed wiring, broken glass, mold, structural damage) requiring formal incident documentation. Standard safety protocol for guest and employee protection',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Inspections verify the quality of work completed in housekeeping assignments. Linking inspection to the assignment that triggered it enables quality tracking per attendant and assignment, supports per',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `maintenance_handoff_id` BIGINT COMMENT 'Reference to the maintenance work order created as a result of issues identified during this inspection. Links to maintenance request tracking system.',
    `primary_inspection_employee_id` BIGINT COMMENT 'Reference to the housekeeping supervisor or quality inspector who performed the inspection. Links to workforce/employee master data.',
    `property_id` BIGINT COMMENT 'Reference to the property where the inspection occurred. Links to the property master data.',
    `reservation_booking_id` BIGINT COMMENT 'Foreign key linking to reservation.reservation_booking. Business justification: Pre-arrival inspections must link to incoming reservations to verify room readiness against guest arrival time, VIP status, and special requests. Critical for room release workflow and ensuring room m',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` (
    `inspection_deficiency_id` BIGINT COMMENT 'Unique identifier for the inspection deficiency record. Primary key for the inspection deficiency entity.',
    `cleaning_standard_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_standard. Business justification: Deficiencies represent violations of specific cleaning standards. This links quality failures to the standard that was not met. Many deficiencies can reference one cleaning standard (N:1). Critical fo',
    `health_safety_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.health_safety_incident. Business justification: Critical deficiencies (mold, pest infestation, structural damage, chemical exposure) may trigger formal safety incident reports. Required for regulatory compliance, liability management, and guest/emp',
    `inspection_id` BIGINT COMMENT 'Reference to the parent quality inspection during which this deficiency was identified. Links to the inspection header record.',
    `maintenance_handoff_id` BIGINT COMMENT 'Foreign key linking to housekeeping.maintenance_handoff. Business justification: Deficiencies identified during room inspections often require maintenance work. When a deficiency is severe enough to generate a maintenance request, it should reference the maintenance_handoff record',
    `employee_id` BIGINT COMMENT 'Reference to the specific employee assigned to resolve the deficiency. Supports individual accountability and performance tracking.',
    `property_id` BIGINT COMMENT 'Reference to the property where the deficiency was identified. Supports multi-property quality benchmarking.',
    `room_id` BIGINT COMMENT 'Reference to the specific room where the deficiency was found. Enables room-level deficiency trend analysis.',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Critical deficiencies discovered during inspection that impact guest experience generate service cases. Real business process: Proactive issue resolution and guest notification when inspection reveals',
    `actual_resolution_time_minutes` STRING COMMENT 'Actual time in minutes taken to resolve the deficiency. Enables variance analysis against estimates and supports CPOR (Cost Per Occupied Room) calculation.',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the deficiency was assigned to a department or employee for resolution. Tracks handoff timing for SLA (Service Level Agreement) compliance.',
    `blocks_room_sale_flag` BOOLEAN COMMENT 'Indicates whether the deficiency prevents the room from being sold until resolved. Critical for revenue management and inventory availability.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the deficiency record was officially closed. Final lifecycle event for deficiency tracking.',
    `corrective_action_required` STRING COMMENT 'Description of the corrective action needed to resolve the deficiency. May include re-cleaning instructions, maintenance work orders, or amenity replenishment requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this deficiency record was first created in the system. Audit trail for data lineage.',
    `deficiency_category` STRING COMMENT 'Primary classification of the deficiency type. Categories align with housekeeping quality standards and maintenance handoff protocols.. Valid values are `cleanliness|maintenance|amenity|linen|damage|safety`',
    `deficiency_description` STRING COMMENT 'Detailed free-text description of the specific deficiency observed during inspection. Provides context for corrective action and quality improvement analysis.',
    `deficiency_sequence` STRING COMMENT 'Sequential line number of this deficiency within the parent inspection. Orders deficiencies for reporting and review workflows.',
    `deficiency_subcategory` STRING COMMENT 'Detailed subcategory within the primary deficiency category. Examples: bathroom cleanliness, HVAC malfunction, missing amenity, torn linen, wall damage, fire safety violation. Enables granular trend analysis.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the deficiency was escalated to management due to severity, recurrence, or resolution delays. Triggers executive visibility.',
    `escalation_reason` STRING COMMENT 'Free-text explanation of why the deficiency was escalated. Provides context for management review and process improvement.',
    `estimated_resolution_time_minutes` STRING COMMENT 'Estimated time in minutes required to resolve the deficiency. Used for workload planning and labor cost estimation.',
    `guest_impacting_flag` BOOLEAN COMMENT 'Indicates whether the deficiency directly impacts guest experience or satisfaction. Used for GSS (Guest Satisfaction Score) correlation analysis.',
    `identified_timestamp` TIMESTAMP COMMENT 'Date and time when the deficiency was first identified during inspection. Business event timestamp for deficiency lifecycle tracking.',
    `inspector_notes` STRING COMMENT 'Additional free-text notes recorded by the inspector at the time of deficiency identification. Provides supplementary context.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this deficiency record was last modified. Audit trail for change tracking and data quality monitoring.',
    `location_detail` STRING COMMENT 'Specific location within the room where the deficiency was found. Examples: bathroom sink, bedroom closet, balcony door, minibar area. Enables precise corrective action.',
    `photo_attachment_url` STRING COMMENT 'URL or file path to photographic evidence of the deficiency. Supports visual documentation for training, dispute resolution, and quality audits.',
    `preventive_action_taken` STRING COMMENT 'Description of preventive actions implemented to avoid recurrence of this deficiency type. Supports continuous improvement programs.',
    `priority_flag` BOOLEAN COMMENT 'Indicates whether this deficiency requires expedited resolution. True for deficiencies blocking room availability or impacting guest safety.',
    `recurring_deficiency_flag` BOOLEAN COMMENT 'Indicates whether this deficiency has been identified in previous inspections of the same room. Flags systemic quality issues requiring root cause analysis.',
    `resolution_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the corrective action was completed. Used to calculate actual resolution time and SLA compliance.',
    `resolution_cost_amount` DECIMAL(18,2) COMMENT 'Direct cost incurred to resolve the deficiency, including labor, materials, and supplies. Denominated in property base currency. Supports CPOR and GOP (Gross Operating Profit) analysis.',
    `resolution_notes` STRING COMMENT 'Free-text notes recorded by the resolver documenting the corrective action taken. Supports knowledge transfer and audit trail.',
    `resolution_started_timestamp` TIMESTAMP COMMENT 'Date and time when corrective action was initiated. Measures response time from identification to action.',
    `resolution_status` STRING COMMENT 'Current status of the deficiency resolution workflow. Tracks lifecycle from identification through verification and closure.. Valid values are `open|in_progress|resolved|verified|closed|escalated`',
    `root_cause_category` STRING COMMENT 'Classification of the underlying root cause of the deficiency. Supports continuous improvement and preventive action planning.. Valid values are `training|process|equipment|supply|staffing|vendor`',
    `root_cause_notes` STRING COMMENT 'Detailed notes on the root cause analysis performed for this deficiency. Documents findings for knowledge management and training.',
    `severity_level` STRING COMMENT 'Severity classification of the deficiency. Critical deficiencies prevent room sale; major deficiencies impact guest satisfaction; minor and cosmetic deficiencies are tracked for continuous improvement.. Valid values are `critical|major|minor|cosmetic`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when the deficiency resolution was verified by a supervisor or quality inspector. Ensures quality control closure.',
    CONSTRAINT pk_inspection_deficiency PRIMARY KEY(`inspection_deficiency_id`)
) COMMENT 'Line-item record of individual deficiencies identified during a room quality inspection, including deficiency category (cleanliness, maintenance, amenity, linen, damage), severity level, description, corrective action required, resolution status, and resolution timestamp. Enables trend analysis for recurring quality issues and supports continuous improvement programs.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` (
    `maintenance_handoff_id` BIGINT COMMENT 'Primary key for maintenance_handoff',
    `corrective_action_id` BIGINT COMMENT 'Foreign key linking to compliance.corrective_action. Business justification: Safety-related maintenance requests (hazards, defects, compliance violations) may require formal corrective action plans with verification and effectiveness review. Links work orders to CAPA system fo',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Links maintenance requests to specific fixed assets (HVAC, furniture, fixtures) for asset lifecycle tracking, warranty claim validation, maintenance cost capitalization decisions, and CapEx replacemen',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Housekeeping public area attendants service F&B outlet spaces (dining rooms, bars) and report maintenance defects (broken furniture, HVAC issues, equipment failures) specific to those outlets. Real bu',
    `function_space_id` BIGINT COMMENT 'Foreign key linking to event.function_space. Business justification: Function spaces generate maintenance requests for repairs, equipment failures, and preventive maintenance discovered during cleaning or inspections. Critical for asset maintenance tracking, ensuring e',
    `health_safety_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.health_safety_incident. Business justification: Maintenance requests often originate from safety incidents (slip hazards, equipment failures, structural issues). Links work orders to incident reports for liability tracking, root cause analysis, and',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Maintenance issues are often identified during specific housekeeping assignments (room cleaning, inspection). This links maintenance requests to the operational context. Many maintenance handoffs can ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Maintenance requests must be charged to appropriate cost centers (housekeeping vs maintenance department) for interdepartmental cost allocation, chargeback processing, and accurate departmental P&L un',
    `employee_id` BIGINT COMMENT 'Identifier of the housekeeping staff member who identified and reported the maintenance issue.',
    `profile_id` BIGINT COMMENT 'Foreign key linking to guest.profile. Business justification: Guest-reported defects, compensation tracking, VIP escalation workflows require profile link. Service recovery process depends on guest context. maintenance_handoff has guest_impacted, compensation_of',
    `property_id` BIGINT COMMENT 'Identifier of the hotel or resort property where the maintenance issue was identified.',
    `reservation_booking_id` BIGINT COMMENT 'Identifier of the guest reservation associated with the room at the time the maintenance issue was identified, if applicable.',
    `room_id` BIGINT COMMENT 'Identifier of the specific room where the maintenance issue was discovered.',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Maintenance issues reported by housekeeping that impact guest experience escalate to service cases. Real business process: Guest impact tracking, compensation decisions, and cross-functional issue res',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: Facility-level maintenance issues (shared HVAC, water systems, structural repairs) affecting spa operations are tracked through hotel maintenance coordination systems that housekeeping interfaces with',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Spa treatment rooms require maintenance (plumbing, HVAC, electrical) coordinated through hotel maintenance systems. Housekeeping initiates maintenance requests for spa facilities as part of integrated',
    `work_order_id` BIGINT COMMENT 'Identifier of the formal engineering work order created to track and resolve this maintenance issue, if applicable.',
    `acknowledged_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance team acknowledged receipt of the handoff request. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred to resolve the maintenance issue, including labor, parts, and vendor fees. Used for financial reporting and variance analysis.',
    `ada_compliance_issue` BOOLEAN COMMENT 'Indicates whether the maintenance issue affects ADA (Americans with Disabilities Act) accessibility features or compliance (True/False).',
    `assigned_timestamp` TIMESTAMP COMMENT 'Date and time when a specific technician was assigned to the maintenance request. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `compensation_offered` BOOLEAN COMMENT 'Indicates whether any form of compensation (room credit, upgrade, amenity) was offered to the guest due to the maintenance issue (True/False).',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance work was completed and the issue resolved. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated and actual cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this maintenance handoff record was first created in the database. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `defect_description` STRING COMMENT 'Detailed narrative description of the maintenance issue as observed by housekeeping staff, including location within the room and severity indicators.',
    `defect_type` STRING COMMENT 'Category of the maintenance issue identified: plumbing (leaks, drains), electrical (outlets, lighting), HVAC (Heating Ventilation and Air Conditioning - temperature control, air quality), furniture (beds, chairs, desks), fixtures (bathroom fixtures, mirrors), appliance (minibar, TV, safe), structural (walls, floors, ceilings), safety (fire alarms, locks), or other. [ENUM-REF-CANDIDATE: plumbing|electrical|hvac|furniture|fixtures|appliance|structural|safety|other — 9 candidates stripped; promote to reference product]',
    `estimated_completion_date` DATE COMMENT 'Target date by which the maintenance issue is expected to be resolved, used for planning and guest communication. Format: yyyy-MM-dd.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost to resolve the maintenance issue, including labor, parts, and vendor fees. Used for budgeting and CPOR (Cost Per Occupied Room) tracking.',
    `ffe_category` STRING COMMENT 'Classification of whether the maintenance issue involves FF&E (Furniture Fixtures and Equipment) assets: furniture (movable items), fixtures (installed items), equipment (operational devices), or none (building systems).. Valid values are `furniture|fixtures|equipment|none`',
    `follow_up_date` DATE COMMENT 'Scheduled date for follow-up inspection or additional work, if required. Format: yyyy-MM-dd.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional follow-up inspection or work is required after initial resolution (True/False).',
    `guest_impacted` BOOLEAN COMMENT 'Indicates whether a guest was directly impacted by the maintenance issue (True) or if the issue was identified during routine cleaning of a vacant room (False).',
    `guest_notified` BOOLEAN COMMENT 'Indicates whether the guest was notified about the maintenance issue and any impact to their stay (True/False).',
    `handoff_status` STRING COMMENT 'Current workflow state of the maintenance handoff: pending (awaiting engineering review), acknowledged (engineering notified), assigned (technician assigned), in_progress (work underway), completed (issue resolved), cancelled (no longer needed).. Valid values are `pending|acknowledged|assigned|in_progress|completed|cancelled`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this maintenance handoff record was last updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `photo_attached` BOOLEAN COMMENT 'Indicates whether photographic documentation of the maintenance issue was captured and attached to the request (True/False).',
    `reported_timestamp` TIMESTAMP COMMENT 'Date and time when the maintenance issue was identified and logged by housekeeping staff. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `request_number` STRING COMMENT 'Business-facing unique reference number for tracking and communication (e.g., MR-2024-001234).',
    `requires_parts` BOOLEAN COMMENT 'Indicates whether the maintenance repair requires ordering or retrieving replacement parts (True) or can be completed with on-hand materials (False).',
    `requires_vendor` BOOLEAN COMMENT 'Indicates whether the maintenance issue requires external vendor or contractor support (True) or can be handled by in-house staff (False).',
    `resolution_notes` STRING COMMENT 'Detailed notes from the maintenance technician describing the work performed, parts replaced, and final resolution of the issue.',
    `room_status_impact` STRING COMMENT 'Impact of the maintenance issue on room availability: out_of_order (room cannot be sold or occupied), out_of_service (room temporarily unavailable), sellable_with_note (room can be sold with guest notification), no_impact (room remains fully available).. Valid values are `out_of_order|out_of_service|sellable_with_note|no_impact`',
    `safety_hazard` BOOLEAN COMMENT 'Indicates whether the maintenance issue poses an immediate safety hazard to guests or staff (True/False), requiring urgent attention per OSHA standards.',
    `source_inspection_type` STRING COMMENT 'Type of housekeeping activity during which the maintenance issue was identified: routine_cleaning (daily service), checkout_inspection (post-departure check), quality_inspection (supervisor review), guest_complaint (guest-reported issue), preventive_maintenance (scheduled inspection).. Valid values are `routine_cleaning|checkout_inspection|quality_inspection|guest_complaint|preventive_maintenance`',
    `urgency_level` STRING COMMENT 'Priority classification for the maintenance request: critical (immediate safety hazard or room unusable), high (impacts guest experience significantly), medium (noticeable but not blocking), low (cosmetic or minor).. Valid values are `critical|high|medium|low`',
    `warranty_applicable` BOOLEAN COMMENT 'Indicates whether the defective item or system is still under manufacturer or vendor warranty (True/False).',
    `work_started_timestamp` TIMESTAMP COMMENT 'Date and time when the assigned technician began work on the maintenance issue. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    CONSTRAINT pk_maintenance_handoff PRIMARY KEY(`maintenance_handoff_id`)
) COMMENT 'Operational record of maintenance issues identified by housekeeping staff during room cleaning or inspection, including defect type (plumbing, electrical, HVAC, furniture, fixtures), room location, urgency level, description, reported timestamp, and handoff status to the engineering/maintenance team. Represents the housekeeping-to-maintenance handoff workflow and tracks resolution to ensure room availability is restored. Distinct from engineering work orders which are owned by the property/facilities domain.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` (
    `hk_schedule_id` BIGINT COMMENT 'Unique identifier for the housekeeping schedule record. Primary key.',
    `employee_id` BIGINT COMMENT 'Identifier of the user (typically housekeeping manager or supervisor) who published the schedule. Nullable if not yet published.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property to which this housekeeping schedule applies.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Shift schedules drive labor budget allocation to cost centers. Essential for labor forecasting, budget variance analysis, CPOR (Cost Per Occupied Room) calculation, and departmental P&L accuracy.',
    `tertiary_hk_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified this housekeeping schedule record.',
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
    `compliance_training_completion_id` BIGINT COMMENT 'Foreign key linking to compliance.training_completion. Business justification: Attendants must complete mandatory compliance training (chemical handling, bloodborne pathogens, safety protocols, harassment prevention). Tracks most recent or required certification for regulatory c',
    `employee_id` BIGINT COMMENT 'Reference to the master employee record in the workforce domain. Links this housekeeping operational profile to the full HR employee master record containing payroll, benefits, and personal details.',
    `position_id` BIGINT COMMENT 'Foreign key linking to workforce.position. Business justification: Attendants hold specific positions (Room Attendant, Housekeeping Supervisor, Turndown Attendant) that determine pay grade, shift eligibility, union classification, and labor cost allocation. Position ',
    `property_id` BIGINT COMMENT 'Reference to the property where this attendant is primarily assigned. Supports multi-property workforce management.',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` (
    `linen_management_id` BIGINT COMMENT 'Primary key for linen_management',
    `attendant_id` BIGINT COMMENT 'Identifier of the housekeeping staff member who performed or recorded the linen transaction.',
    `employee_id` BIGINT COMMENT 'Identifier of the housekeeping supervisor who approved or validated the transaction, particularly for discards and adjustments.',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Linen transactions (issuance to floors, returns, discards) are associated with specific housekeeping assignments. This links linen inventory movements to operational context. Many linen transactions c',
    `laundry_order_id` BIGINT COMMENT 'Foreign key linking to housekeeping.laundry_order. Business justification: Linen management transactions may trigger or be associated with laundry orders (e.g., soiled linens sent to laundry facility). This links linen inventory movements to laundry processing. Many linen tr',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Linen transactions (purchases, transfers, discards) must be allocated to departmental cost centers for USALI operating expense reporting, inventory valuation, and departmental cost control of linen pr',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the linen transaction occurred.',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Spa treatment rooms consume linens (massage sheets, towels, robes, blankets) tracked through hotel linen inventory for par level management, cost allocation, and laundry vendor billing managed by hous',
    `vendor_id` BIGINT COMMENT 'Identifier of the linen supplier or laundry service vendor for purchase or outsourced laundry transactions.',
    `approval_status` STRING COMMENT 'Approval workflow status for high-value or exception transactions (discards, adjustments, transfers). Pending, approved, or rejected.. Valid values are `pending|approved|rejected`',
    `approved_by` BIGINT COMMENT 'Identifier of the manager or supervisor who approved the transaction in the workflow.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction was approved in the workflow.',
    `batch_number` STRING COMMENT 'Laundry batch or load number for items returned from external or internal laundry processing. Enables traceability.',
    `condition_grade` STRING COMMENT 'Quality condition assessment of the linen at time of transaction (new, excellent, good, fair, poor, damaged). Used for loss and shrinkage analysis.. Valid values are `new|excellent|good|fair|poor|damaged`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the linen transaction record was first created in the data platform.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for cost amounts (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `destination_location` STRING COMMENT 'Target location of the linen movement (e.g., Floor 5 Linen Closet, Laundry for soiled returns, Discard Bin).',
    `discard_reason` STRING COMMENT 'Reason code for linen discard transactions (stained, torn, worn out, burned, lost, stolen, contaminated, expired). Used for loss and shrinkage root-cause analysis. [ENUM-REF-CANDIDATE: stained|torn|worn|burned|lost|stolen|contaminated|expired — 8 candidates stripped; promote to reference product]',
    `floor_number` STRING COMMENT 'Floor or level identifier where linen was issued to or returned from. Null for central laundry transactions.',
    `is_voided` BOOLEAN COMMENT 'Indicates whether the transaction has been voided or reversed. True if voided, False if active.',
    `item_code` STRING COMMENT 'Standardized SKU or item code for the specific linen product (e.g., size, quality grade, supplier code).. Valid values are `^[A-Z]{3}-[0-9]{4}$`',
    `item_description` STRING COMMENT 'Detailed description of the linen item including size, material, color, and quality specifications.',
    `item_type` STRING COMMENT 'Category of linen or terry item involved in the transaction (sheets, pillowcases, bath towels, hand towels, washcloths, bathrobes, pool towels, blankets, mattress pads, table linens). [ENUM-REF-CANDIDATE: sheet|pillowcase|duvet_cover|bath_towel|hand_towel|washcloth|bathrobe|pool_towel|blanket|mattress_pad|table_linen — 11 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the linen transaction record was last modified in the data platform.',
    `notes` STRING COMMENT 'Free-text notes or comments about the linen transaction for audit trail and operational context.',
    `par_level_after` STRING COMMENT 'Inventory par level for this item type at the location after the transaction. Enables variance analysis.',
    `par_level_before` STRING COMMENT 'Inventory par level for this item type at the location before the transaction. Used for par-level compliance tracking.',
    `purchase_order_number` STRING COMMENT 'Purchase order number for linen procurement transactions. Links to procurement system for three-way match.',
    `quantity` STRING COMMENT 'Number of linen units involved in the transaction. Positive for receipts/returns, negative for issuances/discards.',
    `room_number` STRING COMMENT 'Specific room number if transaction is tied to a guest room (e.g., linen issuance for room turnover). Null for bulk floor issuances.',
    `section_code` STRING COMMENT 'Housekeeping section or zone code within the floor (e.g., North Wing, South Wing, Tower A). Used for par-level tracking by section.',
    `shift` STRING COMMENT 'Housekeeping shift during which the linen transaction occurred (AM, PM, or Night shift).. Valid values are `AM|PM|Night`',
    `source_location` STRING COMMENT 'Origin location of the linen movement (e.g., Central Laundry, Floor 3 Linen Closet, Property B for transfers).',
    `source_system_code` STRING COMMENT 'Unique identifier of the transaction in the source operational system for reconciliation and traceability.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the transaction (quantity × unit_cost). Used for housekeeping expense tracking and CPOR analysis.',
    `transaction_date` DATE COMMENT 'Business date of the linen transaction for daily operational reporting and CPOR (Cost Per Occupied Room) calculation.',
    `transaction_number` STRING COMMENT 'Business-readable unique transaction number for linen movement tracking and audit trail.. Valid values are `^LIN-[0-9]{10}$`',
    `transaction_timestamp` TIMESTAMP COMMENT 'Date and time when the linen transaction was recorded in the system.',
    `transaction_type` STRING COMMENT 'Type of linen inventory movement: issuance to floors, return to laundry, discard due to damage, par-level adjustment, inter-property transfer, or new purchase receipt.. Valid values are `issuance|return|discard|adjustment|transfer|purchase`',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of the linen item at time of transaction. Used for CPOR (Cost Per Occupied Room) calculation and inventory valuation.',
    `unit_of_measure` STRING COMMENT 'Unit in which linen quantity is measured (piece, set, dozen, pound, kilogram).. Valid values are `piece|set|dozen|pound|kilogram`',
    `void_reason` STRING COMMENT 'Explanation for why the transaction was voided. Null if not voided.',
    `voided_by` BIGINT COMMENT 'Identifier of the user who voided the transaction. Null if not voided.',
    `voided_timestamp` TIMESTAMP COMMENT 'Date and time when the transaction was voided. Null if not voided.',
    CONSTRAINT pk_linen_management PRIMARY KEY(`linen_management_id`)
) COMMENT 'Transactional record of linen and terry inventory movements including issuance to floors, returns to laundry, discards, par-level adjustments, and inter-property transfers. Captures item type (sheets, pillowcases, bath towels, hand towels, washcloths, bathrobes, pool towels), quantity, movement type, floor/section, shift, condition grade, and cost per unit. Enables linen consumption tracking, loss/shrinkage analysis, par-level compliance, and CPOR calculation for linen and laundry expenses.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` (
    `supply_consumption_id` BIGINT COMMENT 'Unique identifier for the supply consumption transaction record.',
    `cleaning_task_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_task. Business justification: Supply consumption occurs during specific cleaning tasks (e.g., amenity replenishment, chemical usage). This links supply usage to the granular task level for accurate CPOR tracking. Many supply consu',
    `hk_assignment_id` BIGINT COMMENT 'Identifier of the housekeeping work assignment during which the supplies were consumed.',
    `material_master_id` BIGINT COMMENT 'Identifier of the specific supply or amenity item consumed.',
    `pos_check_id` BIGINT COMMENT 'Foreign key linking to fnb.pos_check. Business justification: Guest-charged premium amenities (specialty toiletries, in-room snacks) logged by housekeeping must link to the POS transaction that posts the charge to the guest folio. Real business process: housekee',
    `employee_id` BIGINT COMMENT 'Identifier of the housekeeping staff member who recorded the supply consumption.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where the supply consumption occurred.',
    `reservation_booking_id` BIGINT COMMENT 'Identifier of the guest reservation associated with this supply consumption event.',
    `room_id` BIGINT COMMENT 'Identifier of the specific guest room where supplies were consumed.',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Spa treatment rooms consume housekeeping supplies (cleaning chemicals, disinfectants, paper products, guest amenities) tracked for cost center allocation, budget variance analysis, and inventory reple',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier who provided the consumed supply item.',
    `amenity_type` STRING COMMENT 'The category of supply or amenity consumed (toiletries, coffee supplies, stationery, in-room collateral, linens, cleaning supplies).. Valid values are `TOILETRIES|COFFEE_SUPPLIES|STATIONERY|COLLATERAL|LINENS|CLEANING_SUPPLIES`',
    `batch_number` STRING COMMENT 'The batch or lot number of the supply item for traceability and quality control purposes.',
    `charge_amount` DECIMAL(18,2) COMMENT 'The amount charged to the guest folio for this supply consumption, if applicable.',
    `consumption_date` DATE COMMENT 'The calendar date on which the supply consumption occurred.',
    `consumption_reason` STRING COMMENT 'The business reason for the supply consumption (standard service, guest request, damage replacement, quality issue, special event).. Valid values are `STANDARD_SERVICE|GUEST_REQUEST|DAMAGE_REPLACEMENT|QUALITY_ISSUE|SPECIAL_EVENT`',
    `consumption_timestamp` TIMESTAMP COMMENT 'The precise date and time when the supply consumption was recorded in the system.',
    `cost_center_code` STRING COMMENT 'The financial cost center code to which this supply consumption cost is allocated.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the cost amounts.. Valid values are `^[A-Z]{3}$`',
    `expiry_date` DATE COMMENT 'The expiration date of the supply item, particularly relevant for perishable amenities and toiletries.',
    `gl_account_code` STRING COMMENT 'The general ledger account code for recording the supply expense.',
    `guest_charged_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the guest was charged for this supply consumption (e.g., minibar items, premium amenities).',
    `guest_segment` STRING COMMENT 'The market segment classification of the guest associated with this consumption (transient, group, contract, crew, complimentary).. Valid values are `TRANSIENT|GROUP|CONTRACT|CREW|COMPLIMENTARY`',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the supply consumption event, special circumstances, or quality issues.',
    `occupancy_status` STRING COMMENT 'The occupancy status of the room at the time of supply consumption (occupied, vacant, checkout, stayover).. Valid values are `OCCUPIED|VACANT|CHECKOUT|STAYOVER`',
    `par_level` DECIMAL(18,2) COMMENT 'The standard par level (target inventory quantity) for this supply item in the room type.',
    `quality_grade` STRING COMMENT 'The quality grade classification of the supply item (premium, standard, economy, luxury).. Valid values are `PREMIUM|STANDARD|ECONOMY|LUXURY`',
    `quantity_consumed` DECIMAL(18,2) COMMENT 'The numeric quantity of the supply item consumed during this transaction.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this supply consumption record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this supply consumption record was last modified in the system.',
    `reorder_triggered` BOOLEAN COMMENT 'Boolean flag indicating whether this consumption event triggered an automatic reorder workflow in procurement.',
    `replenishment_action` STRING COMMENT 'The type of replenishment action taken by housekeeping staff (full restock, partial restock, no action, special request).. Valid values are `FULL_RESTOCK|PARTIAL_RESTOCK|NO_ACTION|SPECIAL_REQUEST`',
    `replenishment_quantity` DECIMAL(18,2) COMMENT 'The quantity of the supply item replenished to the room after consumption.',
    `room_type_code` STRING COMMENT 'The classification code of the room where consumption occurred (e.g., KING, QUEEN, SUITE, DELUXE).',
    `shift_code` STRING COMMENT 'The housekeeping shift during which the supply consumption occurred (AM, PM, NIGHT, SWING).. Valid values are `AM|PM|NIGHT|SWING`',
    `sustainability_certified` BOOLEAN COMMENT 'Boolean flag indicating whether the supply item carries environmental or sustainability certification.',
    `total_cost` DECIMAL(18,2) COMMENT 'The total cost of the supply consumption calculated as quantity consumed multiplied by unit cost.',
    `unit_cost` DECIMAL(18,2) COMMENT 'The cost per unit of the supply item at the time of consumption.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the consumed quantity (each, box, case, bottle, roll, set, pair, ounce, liter). [ENUM-REF-CANDIDATE: EACH|BOX|CASE|BOTTLE|ROLL|SET|PAIR|OUNCE|LITER — 9 candidates stripped; promote to reference product]',
    `variance_from_par` DECIMAL(18,2) COMMENT 'The variance between actual consumption and the expected par level consumption.',
    `waste_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the consumption represents waste or spoilage rather than normal usage.',
    CONSTRAINT pk_supply_consumption PRIMARY KEY(`supply_consumption_id`)
) COMMENT 'Transactional record of guest room supply and amenity consumption by room and shift, including amenity type (toiletries, coffee supplies, stationery, in-room collateral), quantity consumed, unit cost, and replenishment action taken. Supports CPOR tracking for supplies and amenities, enables consumption benchmarking by room type and occupancy segment, and feeds procurement reorder workflows.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` (
    `lost_and_found_id` BIGINT COMMENT 'Unique identifier for the lost and found record. Primary key.',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: Guests leave personal items in F&B outlets (restaurants, bars, banquet halls). Housekeeping and F&B staff log these with the specific outlet as discovery location for guest retrieval and liability tra',
    `hk_assignment_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_assignment. Business justification: Lost and found items are discovered during specific housekeeping assignments. This links item discovery to the operational context (who found it, when, during which room service). Many lost items can ',
    `employee_id` BIGINT COMMENT 'Identifier of the housekeeping attendant or staff member who discovered the item.',
    `privacy_incident_id` BIGINT COMMENT 'Foreign key linking to compliance.privacy_incident. Business justification: Lost items containing personal data (laptops, phones, documents, USB drives) may trigger privacy incident protocols under GDPR/data protection laws. Links lost property to breach notification and regu',
    `profile_id` BIGINT COMMENT 'Identifier of the guest associated with the room or area where the item was found, if known.',
    `property_id` BIGINT COMMENT 'Identifier of the property where the item was discovered.',
    `room_id` BIGINT COMMENT 'Identifier of the specific room where the item was found, if applicable.',
    `service_case_id` BIGINT COMMENT 'Foreign key linking to experience.service_case. Business justification: Lost item inquiries generate service cases for tracking and resolution. Real business process: Guest property recovery workflow, service recovery when items cannot be located, and compensation decisio',
    `stay_history_id` BIGINT COMMENT 'Foreign key linking to guest.stay_history. Business justification: Items found during specific stays need stay context for accurate guest notification, claim validation, and shipping coordination. Lost item recovery workflow depends on stay-level detail (dates, room,',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` (
    `deep_clean_plan_id` BIGINT COMMENT 'Unique identifier for the deep cleaning plan record. Primary key.',
    `cleaning_standard_id` BIGINT COMMENT 'Foreign key linking to housekeeping.cleaning_standard. Business justification: Deep clean plans follow specific cleaning standards/SOPs that define scope of work, time estimates, and quality criteria. Many deep clean plans reference one cleaning standard (N:1). Links planned dee',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Deep cleaning projects are significant labor and supply expenses requiring cost center allocation for capital vs operating expense classification, PIP compliance tracking, and departmental budget mana',
    `environmental_compliance_id` BIGINT COMMENT 'Foreign key linking to compliance.environmental_compliance. Business justification: Deep cleaning activities must comply with environmental regulations (chemical disposal, water usage, waste management, air quality). Links cleaning programs to environmental permits and sustainability',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Links deep cleaning to specific fixed assets (carpets, drapes, furniture). Supports asset lifecycle tracking, maintenance cost capitalization decisions, useful life assessment, and CapEx replacement j',
    `function_space_id` BIGINT COMMENT 'Foreign key linking to event.function_space. Business justification: Function spaces require scheduled deep cleaning based on usage intensity, rotation cycles, and event calendars. Essential for preventive maintenance planning, scheduling deep cleans during low-occupan',
    `hk_schedule_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_schedule. Business justification: Deep clean plans are scheduled within housekeeping operational schedules. This links planned deep cleaning to shift structure and labor allocation. Many deep clean plans can be part of one schedule (N',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the quality inspection. Null if inspection not yet performed.',
    `maintenance_handoff_id` BIGINT COMMENT 'Identifier of the maintenance request created as a result of issues identified during deep cleaning. Null if no maintenance request was generated.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the housekeeping team or crew assigned to perform the deep cleaning.',
    `primary_deep_employee_id` BIGINT COMMENT 'Identifier of the housekeeping supervisor responsible for overseeing the deep cleaning execution.',
    `property_id` BIGINT COMMENT 'Identifier of the property where the deep cleaning is scheduled.',
    `room_id` BIGINT COMMENT 'Identifier of the specific room scheduled for deep cleaning. Null if the plan applies to a public area.',
    `spa_facility_id` BIGINT COMMENT 'Foreign key linking to spa.spa_facility. Business justification: Spa facility common areas (locker rooms, relaxation lounges, wet areas, saunas) are included in hotel-wide deep clean schedules managed by housekeeping for health code compliance and guest experience ',
    `treatment_room_id` BIGINT COMMENT 'Foreign key linking to spa.treatment_room. Business justification: Spa treatment rooms require periodic deep cleaning (grout, upholstery, equipment sanitization) beyond daily maintenance. Hotels schedule these through housekeeping deep clean rotation cycles for quali',
    `actual_end_time` TIMESTAMP COMMENT 'Actual timestamp when the deep cleaning work was completed. Null if not yet completed.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Actual number of labor hours spent on the deep cleaning tasks. Null if not yet completed.',
    `actual_start_time` TIMESTAMP COMMENT 'Actual timestamp when the deep cleaning work began. Null if not yet started.',
    `area_name` STRING COMMENT 'Name or description of the public area or space being deep cleaned (e.g., lobby, pool deck, grand ballroom). Null for guest rooms.',
    `area_type` STRING COMMENT 'Classification of the area being deep cleaned (guest room, public area, back of house, meeting space, food and beverage outlet, fitness center).. Valid values are `guest_room|public_area|back_of_house|meeting_space|fnb_outlet|fitness_center`',
    `cancellation_reason` STRING COMMENT 'Reason for cancellation or deferral of the deep cleaning plan. Null if plan was not cancelled or deferred.',
    `completion_percentage` DECIMAL(18,2) COMMENT 'Percentage of the deep cleaning work completed (0.00 to 100.00). Used for tracking progress on in-progress plans.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the deep cleaning plan record was first created in the system.',
    `deep_clean_plan_status` STRING COMMENT 'Current status of the deep cleaning plan (scheduled, in progress, completed, cancelled, deferred, on hold).. Valid values are `scheduled|in_progress|completed|cancelled|deferred|on_hold`',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Estimated number of labor hours required to complete the deep cleaning tasks.',
    `ffe_inspection_performed` BOOLEAN COMMENT 'Indicates whether a Furniture Fixtures and Equipment inspection was performed as part of the deep cleaning (True/False).',
    `inspection_date` DATE COMMENT 'Date when the quality inspection was performed. Null if inspection not yet performed.',
    `inspection_notes` STRING COMMENT 'Notes or comments recorded by the inspector regarding the quality of the deep cleaning work.',
    `inspection_status` STRING COMMENT 'Status of the quality inspection (not required, pending, passed, failed, re-inspection required).. Valid values are `not_required|pending|passed|failed|re_inspection_required`',
    `labor_cost` DECIMAL(18,2) COMMENT 'Total labor cost for the deep cleaning activity, calculated from actual labor hours and wage rates.',
    `last_modified_by` STRING COMMENT 'Username or identifier of the user who last modified the deep cleaning plan record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the deep cleaning plan record was last modified.',
    `maintenance_issues_identified` BOOLEAN COMMENT 'Indicates whether maintenance issues were identified during the deep cleaning that require follow-up (True/False).',
    `notes` STRING COMMENT 'Additional notes or comments about the deep cleaning plan, including special instructions or observations.',
    `pip_compliance_flag` BOOLEAN COMMENT 'Indicates whether this deep cleaning plan is part of a Property Improvement Plan compliance requirement (True/False).',
    `pip_reference_code` STRING COMMENT 'Reference code linking this deep cleaning plan to a specific Property Improvement Plan requirement. Null if not PIP-related.',
    `plan_code` STRING COMMENT 'Business identifier or code for the deep cleaning plan, used for tracking and reporting purposes.',
    `planned_date` DATE COMMENT 'Scheduled date for the deep cleaning to be performed.',
    `planned_end_time` TIMESTAMP COMMENT 'Scheduled end timestamp for the deep cleaning activity.',
    `planned_start_time` TIMESTAMP COMMENT 'Scheduled start timestamp for the deep cleaning activity.',
    `priority` STRING COMMENT 'Priority level of the deep cleaning plan (low, medium, high, critical). Critical priority typically assigned to PIP compliance or guest-facing areas.. Valid values are `low|medium|high|critical`',
    `quality_inspection_required` BOOLEAN COMMENT 'Indicates whether a quality inspection is required after deep cleaning completion (True/False).',
    `rescheduled_date` DATE COMMENT 'New scheduled date if the deep cleaning plan was rescheduled. Null if not rescheduled.',
    `rotation_cycle` STRING COMMENT 'Frequency of the deep cleaning rotation (monthly, quarterly, semi-annual, annual, bi-annual, ad-hoc).. Valid values are `monthly|quarterly|semi_annual|annual|bi_annual|ad_hoc`',
    `scope_of_work` STRING COMMENT 'Detailed description of the deep cleaning tasks to be performed (e.g., carpet shampooing, grout cleaning, upholstery treatment, Furniture Fixtures and Equipment inspection, window washing, HVAC vent cleaning).',
    `supply_cost` DECIMAL(18,2) COMMENT 'Total cost of cleaning supplies and materials consumed during the deep cleaning activity.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost of the deep cleaning activity, including labor and supplies. Used for Cost Per Occupied Room (CPOR) analysis.',
    `created_by` STRING COMMENT 'Username or identifier of the user who created the deep cleaning plan record.',
    CONSTRAINT pk_deep_clean_plan PRIMARY KEY(`deep_clean_plan_id`)
) COMMENT 'Master record of scheduled deep cleaning programs for rooms and public areas, defining the rotation cycle (monthly, quarterly, annual), scope of work (carpet shampooing, grout cleaning, upholstery treatment, FF&E inspection), target room or area, planned date, assigned team, estimated labor hours, and completion status. Supports PIP (Property Improvement Plan) compliance and preventive maintenance coordination.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` (
    `cleaning_standard_id` BIGINT COMMENT 'Unique identifier for the cleaning standard configuration. Primary key.',
    `policy_id` BIGINT COMMENT 'Foreign key linking to compliance.policy. Business justification: Cleaning standards must align with corporate policies (brand standards, safety protocols, sustainability commitments, chemical use). Links operational standards to governance policies for brand compli',
    `room_type_id` BIGINT COMMENT 'Foreign key linking to inventory.room_type. Business justification: Cleaning standards are defined per room type for brand consistency, labor planning, and quality control. Housekeeping operations must enforce correct standards when assigning tasks and auditing qualit',
    `amenity_items_list` STRING COMMENT 'Comma-separated or structured list of amenity items to be placed (e.g., shampoo, conditioner, body lotion, soap, dental kit, sewing kit, coffee pods, bottled water). Varies by brand tier and guest segment.',
    `amenity_placement_instructions` STRING COMMENT 'Detailed instructions for amenity item placement and presentation (e.g., toiletries arrangement, towel folding style, welcome card positioning, turndown chocolate placement). Ensures brand consistency and guest experience quality.',
    `approval_date` DATE COMMENT 'Date this cleaning standard was approved for operational use. Required for compliance audit trail.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved this cleaning standard (e.g., Director of Housekeeping, Brand Standards Manager). Required for brand compliance and audit trail.',
    `brand_compliance_required_flag` BOOLEAN COMMENT 'Indicates whether this standard is mandatory for brand compliance audits. True if required for franchise/brand certification. Non-compliance may result in brand penalties.',
    `brand_tier` STRING COMMENT 'Brand service tier this standard applies to (luxury, premium, select_service, extended_stay, resort). Determines amenity quality, service frequency, and compliance requirements.. Valid values are `luxury|premium|select_service|extended_stay|resort`',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether attendants must complete certification training before executing this standard. True for specialized standards (e.g., deep clean, hazardous material handling, luxury suite service).',
    `chemical_product_specifications` STRING COMMENT 'Approved cleaning chemical products and usage instructions (e.g., all-purpose cleaner brand/dilution, glass cleaner, bathroom sanitizer, disinfectant contact time). Ensures safety compliance and brand standards.',
    `cleaning_standard_status` STRING COMMENT 'Current lifecycle status of the cleaning standard: active (in use), inactive (temporarily disabled), draft (under development), archived (historical record).. Valid values are `active|inactive|draft|archived`',
    `cleaning_type` STRING COMMENT 'Type of cleaning service this standard defines: stayover (occupied room daily service), departure (checkout deep clean), deep_clean (periodic intensive cleaning), turndown (evening service), public_area (lobby/corridor/amenity spaces), refresh (quick tidy between same-day checkouts).. Valid values are `stayover|departure|deep_clean|turndown|public_area|refresh`',
    `cost_per_execution_estimate` DECIMAL(18,2) COMMENT 'Estimated total cost in USD to execute this cleaning standard once, including labor, supplies, and equipment depreciation. Used for CPOR (Cost Per Occupied Room) budgeting and variance analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this cleaning standard record was first created in the system. Audit trail field.',
    `effective_date` DATE COMMENT 'Date this cleaning standard becomes active and enforceable. Used for seasonal standard changes and brand compliance rollouts.',
    `equipment_required` STRING COMMENT 'List of equipment and tools required to execute this standard (e.g., vacuum cleaner, microfiber cloths, mop, caddy, UV sanitizer). Used for attendant assignment and equipment allocation.',
    `expiration_date` DATE COMMENT 'Date this cleaning standard is no longer valid. Null for indefinite standards. Used for seasonal or promotional service upgrades.',
    `guest_segment` STRING COMMENT 'Guest segment this standard targets (standard, loyalty_elite, vip, group, corporate, leisure). Elite and VIP segments receive upgraded amenities and enhanced service protocols.. Valid values are `standard|loyalty_elite|vip|group|corporate|leisure`',
    `inspection_pass_threshold_score` DECIMAL(18,2) COMMENT 'Minimum quality inspection score (0-100 scale) required to pass this cleaning standard. Rooms scoring below threshold require re-cleaning. Typical luxury threshold: 95+, select service: 85+.',
    `labor_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated labor cost in USD for this cleaning standard execution, calculated as target_time_minutes multiplied by average hourly wage. Primary component of CPOR.',
    `last_review_date` DATE COMMENT 'Date this cleaning standard was last reviewed for accuracy and relevance. Standards should be reviewed annually or when brand requirements change.',
    `linen_change_frequency_days` STRING COMMENT 'Number of days between scheduled linen changes when protocol is every_n_days. Null for other protocols. Typical values: 2-3 for luxury, 3-5 for select service.',
    `linen_change_protocol` STRING COMMENT 'Linen replacement policy for this standard: full_change (all linens replaced), on_request (guest opt-in), every_n_days (scheduled rotation), departure_only (checkout only). Impacts sustainability metrics and laundry costs.. Valid values are `full_change|on_request|every_n_days|departure_only`',
    `loyalty_tier_upgrade_amenities` STRING COMMENT 'Additional or upgraded amenity items provided for loyalty elite and VIP guests (e.g., premium bath products, welcome fruit basket, branded robe, upgraded coffee). Null for standard guest segment.',
    `maximum_time_minutes` STRING COMMENT 'Maximum allowable time in minutes for this cleaning standard. Exceeding this threshold triggers supervisor review and quality audit.',
    `minimum_time_minutes` STRING COMMENT 'Minimum time allocation in minutes required to complete this cleaning standard. Used for labor scheduling, productivity tracking, and CPOR (Cost Per Occupied Room) calculation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this cleaning standard record was last modified. Audit trail field for change tracking.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this cleaning standard. Used for governance and continuous improvement workflows.',
    `notes` STRING COMMENT 'Free-text notes for additional context, historical changes, or operational guidance not captured in structured fields.',
    `quality_inspection_criteria` STRING COMMENT 'Structured quality inspection checklist and scoring rubric (e.g., cleanliness score, amenity placement accuracy, linen presentation, bathroom sanitation). Used by supervisors and quality auditors to validate standard compliance.',
    `special_instructions` STRING COMMENT 'Additional notes or special handling requirements (e.g., allergy-friendly cleaning for sensitive guests, pet-friendly room protocols, post-construction deep clean procedures).',
    `standard_code` STRING COMMENT 'Business identifier code for the cleaning standard (e.g., STY_LUX_SUITE, DEP_STD_KING, DEEP_PREM_DBL). Used for operational reference and system integration.. Valid values are `^[A-Z0-9_]{3,20}$`',
    `standard_name` STRING COMMENT 'Human-readable name of the cleaning standard (e.g., Luxury Suite Stayover Service, Premium Departure Clean).',
    `supply_consumption_estimate` STRING COMMENT 'Estimated quantity of consumable supplies per cleaning execution (e.g., 2 trash bags, 1 toilet paper roll, 50ml all-purpose cleaner). Used for inventory forecasting and CPOR calculation.',
    `supply_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated consumable supply cost in USD per execution (chemicals, amenities, linens, trash bags). Used for inventory budgeting and CPOR calculation.',
    `sustainability_compliance_flag` BOOLEAN COMMENT 'Indicates whether this standard meets corporate sustainability and environmental compliance requirements (e.g., eco-friendly chemicals, linen reuse program, water conservation). True if compliant.',
    `target_time_minutes` STRING COMMENT 'Target time in minutes for completing this cleaning standard under normal conditions. Used for performance benchmarking and efficiency KPIs.',
    `task_checklist` STRING COMMENT 'Structured list of required cleaning tasks in sequence (e.g., strip linens, dust surfaces, vacuum, sanitize bathroom, restock amenities). Stored as delimited text or JSON. Used to generate attendant mobile app checklists.',
    `training_module_reference` STRING COMMENT 'Reference to the training module or learning content that teaches this cleaning standard (e.g., LMS course ID, training video URL, SOP document number). Used for onboarding and certification.',
    `version_number` STRING COMMENT 'Version number of this cleaning standard configuration. Incremented when standard is updated. Supports audit trail and change management.',
    CONSTRAINT pk_cleaning_standard PRIMARY KEY(`cleaning_standard_id`)
) COMMENT 'Reference master defining standard operating procedures, quality benchmarks, and amenity placement configurations for each cleaning type (stayover, departure, deep clean, turndown, public area) and room type/guest segment combination. Includes required tasks checklist, minimum time allocation, amenity items and placement instructions, linen change protocol, chemical product specifications, brand tier requirements, loyalty tier upgrade amenities, and brand compliance standards. Used to configure cleaning task templates, drive quality inspection scoring, and generate attendant placement checklists.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` (
    `laundry_order_id` BIGINT COMMENT 'Unique identifier for the laundry order. Primary key for the laundry order transaction.',
    `ap_invoice_id` BIGINT COMMENT 'Foreign key linking to finance.ap_invoice. Business justification: External laundry orders generate AP invoices from vendors. Critical for three-way match validation (PO-receipt-invoice), accrual accounting accuracy, vendor payment processing, and USALI expense recog',
    `cost_center_id` BIGINT COMMENT 'Financial cost center to which laundry processing costs are allocated for accounting and budgeting purposes.',
    `org_unit_id` BIGINT COMMENT 'Identifier of the department requesting the laundry service (e.g., Housekeeping, Food and Beverage (F&B), Spa, Banquet).',
    `employee_id` BIGINT COMMENT 'Identifier of the housekeeping staff member who submitted the laundry order.',
    `vendor_id` BIGINT COMMENT 'Identifier of the laundry vendor or facility processing this order. Null for on-property laundry operations.',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property submitting the laundry order.',
    `actual_return_timestamp` TIMESTAMP COMMENT 'Actual date and time when the cleaned laundry was returned to the property. Null if not yet returned. Used for SLA compliance tracking.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the laundry order was cancelled. Null if order_status is not cancelled.',
    `cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the laundry order was cancelled. Null if order_status is not cancelled.',
    `cost_per_item` DECIMAL(18,2) COMMENT 'Unit cost per individual laundry item processed. Applicable when pricing_method is per_item.',
    `cost_per_pound` DECIMAL(18,2) COMMENT 'Unit cost per pound of laundry processed. Applicable when pricing_method is per_pound. Used for CPOR (Cost Per Occupied Room) calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this laundry order record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this order (e.g., USD, EUR, GBP).. Valid values are `^[A-Z]{3}$`',
    `expected_return_timestamp` TIMESTAMP COMMENT 'Scheduled date and time when the cleaned laundry is expected to be returned to the property. Used for linen availability planning.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this laundry order record was last updated. Used for audit trail and change tracking.',
    `order_number` STRING COMMENT 'Business-facing unique order number for tracking and reference. Format: LO-YYYYMMDD-NNNN.. Valid values are `^LO-[0-9]{8}-[0-9]{4}$`',
    `order_status` STRING COMMENT 'Current lifecycle status of the laundry order: draft (being prepared), submitted (sent to laundry), in_process (being cleaned), completed (cleaning finished), returned (delivered back to property), cancelled (order voided).. Valid values are `draft|submitted|in_process|completed|returned|cancelled`',
    `order_type` STRING COMMENT 'Category of laundry items in this order: linen (sheets, pillowcases), terry (towels, robes), uniform (staff clothing), guest (guest laundry service), banquet (event linens), spa (spa towels and robes).. Valid values are `linen|terry|uniform|guest|banquet|spa`',
    `payment_status` STRING COMMENT 'Status of payment to the laundry vendor: pending (awaiting payment), paid (invoice settled), disputed (billing issue), waived (no charge).. Valid values are `pending|paid|disputed|waived`',
    `pricing_method` STRING COMMENT 'Method used to calculate laundry processing cost: per_pound (weight-based), per_item (item count-based), flat_rate (fixed fee per order), contract (pre-negotiated rate).. Valid values are `per_pound|per_item|flat_rate|contract`',
    `priority_level` STRING COMMENT 'Processing priority for the laundry order: standard (normal turnaround), high (expedited), urgent (same-day), rush (immediate need). Affects expected_return_timestamp and may impact pricing.. Valid values are `standard|high|urgent|rush`',
    `processing_location` STRING COMMENT 'Indicates whether laundry is processed on-property (in-house laundry facility) or off-property (outsourced to external vendor).. Valid values are `on_property|off_property`',
    `quality_inspection_notes` STRING COMMENT 'Free-text notes from quality inspection documenting any issues, defects, or observations about the returned laundry.',
    `quality_inspection_status` STRING COMMENT 'Result of quality inspection upon return: pending (awaiting inspection), passed (meets quality standards), failed (requires re-processing), not_required (inspection waived).. Valid values are `pending|passed|failed|not_required`',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicates whether the laundry order was returned within the expected SLA timeframe. True if actual_return_timestamp <= expected_return_timestamp, False otherwise.',
    `special_instructions` STRING COMMENT 'Free-text field for special handling instructions, stain treatment requests, or other processing notes for the laundry vendor.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the laundry order was submitted to the laundry facility. Primary business event timestamp for the transaction.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total cost for processing this laundry order. Calculated based on pricing_method, weight, and item count. Contributes to housekeeping OpEx (Operating Expenditure) and CPOR (Cost Per Occupied Room) metrics.',
    `total_item_count` STRING COMMENT 'Total number of individual laundry items included in this order across all item types.',
    `total_weight_lbs` DECIMAL(18,2) COMMENT 'Total weight of laundry items in this order measured in pounds. Used for weight-based pricing calculations.',
    `turnaround_time_hours` DECIMAL(18,2) COMMENT 'Actual turnaround time in hours from submission to return. Calculated as the difference between actual_return_timestamp and submission_timestamp. Used for vendor SLA (Service Level Agreement) performance tracking.',
    CONSTRAINT pk_laundry_order PRIMARY KEY(`laundry_order_id`)
) COMMENT 'Transactional record of laundry processing orders submitted to on-property or off-property laundry facilities, including linen and terry items submitted, quantities by item type, submission timestamp, expected return timestamp, actual return timestamp, processing vendor (if outsourced), cost per pound or per item, and order status. Enables laundry cycle time tracking, cost management, and linen availability planning.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` (
    `public_area_id` BIGINT COMMENT 'Unique identifier for the public area cleaning zone record. Primary key for the public area entity.',
    `ada_assessment_id` BIGINT COMMENT 'Foreign key linking to compliance.ada_assessment. Business justification: Public areas must be evaluated for ADA compliance (accessibility, signage, pathways, restrooms, entrances). Links areas to accessibility assessments for legal compliance, remediation tracking, and gue',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Public area cleaning must be allocated to cost centers for USALI departmental reporting, labor and supply cost tracking by area type, and operational budget management of common spaces.',
    `cleaning_standard_id` BIGINT COMMENT 'Reference to the cleaning standard protocol that defines task checklists, quality criteria, and supply requirements for this public area type.',
    `employee_id` BIGINT COMMENT 'Identifier of the housekeeping supervisor responsible for quality oversight and staff management for this public area.',
    `fire_safety_record_id` BIGINT COMMENT 'Foreign key linking to compliance.fire_safety_record. Business justification: Public areas require fire safety compliance (extinguishers, exits, suppression systems, evacuation routes, signage). Links areas to fire safety inspections and certifications for life safety regulatio',
    `fnb_outlet_id` BIGINT COMMENT 'Foreign key linking to fnb.fnb_outlet. Business justification: F&B outlets have associated public areas (dining rooms, bar lounges, restaurant restrooms) that housekeeping maintains with outlet-specific cleaning standards and schedules. Real business process: hou',
    `function_space_id` BIGINT COMMENT 'Foreign key linking to event.function_space. Business justification: Some function spaces (pre-function areas, ballroom foyers, breakout spaces) are classified as public areas for housekeeping scheduling and cleaning frequency management. Enables dual classification fo',
    `hk_schedule_id` BIGINT COMMENT 'Foreign key linking to housekeeping.hk_schedule. Business justification: Public area cleaning is scheduled as part of housekeeping operational schedules. This links public area maintenance to shift planning. Many public areas can be serviced during one schedule (N:1). Esse',
    `org_unit_id` BIGINT COMMENT 'Identifier of the housekeeping team or crew permanently assigned to this public area zone. Null if assignment rotates or is dynamic.',
    `parent_public_area_id` BIGINT COMMENT 'Self-referencing FK on public_area (parent_public_area_id)',
    `property_id` BIGINT COMMENT 'Identifier of the hotel property where this public area is located. Links to the property master record.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this public area record is currently active (True) or archived/inactive (False). Inactive records are retained for historical reporting but excluded from operational scheduling.',
    `ada_compliant_flag` BOOLEAN COMMENT 'Indicates whether this public area meets ADA accessibility requirements. Critical for compliance tracking and guest service.',
    `area_code` STRING COMMENT 'Unique business identifier code for the public area zone within the property (e.g., LOBBY-01, CORR-2F, ELEV-BANK-A). Used for operational reference and assignment tracking.. Valid values are `^[A-Z0-9]{3,10}$`',
    `area_name` STRING COMMENT 'Human-readable name of the public area zone (e.g., Main Lobby, Second Floor Corridor East, Elevator Bank A, Guest Restroom Level 3).',
    `area_type` STRING COMMENT 'Classification of the public area by functional type. Determines cleaning protocols, frequency, and staffing requirements. [ENUM-REF-CANDIDATE: lobby|corridor|restroom|elevator|stairwell|parking|pool_deck|fitness_center|business_center|meeting_space_common|restaurant_entrance|back_of_house — 12 candidates stripped; promote to reference product]',
    `building_section` STRING COMMENT 'Building section, wing, or tower designation for multi-building or large properties (e.g., North Tower, East Wing, Main Building).',
    `chemical_products_approved` STRING COMMENT 'List of approved cleaning chemical products and disinfectants for use in this public area. Ensures brand compliance, safety, and sustainability standards.',
    `cleaning_frequency_times_per_day` STRING COMMENT 'Number of times per day this public area is scheduled for cleaning service. Null for non-daily frequencies.',
    `cleaning_frequency_type` STRING COMMENT 'Standard cleaning frequency schedule for this public area. Determines staffing assignments and quality standards. [ENUM-REF-CANDIDATE: continuous|hourly|multiple_daily|daily|every_other_day|weekly|as_needed — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this public area record was first created in the system. Used for audit trail and data lineage.',
    `credit_value` DECIMAL(18,2) COMMENT 'Housekeeping credit value assigned to this public area for workload balancing and productivity tracking. Comparable to room credits for equitable assignment distribution.',
    `deep_clean_rotation_cycle_days` STRING COMMENT 'Number of days in the deep cleaning rotation cycle for this public area (e.g., 30, 60, 90 days). Determines frequency of intensive cleaning beyond daily service.',
    `effective_date` DATE COMMENT 'Date when this public area configuration became effective. Used for historical tracking and audit purposes.',
    `estimated_monthly_labor_hours` DECIMAL(18,2) COMMENT 'Estimated total labor hours per month required to maintain this public area according to cleaning frequency and standards. Used for staffing planning and labor budgeting.',
    `estimated_monthly_supply_cost` DECIMAL(18,2) COMMENT 'Estimated monthly cost of cleaning supplies and consumables for this public area. Used for budget planning and variance analysis.',
    `expiration_date` DATE COMMENT 'Date when this public area configuration expires or is superseded. Null for current active configurations.',
    `floor_level` STRING COMMENT 'Floor or level designation where the public area is located (e.g., Ground, 2, Mezzanine, Basement, Parking Level P1).',
    `guest_facing_flag` BOOLEAN COMMENT 'Indicates whether this public area is directly visible and accessible to guests (True) or is back-of-house/staff-only (False). Guest-facing areas have higher quality standards.',
    `high_traffic_flag` BOOLEAN COMMENT 'Indicates whether this public area experiences high guest traffic volume requiring more frequent cleaning and inspection (True) or standard traffic (False).',
    `last_deep_clean_date` DATE COMMENT 'Date of the most recent deep cleaning or intensive maintenance service performed for this public area. Used to schedule next deep clean cycle.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent quality inspection performed for this public area. Used to track inspection compliance and schedule next inspection.',
    `last_inspection_score` DECIMAL(18,2) COMMENT 'Quality score achieved in the most recent inspection of this public area. Used for trend analysis and performance tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this public area record was most recently updated. Used for audit trail and change tracking.',
    `location_description` STRING COMMENT 'Detailed description of the public area location within the property, including floor, wing, and proximity to landmarks (e.g., Second Floor East Wing near Conference Room A).',
    `next_deep_clean_date` DATE COMMENT 'Scheduled date for the next deep cleaning or intensive maintenance service for this public area. Based on rotation cycle and property standards.',
    `operational_status` STRING COMMENT 'Current operational status of the public area. Determines whether cleaning services are actively scheduled and performed.. Valid values are `active|temporarily_closed|under_renovation|out_of_service|seasonal`',
    `priority_level` STRING COMMENT 'Priority classification for cleaning and maintenance of this public area. Critical areas (e.g., main lobby, guest restrooms) receive highest attention and fastest response times.. Valid values are `critical|high|standard|low`',
    `quality_inspection_frequency` STRING COMMENT 'Frequency at which formal quality inspections are conducted for this public area. High-priority guest-facing areas typically require more frequent inspection.. Valid values are `every_service|daily|weekly|monthly|quarterly`',
    `quality_score_target` DECIMAL(18,2) COMMENT 'Target quality inspection score (typically 0-100 scale) that this public area must maintain. Used for performance management and brand compliance.',
    `safety_hazard_notes` STRING COMMENT 'Documentation of any safety hazards or special precautions required when cleaning this public area (e.g., high-voltage equipment, slippery surfaces, confined space).',
    `seasonal_close_date` DATE COMMENT 'Annual date when seasonal public area closes for off-season. Null for year-round areas.',
    `seasonal_flag` BOOLEAN COMMENT 'Indicates whether this public area operates seasonally (True) or year-round (False). Seasonal areas may have adjusted cleaning schedules during off-season.',
    `seasonal_open_date` DATE COMMENT 'Annual date when seasonal public area opens for guest use. Null for year-round areas.',
    `special_equipment_required` STRING COMMENT 'List of specialized cleaning equipment required for this public area (e.g., floor scrubber, carpet extractor, high-reach duster, pressure washer). Used for resource planning and assignment.',
    `special_instructions` STRING COMMENT 'Special cleaning instructions, safety precautions, or operational notes for staff servicing this public area (e.g., fragile artwork present, noise restrictions during business hours, wet floor signage required).',
    `square_footage` DECIMAL(18,2) COMMENT 'Total square footage of the public area zone. Used for labor planning, supply estimation, and CPOR (Cost Per Occupied Room) calculations.',
    `standard_cleaning_duration_minutes` STRING COMMENT 'Standard time in minutes required to complete one full cleaning cycle of this public area. Used for labor budgeting and scheduling.',
    `sustainability_certified_flag` BOOLEAN COMMENT 'Indicates whether this public area uses green/sustainable cleaning practices and products meeting environmental certification standards (e.g., Green Seal, EcoLogo).',
    CONSTRAINT pk_public_area PRIMARY KEY(`public_area_id`)
) COMMENT 'Master record for public area cleaning zones (lobbies, corridors, restrooms, elevators, parking) with cleaning frequency schedules, assigned staff, and quality standards.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` (
    `housekeeping_training_completion_id` BIGINT COMMENT 'Primary key for housekeeping_training_completion',
    `attendant_id` BIGINT COMMENT 'Foreign key linking to the housekeeping attendant who enrolled in or completed the training course',
    `compliance_training_completion_id` BIGINT COMMENT 'Unique identifier for this training completion record. Primary key for the association.',
    `housekeeping_compliance_training_completion_id` BIGINT COMMENT 'add column compliance_training_completion_id (BIGINT) with FK to compliance.compliance_training_completion.compliance_training_completion_id - housekeeping training completions should reference the master training completion record to resol',
    `employee_id` BIGINT COMMENT 'Reference to the employee who served as instructor or facilitator for this specific course delivery. Null for self-paced or vendor-delivered courses. Used for instructor effectiveness tracking and quality assurance.',
    `learning_course_id` BIGINT COMMENT 'Foreign key linking to the learning course in which the attendant is enrolled or has completed',
    `workforce_training_completion_id` BIGINT COMMENT '',
    `attempt_number` STRING COMMENT 'Sequential attempt number for this attendant-course combination. Increments with each enrollment if attendant fails and re-enrolls. Compared against learning_course.max_attempts to enforce attempt limits.',
    `bloodborne_pathogen_certification_date` DATE COMMENT 'Date the attendant completed their most recent bloodborne pathogen safety certification. OSHA requires annual refresher training for all employees with potential occupational exposure. [Moved from attendant: This date represents the completion_date of the most recent bloodborne pathogen training completion record. It belongs in the association as it is specific to a particular course enrollment, not an inherent attribute of the attendant.]',
    `bloodborne_pathogen_certified_flag` BOOLEAN COMMENT 'Indicates whether the attendant has completed OSHA-required bloodborne pathogen training. Housekeeping staff may encounter blood, bodily fluids, or contaminated materials during room cleaning and must be trained in proper handling, disposal, and exposure response protocols. [Moved from attendant: This flag represents the CURRENT certification status derived from the most recent completed training_completion record for bloodborne pathogen courses. It should be computed from the association rather than stored redundantly on attendant.]',
    `certificate_issued_flag` BOOLEAN COMMENT 'Indicates whether a completion certificate was issued to the attendant for this training. True for completed courses where learning_course.certification_issued_flag is true.',
    `certificate_number` STRING COMMENT 'Unique certificate number issued for this training completion. Null if no certificate issued. Used for verification and audit purposes.',
    `certification_expiry_date` DATE COMMENT 'Date when the certification earned from this course completion expires and recertification is required. Calculated as completion_date plus learning_course.validity_period_days. Null for courses that do not expire. Critical for compliance alerting and scheduling qualified staff.',
    `chemical_handling_certification_date` DATE COMMENT 'Date the attendant completed their most recent chemical handling safety certification. Certifications typically require annual renewal to maintain compliance with OSHA standards. [Moved from attendant: This date represents the completion_date of the most recent chemical handling training completion record. It belongs in the association as it is specific to a particular course enrollment, not an inherent attribute of the attendant.]',
    `chemical_handling_certified_flag` BOOLEAN COMMENT 'Indicates whether the attendant has completed required training for safe handling, storage, and use of cleaning chemicals. Certification includes OSHA Hazard Communication Standard (HCS) training and property-specific chemical safety protocols. [Moved from attendant: This flag represents the CURRENT certification status derived from the most recent completed training_completion record for chemical handling courses. It should be computed from the association rather than stored redundantly on attendant. The source of truth is the training completion record with its expiry date.]',
    `completion_date` DATE COMMENT 'Date when the attendant successfully completed the learning course. Null if course is in-progress or failed. Used to calculate certification validity periods.',
    `completion_status` STRING COMMENT 'Current status of the training enrollment. Enrolled indicates registration but not started; in_progress indicates active participation; completed indicates successful finish; failed indicates did not meet passing requirements; expired indicates certification period has lapsed; withdrawn indicates attendant dropped the course.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was first created in the system. Used for audit trail and data lineage.',
    `enrollment_date` DATE COMMENT 'Date when the attendant was enrolled in the learning course. Marks the start of the training lifecycle for this attendant-course combination.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this training completion record was last modified. Updated when status changes, scores are recorded, or certification dates are set.',
    `score` DECIMAL(18,2) COMMENT 'Percentage score achieved by the attendant on the course assessment or examination. Null if course does not require assessment. Compared against learning_course.passing_score to determine completion eligibility.',
    `suite_qualified_flag` BOOLEAN COMMENT 'Indicates whether the attendant is certified to clean suite-level accommodations. Suite cleaning requires additional training for handling luxury amenities, multiple rooms, and higher guest expectations. Suite-qualified attendants typically receive higher credit values per room. [Moved from attendant: This flag represents certification status that is earned through completion of suite service training courses. The qualification is derived from training_completion records for suite-related courses, making the association the proper source of truth.]',
    `training_hours_completed` DECIMAL(18,2) COMMENT 'Actual number of training hours the attendant completed for this course. May differ from learning_course.duration_hours for partial completions or extended sessions. Used for labor cost tracking and continuing education credit calculation.',
    `vip_certified_flag` BOOLEAN COMMENT 'Indicates whether the attendant is certified to service VIP guest rooms. VIP certification requires demonstrated excellence in cleaning standards, attention to detail, discretion, and ability to handle special requests. VIP rooms receive enhanced amenities and white-glove service. [Moved from attendant: This flag represents certification status that is earned through completion of VIP service training courses. The qualification is derived from training_completion records for VIP-related courses, making the association the proper source of truth.]',
    CONSTRAINT pk_housekeeping_training_completion PRIMARY KEY(`housekeeping_training_completion_id`)
) COMMENT 'Single source of truth is compliance.compliance_training_completion. This association product represents the enrollment and completion tracking between housekeeping attendants and learning courses. It captures the operational training lifecycle including enrollment, completion status, assessment scores, certification issuance, and expiry tracking. Each record links one attendant to one learning course with attributes that exist only in the context of this specific training enrollment. Supports OSHA compliance reporting, certification tracking for suite/VIP qualifications, chemical handling and bloodborne pathogen protocol compliance, and scheduling of qualified staff to appropriate assignments.. Existence Justification: In hotel housekeeping operations, attendants must complete multiple training courses throughout their employment (chemical handling, bloodborne pathogen protocols, suite service certification, VIP certification, ongoing compliance refreshers), and each course is delivered to many attendants across the property and enterprise. The business actively manages training enrollments as operational records with enrollment dates, completion tracking, assessment scores, certification expiry dates, and recertification cycles. This is not an analytical correlation but an operational business process called training completion or course enrollment that HR and housekeeping managers actively create, monitor, and use for compliance reporting and qualified staff scheduling. SSOT: defers to compliance.compliance_training_completion (MVM).compliance_training_completion as single source of truth]compliance_training_completion. [SSOT:training_completion] Domain-specific specialization of the training_completion concept; canonical SSOT owner is compliance.compliance_training_completion. SSOT: defers to canonical compliance.compliance_training_completion (MVM cross-domain dedup).';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Primary key for work_order',
    `team_id` BIGINT COMMENT 'Reference to the housekeeping team assigned to this work order when team-based assignments are used.',
    `follow_up_work_order_id` BIGINT COMMENT 'Self-referencing FK on work_order (follow_up_work_order_id)',
    `maintenance_request_id` BIGINT COMMENT 'Reference to the maintenance request created as a result of issues identified during this housekeeping work order.',
    `procurement_work_order_id` BIGINT COMMENT 'reference master procurement work order to resolve overlap',
    `profile_id` BIGINT COMMENT 'Reference to the guest currently occupying the room or who requested the service, if applicable.',
    `property_id` BIGINT COMMENT 'Reference to the hotel, resort, or vacation property where this work order is assigned.',
    `reservation_booking_id` BIGINT COMMENT 'Reference to the active reservation associated with this work order, linking housekeeping activities to guest stays.',
    `room_id` BIGINT COMMENT 'Reference to the specific guest room or space that requires housekeeping or maintenance service.',
    `employee_id` BIGINT COMMENT 'Reference to the housekeeping staff member or maintenance technician assigned to complete this work order.',
    `work_inspected_by_employee_id` BIGINT COMMENT 'Reference to the supervisor or quality assurance staff member who performed the inspection of the completed work order.',
    `work_requested_by_employee_id` BIGINT COMMENT 'Reference to the employee who initiated or requested this work order, typically a supervisor, front desk agent, or guest services representative.',
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

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` (
    `team_id` BIGINT COMMENT 'Primary key for team',
    `attendant_id` BIGINT COMMENT 'Reference to the housekeeping supervisor or manager responsible for this team.',
    `parent_team_id` BIGINT COMMENT 'Self-referencing FK on team (parent_team_id)',
    `property_id` BIGINT COMMENT 'Reference to the hotel property or resort where this team is assigned.',
    `average_rooms_per_attendant` DECIMAL(18,2) COMMENT 'Target average number of rooms each attendant on this team should clean per shift, used for workload balancing.',
    `break_duration_minutes` STRING COMMENT 'Total break time allocated per shift in minutes, for labor compliance and scheduling.',
    `budget_labor_hours_per_month` DECIMAL(18,2) COMMENT 'Budgeted labor hours allocated to this team per month for workforce planning and cost control.',
    `building_section` STRING COMMENT 'Specific building, tower, wing, or section of the property assigned to this team (e.g., Tower A, West Wing, Executive Floor).',
    `certification_level` STRING COMMENT 'Highest certification or training level achieved by the team (e.g., Green Seal Certified, OSHA Safety Certified, Brand Standards Level 3).',
    `team_code` STRING COMMENT 'Business identifier code for the housekeeping team, used for scheduling and assignment tracking.',
    `contact_email` STRING COMMENT 'Email address for team communications and scheduling notifications.',
    `contact_phone` STRING COMMENT 'Primary contact phone number for reaching the team supervisor or team lead during shift hours.',
    `cost_center_code` STRING COMMENT 'Financial cost center code for tracking labor and supply costs associated with this team, used in CPOR (Cost Per Occupied Room) calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this team record was first created in the system.',
    `effective_from_date` DATE COMMENT 'Date when this team configuration became active and operational.',
    `effective_to_date` DATE COMMENT 'Date when this team configuration ended or is scheduled to end (null for currently active teams).',
    `end_time` TIMESTAMP COMMENT 'Standard shift end time for this team in HH:mm format (24-hour clock).',
    `equipment_cart_ids` STRING COMMENT 'Comma-separated list of housekeeping cart and equipment identifiers assigned to this team.',
    `floor_assignment` STRING COMMENT 'Specific floor or floor range assigned to this team (e.g., 5-7, 10, Lobby Level).',
    `guest_satisfaction_score` DECIMAL(18,2) COMMENT 'Average guest satisfaction score related to room cleanliness and housekeeping service for areas serviced by this team.',
    `is_seasonal` BOOLEAN COMMENT 'Indicates whether this is a seasonal team activated during peak occupancy periods.',
    `language_capabilities` STRING COMMENT 'Languages spoken by team members, important for guest interaction and multilingual properties (comma-separated list).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this team record was last updated.',
    `team_name` STRING COMMENT 'Human-readable name of the housekeeping team (e.g., Tower A Morning Crew, Executive Floor Team).',
    `notes` STRING COMMENT 'Free-text notes about team configuration, special assignments, or operational considerations.',
    `opera_pms_team_code` STRING COMMENT 'Team identifier in Oracle OPERA PMS system for real-time room status synchronization and assignment tracking.',
    `quality_score_average` DECIMAL(18,2) COMMENT 'Rolling average quality inspection score for this team, typically on a 0-100 scale, used for performance management.',
    `seasonal_period` STRING COMMENT 'Description of the seasonal period when this team is active (e.g., Summer Peak, Holiday Season, Winter Ski Season).',
    `service_standard_level` STRING COMMENT 'Quality and service standard tier this team is trained to deliver, aligned with property segment.',
    `shift` STRING COMMENT 'Primary shift assignment for the team (morning, afternoon, evening, night, or split shift).',
    `size` STRING COMMENT 'Number of housekeeping staff members currently assigned to this team.',
    `specialization` STRING COMMENT 'Specific area of expertise or specialized service this team provides (e.g., Suite Turndown, Deep Cleaning, VIP Service).',
    `start_time` TIMESTAMP COMMENT 'Standard shift start time for this team in HH:mm format (24-hour clock).',
    `supply_storage_location` STRING COMMENT 'Primary linen room or supply storage location assigned to this team for restocking.',
    `target_rooms_per_shift` STRING COMMENT 'Expected number of rooms this team should service during a standard shift, used for productivity planning.',
    `team_status` STRING COMMENT 'Current operational status of the housekeeping team in the workforce lifecycle.',
    `team_type` STRING COMMENT 'Classification of the housekeeping team based on primary function and service area.',
    CONSTRAINT pk_team PRIMARY KEY(`team_id`)
) COMMENT 'Master reference table for team. Referenced by assigned_to_team_id.';

CREATE OR REPLACE TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` (
    `maintenance_request_id` BIGINT COMMENT 'Primary key for maintenance_request',
    `vendor_id` BIGINT COMMENT 'Reference to the external vendor or contractor assigned to perform the maintenance work.',
    `follow_up_maintenance_request_id` BIGINT COMMENT 'Self-referencing FK on maintenance_request (follow_up_maintenance_request_id)',
    `employee_id` BIGINT COMMENT 'Reference to the employee who performed the post-maintenance quality inspection.',
    `maintenance_assigned_to_employee_id` BIGINT COMMENT 'Reference to the maintenance staff member or technician assigned to handle the request.',
    `maintenance_reported_by_employee_id` BIGINT COMMENT 'Reference to the employee who reported or created the maintenance request.',
    `profile_id` BIGINT COMMENT 'Reference to the guest who reported the maintenance issue, if applicable.',
    `property_id` BIGINT COMMENT 'Reference to the property where the maintenance request originated.',
    `room_id` BIGINT COMMENT 'Reference to the specific room where maintenance is required.',
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
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ADD CONSTRAINT `fk_housekeeping_hk_assignment_hk_schedule_id` FOREIGN KEY (`hk_schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule`(`hk_schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_hk_schedule_id` FOREIGN KEY (`hk_schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule`(`hk_schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ADD CONSTRAINT `fk_housekeeping_cleaning_task_maintenance_handoff_id` FOREIGN KEY (`maintenance_handoff_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff`(`maintenance_handoff_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ADD CONSTRAINT `fk_housekeeping_inspection_maintenance_handoff_id` FOREIGN KEY (`maintenance_handoff_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff`(`maintenance_handoff_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`inspection`(`inspection_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ADD CONSTRAINT `fk_housekeeping_inspection_deficiency_maintenance_handoff_id` FOREIGN KEY (`maintenance_handoff_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff`(`maintenance_handoff_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ADD CONSTRAINT `fk_housekeeping_maintenance_handoff_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ADD CONSTRAINT `fk_housekeeping_linen_management_laundry_order_id` FOREIGN KEY (`laundry_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order`(`laundry_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_cleaning_task_id` FOREIGN KEY (`cleaning_task_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task`(`cleaning_task_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ADD CONSTRAINT `fk_housekeeping_supply_consumption_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ADD CONSTRAINT `fk_housekeeping_lost_and_found_hk_assignment_id` FOREIGN KEY (`hk_assignment_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment`(`hk_assignment_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_hk_schedule_id` FOREIGN KEY (`hk_schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule`(`hk_schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ADD CONSTRAINT `fk_housekeeping_deep_clean_plan_maintenance_handoff_id` FOREIGN KEY (`maintenance_handoff_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff`(`maintenance_handoff_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ADD CONSTRAINT `fk_housekeeping_public_area_cleaning_standard_id` FOREIGN KEY (`cleaning_standard_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard`(`cleaning_standard_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ADD CONSTRAINT `fk_housekeeping_public_area_hk_schedule_id` FOREIGN KEY (`hk_schedule_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule`(`hk_schedule_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ADD CONSTRAINT `fk_housekeeping_public_area_parent_public_area_id` FOREIGN KEY (`parent_public_area_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`public_area`(`public_area_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ADD CONSTRAINT `fk_housekeeping_housekeeping_training_completion_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_team_id` FOREIGN KEY (`team_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`team`(`team_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_follow_up_work_order_id` FOREIGN KEY (`follow_up_work_order_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`work_order`(`work_order_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ADD CONSTRAINT `fk_housekeeping_work_order_maintenance_request_id` FOREIGN KEY (`maintenance_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request`(`maintenance_request_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ADD CONSTRAINT `fk_housekeeping_team_attendant_id` FOREIGN KEY (`attendant_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`attendant`(`attendant_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ADD CONSTRAINT `fk_housekeeping_team_parent_team_id` FOREIGN KEY (`parent_team_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`team`(`team_id`);
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ADD CONSTRAINT `fk_housekeeping_maintenance_request_follow_up_maintenance_request_id` FOREIGN KEY (`follow_up_maintenance_request_id`) REFERENCES `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request`(`maintenance_request_id`);

-- ========= TAGS =========
ALTER SCHEMA `vibe_travel_hospitality_v1`.`housekeeping` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `vibe_travel_hospitality_v1`.`housekeeping` SET TAGS ('dbx_domain' = 'housekeeping');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Assignment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Assignment Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Attendant ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `experience_special_request_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Special Request Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `hk_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Schedule Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Check Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `reputation_alert_id` SET TAGS ('dbx_business_glossary_term' = 'Reputation Alert Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `allergy_flags` SET TAGS ('dbx_business_glossary_term' = 'Allergy Flags');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `allergy_flags` SET TAGS ('dbx_confidential' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `guest_preference_instructions` SET TAGS ('dbx_business_glossary_term' = 'Guest Preference Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `guest_preference_instructions` SET TAGS ('dbx_confidential' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_assignment` ALTER COLUMN `vip_indicator` SET TAGS ('dbx_business_glossary_term' = 'VIP Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `cleaning_task_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Task ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Attendant ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspected By ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `experience_special_request_id` SET TAGS ('dbx_business_glossary_term' = 'Experience Special Request Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `hk_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Schedule Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `maintenance_handoff_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `room_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Room Assignment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_task` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Task Cost Center Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeper ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `audit_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `guest_feedback_id` SET TAGS ('dbx_business_glossary_term' = 'Guest Feedback Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Incident Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `maintenance_handoff_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `primary_inspection_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `primary_inspection_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `primary_inspection_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `inspection_deficiency_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Deficiency ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Incident Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `maintenance_handoff_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `actual_resolution_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Time (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `blocks_room_sale_flag` SET TAGS ('dbx_business_glossary_term' = 'Blocks Room Sale Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `deficiency_category` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `deficiency_category` SET TAGS ('dbx_value_regex' = 'cleanliness|maintenance|amenity|linen|damage|safety');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `deficiency_sequence` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Sequence Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `deficiency_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Subcategory');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `estimated_resolution_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Resolution Time (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `guest_impacting_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Impacting Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `identified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Identified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `inspector_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspector Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `location_detail` SET TAGS ('dbx_business_glossary_term' = 'Location Detail');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `photo_attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Photo Attachment URL');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `preventive_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Taken');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `priority_flag` SET TAGS ('dbx_business_glossary_term' = 'Priority Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `recurring_deficiency_flag` SET TAGS ('dbx_business_glossary_term' = 'Recurring Deficiency Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `resolution_completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Completed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `resolution_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Resolution Cost Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `resolution_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Started Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|verified|closed|escalated');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'training|process|equipment|supply|staffing|vendor');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `root_cause_notes` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'critical|major|minor|cosmetic');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`inspection_deficiency` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` SET TAGS ('dbx_subdomain' = 'facility_maintenance');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `maintenance_handoff_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Handoff Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Health Safety Incident Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `health_safety_incident_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Treatment Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `acknowledged_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acknowledged Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `actual_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `ada_compliance_issue` SET TAGS ('dbx_business_glossary_term' = 'Americans with Disabilities Act (ADA) Compliance Issue Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `assigned_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assigned Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `compensation_offered` SET TAGS ('dbx_business_glossary_term' = 'Compensation Offered Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `compensation_offered` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `compensation_offered` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `defect_description` SET TAGS ('dbx_business_glossary_term' = 'Defect Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `estimated_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Estimated Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `ffe_category` SET TAGS ('dbx_business_glossary_term' = 'Furniture Fixtures and Equipment (FF&E) Category');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `ffe_category` SET TAGS ('dbx_value_regex' = 'furniture|fixtures|equipment|none');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `guest_impacted` SET TAGS ('dbx_business_glossary_term' = 'Guest Impacted Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `guest_notified` SET TAGS ('dbx_business_glossary_term' = 'Guest Notified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `handoff_status` SET TAGS ('dbx_business_glossary_term' = 'Handoff Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `handoff_status` SET TAGS ('dbx_value_regex' = 'pending|acknowledged|assigned|in_progress|completed|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `photo_attached` SET TAGS ('dbx_business_glossary_term' = 'Photo Attached Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `reported_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Reported Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `requires_parts` SET TAGS ('dbx_business_glossary_term' = 'Requires Parts Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `requires_vendor` SET TAGS ('dbx_business_glossary_term' = 'Requires Vendor Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `room_status_impact` SET TAGS ('dbx_business_glossary_term' = 'Room Status Impact');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `room_status_impact` SET TAGS ('dbx_value_regex' = 'out_of_order|out_of_service|sellable_with_note|no_impact');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `safety_hazard` SET TAGS ('dbx_business_glossary_term' = 'Safety Hazard Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `source_inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Source Inspection Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `source_inspection_type` SET TAGS ('dbx_value_regex' = 'routine_cleaning|checkout_inspection|quality_inspection|guest_complaint|preventive_maintenance');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `urgency_level` SET TAGS ('dbx_business_glossary_term' = 'Urgency Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `urgency_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `warranty_applicable` SET TAGS ('dbx_business_glossary_term' = 'Warranty Applicable Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_handoff` ALTER COLUMN `work_started_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Work Started Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `hk_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Schedule ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Published By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `tertiary_hk_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `tertiary_hk_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`hk_schedule` ALTER COLUMN `tertiary_hk_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Attendant Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`attendant` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Identifier (ID)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` SET TAGS ('dbx_subdomain' = 'supply_inventory');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `linen_management_id` SET TAGS ('dbx_business_glossary_term' = 'Linen Management Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `linen_management_id` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeper ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `laundry_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laundry Order Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Linen Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Treatment Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `condition_grade` SET TAGS ('dbx_business_glossary_term' = 'Condition Grade');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `condition_grade` SET TAGS ('dbx_value_regex' = 'new|excellent|good|fair|poor|damaged');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `destination_location` SET TAGS ('dbx_business_glossary_term' = 'Destination Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `discard_reason` SET TAGS ('dbx_business_glossary_term' = 'Discard Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `is_voided` SET TAGS ('dbx_business_glossary_term' = 'Is Voided Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `item_code` SET TAGS ('dbx_business_glossary_term' = 'Linen Item Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `item_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}-[0-9]{4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `item_description` SET TAGS ('dbx_business_glossary_term' = 'Item Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `item_type` SET TAGS ('dbx_business_glossary_term' = 'Linen Item Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `par_level_after` SET TAGS ('dbx_business_glossary_term' = 'Par Level After Transaction');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `par_level_before` SET TAGS ('dbx_business_glossary_term' = 'Par Level Before Transaction');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `section_code` SET TAGS ('dbx_business_glossary_term' = 'Section Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'AM|PM|Night');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `source_location` SET TAGS ('dbx_business_glossary_term' = 'Source Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Transaction ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Linen Transaction Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `transaction_number` SET TAGS ('dbx_value_regex' = '^LIN-[0-9]{10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Transaction Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'Transaction Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'issuance|return|discard|adjustment|transfer|purchase');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'piece|set|dozen|pound|kilogram');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `void_reason` SET TAGS ('dbx_business_glossary_term' = 'Void Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `voided_by` SET TAGS ('dbx_business_glossary_term' = 'Voided By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`linen_management` ALTER COLUMN `voided_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Void Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` SET TAGS ('dbx_subdomain' = 'supply_inventory');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `supply_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Consumption ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `cleaning_task_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Task Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeping Assignment ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Supply Item ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `pos_check_id` SET TAGS ('dbx_business_glossary_term' = 'Pos Check Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Housekeeper ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Treatment Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `amenity_type` SET TAGS ('dbx_business_glossary_term' = 'Amenity Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `amenity_type` SET TAGS ('dbx_value_regex' = 'TOILETRIES|COFFEE_SUPPLIES|STATIONERY|COLLATERAL|LINENS|CLEANING_SUPPLIES');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Charge Amount');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `consumption_date` SET TAGS ('dbx_business_glossary_term' = 'Consumption Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `consumption_reason` SET TAGS ('dbx_business_glossary_term' = 'Consumption Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `consumption_reason` SET TAGS ('dbx_value_regex' = 'STANDARD_SERVICE|GUEST_REQUEST|DAMAGE_REPLACEMENT|QUALITY_ISSUE|SPECIAL_EVENT');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `consumption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consumption Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `guest_charged_indicator` SET TAGS ('dbx_business_glossary_term' = 'Guest Charged Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `guest_segment` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `guest_segment` SET TAGS ('dbx_value_regex' = 'TRANSIENT|GROUP|CONTRACT|CREW|COMPLIMENTARY');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `occupancy_status` SET TAGS ('dbx_value_regex' = 'OCCUPIED|VACANT|CHECKOUT|STAYOVER');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `par_level` SET TAGS ('dbx_business_glossary_term' = 'Par Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `quality_grade` SET TAGS ('dbx_business_glossary_term' = 'Quality Grade');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `quality_grade` SET TAGS ('dbx_value_regex' = 'PREMIUM|STANDARD|ECONOMY|LUXURY');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `quantity_consumed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Consumed');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `reorder_triggered` SET TAGS ('dbx_business_glossary_term' = 'Reorder Triggered');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `replenishment_action` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Action');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `replenishment_action` SET TAGS ('dbx_value_regex' = 'FULL_RESTOCK|PARTIAL_RESTOCK|NO_ACTION|SPECIAL_REQUEST');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `replenishment_quantity` SET TAGS ('dbx_business_glossary_term' = 'Replenishment Quantity');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `room_type_code` SET TAGS ('dbx_business_glossary_term' = 'Room Type Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = 'AM|PM|NIGHT|SWING');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `sustainability_certified` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `variance_from_par` SET TAGS ('dbx_business_glossary_term' = 'Variance from Par');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`supply_consumption` ALTER COLUMN `waste_indicator` SET TAGS ('dbx_business_glossary_term' = 'Waste Indicator');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `lost_and_found_id` SET TAGS ('dbx_business_glossary_term' = 'Lost and Found ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `hk_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Assignment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Finder Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `privacy_incident_id` SET TAGS ('dbx_business_glossary_term' = 'Privacy Incident Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Guest ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `service_case_id` SET TAGS ('dbx_business_glossary_term' = 'Service Case Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`lost_and_found` ALTER COLUMN `stay_history_id` SET TAGS ('dbx_business_glossary_term' = 'Stay History Id (Foreign Key)');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `deep_clean_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Deep Clean Plan ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Deep Clean Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `environmental_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Related Fixed Asset Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `hk_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Schedule Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `maintenance_handoff_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `primary_deep_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Supervisor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `primary_deep_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `primary_deep_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `spa_facility_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Facility Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_business_glossary_term' = 'Spa Treatment Room Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `treatment_room_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `actual_end_time` SET TAGS ('dbx_business_glossary_term' = 'Actual End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `actual_start_time` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `area_name` SET TAGS ('dbx_business_glossary_term' = 'Area Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `area_type` SET TAGS ('dbx_business_glossary_term' = 'Area Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `area_type` SET TAGS ('dbx_value_regex' = 'guest_room|public_area|back_of_house|meeting_space|fnb_outlet|fitness_center');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_business_glossary_term' = 'Completion Percentage');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `completion_percentage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `deep_clean_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Deep Clean Plan Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `deep_clean_plan_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred|on_hold');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `ffe_inspection_performed` SET TAGS ('dbx_business_glossary_term' = 'Furniture Fixtures and Equipment (FF&E) Inspection Performed Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|passed|failed|re_inspection_required');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `labor_cost` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `labor_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `maintenance_issues_identified` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Issues Identified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Deep Clean Plan Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `pip_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `pip_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Property Improvement Plan (PIP) Reference Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Deep Clean Plan Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `planned_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `planned_end_time` SET TAGS ('dbx_business_glossary_term' = 'Planned End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `planned_start_time` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `quality_inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `rescheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Rescheduled Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `rotation_cycle` SET TAGS ('dbx_business_glossary_term' = 'Rotation Cycle');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `rotation_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semi_annual|annual|bi_annual|ad_hoc');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `scope_of_work` SET TAGS ('dbx_business_glossary_term' = 'Scope of Work');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `supply_cost` SET TAGS ('dbx_business_glossary_term' = 'Supply Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `supply_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`deep_clean_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` SET TAGS ('dbx_subdomain' = 'quality_control');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `policy_id` SET TAGS ('dbx_business_glossary_term' = 'Policy Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `room_type_id` SET TAGS ('dbx_business_glossary_term' = 'Room Type Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `amenity_items_list` SET TAGS ('dbx_business_glossary_term' = 'Amenity Items List');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `amenity_placement_instructions` SET TAGS ('dbx_business_glossary_term' = 'Amenity Placement Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `brand_compliance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Brand Compliance Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `brand_tier` SET TAGS ('dbx_business_glossary_term' = 'Brand Tier');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `brand_tier` SET TAGS ('dbx_value_regex' = 'luxury|premium|select_service|extended_stay|resort');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `chemical_product_specifications` SET TAGS ('dbx_business_glossary_term' = 'Chemical Product Specifications');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `cleaning_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Standard Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `cleaning_standard_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|archived');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `cleaning_type` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `cleaning_type` SET TAGS ('dbx_value_regex' = 'stayover|departure|deep_clean|turndown|public_area|refresh');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `cost_per_execution_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Execution Estimate (USD)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `guest_segment` SET TAGS ('dbx_business_glossary_term' = 'Guest Segment');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `guest_segment` SET TAGS ('dbx_value_regex' = 'standard|loyalty_elite|vip|group|corporate|leisure');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `inspection_pass_threshold_score` SET TAGS ('dbx_business_glossary_term' = 'Inspection Pass Threshold Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `labor_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Estimate (USD)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `linen_change_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Linen Change Frequency (Days)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `linen_change_protocol` SET TAGS ('dbx_business_glossary_term' = 'Linen Change Protocol');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `linen_change_protocol` SET TAGS ('dbx_value_regex' = 'full_change|on_request|every_n_days|departure_only');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `loyalty_tier_upgrade_amenities` SET TAGS ('dbx_business_glossary_term' = 'Loyalty Tier Upgrade Amenities');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `maximum_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Maximum Time (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `minimum_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Minimum Time (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `quality_inspection_criteria` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Criteria');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_business_glossary_term' = 'Standard Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{3,20}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `standard_name` SET TAGS ('dbx_business_glossary_term' = 'Standard Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `supply_consumption_estimate` SET TAGS ('dbx_business_glossary_term' = 'Supply Consumption Estimate');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `supply_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Supply Cost Estimate (USD)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `sustainability_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `target_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Target Time (Minutes)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `task_checklist` SET TAGS ('dbx_business_glossary_term' = 'Task Checklist');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `training_module_reference` SET TAGS ('dbx_business_glossary_term' = 'Training Module Reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`cleaning_standard` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` SET TAGS ('dbx_subdomain' = 'supply_inventory');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `laundry_order_id` SET TAGS ('dbx_business_glossary_term' = 'Laundry Order ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `ap_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Ap Invoice Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Department ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Submitted By Employee ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Processing Vendor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `actual_return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Return Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `cancelled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `cost_per_item` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Item');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `cost_per_item` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `cost_per_pound` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Pound');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `cost_per_pound` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `expected_return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Expected Return Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Laundry Order Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^LO-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Laundry Order Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|in_process|completed|returned|cancelled');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Laundry Order Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'linen|terry|uniform|guest|banquet|spa');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|disputed|waived');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `pricing_method` SET TAGS ('dbx_business_glossary_term' = 'Pricing Method');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `pricing_method` SET TAGS ('dbx_value_regex' = 'per_pound|per_item|flat_rate|contract');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'standard|high|urgent|rush');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `processing_location` SET TAGS ('dbx_business_glossary_term' = 'Processing Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `processing_location` SET TAGS ('dbx_value_regex' = 'on_property|off_property');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `quality_inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'pending|passed|failed|not_required');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Laundry Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `total_item_count` SET TAGS ('dbx_business_glossary_term' = 'Total Item Count');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `total_weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Pounds)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`laundry_order` ALTER COLUMN `turnaround_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Turnaround Time (Hours)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` SET TAGS ('dbx_subdomain' = 'facility_maintenance');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `public_area_id` SET TAGS ('dbx_business_glossary_term' = 'Public Area ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `ada_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Ada Assessment Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Area Cost Center Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `cleaning_standard_id` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Standard ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Supervisor ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `fire_safety_record_id` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Record Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `fnb_outlet_id` SET TAGS ('dbx_business_glossary_term' = 'Fnb Outlet Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `function_space_id` SET TAGS ('dbx_business_glossary_term' = 'Function Space Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `hk_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Hk Schedule Id (Foreign Key)');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `org_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Team ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `parent_public_area_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Public Area Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `parent_public_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property ID');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `ada_compliant_flag` SET TAGS ('dbx_business_glossary_term' = 'ADA (Americans with Disabilities Act) Compliant Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Public Area Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `area_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `area_name` SET TAGS ('dbx_business_glossary_term' = 'Public Area Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `area_type` SET TAGS ('dbx_business_glossary_term' = 'Public Area Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `building_section` SET TAGS ('dbx_business_glossary_term' = 'Building Section');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `chemical_products_approved` SET TAGS ('dbx_business_glossary_term' = 'Chemical Products Approved');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `cleaning_frequency_times_per_day` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Frequency Times Per Day');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `cleaning_frequency_type` SET TAGS ('dbx_business_glossary_term' = 'Cleaning Frequency Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `credit_value` SET TAGS ('dbx_business_glossary_term' = 'Credit Value');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `deep_clean_rotation_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Deep Clean Rotation Cycle Days');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `estimated_monthly_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Monthly Labor Hours');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `estimated_monthly_supply_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Monthly Supply Cost');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `floor_level` SET TAGS ('dbx_business_glossary_term' = 'Floor Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `guest_facing_flag` SET TAGS ('dbx_business_glossary_term' = 'Guest Facing Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `high_traffic_flag` SET TAGS ('dbx_business_glossary_term' = 'High Traffic Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `last_deep_clean_date` SET TAGS ('dbx_business_glossary_term' = 'Last Deep Clean Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `last_inspection_score` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `next_deep_clean_date` SET TAGS ('dbx_business_glossary_term' = 'Next Deep Clean Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|temporarily_closed|under_renovation|out_of_service|seasonal');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|standard|low');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `quality_inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Frequency');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `quality_inspection_frequency` SET TAGS ('dbx_value_regex' = 'every_service|daily|weekly|monthly|quarterly');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `quality_score_target` SET TAGS ('dbx_business_glossary_term' = 'Quality Score Target');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `safety_hazard_notes` SET TAGS ('dbx_business_glossary_term' = 'Safety Hazard Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `seasonal_close_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Close Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `seasonal_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `seasonal_open_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Open Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `special_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Special Equipment Required');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `special_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Instructions');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `square_footage` SET TAGS ('dbx_business_glossary_term' = 'Square Footage');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `square_footage` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `standard_cleaning_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Standard Cleaning Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`public_area` ALTER COLUMN `sustainability_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Sustainability Certified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_subdomain' = 'facility_maintenance');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_association_edges' = 'housekeeping.attendant,workforce.learning_course');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_ssot_reference' = 'compliance.compliance_training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_mvm_ssot_role' = 'referencing');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_ssot_concept' = 'training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_ssot_references' = 'compliance.compliance_training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_ssot_duplicate' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_ssot' = 'alias');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_ssot_authority_defer_to' = 'compliance.compliance_training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_ssot_ref' = 'compliance.compliance_training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_ssot_group' = 'training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_ssot_canonical' = 'compliance.compliance_training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` SET TAGS ('dbx_ssot_role' = 'reference');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `housekeeping_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'housekeeping_training_completion Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Attendant Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `compliance_training_completion_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Instructor Employee Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `learning_course_id` SET TAGS ('dbx_business_glossary_term' = 'Training Completion - Learning Course Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `workforce_training_completion_id` SET TAGS ('dbx_ssot_owner' = 'workforce.workforce_training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `workforce_training_completion_id` SET TAGS ('dbx_ssot_entity' = 'training_completion');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `attempt_number` SET TAGS ('dbx_business_glossary_term' = 'Attempt Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `bloodborne_pathogen_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Bloodborne Pathogen Certification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `bloodborne_pathogen_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Bloodborne Pathogen Certified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `certificate_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issued Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiry Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `chemical_handling_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Chemical Handling Certification Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `chemical_handling_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Chemical Handling Certified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `suite_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Suite Qualified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `training_hours_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Hours Completed');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`housekeeping_training_completion` ALTER COLUMN `vip_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'VIP (Very Important Person) Certified Flag');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` SET TAGS ('dbx_subdomain' = 'facility_maintenance');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Team Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `follow_up_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Work Order Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `follow_up_work_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `maintenance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Profile Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `reservation_booking_id` SET TAGS ('dbx_business_glossary_term' = 'Reservation Booking Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `work_inspected_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspected By Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `work_inspected_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `work_inspected_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `work_requested_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requested By Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `work_requested_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`work_order` ALTER COLUMN `work_requested_by_employee_id` SET TAGS ('dbx_pii' = 'true');
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
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` SET TAGS ('dbx_subdomain' = 'room_operations');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `team_id` SET TAGS ('dbx_business_glossary_term' = 'Team Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `attendant_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `parent_team_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Team Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `parent_team_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `average_rooms_per_attendant` SET TAGS ('dbx_business_glossary_term' = 'Average Rooms Per Attendant');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `average_rooms_per_attendant` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `budget_labor_hours_per_month` SET TAGS ('dbx_business_glossary_term' = 'Budget Labor Hours Per Month');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `budget_labor_hours_per_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `building_section` SET TAGS ('dbx_business_glossary_term' = 'Building Section');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `team_code` SET TAGS ('dbx_business_glossary_term' = 'Team Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `effective_from_date` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `effective_to_date` SET TAGS ('dbx_business_glossary_term' = 'Effective To Date');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'End Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `equipment_cart_ids` SET TAGS ('dbx_business_glossary_term' = 'Equipment Cart Ids');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `floor_assignment` SET TAGS ('dbx_business_glossary_term' = 'Floor Assignment');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `guest_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Guest Satisfaction Score');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `is_seasonal` SET TAGS ('dbx_business_glossary_term' = 'Is Seasonal');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `language_capabilities` SET TAGS ('dbx_business_glossary_term' = 'Language Capabilities');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `language_capabilities` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `team_name` SET TAGS ('dbx_business_glossary_term' = 'Team Name');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `opera_pms_team_code` SET TAGS ('dbx_business_glossary_term' = 'Opera Pms Team Code');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `quality_score_average` SET TAGS ('dbx_business_glossary_term' = 'Quality Score Average');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `quality_score_average` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `seasonal_period` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Period');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `service_standard_level` SET TAGS ('dbx_business_glossary_term' = 'Service Standard Level');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Shift');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Team Size');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Specialization');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Start Time');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `supply_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Supply Storage Location');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `supply_storage_location` SET TAGS ('dbx_pii_tracked' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `target_rooms_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Target Rooms Per Shift');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `team_status` SET TAGS ('dbx_business_glossary_term' = 'Status');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`team` ALTER COLUMN `team_type` SET TAGS ('dbx_business_glossary_term' = 'Team Type');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` SET TAGS ('dbx_subdomain' = 'facility_maintenance');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` SET TAGS ('dbx_governance' = 'section2_supreme_authority');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` SET TAGS ('dbx_structure_preserved' = 'v2');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `maintenance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Request Identifier');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Vendor Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `follow_up_maintenance_request_id` SET TAGS ('dbx_business_glossary_term' = 'Follow Up Maintenance Request Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `follow_up_maintenance_request_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `maintenance_assigned_to_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned To Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `maintenance_assigned_to_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `maintenance_assigned_to_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `maintenance_reported_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Employee Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `maintenance_reported_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `maintenance_reported_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `profile_id` SET TAGS ('dbx_business_glossary_term' = 'Reported By Guest Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `property_id` SET TAGS ('dbx_business_glossary_term' = 'Property Id');
ALTER TABLE `vibe_travel_hospitality_v1`.`housekeeping`.`maintenance_request` ALTER COLUMN `room_id` SET TAGS ('dbx_business_glossary_term' = 'Room Id');
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
