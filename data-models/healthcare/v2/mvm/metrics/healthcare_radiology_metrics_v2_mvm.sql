-- Metric views for domain: radiology | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 09:11:47

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_imaging_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core radiology imaging order KPIs including volume, turnaround time, critical findings, and operational efficiency metrics"
  source: "`vibe_healthcare_v1`.`radiology`.`imaging_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the imaging order (ordered, scheduled, in-progress, completed, cancelled)"
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the imaging order (routine, urgent, stat)"
    - name: "modality_type"
      expr: modality_type
      comment: "Type of imaging modality (CT, MRI, X-Ray, Ultrasound, etc.)"
    - name: "body_part"
      expr: body_part
      comment: "Anatomical body part being imaged"
    - name: "laterality"
      expr: laterality
      comment: "Side of body (left, right, bilateral) for the imaging study"
    - name: "order_source"
      expr: order_source
      comment: "Source system or channel where the order originated"
    - name: "referring_department"
      expr: referring_department
      comment: "Department that referred the patient for imaging"
    - name: "report_status"
      expr: report_status
      comment: "Status of the radiology report (preliminary, final, amended)"
    - name: "is_stat_override"
      expr: is_stat_override
      comment: "Flag indicating if order was marked as stat/emergency priority"
    - name: "is_portable"
      expr: is_portable
      comment: "Flag indicating if imaging was performed at bedside/portable"
    - name: "contrast_required"
      expr: contrast_required
      comment: "Flag indicating if contrast agent is required for the study"
    - name: "critical_finding_flag"
      expr: critical_finding_flag
      comment: "Flag indicating if a critical finding was identified"
    - name: "ordered_year"
      expr: YEAR(ordered_timestamp)
      comment: "Year the imaging order was placed"
    - name: "ordered_month"
      expr: DATE_TRUNC('MONTH', ordered_timestamp)
      comment: "Month the imaging order was placed"
    - name: "ordered_date"
      expr: DATE(ordered_timestamp)
      comment: "Date the imaging order was placed"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for order cancellation"
  measures:
    - name: "total_imaging_orders"
      expr: COUNT(1)
      comment: "Total number of imaging orders placed"
    - name: "unique_patients_imaged"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct count of patients who received imaging orders"
    - name: "critical_finding_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of imaging orders that resulted in critical findings requiring immediate clinical action"
    - name: "stat_order_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_stat_override = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of imaging orders marked as stat/emergency priority"
    - name: "portable_imaging_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_portable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of imaging performed at bedside or portable location"
    - name: "contrast_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN contrast_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of imaging orders requiring contrast agent administration"
    - name: "order_cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of imaging orders that were cancelled before completion"
    - name: "avg_order_to_exam_start_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(exam_start_timestamp) - UNIX_TIMESTAMP(ordered_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours from order placement to exam start, measuring scheduling efficiency"
    - name: "avg_exam_duration_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(exam_end_timestamp) - UNIX_TIMESTAMP(exam_start_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average duration in hours of the imaging exam itself"
    - name: "avg_exam_to_report_finalized_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(report_finalized_timestamp) - UNIX_TIMESTAMP(exam_end_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours from exam completion to report finalization, measuring radiologist turnaround time"
    - name: "avg_total_order_to_report_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(report_finalized_timestamp) - UNIX_TIMESTAMP(ordered_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average total turnaround time in hours from order placement to final report, key operational efficiency metric"
    - name: "total_radiation_dose_ctdi"
      expr: SUM(CAST(radiation_dose_ctdi AS DOUBLE))
      comment: "Total cumulative CT Dose Index across all CT imaging orders, radiation safety metric"
    - name: "total_radiation_dose_dlp"
      expr: SUM(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Total cumulative Dose Length Product across all CT imaging orders, radiation safety metric"
    - name: "avg_radiation_dose_ctdi"
      expr: AVG(CAST(radiation_dose_ctdi AS DOUBLE))
      comment: "Average CT Dose Index per imaging order, radiation safety benchmark"
    - name: "avg_radiation_dose_dlp"
      expr: AVG(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Average Dose Length Product per imaging order, radiation safety benchmark"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology appointment scheduling and utilization KPIs including no-show rates, wait times, and scheduling efficiency"
  source: "`vibe_healthcare_v1`.`radiology`.`appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the appointment (scheduled, arrived, in-progress, completed, cancelled, no-show)"
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type or category of radiology appointment"
    - name: "modality_type"
      expr: modality_type
      comment: "Type of imaging modality for the appointment"
    - name: "body_part"
      expr: body_part
      comment: "Anatomical body part to be imaged"
    - name: "priority"
      expr: priority
      comment: "Priority level of the appointment (routine, urgent, stat)"
    - name: "booking_channel"
      expr: booking_channel
      comment: "Channel through which the appointment was booked (phone, online, in-person)"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where imaging will be performed (inpatient, outpatient, emergency)"
    - name: "visit_modality"
      expr: visit_modality
      comment: "Modality of the visit (in-person, telehealth)"
    - name: "confirmation_status"
      expr: confirmation_status
      comment: "Whether the appointment has been confirmed by the patient"
    - name: "insurance_verification_status"
      expr: insurance_verification_status
      comment: "Status of insurance verification for the appointment"
    - name: "no_show_flag"
      expr: no_show_flag
      comment: "Flag indicating if patient did not show up for appointment"
    - name: "is_stat"
      expr: is_stat
      comment: "Flag indicating if appointment is stat/emergency priority"
    - name: "is_portable"
      expr: is_portable
      comment: "Flag indicating if imaging is portable/bedside"
    - name: "contrast_required"
      expr: contrast_required
      comment: "Flag indicating if contrast is required"
    - name: "scheduled_year"
      expr: YEAR(scheduled_date)
      comment: "Year of the scheduled appointment"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_date)
      comment: "Month of the scheduled appointment"
    - name: "scheduled_date_day"
      expr: scheduled_date
      comment: "Date of the scheduled appointment"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason provided for appointment cancellation"
    - name: "no_show_reason"
      expr: no_show_reason
      comment: "Reason provided for patient no-show"
  measures:
    - name: "total_appointments"
      expr: COUNT(1)
      comment: "Total number of radiology appointments scheduled"
    - name: "unique_patients_scheduled"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct count of patients with radiology appointments"
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN no_show_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments where patient did not show up, key operational efficiency and revenue leakage metric"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appointment_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments that were cancelled, impacts capacity utilization"
    - name: "completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appointment_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments successfully completed, key operational performance metric"
    - name: "confirmation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN confirmation_status = 'confirmed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments confirmed by patients, predictor of no-show risk"
    - name: "insurance_verified_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN insurance_verification_status = 'verified' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments with verified insurance, impacts revenue cycle efficiency"
    - name: "avg_booking_to_appointment_days"
      expr: AVG(CAST(DATEDIFF(scheduled_date, DATE(booking_timestamp)) AS DOUBLE))
      comment: "Average days from booking to scheduled appointment date, measures access and wait times"
    - name: "avg_arrival_to_checkin_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(check_in_timestamp) - UNIX_TIMESTAMP(arrival_timestamp)) / 60.0 AS DOUBLE))
      comment: "Average time in minutes from patient arrival to check-in completion, measures front-desk efficiency"
    - name: "avg_checkin_to_roomed_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(roomed_timestamp) - UNIX_TIMESTAMP(check_in_timestamp)) / 60.0 AS DOUBLE))
      comment: "Average time in minutes from check-in to patient roomed, measures patient flow efficiency"
    - name: "avg_roomed_to_exam_start_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(actual_start_datetime) - UNIX_TIMESTAMP(roomed_timestamp)) / 60.0 AS DOUBLE))
      comment: "Average time in minutes from patient roomed to exam start, measures technologist readiness"
    - name: "avg_exam_duration_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(actual_end_datetime) - UNIX_TIMESTAMP(actual_start_datetime)) / 60.0 AS DOUBLE))
      comment: "Average duration in minutes of the imaging exam"
    - name: "avg_scheduled_vs_actual_variance_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(actual_start_datetime) - UNIX_TIMESTAMP(scheduled_start_datetime)) / 60.0 AS DOUBLE))
      comment: "Average variance in minutes between scheduled and actual start time, measures schedule adherence"
    - name: "stat_appointment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_stat = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of appointments marked as stat/emergency, impacts capacity planning"
    - name: "avg_reschedule_count"
      expr: AVG(CAST(reschedule_count AS DOUBLE))
      comment: "Average number of times appointments were rescheduled, measures scheduling stability"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology report quality and turnaround KPIs including critical findings communication, addendum rates, and radiologist productivity"
  source: "`vibe_healthcare_v1`.`radiology`.`report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the radiology report (preliminary, final, amended, corrected)"
    - name: "modality_code"
      expr: modality_code
      comment: "Imaging modality code for the study"
    - name: "body_part"
      expr: body_part
      comment: "Anatomical body part examined"
    - name: "laterality"
      expr: laterality
      comment: "Side of body examined (left, right, bilateral)"
    - name: "critical_finding_flag"
      expr: critical_finding_flag
      comment: "Flag indicating if report contains critical findings"
    - name: "critical_finding_communicated_flag"
      expr: critical_finding_communicated_flag
      comment: "Flag indicating if critical finding was communicated to ordering provider"
    - name: "stat_priority_flag"
      expr: stat_priority_flag
      comment: "Flag indicating if report was stat/emergency priority"
    - name: "contrast_administered_flag"
      expr: contrast_administered_flag
      comment: "Flag indicating if contrast was administered during study"
    - name: "addendum_type"
      expr: addendum_type
      comment: "Type of addendum if report was amended (correction, addition, clarification)"
    - name: "rads_category"
      expr: rads_category
      comment: "Radiology reporting and data system category (e.g., BI-RADS, LI-RADS)"
    - name: "follow_up_recommendation"
      expr: follow_up_recommendation
      comment: "Follow-up recommendation provided in the report"
    - name: "study_year"
      expr: YEAR(study_datetime)
      comment: "Year the imaging study was performed"
    - name: "study_month"
      expr: DATE_TRUNC('MONTH', study_datetime)
      comment: "Month the imaging study was performed"
    - name: "study_date"
      expr: DATE(study_datetime)
      comment: "Date the imaging study was performed"
  measures:
    - name: "total_reports"
      expr: COUNT(1)
      comment: "Total number of radiology reports generated"
    - name: "unique_patients_reported"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with radiology reports"
    - name: "critical_finding_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports containing critical findings requiring immediate clinical action"
    - name: "critical_finding_communication_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_finding_communicated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of critical findings that were successfully communicated to ordering provider, key patient safety and regulatory compliance metric"
    - name: "addendum_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN addendum_type IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports requiring addenda, quality metric indicating initial report completeness"
    - name: "stat_report_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN stat_priority_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of reports marked as stat/emergency priority"
    - name: "avg_dictation_to_transcription_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(transcription_timestamp) - UNIX_TIMESTAMP(dictation_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours from dictation to transcription completion"
    - name: "avg_transcription_to_preliminary_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(preliminary_timestamp) - UNIX_TIMESTAMP(transcription_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours from transcription to preliminary report availability"
    - name: "avg_preliminary_to_final_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(attestation_timestamp) - UNIX_TIMESTAMP(preliminary_timestamp)) / 3600.0 AS DOUBLE))
      comment: "Average time in hours from preliminary to final signed report"
    - name: "avg_study_to_final_report_hours"
      expr: AVG(CAST((UNIX_TIMESTAMP(attestation_timestamp) - UNIX_TIMESTAMP(study_datetime)) / 3600.0 AS DOUBLE))
      comment: "Average total turnaround time in hours from study completion to final report, key radiologist productivity and operational efficiency metric"
    - name: "avg_critical_finding_communication_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(critical_finding_communicated_timestamp) - UNIX_TIMESTAMP(study_datetime)) / 60.0 AS DOUBLE))
      comment: "Average time in minutes to communicate critical findings after study completion, critical patient safety metric"
    - name: "total_radiation_dose_ctdi"
      expr: SUM(CAST(radiation_dose_ctdi AS DOUBLE))
      comment: "Total cumulative CT Dose Index documented in reports"
    - name: "total_radiation_dose_dlp"
      expr: SUM(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Total cumulative Dose Length Product documented in reports"
    - name: "avg_radiation_dose_ctdi"
      expr: AVG(CAST(radiation_dose_ctdi AS DOUBLE))
      comment: "Average CT Dose Index per report, radiation safety benchmark"
    - name: "avg_radiation_dose_dlp"
      expr: AVG(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Average Dose Length Product per report, radiation safety benchmark"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_contrast_admin`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contrast administration safety and adverse reaction KPIs for patient safety monitoring and quality improvement"
  source: "`vibe_healthcare_v1`.`radiology`.`contrast_admin`"
  dimensions:
    - name: "administration_status"
      expr: administration_status
      comment: "Status of contrast administration (planned, administered, cancelled)"
    - name: "contrast_agent_name"
      expr: contrast_agent_name
      comment: "Name of the contrast agent administered"
    - name: "agent_class"
      expr: agent_class
      comment: "Class of contrast agent (ionic, non-ionic, gadolinium-based)"
    - name: "agent_osmolality_type"
      expr: agent_osmolality_type
      comment: "Osmolality type of contrast agent (iso-osmolar, low-osmolar, high-osmolar)"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route by which contrast was administered (IV, oral, rectal)"
    - name: "body_region"
      expr: body_region
      comment: "Body region for which contrast was administered"
    - name: "modality"
      expr: modality
      comment: "Imaging modality for which contrast was used"
    - name: "adverse_reaction_occurred"
      expr: adverse_reaction_occurred
      comment: "Flag indicating if adverse reaction occurred"
    - name: "adverse_reaction_severity"
      expr: adverse_reaction_severity
      comment: "Severity level of adverse reaction (mild, moderate, severe)"
    - name: "extravasation_occurred"
      expr: extravasation_occurred
      comment: "Flag indicating if contrast extravasation occurred"
    - name: "power_injector_used"
      expr: power_injector_used
      comment: "Flag indicating if power injector was used for administration"
    - name: "premedication_given"
      expr: premedication_given
      comment: "Flag indicating if premedication was given to prevent reaction"
    - name: "informed_consent_obtained"
      expr: informed_consent_obtained
      comment: "Flag indicating if informed consent was obtained"
    - name: "pregnancy_status"
      expr: pregnancy_status
      comment: "Pregnancy status of patient at time of administration"
    - name: "thyroid_disease_flag"
      expr: thyroid_disease_flag
      comment: "Flag indicating if patient has thyroid disease"
    - name: "metformin_held"
      expr: metformin_held
      comment: "Flag indicating if metformin was held prior to contrast administration"
    - name: "contrast_allergy_screening_result"
      expr: contrast_allergy_screening_result
      comment: "Result of contrast allergy screening"
    - name: "administration_year"
      expr: YEAR(administration_datetime)
      comment: "Year contrast was administered"
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_datetime)
      comment: "Month contrast was administered"
  measures:
    - name: "total_contrast_administrations"
      expr: COUNT(1)
      comment: "Total number of contrast administrations performed"
    - name: "unique_patients_receiving_contrast"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct count of patients who received contrast"
    - name: "adverse_reaction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN adverse_reaction_occurred = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contrast administrations resulting in adverse reactions, critical patient safety metric"
    - name: "severe_reaction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN adverse_reaction_severity = 'severe' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contrast administrations resulting in severe adverse reactions, key patient safety and quality metric"
    - name: "extravasation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN extravasation_occurred = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contrast administrations resulting in extravasation, quality and safety metric"
    - name: "premedication_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN premedication_given = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contrast administrations where premedication was given to prevent reactions"
    - name: "informed_consent_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN informed_consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contrast administrations with documented informed consent, regulatory compliance metric"
    - name: "power_injector_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN power_injector_used = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of contrast administrations using power injector"
    - name: "avg_contrast_dose_ml"
      expr: AVG(CAST(dose_ml AS DOUBLE))
      comment: "Average contrast dose volume in milliliters administered per patient"
    - name: "avg_contrast_dose_mg"
      expr: AVG(CAST(dose_amount_mg AS DOUBLE))
      comment: "Average contrast dose amount in milligrams administered per patient"
    - name: "avg_injection_rate_ml_per_sec"
      expr: AVG(CAST(injection_rate_ml_per_sec AS DOUBLE))
      comment: "Average injection rate in milliliters per second"
    - name: "avg_patient_weight_kg"
      expr: AVG(CAST(patient_weight_kg AS DOUBLE))
      comment: "Average patient weight in kilograms at time of contrast administration"
    - name: "avg_extravasation_volume_ml"
      expr: AVG(CAST(extravasation_volume_ml AS DOUBLE))
      comment: "Average volume in milliliters of contrast extravasated when extravasation occurred"
    - name: "total_contrast_volume_ml"
      expr: SUM(CAST(dose_ml AS DOUBLE))
      comment: "Total volume of contrast administered in milliliters, inventory and cost management metric"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_critical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical radiology finding notification and communication KPIs for patient safety and regulatory compliance monitoring"
  source: "`vibe_healthcare_v1`.`radiology`.`critical_result`"
  dimensions:
    - name: "finding_category"
      expr: finding_category
      comment: "Category of critical finding (vascular, oncologic, infectious, traumatic)"
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity level of the critical finding"
    - name: "notification_status"
      expr: notification_status
      comment: "Status of notification to ordering provider (pending, completed, failed)"
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify provider (phone, page, secure message, in-person)"
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "Method by which provider acknowledged the critical finding"
    - name: "acknowledged_flag"
      expr: acknowledged_flag
      comment: "Flag indicating if critical finding was acknowledged by provider"
    - name: "read_back_performed"
      expr: read_back_performed
      comment: "Flag indicating if read-back verification was performed"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Flag indicating if notification required escalation"
    - name: "escalation_reason"
      expr: escalation_reason
      comment: "Reason escalation was required"
    - name: "patient_safety_event_flag"
      expr: patient_safety_event_flag
      comment: "Flag indicating if critical finding was associated with patient safety event"
    - name: "tjc_compliance_status"
      expr: tjc_compliance_status
      comment: "Joint Commission compliance status for critical result notification"
    - name: "emtala_applicable"
      expr: emtala_applicable
      comment: "Flag indicating if EMTALA regulations apply to this critical finding"
    - name: "patient_care_setting"
      expr: patient_care_setting
      comment: "Care setting where patient was located (inpatient, outpatient, emergency)"
    - name: "modality"
      expr: modality
      comment: "Imaging modality that identified the critical finding"
    - name: "body_part_examined"
      expr: body_part_examined
      comment: "Body part where critical finding was identified"
    - name: "finding_year"
      expr: YEAR(finding_datetime)
      comment: "Year the critical finding was identified"
    - name: "finding_month"
      expr: DATE_TRUNC('MONTH', finding_datetime)
      comment: "Month the critical finding was identified"
  measures:
    - name: "total_critical_results"
      expr: COUNT(1)
      comment: "Total number of critical radiology findings identified"
    - name: "unique_patients_with_critical_findings"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct count of patients with critical radiology findings"
    - name: "acknowledgment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN acknowledged_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of critical findings acknowledged by ordering provider, key patient safety and regulatory compliance metric"
    - name: "read_back_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN read_back_performed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of critical findings with documented read-back verification, Joint Commission compliance metric"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of critical findings requiring escalation due to communication challenges"
    - name: "patient_safety_event_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_safety_event_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of critical findings associated with patient safety events, quality and risk management metric"
    - name: "tjc_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN tjc_compliance_status = 'compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of critical findings meeting Joint Commission compliance standards, regulatory metric"
    - name: "avg_notification_turnaround_minutes"
      expr: AVG(CAST(notification_turnaround_minutes AS DOUBLE))
      comment: "Average time in minutes from finding identification to provider notification, critical patient safety metric"
    - name: "avg_acknowledgment_turnaround_minutes"
      expr: AVG(CAST(acknowledgment_turnaround_minutes AS DOUBLE))
      comment: "Average time in minutes from notification to provider acknowledgment, measures communication loop closure"
    - name: "avg_finding_to_notification_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(notification_datetime) - UNIX_TIMESTAMP(finding_datetime)) / 60.0 AS DOUBLE))
      comment: "Average time in minutes from finding identification to notification initiation, key patient safety timeliness metric"
    - name: "avg_notification_to_acknowledgment_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(acknowledgment_datetime) - UNIX_TIMESTAMP(notification_datetime)) / 60.0 AS DOUBLE))
      comment: "Average time in minutes from notification to acknowledgment, measures provider responsiveness"
    - name: "avg_notification_attempts"
      expr: AVG(CAST(notification_attempt_count AS DOUBLE))
      comment: "Average number of attempts required to successfully notify provider, measures communication efficiency"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_modality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology equipment utilization, maintenance, and operational status KPIs for capacity planning and asset management"
  source: "`vibe_healthcare_v1`.`radiology`.`modality`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the modality (operational, down, maintenance, decommissioned)"
    - name: "dicom_modality_code"
      expr: dicom_modality_code
      comment: "DICOM standard modality code (CT, MR, CR, DX, US, etc.)"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of imaging equipment"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Equipment manufacturer name"
    - name: "model_name"
      expr: model_name
      comment: "Equipment model name"
    - name: "department_name"
      expr: department_name
      comment: "Department where modality is located"
    - name: "room_identifier"
      expr: room_identifier
      comment: "Room identifier where modality is located"
    - name: "is_mobile"
      expr: is_mobile
      comment: "Flag indicating if modality is mobile/portable"
    - name: "contrast_capable"
      expr: contrast_capable
      comment: "Flag indicating if modality supports contrast imaging"
    - name: "radiation_emitting"
      expr: radiation_emitting
      comment: "Flag indicating if modality emits ionizing radiation"
    - name: "dose_tracking_enabled"
      expr: dose_tracking_enabled
      comment: "Flag indicating if radiation dose tracking is enabled"
    - name: "acr_accreditation_status"
      expr: acr_accreditation_status
      comment: "American College of Radiology accreditation status"
    - name: "shared_service_indicator"
      expr: shared_service_indicator
      comment: "Flag indicating if modality is shared across multiple facilities"
    - name: "installation_year"
      expr: YEAR(installation_date)
      comment: "Year the modality was installed"
  measures:
    - name: "total_modalities"
      expr: COUNT(1)
      comment: "Total number of imaging modalities in the fleet"
    - name: "operational_modalities"
      expr: SUM(CASE WHEN operational_status = 'operational' THEN 1 ELSE 0 END)
      comment: "Count of modalities currently operational and available for use"
    - name: "operational_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN operational_status = 'operational' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of modalities that are operational, key capacity and uptime metric"
    - name: "acr_accredited_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN acr_accreditation_status = 'accredited' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of modalities with current ACR accreditation, quality and regulatory compliance metric"
    - name: "dose_tracking_enabled_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dose_tracking_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of radiation-emitting modalities with dose tracking enabled, patient safety metric"
    - name: "contrast_capable_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN contrast_capable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of modalities capable of contrast-enhanced imaging"
    - name: "mobile_modality_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_mobile = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of modalities that are mobile/portable"
    - name: "avg_scheduled_hours_per_day"
      expr: AVG(CAST(scheduled_hours_per_day AS DOUBLE))
      comment: "Average scheduled operating hours per day across all modalities, capacity planning metric"
    - name: "avg_days_since_last_calibration"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE(), last_calibration_date) AS DOUBLE))
      comment: "Average days since last calibration across all modalities, quality assurance metric"
    - name: "avg_days_since_last_pm"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE(), last_preventive_maintenance_date) AS DOUBLE))
      comment: "Average days since last preventive maintenance, equipment reliability metric"
    - name: "avg_days_until_next_calibration"
      expr: AVG(CAST(DATEDIFF(next_calibration_due_date, CURRENT_DATE()) AS DOUBLE))
      comment: "Average days until next calibration due, proactive maintenance planning metric"
    - name: "avg_days_until_next_pm"
      expr: AVG(CAST(DATEDIFF(next_preventive_maintenance_date, CURRENT_DATE()) AS DOUBLE))
      comment: "Average days until next preventive maintenance due, proactive maintenance planning metric"
    - name: "avg_equipment_age_years"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE(), installation_date) / 365.25 AS DOUBLE))
      comment: "Average age of equipment in years, capital planning and replacement cycle metric"
    - name: "avg_max_patient_weight_kg"
      expr: AVG(CAST(max_patient_weight_kg AS DOUBLE))
      comment: "Average maximum patient weight capacity in kilograms across modalities"
    - name: "avg_bore_diameter_cm"
      expr: AVG(CAST(bore_diameter_cm AS DOUBLE))
      comment: "Average bore diameter in centimeters for MRI and CT modalities"
    - name: "avg_tesla_field_strength"
      expr: AVG(CAST(tesla_field_strength AS DOUBLE))
      comment: "Average magnetic field strength in Tesla for MRI modalities"
$$;