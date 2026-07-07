-- Metric views for domain: scheduling | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core appointment KPIs: volume, no-show behavior, telehealth adoption, self-scheduling, and confirmation performance used to steer access and utilization strategy."
  source: "`vibe_healthcare_v1`.`scheduling`.`scheduling_appointment`"
  dimensions:
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting (inpatient, outpatient, ambulatory) for access analysis."
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (phone, portal, walk-in)."
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current lifecycle status of the appointment."
    - name: "visit_modality"
      expr: visit_modality
      comment: "In-person vs virtual visit modality."
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Patient confirmation state for the appointment."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month bucket of the scheduled date for trend analysis."
  measures:
    - name: "Appointment Count"
      expr: COUNT(1)
      comment: "Total number of scheduled appointments — baseline volume KPI."
    - name: "Distinct Patients Scheduled"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients with scheduled appointments — access reach."
    - name: "No Show Count"
      expr: COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END)
      comment: "Appointments where the patient failed to show — lost capacity indicator."
    - name: "No Show Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments ending in no-show — key operational efficiency KPI leadership monitors."
    - name: "Telehealth Appointment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_telehealth = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of appointments delivered via telehealth — virtual care adoption KPI."
    - name: "Self Scheduled Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN self_scheduled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of appointments booked by patients themselves — digital front-door effectiveness."
    - name: "Confirmed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN confirmation_status = 'CONFIRMED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments confirmed by patients — predictor of attendance."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_block_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating room block utilization KPIs used by perioperative leadership to manage OR capacity, first-case on-time starts, and block reallocation risk."
  source: "`vibe_healthcare_v1`.`scheduling`.`block_utilization`"
  dimensions:
    - name: "block_owner_type"
      expr: block_owner_type
      comment: "Type of block owner (service, surgeon, group)."
    - name: "owner_specialty_code"
      expr: owner_specialty_code
      comment: "Specialty that owns the OR block."
    - name: "block_utilization_status"
      expr: block_utilization_status
      comment: "Status classification of the block utilization record."
    - name: "prime_time_flag"
      expr: prime_time_flag
      comment: "Whether the block falls within prime OR time."
    - name: "utilization_month"
      expr: DATE_TRUNC('MONTH', utilization_date)
      comment: "Month bucket of the utilization date for trend analysis."
  measures:
    - name: "Block Records"
      expr: COUNT(1)
      comment: "Number of block utilization records — baseline volume."
    - name: "Avg Utilization Pct"
      expr: ROUND(AVG(CAST(utilization_percentage AS DOUBLE)), 2)
      comment: "Average OR block utilization percentage — core capacity efficiency KPI."
    - name: "Avg Utilization Variance Pct"
      expr: ROUND(AVG(CAST(utilization_variance_percentage AS DOUBLE)), 2)
      comment: "Average variance of actual vs target utilization — signals over/under allocation."
    - name: "Avg Turnover Minutes"
      expr: ROUND(AVG(CAST(average_turnover_minutes AS DOUBLE)), 2)
      comment: "Average room turnover time — throughput driver leadership targets for reduction."
    - name: "First Case On Time Start Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN first_case_on_time_start_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of blocks with an on-time first case start — key perioperative performance KPI."
    - name: "Blocks Meeting Threshold Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN meets_utilization_threshold_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of blocks meeting the utilization threshold — governs block retention decisions."
    - name: "Reallocation Risk Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN block_reallocation_risk_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of blocks flagged for reallocation risk — triggers block committee action."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_capacity_utilization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility/provider capacity planning KPIs comparing actual vs target utilization and volume to steer staffing and access investment."
  source: "`vibe_healthcare_v1`.`scheduling`.`capacity_utilization`"
  dimensions:
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for capacity segmentation."
    - name: "specialty_code"
      expr: specialty_code
      comment: "Specialty associated with the capacity record."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of capacity plan."
    - name: "trend_indicator"
      expr: trend_indicator
      comment: "Directional trend of capacity utilization."
    - name: "planning_month"
      expr: DATE_TRUNC('MONTH', planning_period_start_date)
      comment: "Month bucket of the planning period start."
  measures:
    - name: "Capacity Records"
      expr: COUNT(1)
      comment: "Number of capacity utilization records — baseline."
    - name: "Avg Actual Utilization Rate Pct"
      expr: ROUND(AVG(CAST(actual_utilization_rate_pct AS DOUBLE)), 2)
      comment: "Average actual utilization rate — core capacity efficiency KPI."
    - name: "Avg Target Utilization Rate Pct"
      expr: ROUND(AVG(CAST(target_utilization_rate_pct AS DOUBLE)), 2)
      comment: "Average target utilization rate — benchmark for planning."
    - name: "Avg Utilization Variance Pct"
      expr: ROUND(AVG(CAST(variance_utilization_pct AS DOUBLE)), 2)
      comment: "Average variance between actual and target utilization — action trigger for rebalancing."
    - name: "Total Utilized Hours"
      expr: ROUND(SUM(CAST(utilized_hours AS DOUBLE)), 2)
      comment: "Total utilized hours across capacity records — throughput volume."
    - name: "Total Scheduled Hours"
      expr: ROUND(SUM(CAST(scheduled_hours AS DOUBLE)), 2)
      comment: "Total scheduled hours — denominator for capacity utilization."
    - name: "Total Available Hours"
      expr: ROUND(SUM(CAST(available_hours AS DOUBLE)), 2)
      comment: "Total available hours — supply-side capacity baseline."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_surgical_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical case KPIs covering cancellations, add-on cases, and safety compliance (timeout, consent, site marking) for perioperative steering."
  source: "`vibe_healthcare_v1`.`scheduling`.`surgical_case`"
  dimensions:
    - name: "service_line"
      expr: service_line
      comment: "Surgical service line for volume and quality segmentation."
    - name: "case_type"
      expr: case_type
      comment: "Type of surgical case (elective, urgent, emergent)."
    - name: "urgency_level"
      expr: urgency_level
      comment: "Urgency classification of the case."
    - name: "case_status"
      expr: case_status
      comment: "Current status of the surgical case."
    - name: "asa_classification"
      expr: asa_classification
      comment: "ASA physical status classification — risk stratification."
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month bucket of the scheduled surgical date."
  measures:
    - name: "Surgical Case Count"
      expr: COUNT(1)
      comment: "Total surgical cases — baseline perioperative volume."
    - name: "Cancelled Case Count"
      expr: COUNT(CASE WHEN case_status = 'CANCELLED' THEN 1 END)
      comment: "Number of cancelled surgical cases — lost OR revenue and capacity."
    - name: "Cancellation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN case_status = 'CANCELLED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of cases cancelled — key perioperative efficiency KPI leadership reduces."
    - name: "Add On Case Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN add_on_case_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of add-on (unscheduled) cases — capacity planning stress indicator."
    - name: "Timeout Completion Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN timeout_completed_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Surgical timeout completion rate — patient safety compliance KPI."
    - name: "Site Marked Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN site_marked_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Surgical site marking compliance rate — wrong-site prevention KPI."
    - name: "Consent Obtained Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Documented consent rate — regulatory compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_appointment_reminder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient reminder delivery and cost KPIs used to optimize outreach channels, reduce no-shows, and manage communication spend."
  source: "`vibe_healthcare_v1`.`scheduling`.`appointment_reminder`"
  dimensions:
    - name: "delivery_channel"
      expr: delivery_channel
      comment: "Channel used to deliver the reminder (SMS, email, voice)."
    - name: "reminder_type"
      expr: reminder_type
      comment: "Type of reminder message."
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery outcome status of the reminder."
    - name: "language_code"
      expr: language_code
      comment: "Language of the reminder for equity analysis."
    - name: "send_month"
      expr: DATE_TRUNC('MONTH', scheduled_send_datetime)
      comment: "Month bucket of the scheduled send time."
  measures:
    - name: "Reminder Count"
      expr: COUNT(1)
      comment: "Total reminders issued — baseline outreach volume."
    - name: "Delivery Success Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN delivery_status = 'DELIVERED' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reminders successfully delivered — outreach effectiveness KPI."
    - name: "Opt Out Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN opt_out_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of recipients opting out — channel fatigue / compliance signal."
    - name: "Total Reminder Cost"
      expr: ROUND(SUM(CAST(cost_per_reminder AS DOUBLE)), 2)
      comment: "Total spend on reminders — communication cost KPI."
    - name: "Avg Reminder Cost"
      expr: ROUND(AVG(CAST(cost_per_reminder AS DOUBLE)), 2)
      comment: "Average cost per reminder — channel cost efficiency."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_waitlist_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Access-to-care waitlist KPIs measuring wait times, escalations, and outreach effort to steer capacity and patient access improvements."
  source: "`vibe_healthcare_v1`.`scheduling`.`waitlist_entry`"
  dimensions:
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting of the waitlist entry."
    - name: "entry_type"
      expr: entry_type
      comment: "Type of waitlist entry."
    - name: "entry_status"
      expr: entry_status
      comment: "Current status of the waitlist entry."
    - name: "priority_level"
      expr: priority_level
      comment: "Clinical/operational priority level of the entry."
    - name: "specialty_required"
      expr: specialty_required
      comment: "Specialty required for the waitlisted service."
    - name: "created_month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
      comment: "Month bucket the entry was created."
  measures:
    - name: "Waitlist Entry Count"
      expr: COUNT(1)
      comment: "Total waitlist entries — access demand backlog volume."
    - name: "Distinct Waitlisted Patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Unique patients waiting for appointments — access reach measure."
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of entries escalated — service level breach indicator."
    - name: "Avg Estimated Wait Days"
      expr: ROUND(AVG(CAST(estimated_wait_time_days AS DOUBLE)), 2)
      comment: "Average estimated wait time in days — patient access KPI."
    - name: "Avg Outreach Attempts"
      expr: ROUND(AVG(CAST(outreach_attempt_count AS DOUBLE)), 2)
      comment: "Average outreach attempts per entry — scheduling team effort intensity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_open_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Slot availability and online-booking KPIs used to manage schedule fill rates and digital self-service enablement."
  source: "`vibe_healthcare_v1`.`scheduling`.`open_slot`"
  dimensions:
    - name: "slot_type"
      expr: slot_type
      comment: "Type of schedule slot."
    - name: "slot_category"
      expr: slot_category
      comment: "Category classification of the slot."
    - name: "slot_status"
      expr: slot_status
      comment: "Current availability status of the slot."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting associated with the slot."
    - name: "specialty"
      expr: specialty
      comment: "Specialty the slot is designated for."
    - name: "slot_month"
      expr: DATE_TRUNC('MONTH', slot_start_datetime)
      comment: "Month bucket of the slot start time."
  measures:
    - name: "Slot Count"
      expr: COUNT(1)
      comment: "Total schedule slots — supply-side capacity volume."
    - name: "Online Booking Enabled Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN online_booking_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of slots enabled for online booking — digital access enablement KPI."
    - name: "Overbook Allowed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN overbook_allowed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of slots permitting overbooking — access buffer strategy indicator."
    - name: "Waitlist Enabled Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waitlist_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of slots with waitlist enabled — backfill readiness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_telehealth_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telehealth delivery KPIs covering connection quality, no-shows, technical issues, and consent compliance for virtual care program steering."
  source: "`vibe_healthcare_v1`.`scheduling`.`telehealth_session`"
  dimensions:
    - name: "session_type"
      expr: session_type
      comment: "Type of telehealth session."
    - name: "session_status"
      expr: session_status
      comment: "Current status of the session."
    - name: "platform_vendor"
      expr: platform_vendor
      comment: "Telehealth platform vendor for quality benchmarking."
    - name: "connection_status"
      expr: connection_status
      comment: "Connection outcome status."
    - name: "session_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_datetime)
      comment: "Month bucket of the scheduled session start."
  measures:
    - name: "Session Count"
      expr: COUNT(1)
      comment: "Total telehealth sessions — virtual care volume."
    - name: "No Show Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Telehealth no-show rate — virtual access efficiency KPI."
    - name: "Technical Issue Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN technical_issue_reported_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of sessions with technical issues — platform reliability KPI."
    - name: "Avg Connection Quality Score"
      expr: ROUND(AVG(CAST(connection_quality_score AS DOUBLE)), 2)
      comment: "Average connection quality score — virtual care experience KPI."
    - name: "Billing Eligible Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN billing_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of sessions eligible for billing — telehealth revenue capture KPI."
    - name: "Consent Obtained Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Consent capture rate for telehealth — regulatory compliance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_recall_list`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive-care recall and care-gap KPIs used by population health leadership to close quality gaps and drive HEDIS/Star performance."
  source: "`vibe_healthcare_v1`.`scheduling`.`recall_list`"
  dimensions:
    - name: "recall_category"
      expr: recall_category
      comment: "Category of the recall (screening, follow-up, chronic care)."
    - name: "recall_status"
      expr: recall_status
      comment: "Current status of the recall entry."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the recall."
    - name: "hedis_measure_code"
      expr: hedis_measure_code
      comment: "Associated HEDIS quality measure code."
    - name: "target_month"
      expr: DATE_TRUNC('MONTH', target_recall_date)
      comment: "Month bucket of the target recall date."
  measures:
    - name: "Recall Count"
      expr: COUNT(1)
      comment: "Total recall entries — outstanding preventive-care demand."
    - name: "Distinct Recall Patients"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Unique patients on recall lists — population reach."
    - name: "Gap Closure Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN recall_completion_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of recalls completed — care-gap closure KPI tied to quality revenue."
    - name: "ACO Attributed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN aco_attributed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of recalls tied to ACO-attributed patients — value-based care focus."
    - name: "Avg Outreach Attempts"
      expr: ROUND(AVG(CAST(outreach_attempt_count AS DOUBLE)), 2)
      comment: "Average outreach attempts per recall — engagement effort intensity."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_appointment_status_history`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appointment status transition KPIs quantifying cancellations, no-show penalties, revenue impact, and policy compliance for revenue-cycle and access steering."
  source: "`vibe_healthcare_v1`.`scheduling`.`appointment_status_history`"
  dimensions:
    - name: "new_status"
      expr: new_status
      comment: "New appointment status after transition."
    - name: "reason_category"
      expr: reason_category
      comment: "Category of the status change reason."
    - name: "initiated_by_role"
      expr: initiated_by_role
      comment: "Role that initiated the status transition."
    - name: "transition_source"
      expr: transition_source
      comment: "System or channel source of the transition."
    - name: "transition_month"
      expr: DATE_TRUNC('MONTH', transition_timestamp)
      comment: "Month bucket of the transition."
  measures:
    - name: "Transition Count"
      expr: COUNT(1)
      comment: "Total status transitions — baseline volume."
    - name: "No Show Penalty Applied Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN no_show_penalty_applied = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of transitions applying a no-show penalty — revenue recovery policy KPI."
    - name: "Total No Show Penalty Amount"
      expr: ROUND(SUM(CAST(no_show_penalty_amount AS DOUBLE)), 2)
      comment: "Total no-show penalty dollars — revenue-cycle recovery KPI."
    - name: "Total Estimated Revenue Impact"
      expr: ROUND(SUM(CAST(estimated_revenue_impact AS DOUBLE)), 2)
      comment: "Aggregate estimated revenue impact of status changes — financial steering KPI."
    - name: "Within Policy Window Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN within_policy_window = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of transitions within the policy notice window — compliance KPI."
    - name: "Patient Contacted Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_contacted_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of transitions where patient was contacted — service quality KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_provider_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider availability and access KPIs measuring new-patient acceptance, telehealth enablement, and booked capacity to steer network access."
  source: "`vibe_healthcare_v1`.`scheduling`.`provider_availability`"
  dimensions:
    - name: "availability_type"
      expr: availability_type
      comment: "Type of availability record."
    - name: "availability_status"
      expr: availability_status
      comment: "Current availability status."
    - name: "specialty_code"
      expr: specialty_code
      comment: "Provider specialty for network access analysis."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting of the availability."
    - name: "day_of_week"
      expr: day_of_week
      comment: "Day of week of the availability slot."
  measures:
    - name: "Availability Records"
      expr: COUNT(1)
      comment: "Number of availability records — baseline supply volume."
    - name: "Distinct Available Providers"
      expr: COUNT(DISTINCT clinician_id)
      comment: "Unique clinicians with availability — network access breadth."
    - name: "Accepts New Patients Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN accepts_new_patients_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of availability accepting new patients — access-to-care KPI."
    - name: "Telehealth Enabled Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN telehealth_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of availability enabled for telehealth — virtual access enablement KPI."
    - name: "Avg Slot Duration Minutes"
      expr: ROUND(AVG(CAST(slot_duration_minutes AS DOUBLE)), 2)
      comment: "Average slot duration — capacity granularity metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_case_material_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical supply consumption and cost KPIs used to manage OR supply spend, implant tracking, charge capture, and waste reduction."
  source: "`vibe_healthcare_v1`.`scheduling`.`case_material_usage`"
  dimensions:
    - name: "material_code"
      expr: material_code
      comment: "Material/supply code used in the case."
    - name: "material_description"
      expr: material_description
      comment: "Description of the supply item."
    - name: "unit_of_measure"
      expr: unit_of_measure
      comment: "Unit of measure for quantity."
    - name: "usage_month"
      expr: DATE_TRUNC('MONTH', usage_timestamp)
      comment: "Month bucket of the usage event."
  measures:
    - name: "Usage Records"
      expr: COUNT(1)
      comment: "Number of material usage records — baseline volume."
    - name: "Total Material Cost"
      expr: ROUND(SUM(CAST(total_cost AS DOUBLE)), 2)
      comment: "Total surgical supply cost — OR cost management KPI."
    - name: "Total Charge Amount"
      expr: ROUND(SUM(CAST(charge_amount AS DOUBLE)), 2)
      comment: "Total billable charge from materials — revenue capture KPI."
    - name: "Total Quantity Used"
      expr: ROUND(SUM(CAST(quantity_used AS DOUBLE)), 2)
      comment: "Total quantity of materials consumed — utilization volume."
    - name: "Implant Usage Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN implant_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of usage records that are implants — high-cost supply tracking KPI."
    - name: "Charge Capture Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN charge_captured_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of billable materials with charge captured — revenue leakage KPI."
    - name: "Waste Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN waste_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of usage records flagged as waste — cost-reduction target KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_booking_queue`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Scheduling queue KPIs measuring backlog aging, SLA escalations, and outreach effort to steer scheduling operations staffing."
  source: "`vibe_healthcare_v1`.`scheduling`.`booking_queue`"
  dimensions:
    - name: "queue_type"
      expr: queue_type
      comment: "Type of scheduling queue."
    - name: "queue_status"
      expr: queue_status
      comment: "Current status of the queue entry."
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the queue entry."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting of the queued request."
    - name: "enqueued_month"
      expr: DATE_TRUNC('MONTH', enqueued_timestamp)
      comment: "Month bucket the entry was enqueued."
  measures:
    - name: "Queue Entry Count"
      expr: COUNT(1)
      comment: "Total queue entries — scheduling backlog volume."
    - name: "Escalation Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN escalation_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of queue entries escalated — SLA breach indicator triggering action."
    - name: "Avg Aging Days"
      expr: ROUND(AVG(CAST(aging_days AS DOUBLE)), 2)
      comment: "Average age of queue entries in days — backlog freshness KPI."
    - name: "Avg Wait Time Minutes"
      expr: ROUND(AVG(CAST(wait_time_minutes AS DOUBLE)), 2)
      comment: "Average wait time in the queue — patient experience KPI."
    - name: "Avg Outreach Attempts"
      expr: ROUND(AVG(CAST(outreach_attempt_count AS DOUBLE)), 2)
      comment: "Average outreach attempts per entry — team effort intensity."
$$;