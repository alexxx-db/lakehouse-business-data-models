-- Metric views for domain: scheduling | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 16:17:39

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core appointment scheduling metrics tracking volume, utilization, patient flow, and operational efficiency across care settings and modalities"
  source: "`vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (scheduled, completed, cancelled, no-show, etc.)"
    - name: "care_setting"
      expr: care_setting
      comment: "Care delivery setting (inpatient, outpatient, emergency, etc.)"
    - name: "visit_modality"
      expr: visit_modality
      comment: "Mode of visit delivery (in-person, telehealth, hybrid)"
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which appointment was booked (online, phone, in-person, mobile app)"
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Date the appointment is scheduled for"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled appointment for trend analysis"
    - name: "scheduled_year"
      expr: YEAR(scheduled_date)
      comment: "Year of scheduled appointment"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for appointment cancellation when applicable"
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Whether appointment has been confirmed by patient"
    - name: "insurance_verification_status"
      expr: insurance_verification_status
      comment: "Status of insurance eligibility verification"
    - name: "priority"
      expr: priority
      comment: "Appointment priority level (routine, urgent, emergent)"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Boolean indicator whether patient did not show for appointment"
    - name: "telehealth_connection_status"
      expr: telehealth_connection_status
      comment: "Status of telehealth connection when applicable"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of appointments scheduled"
    - name: "unique_patients"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Count of unique patients with appointments"
    - name: "unique_providers"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Count of unique clinicians with appointments"
    - name: "no_show_count"
      expr: SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of appointments where patient did not show"
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments resulting in patient no-show - key operational efficiency metric"
    - name: "cancelled_count"
      expr: SUM(CASE WHEN appointment_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled appointments"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appointment_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments cancelled - indicates scheduling stability and patient engagement"
    - name: "completed_count"
      expr: SUM(CASE WHEN appointment_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed appointments"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appointment_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments completed - primary throughput and access metric"
    - name: "telehealth_count"
      expr: SUM(CASE WHEN visit_modality = 'telehealth' THEN 1 ELSE 0 END)
      comment: "Count of telehealth appointments"
    - name: "telehealth_adoption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN visit_modality = 'telehealth' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments delivered via telehealth - strategic digital transformation metric"
    - name: "insurance_verified_count"
      expr: SUM(CASE WHEN insurance_verification_status = 'verified' THEN 1 ELSE 0 END)
      comment: "Count of appointments with verified insurance"
    - name: "insurance_verification_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN insurance_verification_status = 'verified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments with insurance verified - impacts revenue cycle efficiency"
    - name: "online_booking_count"
      expr: SUM(CASE WHEN booking_channel = 'online' THEN 1 ELSE 0 END)
      comment: "Count of appointments booked online"
    - name: "online_booking_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN booking_channel = 'online' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments booked online - measures patient self-service adoption"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_open_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduling capacity and availability metrics tracking slot utilization, online booking enablement, and access optimization"
  source: "`vibe_healthcare_v1`.`scheduling`.`open_slot`"
  dimensions:
    - name: "slot_status"
      expr: slot_status
      comment: "Current status of the scheduling slot (available, booked, blocked, held)"
    - name: "slot_type"
      expr: slot_type
      comment: "Type of scheduling slot (standard, urgent, walk-in, etc.)"
    - name: "care_setting"
      expr: care_setting
      comment: "Care delivery setting for the slot"
    - name: "specialty"
      expr: specialty
      comment: "Clinical specialty associated with the slot"
    - name: "online_booking_enabled_flag"
      expr: online_booking_enabled_flag
      comment: "Whether slot is available for online patient booking"
    - name: "waitlist_enabled_flag"
      expr: waitlist_enabled_flag
      comment: "Whether slot supports waitlist functionality"
    - name: "overbook_allowed_flag"
      expr: overbook_allowed_flag
      comment: "Whether slot can be overbooked"
    - name: "slot_date"
      expr: DATE(slot_start_datetime)
      comment: "Date of the scheduling slot"
    - name: "slot_month"
      expr: DATE_TRUNC('MONTH', slot_start_datetime)
      comment: "Month of the scheduling slot"
    - name: "hold_status"
      expr: hold_status
      comment: "Whether slot is on hold and hold status"
    - name: "block_type"
      expr: block_type
      comment: "Type of block if slot is blocked"
  measures:
    - name: "total_slots"
      expr: COUNT(1)
      comment: "Total number of scheduling slots"
    - name: "available_slots"
      expr: SUM(CASE WHEN slot_status = 'available' THEN 1 ELSE 0 END)
      comment: "Count of available scheduling slots"
    - name: "booked_slots"
      expr: SUM(CASE WHEN slot_status = 'booked' THEN 1 ELSE 0 END)
      comment: "Count of booked scheduling slots"
    - name: "slot_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN slot_status = 'booked' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots that are booked - primary capacity utilization metric for resource optimization"
    - name: "online_bookable_slots"
      expr: SUM(CASE WHEN online_booking_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of slots available for online booking"
    - name: "online_booking_enablement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN online_booking_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots enabled for online booking - measures patient access strategy execution"
    - name: "blocked_slots"
      expr: SUM(CASE WHEN slot_status = 'blocked' THEN 1 ELSE 0 END)
      comment: "Count of blocked scheduling slots"
    - name: "blocked_slot_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN slot_status = 'blocked' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of slots blocked - indicates capacity constraints and scheduling friction"
    - name: "held_slots"
      expr: SUM(CASE WHEN hold_status IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of slots currently on hold"
    - name: "waitlist_enabled_slots"
      expr: SUM(CASE WHEN waitlist_enabled_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of slots with waitlist functionality enabled"
    - name: "unique_providers_with_slots"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Count of unique clinicians with scheduling slots"
    - name: "unique_locations_with_slots"
      expr: COUNT(DISTINCT location_id)
      comment: "Count of unique locations with scheduling slots"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_surgical_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical case volume, efficiency, and resource utilization metrics for OR management and perioperative optimization"
  source: "`vibe_healthcare_v1`.`scheduling`.`surgical_case`"
  dimensions:
    - name: "case_status"
      expr: case_status
      comment: "Current status of the surgical case"
    - name: "case_type"
      expr: case_type
      comment: "Type of surgical case (elective, urgent, emergent)"
    - name: "urgency_level"
      expr: urgency_level
      comment: "Clinical urgency level of the case"
    - name: "service_line"
      expr: service_line
      comment: "Surgical service line"
    - name: "specialty"
      expr: specialty
      comment: "Surgical specialty"
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Type of anesthesia used"
    - name: "asa_classification"
      expr: asa_classification
      comment: "ASA physical status classification"
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Date case is scheduled"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of scheduled case"
    - name: "add_on_case_indicator"
      expr: add_on_case_indicator
      comment: "Whether case was added on (not originally scheduled)"
    - name: "block_time_indicator"
      expr: block_time_indicator
      comment: "Whether case used block time"
    - name: "laterality"
      expr: laterality
      comment: "Surgical site laterality (left, right, bilateral)"
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class (inpatient, outpatient, observation)"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for case cancellation when applicable"
  measures:
    - name: "total_cases"
      expr: COUNT(1)
      comment: "Total number of surgical cases"
    - name: "completed_cases"
      expr: SUM(CASE WHEN case_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed surgical cases"
    - name: "cancelled_cases"
      expr: SUM(CASE WHEN case_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled surgical cases"
    - name: "case_cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN case_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of surgical cases cancelled - key quality and efficiency metric impacting OR utilization and revenue"
    - name: "add_on_cases"
      expr: SUM(CASE WHEN add_on_case_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of add-on surgical cases"
    - name: "add_on_case_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN add_on_case_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases that were add-ons - indicates scheduling predictability and OR flexibility"
    - name: "emergent_cases"
      expr: SUM(CASE WHEN urgency_level = 'emergent' THEN 1 ELSE 0 END)
      comment: "Count of emergent surgical cases"
    - name: "emergent_case_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN urgency_level = 'emergent' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of emergent cases - reflects acuity mix and capacity planning needs"
    - name: "cases_requiring_icu"
      expr: SUM(CASE WHEN requires_icu_bed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases requiring ICU bed"
    - name: "icu_requirement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN requires_icu_bed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases requiring ICU - critical for capacity planning and resource allocation"
    - name: "cases_with_implants"
      expr: SUM(CASE WHEN implant_required = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases requiring implants"
    - name: "timeout_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN timeout_completed_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with completed surgical timeout - critical patient safety and compliance metric"
    - name: "site_marking_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN site_marked_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases with surgical site marked - patient safety and wrong-site surgery prevention metric"
    - name: "unique_surgeons"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Count of unique surgeons performing cases"
    - name: "unique_patients"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Count of unique patients with surgical cases"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_waitlist_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waitlist management and patient access metrics tracking queue performance, escalations, and appointment conversion"
  source: "`vibe_healthcare_v1`.`scheduling`.`waitlist_entry`"
  dimensions:
    - name: "entry_status"
      expr: entry_status
      comment: "Current status of waitlist entry"
    - name: "entry_type"
      expr: entry_type
      comment: "Type of waitlist entry"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the waitlist entry"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for the waitlist entry"
    - name: "specialty_required"
      expr: specialty_required
      comment: "Clinical specialty required"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether entry has been escalated"
    - name: "authorization_required_flag"
      expr: authorization_required_flag
      comment: "Whether prior authorization is required"
    - name: "telehealth_eligible_flag"
      expr: telehealth_eligible_flag
      comment: "Whether patient is eligible for telehealth"
    - name: "interpreter_required_flag"
      expr: interpreter_required_flag
      comment: "Whether interpreter services are required"
    - name: "transportation_assistance_needed_flag"
      expr: transportation_assistance_needed_flag
      comment: "Whether patient needs transportation assistance"
    - name: "queue_month"
      expr: DATE_TRUNC('MONTH', queue_entry_datetime)
      comment: "Month entry was added to waitlist"
    - name: "removal_reason"
      expr: removal_reason
      comment: "Reason for removal from waitlist"
    - name: "escalation_reason"
      expr: escalation_reason
      comment: "Reason for escalation when applicable"
  measures:
    - name: "total_waitlist_entries"
      expr: COUNT(1)
      comment: "Total number of waitlist entries"
    - name: "active_waitlist_entries"
      expr: SUM(CASE WHEN entry_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active waitlist entries"
    - name: "scheduled_from_waitlist"
      expr: SUM(CASE WHEN entry_status = 'scheduled' THEN 1 ELSE 0 END)
      comment: "Count of waitlist entries that resulted in scheduled appointment"
    - name: "waitlist_conversion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN entry_status = 'scheduled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waitlist entries converted to scheduled appointments - key access and operational efficiency metric"
    - name: "escalated_entries"
      expr: SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of escalated waitlist entries"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waitlist entries requiring escalation - indicates access barriers and care coordination challenges"
    - name: "entries_requiring_authorization"
      expr: SUM(CASE WHEN authorization_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of entries requiring prior authorization"
    - name: "authorization_requirement_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN authorization_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waitlist entries requiring authorization - impacts scheduling velocity and revenue cycle"
    - name: "telehealth_eligible_entries"
      expr: SUM(CASE WHEN telehealth_eligible_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of telehealth-eligible waitlist entries"
    - name: "telehealth_eligibility_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN telehealth_eligible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waitlist entries eligible for telehealth - measures opportunity for virtual care to improve access"
    - name: "entries_needing_interpreter"
      expr: SUM(CASE WHEN interpreter_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of entries requiring interpreter services"
    - name: "entries_needing_transportation"
      expr: SUM(CASE WHEN transportation_assistance_needed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of entries requiring transportation assistance"
    - name: "social_determinant_barrier_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN transportation_assistance_needed_flag = TRUE OR interpreter_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of waitlist entries with social determinant barriers (transportation or language) - critical health equity metric"
    - name: "unique_patients_on_waitlist"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Count of unique patients on waitlist"
    - name: "unique_specialties_waitlisted"
      expr: COUNT(DISTINCT specialty_required)
      comment: "Count of unique specialties with waitlist demand"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_provider_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider capacity and availability metrics for workforce planning, access optimization, and panel management"
  source: "`vibe_healthcare_v1`.`scheduling`.`provider_availability`"
  dimensions:
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status of the provider"
    - name: "availability_type"
      expr: availability_type
      comment: "Type of availability (regular, on-call, override, etc.)"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for the availability"
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class accepted during this availability"
    - name: "accepts_new_patients"
      expr: accepts_new_patients
      comment: "Whether provider is accepting new patients"
    - name: "telehealth_enabled"
      expr: telehealth_enabled
      comment: "Whether telehealth is enabled for this availability"
    - name: "overbooking_allowed"
      expr: overbooking_allowed
      comment: "Whether overbooking is allowed"
    - name: "credentialing_status"
      expr: credentialing_status
      comment: "Credentialing status of the provider"
    - name: "on_call_type"
      expr: on_call_type
      comment: "Type of on-call availability when applicable"
    - name: "unavailability_reason"
      expr: unavailability_reason
      comment: "Reason for unavailability when applicable"
    - name: "availability_month"
      expr: DATE_TRUNC('MONTH', start_datetime)
      comment: "Month of availability"
    - name: "override_flag"
      expr: override_flag
      comment: "Whether availability is an override of standard schedule"
  measures:
    - name: "total_availability_blocks"
      expr: COUNT(1)
      comment: "Total number of provider availability blocks"
    - name: "available_blocks"
      expr: SUM(CASE WHEN availability_status = 'available' THEN 1 ELSE 0 END)
      comment: "Count of available provider blocks"
    - name: "unavailable_blocks"
      expr: SUM(CASE WHEN availability_status = 'unavailable' THEN 1 ELSE 0 END)
      comment: "Count of unavailable provider blocks"
    - name: "provider_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN availability_status = 'available' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of provider blocks that are available - key capacity and access metric for workforce planning"
    - name: "new_patient_accepting_blocks"
      expr: SUM(CASE WHEN accepts_new_patients = TRUE THEN 1 ELSE 0 END)
      comment: "Count of availability blocks accepting new patients"
    - name: "new_patient_acceptance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN accepts_new_patients = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of availability blocks accepting new patients - critical patient access and panel growth metric"
    - name: "telehealth_enabled_blocks"
      expr: SUM(CASE WHEN telehealth_enabled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of telehealth-enabled availability blocks"
    - name: "telehealth_capacity_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN telehealth_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of availability blocks with telehealth enabled - measures virtual care capacity"
    - name: "overbooking_allowed_blocks"
      expr: SUM(CASE WHEN overbooking_allowed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of blocks allowing overbooking"
    - name: "credentialed_blocks"
      expr: SUM(CASE WHEN credentialing_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of availability blocks with active credentialing"
    - name: "credentialing_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN credentialing_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of availability blocks with active credentialing - regulatory compliance and risk metric"
    - name: "on_call_blocks"
      expr: SUM(CASE WHEN on_call_type IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of on-call availability blocks"
    - name: "override_blocks"
      expr: SUM(CASE WHEN override_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of override availability blocks"
    - name: "schedule_override_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN override_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of availability blocks that are overrides - indicates scheduling stability and predictability"
    - name: "unique_providers"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Count of unique providers with availability"
    - name: "unique_locations"
      expr: COUNT(DISTINCT location_id)
      comment: "Count of unique locations with provider availability"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_or_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating room block utilization and allocation metrics for surgical capacity planning and resource optimization"
  source: "`vibe_healthcare_v1`.`scheduling`.`or_block`"
  dimensions:
    - name: "block_status"
      expr: block_status
      comment: "Current status of the OR block"
    - name: "block_type"
      expr: block_type
      comment: "Type of OR block (dedicated, shared, flex)"
    - name: "block_owner_type"
      expr: block_owner_type
      comment: "Type of block owner (surgeon, service line, department)"
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week for the block"
    - name: "allows_overbooking"
      expr: allows_overbooking
      comment: "Whether block allows overbooking"
    - name: "allows_sharing"
      expr: allows_sharing
      comment: "Whether block can be shared with other surgeons"
    - name: "release_rule_type"
      expr: release_rule_type
      comment: "Type of rule for releasing unused block time"
    - name: "recurring_pattern"
      expr: recurring_pattern
      comment: "Recurrence pattern of the block"
    - name: "anesthesia_type_required"
      expr: anesthesia_type_required
      comment: "Type of anesthesia required for block"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for block cancellation when applicable"
    - name: "suspension_reason"
      expr: suspension_reason
      comment: "Reason for block suspension when applicable"
    - name: "block_month"
      expr: DATE_TRUNC('MONTH', block_start_time)
      comment: "Month of the OR block"
  measures:
    - name: "total_or_blocks"
      expr: COUNT(1)
      comment: "Total number of OR blocks"
    - name: "active_blocks"
      expr: SUM(CASE WHEN block_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active OR blocks"
    - name: "cancelled_blocks"
      expr: SUM(CASE WHEN block_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled OR blocks"
    - name: "block_cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN block_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of OR blocks cancelled - indicates scheduling stability and surgical volume predictability"
    - name: "shareable_blocks"
      expr: SUM(CASE WHEN allows_sharing = TRUE THEN 1 ELSE 0 END)
      comment: "Count of blocks that allow sharing"
    - name: "block_sharing_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN allows_sharing = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of blocks allowing sharing - measures OR capacity flexibility and optimization opportunity"
    - name: "overbookable_blocks"
      expr: SUM(CASE WHEN allows_overbooking = TRUE THEN 1 ELSE 0 END)
      comment: "Count of blocks allowing overbooking"
    - name: "blocks_with_release_rules"
      expr: SUM(CASE WHEN release_rule_type IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of blocks with release rules defined"
    - name: "release_rule_adoption_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN release_rule_type IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of blocks with release rules - indicates maturity of OR utilization management practices"
    - name: "suspended_blocks"
      expr: SUM(CASE WHEN block_status = 'suspended' THEN 1 ELSE 0 END)
      comment: "Count of suspended OR blocks"
    - name: "avg_minimum_utilization_threshold"
      expr: AVG(CAST(minimum_utilization_threshold_pct AS DOUBLE))
      comment: "Average minimum utilization threshold across blocks"
    - name: "avg_target_utilization_threshold"
      expr: AVG(CAST(target_utilization_threshold_pct AS DOUBLE))
      comment: "Average target utilization threshold across blocks - strategic capacity planning benchmark"
    - name: "unique_block_owners"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Count of unique clinicians owning OR blocks"
    - name: "unique_locations"
      expr: COUNT(DISTINCT location_id)
      comment: "Count of unique locations with OR blocks"
$$;