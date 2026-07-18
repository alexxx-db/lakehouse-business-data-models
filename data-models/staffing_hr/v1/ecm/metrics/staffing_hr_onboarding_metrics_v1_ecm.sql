-- Metric views for domain: onboarding | Business: Staffing Hr | Version: 1 | Generated on: 2026-05-02 15:43:14

CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`onboarding_engagement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core onboarding engagement metrics tracking time-to-ready, completion rates, and SLA performance for worker onboarding lifecycle"
  source: "`staffing_hr_ecm`.`onboarding`.`onboarding_engagement`"
  dimensions:
    - name: "onboarding_status"
      expr: onboarding_status
      comment: "Current status of the onboarding engagement (e.g., In Progress, Completed, On Hold, Cancelled)"
    - name: "onboarding_type"
      expr: onboarding_type
      comment: "Type of onboarding process (e.g., New Hire, Rehire, Transfer, Contractor)"
    - name: "employment_type"
      expr: employment_type
      comment: "Employment classification (e.g., Full-Time, Part-Time, Temporary, Contract)"
    - name: "worker_classification"
      expr: worker_classification
      comment: "Worker classification for compliance (e.g., W2, 1099, Contractor)"
    - name: "onboarding_priority"
      expr: onboarding_priority
      comment: "Priority level of the onboarding engagement (e.g., High, Medium, Low, Critical)"
    - name: "onboarding_start_month"
      expr: DATE_TRUNC('MONTH', onboarding_start_date)
      comment: "Month when onboarding process started"
    - name: "assignment_start_month"
      expr: DATE_TRUNC('MONTH', assignment_start_date)
      comment: "Month when assignment is scheduled to start"
    - name: "training_status"
      expr: training_status
      comment: "Status of training completion (e.g., Not Started, In Progress, Completed, Waived)"
    - name: "orientation_status"
      expr: orientation_status
      comment: "Status of orientation completion (e.g., Not Started, Scheduled, Completed, No Show)"
    - name: "equipment_provisioning_status"
      expr: equipment_provisioning_status
      comment: "Status of equipment provisioning (e.g., Not Required, Requested, Fulfilled, Returned)"
    - name: "direct_deposit_status"
      expr: direct_deposit_status
      comment: "Status of direct deposit setup (e.g., Not Started, Pending, Verified, Active)"
    - name: "tax_forms_status"
      expr: tax_forms_status
      comment: "Status of tax form collection (e.g., Not Started, Pending, Submitted, Verified)"
  measures:
    - name: "total_onboarding_engagements"
      expr: COUNT(1)
      comment: "Total number of onboarding engagements"
    - name: "total_workers_onboarded"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of workers going through onboarding"
    - name: "avg_time_to_ready_days"
      expr: AVG(CAST(actual_onboarding_days AS DOUBLE))
      comment: "Average number of days from onboarding start to worker ready status"
    - name: "avg_completion_percentage"
      expr: AVG(CAST(completion_percentage AS DOUBLE))
      comment: "Average completion percentage across all onboarding engagements"
    - name: "avg_fte_value"
      expr: AVG(CAST(fte_value AS DOUBLE))
      comment: "Average FTE value of workers being onboarded"
    - name: "total_fte_onboarded"
      expr: SUM(CAST(fte_value AS DOUBLE))
      comment: "Total FTE capacity being onboarded"
    - name: "onboarding_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN onboarding_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of onboarding engagements that reached completed status"
    - name: "onboarding_cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN onboarding_status = 'Cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of onboarding engagements that were cancelled before completion"
    - name: "avg_overdue_tasks"
      expr: AVG(CAST(overdue_tasks_count AS DOUBLE))
      comment: "Average number of overdue tasks per onboarding engagement"
    - name: "training_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN training_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of engagements with completed training"
    - name: "orientation_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN orientation_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of engagements with completed orientation"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`onboarding_task_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Task-level onboarding metrics tracking completion rates, cycle times, and blocking task performance"
  source: "`staffing_hr_ecm`.`onboarding`.`task_assignment`"
  dimensions:
    - name: "task_status"
      expr: task_status
      comment: "Current status of the task (e.g., Not Started, In Progress, Completed, Blocked, Waived)"
    - name: "task_category"
      expr: task_category
      comment: "Category of the onboarding task (e.g., Documentation, Training, Compliance, Equipment, System Access)"
    - name: "task_subcategory"
      expr: task_subcategory
      comment: "Subcategory providing more granular task classification"
    - name: "task_priority"
      expr: task_priority
      comment: "Priority level of the task (e.g., Critical, High, Medium, Low)"
    - name: "responsible_party"
      expr: responsible_party
      comment: "Party responsible for completing the task (e.g., Worker, Recruiter, Client, Vendor)"
    - name: "is_blocking"
      expr: is_blocking
      comment: "Whether this task blocks onboarding progression"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether this task is mandatory for onboarding completion"
    - name: "escalation_level"
      expr: escalation_level
      comment: "Current escalation level for overdue or blocked tasks"
    - name: "system_access_type"
      expr: system_access_type
      comment: "Type of system access being provisioned (e.g., VPN, Email, Application, Database)"
    - name: "completed_month"
      expr: DATE_TRUNC('MONTH', completed_date)
      comment: "Month when task was completed"
    - name: "due_month"
      expr: DATE_TRUNC('MONTH', due_date)
      comment: "Month when task is due"
  measures:
    - name: "total_tasks"
      expr: COUNT(1)
      comment: "Total number of onboarding tasks"
    - name: "total_engagements_with_tasks"
      expr: COUNT(DISTINCT onboarding_engagement_id)
      comment: "Distinct count of onboarding engagements with tasks"
    - name: "task_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN task_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks that have been completed"
    - name: "blocking_task_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_blocking = TRUE AND task_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_blocking = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of blocking tasks that have been completed"
    - name: "mandatory_task_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_mandatory = TRUE AND task_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_mandatory = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of mandatory tasks that have been completed"
    - name: "task_waiver_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN task_status = 'Waived' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks that were waived rather than completed"
    - name: "avg_training_completion_score"
      expr: AVG(CAST(training_completion_score AS DOUBLE))
      comment: "Average training completion score across all training tasks"
    - name: "total_blocking_tasks"
      expr: SUM(CASE WHEN is_blocking = TRUE THEN 1 ELSE 0 END)
      comment: "Total count of tasks that block onboarding progression"
    - name: "total_mandatory_tasks"
      expr: SUM(CASE WHEN is_mandatory = TRUE THEN 1 ELSE 0 END)
      comment: "Total count of mandatory tasks"
    - name: "escalated_task_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_level IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tasks that have been escalated"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`onboarding_lms_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Learning management system enrollment metrics tracking training completion, pass rates, and compliance training effectiveness"
  source: "`staffing_hr_ecm`.`onboarding`.`lms_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the enrollment (e.g., Enrolled, In Progress, Completed, Failed, Expired)"
    - name: "pass_fail_status"
      expr: pass_fail_status
      comment: "Pass or fail status of the course (e.g., Pass, Fail, Pending)"
    - name: "delivery_method"
      expr: delivery_method
      comment: "Method of course delivery (e.g., Online, Instructor-Led, Blended, Self-Paced)"
    - name: "is_mandatory"
      expr: is_mandatory
      comment: "Whether the course is mandatory for the worker"
    - name: "is_assignment_blocking"
      expr: is_assignment_blocking
      comment: "Whether this course blocks assignment start"
    - name: "waiver_flag"
      expr: waiver_flag
      comment: "Whether a waiver was granted for this enrollment"
    - name: "assignment_reason"
      expr: assignment_reason
      comment: "Reason the course was assigned (e.g., Client Requirement, Compliance, Skill Development)"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month when worker was enrolled in the course"
    - name: "completion_month"
      expr: DATE_TRUNC('MONTH', completion_date)
      comment: "Month when course was completed"
  measures:
    - name: "total_enrollments"
      expr: COUNT(1)
      comment: "Total number of course enrollments"
    - name: "total_learners"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of workers enrolled in courses"
    - name: "total_courses_enrolled"
      expr: COUNT(DISTINCT lms_course_id)
      comment: "Distinct count of courses with active enrollments"
    - name: "course_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN enrollment_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that reached completed status"
    - name: "course_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN pass_fail_status = 'Pass' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN pass_fail_status IN ('Pass', 'Fail') THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of completed courses that resulted in a pass"
    - name: "avg_course_score"
      expr: AVG(CAST(score AS DOUBLE))
      comment: "Average score achieved across all enrollments"
    - name: "avg_time_spent_hours"
      expr: AVG(CAST(time_spent_hours AS DOUBLE))
      comment: "Average time spent in hours per enrollment"
    - name: "total_training_hours"
      expr: SUM(CAST(time_spent_hours AS DOUBLE))
      comment: "Total training hours consumed across all enrollments"
    - name: "avg_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average course duration in hours"
    - name: "mandatory_course_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_mandatory = TRUE AND enrollment_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_mandatory = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of mandatory courses that have been completed"
    - name: "blocking_course_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_assignment_blocking = TRUE AND enrollment_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_assignment_blocking = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of assignment-blocking courses that have been completed"
    - name: "course_waiver_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN waiver_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of enrollments that received a waiver"
    - name: "first_attempt_pass_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN attempt_number = '1' AND pass_fail_status = 'Pass' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN attempt_number = '1' AND pass_fail_status IN ('Pass', 'Fail') THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of learners who passed on their first attempt"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`onboarding_offboarding_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Offboarding metrics tracking separation reasons, equipment returns, exit interview completion, and rehire eligibility"
  source: "`staffing_hr_ecm`.`onboarding`.`offboarding_record`"
  dimensions:
    - name: "offboarding_status"
      expr: offboarding_status
      comment: "Current status of the offboarding process (e.g., Initiated, In Progress, Completed, Cancelled)"
    - name: "offboarding_type"
      expr: offboarding_type
      comment: "Type of offboarding (e.g., Voluntary, Involuntary, End of Assignment, Conversion)"
    - name: "exit_reason_category"
      expr: exit_reason_category
      comment: "Category of exit reason (e.g., Resignation, Termination, Completion, Conversion, Performance)"
    - name: "offboarding_initiated_by"
      expr: offboarding_initiated_by
      comment: "Party who initiated offboarding (e.g., Worker, Client, Staffing Firm, Mutual)"
    - name: "rehire_eligibility"
      expr: rehire_eligibility
      comment: "Rehire eligibility status (e.g., Eligible, Not Eligible, Review Required)"
    - name: "exit_interview_status"
      expr: exit_interview_status
      comment: "Status of exit interview (e.g., Scheduled, Completed, Declined, Not Required)"
    - name: "equipment_return_status"
      expr: equipment_return_status
      comment: "Status of equipment return (e.g., Not Required, Pending, Returned, Overdue)"
    - name: "conversion_to_perm_flag"
      expr: conversion_to_perm_flag
      comment: "Whether the worker converted to permanent employment"
    - name: "redeployment_flag"
      expr: redeployment_flag
      comment: "Whether the worker was redeployed to another assignment"
    - name: "separation_month"
      expr: DATE_TRUNC('MONTH', separation_date)
      comment: "Month when separation occurred"
    - name: "last_day_worked_month"
      expr: DATE_TRUNC('MONTH', last_day_worked)
      comment: "Month of last day worked"
  measures:
    - name: "total_offboarding_records"
      expr: COUNT(1)
      comment: "Total number of offboarding records"
    - name: "total_workers_offboarded"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of workers who have been offboarded"
    - name: "voluntary_separation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN offboarding_type = 'Voluntary' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of offboardings that were voluntary separations"
    - name: "conversion_to_perm_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN conversion_to_perm_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of offboardings that resulted in conversion to permanent employment"
    - name: "redeployment_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN redeployment_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of offboardings that resulted in redeployment to another assignment"
    - name: "rehire_eligible_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rehire_eligibility = 'Eligible' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of offboarded workers who are eligible for rehire"
    - name: "exit_interview_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN exit_interview_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of offboardings with completed exit interviews"
    - name: "equipment_return_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN equipment_return_required = TRUE AND equipment_return_status = 'Returned' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN equipment_return_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of required equipment returns that have been completed"
    - name: "avg_offboarding_checklist_completion_pct"
      expr: AVG(CAST(offboarding_checklist_completion_pct AS DOUBLE))
      comment: "Average completion percentage of offboarding checklists"
    - name: "total_conversion_fees"
      expr: SUM(CAST(conversion_fee_amount AS DOUBLE))
      comment: "Total conversion fees collected from permanent conversions"
    - name: "avg_conversion_fee"
      expr: AVG(CAST(conversion_fee_amount AS DOUBLE))
      comment: "Average conversion fee per permanent conversion"
    - name: "total_pto_payout_amount"
      expr: SUM(CAST(pto_payout_amount AS DOUBLE))
      comment: "Total PTO payout amount across all offboardings"
    - name: "avg_pto_payout_hours"
      expr: AVG(CAST(pto_payout_hours AS DOUBLE))
      comment: "Average PTO hours paid out per offboarding"
    - name: "unemployment_claim_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN unemployment_claim_filed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of offboardings that resulted in unemployment claims"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`onboarding_document_collection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Document collection metrics tracking submission rates, electronic signature adoption, and document verification cycle times"
  source: "`staffing_hr_ecm`.`onboarding`.`document_collection`"
  dimensions:
    - name: "document_status"
      expr: document_status
      comment: "Current status of the document (e.g., Pending, Submitted, Reviewed, Approved, Rejected)"
    - name: "document_type"
      expr: document_type
      comment: "Type of document (e.g., W4, I9, Direct Deposit, NDA, Background Check Consent)"
    - name: "onboarding_phase"
      expr: onboarding_phase
      comment: "Onboarding phase when document is required (e.g., Pre-Start, Day 1, Week 1, Post-Start)"
    - name: "is_required"
      expr: is_required
      comment: "Whether the document is required for onboarding completion"
    - name: "is_electronic_signature"
      expr: is_electronic_signature
      comment: "Whether the document was signed electronically"
    - name: "filing_status"
      expr: filing_status
      comment: "Tax filing status (for tax forms)"
    - name: "exempt_flag"
      expr: exempt_flag
      comment: "Whether worker claimed exempt status (for tax forms)"
    - name: "source_system"
      expr: source_system
      comment: "System where document was collected (e.g., DocuSign, Internal Portal, Manual)"
    - name: "submission_month"
      expr: DATE_TRUNC('MONTH', form_submission_date)
      comment: "Month when document was submitted"
  measures:
    - name: "total_documents"
      expr: COUNT(1)
      comment: "Total number of documents in collection process"
    - name: "total_workers_with_documents"
      expr: COUNT(DISTINCT profile_id)
      comment: "Distinct count of workers with documents being collected"
    - name: "document_submission_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN document_status IN ('Submitted', 'Reviewed', 'Approved') THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of documents that have been submitted"
    - name: "document_approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN document_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN document_status IN ('Reviewed', 'Approved', 'Rejected') THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of reviewed documents that were approved"
    - name: "document_rejection_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN document_status = 'Rejected' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN document_status IN ('Reviewed', 'Approved', 'Rejected') THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of reviewed documents that were rejected"
    - name: "electronic_signature_adoption_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_electronic_signature = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of documents signed electronically"
    - name: "required_document_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_required = TRUE AND document_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN is_required = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of required documents that have been approved"
    - name: "avg_additional_withholding"
      expr: AVG(CAST(additional_withholding_amount AS DOUBLE))
      comment: "Average additional withholding amount claimed on tax forms"
    - name: "tax_exempt_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN exempt_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tax forms claiming exempt status"
$$;


CREATE OR REPLACE VIEW `staffing_hr_ecm`.`_metrics`.`onboarding_orientation_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Orientation session metrics tracking attendance, completion, satisfaction scores, and session capacity utilization"
  source: "`staffing_hr_ecm`.`onboarding`.`orientation_session`"
  dimensions:
    - name: "session_status"
      expr: session_status
      comment: "Current status of the orientation session (e.g., Scheduled, In Progress, Completed, Cancelled)"
    - name: "orientation_type"
      expr: orientation_type
      comment: "Type of orientation (e.g., General, Client-Specific, Role-Specific, Safety)"
    - name: "location_type"
      expr: location_type
      comment: "Type of location (e.g., Virtual, On-Site, Hybrid)"
    - name: "mandatory_flag"
      expr: mandatory_flag
      comment: "Whether attendance is mandatory"
    - name: "assessment_required"
      expr: assessment_required
      comment: "Whether an assessment is required for completion"
    - name: "compliance_category"
      expr: compliance_category
      comment: "Compliance category of the orientation (e.g., Safety, OSHA, Client-Required, Industry-Specific)"
    - name: "language"
      expr: language
      comment: "Language in which orientation is conducted"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month when session is scheduled"
  measures:
    - name: "total_sessions"
      expr: COUNT(1)
      comment: "Total number of orientation sessions"
    - name: "session_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN session_status = 'Completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that were completed"
    - name: "session_cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN session_status = 'Cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions that were cancelled"
    - name: "avg_session_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average duration of orientation sessions in hours"
    - name: "avg_registered_count"
      expr: AVG(CAST(registered_count AS DOUBLE))
      comment: "Average number of registrations per session"
    - name: "avg_attended_count"
      expr: AVG(CAST(attended_count AS DOUBLE))
      comment: "Average number of attendees per session"
    - name: "avg_completed_count"
      expr: AVG(CAST(completed_count AS DOUBLE))
      comment: "Average number of completions per session"
    - name: "avg_satisfaction_score"
      expr: AVG(CAST(average_satisfaction_score AS DOUBLE))
      comment: "Average satisfaction score across all sessions"
    - name: "avg_cost_per_attendee"
      expr: AVG(CAST(cost_per_attendee AS DOUBLE))
      comment: "Average cost per attendee across sessions"
    - name: "avg_passing_score_percentage"
      expr: AVG(CAST(passing_score_percentage AS DOUBLE))
      comment: "Average passing score percentage required for sessions with assessments"
    - name: "virtual_session_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN location_type = 'Virtual' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of sessions conducted virtually"
$$;
