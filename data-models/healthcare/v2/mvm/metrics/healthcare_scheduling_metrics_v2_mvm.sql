-- Metric views for domain: scheduling | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 09:11:47

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_appointment_type`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Appointment Type business metrics"
  source: "`vibe_healthcare_v1`.`scheduling`.`appointment_type`"
  dimensions:
    - name: "Allows Self Scheduling"
      expr: allows_self_scheduling
    - name: "Allows Telehealth"
      expr: allows_telehealth
    - name: "Appointment Type Status"
      expr: appointment_type_status
    - name: "Billing Class"
      expr: billing_class
    - name: "Cancellation Notice Hours"
      expr: cancellation_notice_hours
    - name: "Care Setting"
      expr: care_setting
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Default Duration Minutes"
      expr: default_duration_minutes
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Equipment Required"
      expr: equipment_required
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Maximum Duration Minutes"
      expr: maximum_duration_minutes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Appointment Type"
      expr: COUNT(DISTINCT appointment_type_id)
    - name: "Total Rvu Malpractice"
      expr: SUM(rvu_malpractice)
    - name: "Average Rvu Malpractice"
      expr: AVG(rvu_malpractice)
    - name: "Total Rvu Practice Expense"
      expr: SUM(rvu_practice_expense)
    - name: "Average Rvu Practice Expense"
      expr: AVG(rvu_practice_expense)
    - name: "Total Rvu Work"
      expr: SUM(rvu_work)
    - name: "Average Rvu Work"
      expr: AVG(rvu_work)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_open_slot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Open Slot business metrics"
  source: "`vibe_healthcare_v1`.`scheduling`.`open_slot`"
  dimensions:
    - name: "Appointment Type Eligibility"
      expr: appointment_type_eligibility
    - name: "Block Reason"
      expr: block_reason
    - name: "Block Type"
      expr: block_type
    - name: "Care Setting"
      expr: care_setting
    - name: "Comment"
      expr: comment
    - name: "Created Datetime"
      expr: created_datetime
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Hold Expiration Datetime"
      expr: hold_expiration_datetime
    - name: "Hold Reason"
      expr: hold_reason
    - name: "Hold Status"
      expr: hold_status
    - name: "Insurance Eligibility"
      expr: insurance_eligibility
    - name: "Last Modified Datetime"
      expr: last_modified_datetime
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Max Capacity"
      expr: max_capacity
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Open Slot"
      expr: COUNT(DISTINCT open_slot_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_or_block`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Or Block business metrics"
  source: "`vibe_healthcare_v1`.`scheduling`.`or_block`"
  dimensions:
    - name: "Allows Overbooking"
      expr: allows_overbooking
    - name: "Allows Sharing"
      expr: allows_sharing
    - name: "Anesthesia Type Required"
      expr: anesthesia_type_required
    - name: "Block Duration Minutes"
      expr: block_duration_minutes
    - name: "Block End Time"
      expr: block_end_time
    - name: "Block Name"
      expr: block_name
    - name: "Block Number"
      expr: block_number
    - name: "Block Owner Type"
      expr: block_owner_type
    - name: "Block Start Time"
      expr: block_start_time
    - name: "Block Status"
      expr: block_status
    - name: "Block Type"
      expr: block_type
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Day Of Week"
      expr: day_of_week
    - name: "Effective End Date"
      expr: effective_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Or Block"
      expr: COUNT(DISTINCT or_block_id)
    - name: "Total Minimum Utilization Threshold Pct"
      expr: SUM(minimum_utilization_threshold_pct)
    - name: "Average Minimum Utilization Threshold Pct"
      expr: AVG(minimum_utilization_threshold_pct)
    - name: "Total Target Utilization Threshold Pct"
      expr: SUM(target_utilization_threshold_pct)
    - name: "Average Target Utilization Threshold Pct"
      expr: AVG(target_utilization_threshold_pct)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_provider_availability`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Provider Availability business metrics"
  source: "`vibe_healthcare_v1`.`scheduling`.`provider_availability`"
  dimensions:
    - name: "Accepts New Patients"
      expr: accepts_new_patients
    - name: "Accepts New Patients Flag"
      expr: accepts_new_patients_flag
    - name: "Approval Timestamp"
      expr: approval_timestamp
    - name: "Availability Status"
      expr: availability_status
    - name: "Availability Type"
      expr: availability_type
    - name: "Booked Appointments"
      expr: booked_appointments
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Care Setting"
      expr: care_setting
    - name: "Coverage Area"
      expr: coverage_area
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credentialing Status"
      expr: credentialing_status
    - name: "Day Of Week"
      expr: day_of_week
    - name: "Duration Minutes"
      expr: duration_minutes
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Provider Availability"
      expr: COUNT(DISTINCT provider_availability_id)
    - name: "Total Slot Duration Minutes"
      expr: SUM(slot_duration_minutes)
    - name: "Average Slot Duration Minutes"
      expr: AVG(slot_duration_minutes)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_resource_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Resource Assignment business metrics"
  source: "`vibe_healthcare_v1`.`scheduling`.`resource_assignment`"
  dimensions:
    - name: "Actual End Datetime"
      expr: actual_end_datetime
    - name: "Actual Start Datetime"
      expr: actual_start_datetime
    - name: "Assignment Notes"
      expr: assignment_notes
    - name: "Assignment Priority"
      expr: assignment_priority
    - name: "Assignment Role"
      expr: assignment_role
    - name: "Assignment Status"
      expr: assignment_status
    - name: "Billable Flag"
      expr: billable_flag
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled Datetime"
      expr: cancelled_datetime
    - name: "Charge Code"
      expr: charge_code
    - name: "Confirmation Datetime"
      expr: confirmation_datetime
    - name: "Confirmation Status"
      expr: confirmation_status
    - name: "Conflict Description"
      expr: conflict_description
    - name: "Conflict Flag"
      expr: conflict_flag
    - name: "Created Datetime"
      expr: created_datetime
    - name: "Created Timestamp"
      expr: created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Resource Assignment"
      expr: COUNT(DISTINCT resource_assignment_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_schedulable_resource`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedulable Resource business metrics"
  source: "`vibe_healthcare_v1`.`scheduling`.`schedulable_resource`"
  dimensions:
    - name: "Accepts New Patients"
      expr: accepts_new_patients
    - name: "Allows Overbooking"
      expr: allows_overbooking
    - name: "Building"
      expr: building
    - name: "Care Setting"
      expr: care_setting
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credentialing Expiration Date"
      expr: credentialing_expiration_date
    - name: "Credentialing Status"
      expr: credentialing_status
    - name: "Default Slot Duration Minutes"
      expr: default_slot_duration_minutes
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Floor"
      expr: floor
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "License Number"
      expr: license_number
    - name: "License State"
      expr: license_state
    - name: "Location Code"
      expr: location_code
    - name: "Maintenance Window End"
      expr: maintenance_window_end
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Schedulable Resource"
      expr: COUNT(DISTINCT schedulable_resource_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_schedule_template`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Schedule Template business metrics"
  source: "`vibe_healthcare_v1`.`scheduling`.`schedule_template`"
  dimensions:
    - name: "Approval Status"
      expr: approval_status
    - name: "Approved Timestamp"
      expr: approved_timestamp
    - name: "Auto Confirm Flag"
      expr: auto_confirm_flag
    - name: "Buffer Time Minutes"
      expr: buffer_time_minutes
    - name: "Cancellation Policy Code"
      expr: cancellation_policy_code
    - name: "Care Setting"
      expr: care_setting
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Day Of Week"
      expr: day_of_week
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Insurance Type Accepted"
      expr: insurance_type_accepted
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Max Slots Per Session"
      expr: max_slots_per_session
    - name: "Modified Timestamp"
      expr: modified_timestamp
    - name: "No Show Tracking Enabled Flag"
      expr: no_show_tracking_enabled_flag
    - name: "Notes"
      expr: notes
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Schedule Template"
      expr: COUNT(DISTINCT schedule_template_id)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_surgical_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical Case business metrics"
  source: "`vibe_healthcare_v1`.`scheduling`.`surgical_case`"
  dimensions:
    - name: "Actual Duration Minutes"
      expr: actual_duration_minutes
    - name: "Actual End Time"
      expr: actual_end_time
    - name: "Actual Start Time"
      expr: actual_start_time
    - name: "Add On Case Indicator"
      expr: add_on_case_indicator
    - name: "Anesthesia Type"
      expr: anesthesia_type
    - name: "Asa Classification"
      expr: asa_classification
    - name: "Block Time Indicator"
      expr: block_time_indicator
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancellation Timestamp"
      expr: cancellation_timestamp
    - name: "Case Number"
      expr: case_number
    - name: "Case Status"
      expr: case_status
    - name: "Case Type"
      expr: case_type
    - name: "Consent Obtained Indicator"
      expr: consent_obtained_indicator
    - name: "Consent Timestamp"
      expr: consent_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Surgical Case"
      expr: COUNT(DISTINCT surgical_case_id)
    - name: "Total Record Number"
      expr: SUM(record_number)
    - name: "Average Record Number"
      expr: AVG(record_number)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_telehealth_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Telehealth Session business metrics"
  source: "`vibe_healthcare_v1`.`scheduling`.`telehealth_session`"
  dimensions:
    - name: "Actual Duration Minutes"
      expr: actual_duration_minutes
    - name: "Actual End Datetime"
      expr: actual_end_datetime
    - name: "Actual Start Datetime"
      expr: actual_start_datetime
    - name: "Billing Eligible Flag"
      expr: billing_eligible_flag
    - name: "Billing Modifier Code"
      expr: billing_modifier_code
    - name: "Cancellation Datetime"
      expr: cancellation_datetime
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled By Role"
      expr: cancelled_by_role
    - name: "Connection Status"
      expr: connection_status
    - name: "Consent Datetime"
      expr: consent_datetime
    - name: "Consent Obtained Flag"
      expr: consent_obtained_flag
    - name: "Created Datetime"
      expr: created_datetime
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Distant Site Code"
      expr: distant_site_code
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Telehealth Session"
      expr: COUNT(DISTINCT telehealth_session_id)
    - name: "Total Connection Quality Score"
      expr: SUM(connection_quality_score)
    - name: "Average Connection Quality Score"
      expr: AVG(connection_quality_score)
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`scheduling_waitlist_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Waitlist Entry business metrics"
  source: "`vibe_healthcare_v1`.`scheduling`.`waitlist_entry`"
  dimensions:
    - name: "Authorization Required Flag"
      expr: authorization_required_flag
    - name: "Care Setting"
      expr: care_setting
    - name: "Created Datetime"
      expr: created_datetime
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Entry Number"
      expr: entry_number
    - name: "Entry Status"
      expr: entry_status
    - name: "Entry Type"
      expr: entry_type
    - name: "Escalation Datetime"
      expr: escalation_datetime
    - name: "Escalation Flag"
      expr: escalation_flag
    - name: "Escalation Reason"
      expr: escalation_reason
    - name: "Estimated Wait Time Days"
      expr: estimated_wait_time_days
    - name: "Interpreter Required Flag"
      expr: interpreter_required_flag
    - name: "Language Preference"
      expr: language_preference
    - name: "Last Modified Datetime"
      expr: last_modified_datetime
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Waitlist Entry"
      expr: COUNT(DISTINCT waitlist_entry_id)
    - name: "Total Record Number"
      expr: SUM(record_number)
    - name: "Average Record Number"
      expr: AVG(record_number)
$$;