-- Metric views for domain: scheduling | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core appointment access KPIs: volume, no-show rate, cancellation rate, telehealth mix, and cycle-time indicators used to steer clinic access and patient throughput."
  source: "`vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`"
  dimensions:
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Calendar date the appointment is scheduled for; primary time axis for access reporting."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_time)
      comment: "Month bucket of the scheduled start time for trend analysis."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Lifecycle status of the appointment (scheduled, completed, cancelled, no-show)."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting (inpatient, outpatient, telehealth) for access segmentation."
    - name: "visit_modality"
      expr: visit_modality
      comment: "Modality of the visit (in-person vs virtual) for telehealth analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (portal, phone, referral)."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Whether the patient confirmed the appointment."
  measures:
    - name: "Appointment Count"
      expr: COUNT(1)
      comment: "Total number of appointment records; baseline volume for access KPIs."
    - name: "Distinct Patients Scheduled"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patients scheduled; measures access breadth across the population."
    - name: "No Show Count"
      expr: SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of no-show appointments; driver of lost capacity and revenue."
    - name: "No Show Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of appointments that were no-shows; key efficiency and revenue-leakage KPI."
    - name: "Cancelled Count"
      expr: SUM(CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled appointments; signals access disruption."
    - name: "Cancellation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appointment_status = 'Cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of appointments cancelled; monitored to reduce wasted slots."
    - name: "Telehealth Appointment Share Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN care_setting = 'Telehealth' THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of appointments delivered via telehealth; tracks virtual-care strategy adoption."
    - name: "Confirmed Appointment Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN confirmation_status = 'Confirmed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of appointments patients actively confirmed; leading indicator of attendance."
    - name: "Billing Eligible Appointment Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN billing_eligibility_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of appointments eligible for billing; ties access to revenue capture."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_block_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating room / resource block utilization KPIs used to steer capacity allocation, on-time starts, and turnover efficiency."
  source: "`vibe_healthcare_v1`.`scheduling`.`block_utilization`"
  dimensions:
    - name: "utilization_date"
      expr: utilization_date
      comment: "Date of the block utilization measurement."
    - name: "block_status"
      expr: block_status
      comment: "Status of the block (active, released, cancelled)."
    - name: "block_owner_type"
      expr: block_owner_type
      comment: "Type of block owner (service line, individual surgeon, pool)."
    - name: "owner_specialty_code"
      expr: owner_specialty_code
      comment: "Specialty owning the block for service-line utilization comparison."
    - name: "prime_time_flag"
      expr: prime_time_flag
      comment: "Whether the block falls within prime operating hours."
  measures:
    - name: "Block Count"
      expr: COUNT(1)
      comment: "Number of block utilization records; baseline for capacity analysis."
    - name: "Avg Utilization Pct"
      expr: ROUND(AVG(CAST(utilization_percentage AS DOUBLE)), 2)
      comment: "Average block utilization percentage; core OR efficiency KPI."
    - name: "Avg Utilization Variance Pct"
      expr: ROUND(AVG(CAST(utilization_variance_percentage AS DOUBLE)), 2)
      comment: "Average variance of actual vs target utilization; flags over/under-allocated blocks."
    - name: "Avg Turnover Minutes"
      expr: ROUND(AVG(CAST(average_turnover_minutes AS DOUBLE)), 2)
      comment: "Average room turnover time; efficiency lever for adding cases."
    - name: "On Time First Case Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN first_case_on_time_start_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of blocks whose first case started on time; leadership-tracked OR discipline KPI."
    - name: "Utilization Threshold Met Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN meets_utilization_threshold_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of blocks meeting the utilization target; drives block reallocation decisions."
    - name: "Avg Target Utilization Pct"
      expr: ROUND(AVG(CAST(target_utilization_percentage AS DOUBLE)), 2)
      comment: "Average target utilization for benchmarking against actuals."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_capacity_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity planning KPIs comparing scheduled vs utilized vs available hours and volume to steer staffing and access expansion."
  source: "`vibe_healthcare_v1`.`scheduling`.`capacity_utilization`"
  dimensions:
    - name: "planning_period_start_date"
      expr: planning_period_start_date
      comment: "Start of the capacity planning period."
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the capacity plan (draft, approved, active)."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity plan for segmentation."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting the capacity applies to."
    - name: "specialty_code"
      expr: specialty_code
      comment: "Specialty associated with the capacity plan."
    - name: "trend_indicator"
      expr: trend_indicator
      comment: "Directional trend indicator for capacity demand."
  measures:
    - name: "Total Available Hours"
      expr: SUM(CAST(available_hours AS DOUBLE))
      comment: "Total available capacity hours; denominator for utilization analysis."
    - name: "Total Utilized Hours"
      expr: SUM(CAST(utilized_hours AS DOUBLE))
      comment: "Total utilized capacity hours; drives access and staffing decisions."
    - name: "Total Scheduled Hours"
      expr: SUM(CAST(scheduled_hours AS DOUBLE))
      comment: "Total scheduled hours; leading indicator of booked demand."
    - name: "Avg Actual Utilization Rate Pct"
      expr: ROUND(AVG(CAST(actual_utilization_rate_pct AS DOUBLE)), 2)
      comment: "Average actual utilization rate; primary capacity efficiency KPI."
    - name: "Avg Target Utilization Rate Pct"
      expr: ROUND(AVG(CAST(target_utilization_rate_pct AS DOUBLE)), 2)
      comment: "Average target utilization rate for benchmarking."
    - name: "Total Utilization Variance Hours"
      expr: SUM(CAST(variance_hours AS DOUBLE))
      comment: "Sum of hours variance between planned and actual; quantifies under/over capacity."
    - name: "Avg Available FTE"
      expr: ROUND(AVG(CAST(available_fte AS DOUBLE)), 2)
      comment: "Average available FTE; ties capacity to workforce planning."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_waitlist_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waitlist and access-to-care KPIs measuring backlog, escalations, and SLA adherence to steer patient access improvements."
  source: "`vibe_healthcare_v1`.`scheduling`.`waitlist_entry`"
  dimensions:
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_datetime)
      comment: "Month the waitlist entry was created."
    - name: "entry_status"
      expr: entry_status
      comment: "Current status of the waitlist entry (active, scheduled, removed)."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of waitlist entry for segmentation."
    - name: "priority_level"
      expr: priority_level
      comment: "Clinical/operational priority of the waitlist entry."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting the waitlist entry applies to."
    - name: "specialty_required"
      expr: specialty_required
      comment: "Specialty required to fulfil the waitlist entry."
  measures:
    - name: "Waitlist Entry Count"
      expr: COUNT(1)
      comment: "Total waitlist entries; backlog volume baseline."
    - name: "Distinct Patients Waiting"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients on the waitlist; measures true access backlog."
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of waitlist entries escalated; signals access-timeliness risk."
    - name: "Avg Outreach Attempts"
      expr: ROUND(AVG(CAST(outreach_attempt_count AS DOUBLE)), 2)
      comment: "Average outreach attempts per entry; measures patient-engagement effort."
    - name: "Avg Estimated Wait Days"
      expr: ROUND(AVG(CAST(estimated_wait_time_days AS DOUBLE)), 2)
      comment: "Average estimated wait time in days; core access-to-care KPI."
    - name: "Interpreter Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN interpreter_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of entries requiring an interpreter; informs language-access resource planning."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_surgical_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical case KPIs covering volume, cancellations, add-ons, and duration accuracy used to steer OR scheduling and perioperative efficiency."
  source: "`vibe_healthcare_v1`.`scheduling`.`surgical_case`"
  dimensions:
    - name: "scheduled_date"
      expr: scheduled_date
      comment: "Scheduled date of the surgical case."
    - name: "case_status"
      expr: case_status
      comment: "Status of the case (scheduled, completed, cancelled)."
    - name: "case_type"
      expr: case_type
      comment: "Type of surgical case (elective, urgent, emergent)."
    - name: "service_line"
      expr: service_line
      comment: "Service line performing the case."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the case."
    - name: "asa_classification"
      expr: asa_classification
      comment: "ASA physical status classification for case-mix analysis."
  measures:
    - name: "Surgical Case Count"
      expr: COUNT(1)
      comment: "Total surgical cases; core perioperative volume KPI."
    - name: "Cancellation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN case_status = 'Cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of surgical cases cancelled; drives OR revenue-leakage action."
    - name: "Add On Case Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN add_on_case_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of add-on (unscheduled) cases; measures schedule volatility."
    - name: "Avg Actual Duration Minutes"
      expr: ROUND(AVG(CAST(actual_duration_minutes AS DOUBLE)), 2)
      comment: "Average actual case duration; input to block-time accuracy."
    - name: "Avg Estimated Duration Minutes"
      expr: ROUND(AVG(CAST(estimated_duration_minutes AS DOUBLE)), 2)
      comment: "Average estimated case duration for scheduling-accuracy benchmarking."
    - name: "Timeout Completion Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN timeout_completed_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of cases with a completed surgical timeout; patient-safety compliance KPI."
    - name: "ICU Bed Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN requires_icu_bed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of cases requiring an ICU bed; drives downstream bed-capacity planning."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_telehealth_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telehealth delivery KPIs covering connection quality, no-shows, technical issues, and billing eligibility to steer virtual-care operations."
  source: "`vibe_healthcare_v1`.`scheduling`.`telehealth_session`"
  dimensions:
    - name: "created_date"
      expr: DATE_TRUNC('DAY', created_datetime)
      comment: "Day the telehealth session was created."
    - name: "session_status"
      expr: session_status
      comment: "Status of the telehealth session (completed, cancelled, no-show)."
    - name: "session_type"
      expr: session_type
      comment: "Type of telehealth session for segmentation."
    - name: "platform_name"
      expr: platform_name
      comment: "Telehealth platform used to deliver the session."
    - name: "connection_status"
      expr: connection_status
      comment: "Final connection status of the session."
  measures:
    - name: "Telehealth Session Count"
      expr: COUNT(1)
      comment: "Total telehealth sessions; virtual-care volume baseline."
    - name: "No Show Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of telehealth sessions with no-shows; virtual access-efficiency KPI."
    - name: "Technical Issue Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN technical_issue_reported_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of sessions with reported technical issues; drives platform/support investment."
    - name: "Avg Connection Quality Score"
      expr: ROUND(AVG(CAST(connection_quality_score AS DOUBLE)), 2)
      comment: "Average connection quality score; measures patient virtual-care experience."
    - name: "Billing Eligible Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN billing_eligible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of sessions eligible for billing; ties telehealth volume to revenue."
    - name: "Interpreter Utilization Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN interpreter_present_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of sessions with an interpreter present; language-access performance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_recall_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive-care recall and gap-closure KPIs used to steer population health, HEDIS/STAR performance, and patient outreach."
  source: "`vibe_healthcare_v1`.`scheduling`.`recall_list`"
  dimensions:
    - name: "target_recall_date"
      expr: target_recall_date
      comment: "Target date the patient should be recalled."
    - name: "recall_status"
      expr: recall_status
      comment: "Status of the recall (open, scheduled, completed, expired)."
    - name: "recall_category"
      expr: recall_category
      comment: "Category of preventive-care recall."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the recall for outreach prioritization."
    - name: "cms_quality_program"
      expr: cms_quality_program
      comment: "Associated CMS quality program for regulatory tracking."
  measures:
    - name: "Recall Entry Count"
      expr: COUNT(1)
      comment: "Total recall list entries; care-gap volume baseline."
    - name: "Distinct Patients On Recall"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patients with an open recall; measures outreach population size."
    - name: "Numerator Eligible Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN quality_measure_numerator_eligible = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of recalls eligible for quality-measure numerator; ties outreach to HEDIS/STAR yield."
    - name: "ACO Attributed Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN aco_attributed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of recalls attributed to an ACO; informs value-based-care focus."
    - name: "Avg Outreach Attempts"
      expr: ROUND(AVG(CAST(outreach_attempt_count AS DOUBLE)), 2)
      comment: "Average outreach attempts per recall; measures engagement effort per gap."
    - name: "Star Measure Applicable Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN star_measure_applicable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of recalls applicable to STAR measures; drives Medicare Advantage revenue focus."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_appointment_reminder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient reminder effectiveness KPIs covering delivery success, opt-outs, and cost to steer engagement-channel investment."
  source: "`vibe_healthcare_v1`.`scheduling`.`appointment_reminder`"
  dimensions:
    - name: "scheduled_send_month"
      expr: DATE_TRUNC('MONTH', scheduled_send_datetime)
      comment: "Month the reminder was scheduled to send."
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel used to deliver the reminder (SMS, email, voice)."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery outcome of the reminder."
    - name: "reminder_type"
      expr: reminder_type
      comment: "Type of reminder sent."
    - name: "language_code"
      expr: language_code
      comment: "Language of the reminder for language-access analysis."
  measures:
    - name: "Reminder Count"
      expr: COUNT(1)
      comment: "Total reminders sent; engagement-volume baseline."
    - name: "Delivery Success Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN delivery_status = 'Delivered' THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percentage of reminders successfully delivered; channel-effectiveness KPI."
    - name: "Opt Out Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN opt_out_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of reminders resulting in opt-out; monitors engagement fatigue."
    - name: "Total Reminder Cost"
      expr: SUM(CAST(cost_per_reminder AS DOUBLE))
      comment: "Total reminder cost; input to cost-per-attended-appointment analysis."
    - name: "Avg Cost Per Reminder"
      expr: ROUND(AVG(CAST(cost_per_reminder AS DOUBLE)), 2)
      comment: "Average cost per reminder; channel cost-efficiency KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_provider_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider availability and access KPIs measuring open capacity, new-patient acceptance, and overbooking to steer scheduling optimization."
  source: "`vibe_healthcare_v1`.`scheduling`.`provider_availability`"
  dimensions:
    - name: "effective_start_date"
      expr: effective_start_date
      comment: "Start date of the provider availability window."
    - name: "availability_status"
      expr: availability_status
      comment: "Status of the availability record."
    - name: "availability_type"
      expr: availability_type
      comment: "Type of availability (regular, on-call, telehealth)."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for the availability."
    - name: "specialty_code"
      expr: specialty_code
      comment: "Provider specialty for access comparison."
  measures:
    - name: "Availability Record Count"
      expr: COUNT(1)
      comment: "Total availability records; baseline for provider capacity analysis."
    - name: "Distinct Available Providers"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Unique providers with availability; measures access supply breadth."
    - name: "New Patient Acceptance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN accepts_new_patients = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of availability accepting new patients; core access-expansion KPI."
    - name: "Total Booked Appointments"
      expr: SUM(CAST(booked_appointments AS DOUBLE))
      comment: "Total appointments booked into availability; measures demand fill."
    - name: "Total Remaining Capacity"
      expr: SUM(CAST(remaining_capacity AS DOUBLE))
      comment: "Total unfilled capacity; quantifies open access supply."
    - name: "Overbooking Allowed Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN overbooking_allowed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of availability allowing overbooking; risk lever for no-show mitigation."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_open_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open-slot supply KPIs measuring bookable capacity, online-booking enablement, and holds to steer digital access and slot fill."
  source: "`vibe_healthcare_v1`.`scheduling`.`open_slot`"
  dimensions:
    - name: "slot_start_date"
      expr: DATE_TRUNC('DAY', slot_start_datetime)
      comment: "Day the slot starts."
    - name: "slot_status"
      expr: slot_status
      comment: "Status of the slot (open, held, booked, blocked)."
    - name: "slot_type"
      expr: slot_type
      comment: "Type of slot for segmentation."
    - name: "slot_category"
      expr: slot_category
      comment: "Category of the slot."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting the slot serves."
  measures:
    - name: "Slot Count"
      expr: COUNT(1)
      comment: "Total open-slot records; supply-side baseline."
    - name: "Online Booking Enabled Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN online_booking_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of slots enabled for online booking; digital-access adoption KPI."
    - name: "Overbook Allowed Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN overbook_allowed_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of slots allowing overbooking; capacity-optimization lever."
    - name: "Waitlist Enabled Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN waitlist_enabled_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of slots with waitlist enabled; measures backfill capability."
    - name: "Total Remaining Capacity"
      expr: SUM(CAST(remaining_capacity AS DOUBLE))
      comment: "Total remaining bookable capacity across slots; open-access supply metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_booking_queue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Booking queue backlog and SLA KPIs measuring aging, escalations, and authorization burden to steer scheduling operations."
  source: "`vibe_healthcare_v1`.`scheduling`.`booking_queue`"
  dimensions:
    - name: "queue_entry_month"
      expr: DATE_TRUNC('MONTH', queue_entry_datetime)
      comment: "Month the booking request entered the queue."
    - name: "queue_status"
      expr: queue_status
      comment: "Status of the queue entry."
    - name: "queue_type"
      expr: queue_type
      comment: "Type of booking queue."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority of the queued booking request."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for the queued request."
  measures:
    - name: "Queue Entry Count"
      expr: COUNT(1)
      comment: "Total booking queue entries; backlog volume baseline."
    - name: "Avg Aging Days"
      expr: ROUND(AVG(CAST(aging_days AS DOUBLE)), 2)
      comment: "Average days a request has aged in the queue; core backlog-timeliness KPI."
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of queue entries escalated; signals SLA-breach risk."
    - name: "Authorization Required Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN authorization_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of requests requiring prior authorization; drives payer-workflow staffing."
    - name: "Avg Outreach Attempts"
      expr: ROUND(AVG(CAST(outreach_attempt_count AS DOUBLE)), 2)
      comment: "Average patient outreach attempts per queued request; engagement-effort metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_equipment_reservation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Equipment reservation KPIs covering conflicts, cancellations, and sterilization readiness to steer perioperative resource management."
  source: "`vibe_healthcare_v1`.`scheduling`.`equipment_reservation`"
  dimensions:
    - name: "scheduled_start_date"
      expr: DATE_TRUNC('DAY', scheduled_start_datetime)
      comment: "Day the equipment reservation starts."
    - name: "reservation_status"
      expr: reservation_status
      comment: "Status of the reservation."
    - name: "reservation_priority"
      expr: reservation_priority
      comment: "Priority of the reservation."
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment reserved."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Confirmation status of the reservation."
  measures:
    - name: "Reservation Count"
      expr: COUNT(1)
      comment: "Total equipment reservations; resource-demand baseline."
    - name: "Conflict Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN conflict_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of reservations with scheduling conflicts; drives resource-contention action."
    - name: "Sterilization Clearance Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN maintenance_clearance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of reservations with maintenance clearance; patient-safety readiness KPI."
    - name: "Avg Actual Duration Minutes"
      expr: ROUND(AVG(CAST(actual_duration_minutes AS DOUBLE)), 2)
      comment: "Average actual equipment use duration; utilization-efficiency input."
    - name: "Billable Reservation Rate Pct"
      expr: ROUND(100.0 * SUM(CASE WHEN billable_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1),0), 2)
      comment: "Share of reservations that are billable; ties equipment use to revenue."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_appointment_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tracks financial and operational impact of appointment status transitions"
  source: "`vibe_healthcare_v1`.`scheduling`.`appointment_status_history`"
  dimensions:
    - name: "new_status"
      expr: new_status
      comment: "The status an appointment transitioned to"
    - name: "prior_status"
      expr: prior_status
      comment: "The status an appointment transitioned from"
    - name: "transition_month"
      expr: DATE_TRUNC('month', transition_timestamp)
      comment: "Month of the status transition event"
  measures:
    - name: "status_change_count"
      expr: COUNT(1)
      comment: "Number of appointment status change events"
    - name: "total_estimated_revenue_impact"
      expr: SUM(CAST(estimated_revenue_impact AS DOUBLE))
      comment: "Sum of estimated revenue impact from status changes"
    - name: "total_no_show_penalty_amount"
      expr: SUM(CAST(no_show_penalty_amount AS DOUBLE))
      comment: "Total monetary penalties applied for no‑shows"
    - name: "no_show_penalty_applied_count"
      expr: SUM(CASE WHEN no_show_penalty_applied THEN 1 ELSE 0 END)
      comment: "Count of status changes where a no‑show penalty was applied"
$$;