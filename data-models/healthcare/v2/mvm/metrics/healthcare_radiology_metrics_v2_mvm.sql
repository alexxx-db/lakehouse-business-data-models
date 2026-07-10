-- Metric views for domain: radiology | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 16:17:39

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_imaging_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core radiology order performance metrics including volume, turnaround time, critical findings, and order status distribution"
  source: "`vibe_healthcare_v1`.`radiology`.`imaging_order`"
  dimensions:
    - name: "order_status"
      expr: order_status
      comment: "Current status of the imaging order (ordered, scheduled, in-progress, completed, cancelled)"
    - name: "order_priority"
      expr: order_priority
      comment: "Priority level of the imaging order (STAT, urgent, routine)"
    - name: "modality_type"
      expr: modality_type
      comment: "Type of imaging modality (CT, MRI, X-Ray, Ultrasound, etc.)"
    - name: "order_source"
      expr: order_source
      comment: "Source system or department that originated the order"
    - name: "referring_department"
      expr: referring_department
      comment: "Department that referred the patient for imaging"
    - name: "contrast_required"
      expr: contrast_required
      comment: "Whether contrast agent is required for the exam"
    - name: "is_stat_override"
      expr: is_stat_override
      comment: "Whether the order was marked as STAT priority override"
    - name: "is_portable"
      expr: is_portable
      comment: "Whether the imaging is portable/bedside"
    - name: "critical_finding_flag"
      expr: critical_finding_flag
      comment: "Whether a critical finding was identified"
    - name: "report_status"
      expr: report_status
      comment: "Status of the radiology report (preliminary, final, addended)"
    - name: "laterality"
      expr: laterality
      comment: "Body side examined (left, right, bilateral)"
    - name: "order_year"
      expr: YEAR(ordered_timestamp)
      comment: "Year the order was placed"
    - name: "order_month"
      expr: DATE_TRUNC('MONTH', ordered_timestamp)
      comment: "Month the order was placed"
    - name: "order_date"
      expr: DATE_TRUNC('DAY', ordered_timestamp)
      comment: "Date the order was placed"
  measures:
    - name: "total_imaging_orders"
      expr: COUNT(imaging_order_id)
      comment: "Total number of imaging orders placed"
    - name: "unique_patients_imaged"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients who received imaging orders"
    - name: "stat_order_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_stat_override = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(imaging_order_id), 0), 2)
      comment: "Percentage of orders marked as STAT priority"
    - name: "critical_finding_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(imaging_order_id), 0), 2)
      comment: "Percentage of orders with critical findings identified"
    - name: "contrast_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN contrast_required = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(imaging_order_id), 0), 2)
      comment: "Percentage of orders requiring contrast agent"
    - name: "portable_exam_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_portable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(imaging_order_id), 0), 2)
      comment: "Percentage of exams performed as portable/bedside"
    - name: "order_cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN order_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(imaging_order_id), 0), 2)
      comment: "Percentage of orders that were cancelled"
    - name: "avg_order_to_exam_start_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(exam_start_timestamp) - UNIX_TIMESTAMP(ordered_timestamp)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average hours from order placement to exam start"
    - name: "avg_exam_duration_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(exam_end_timestamp) - UNIX_TIMESTAMP(exam_start_timestamp)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average duration of imaging exam in hours"
    - name: "avg_exam_to_report_finalized_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(report_finalized_timestamp) - UNIX_TIMESTAMP(exam_end_timestamp)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average hours from exam completion to report finalization"
    - name: "avg_order_to_report_turnaround_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(report_finalized_timestamp) - UNIX_TIMESTAMP(ordered_timestamp)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average total turnaround time from order to finalized report in hours"
    - name: "total_radiation_dose_ctdi"
      expr: SUM(CAST(radiation_dose_ctdi AS DOUBLE))
      comment: "Total cumulative CT Dose Index across all orders"
    - name: "total_radiation_dose_dlp"
      expr: SUM(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Total cumulative Dose Length Product across all orders"
    - name: "avg_radiation_dose_ctdi"
      expr: AVG(CAST(radiation_dose_ctdi AS DOUBLE))
      comment: "Average CT Dose Index per order"
    - name: "avg_radiation_dose_dlp"
      expr: AVG(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Average Dose Length Product per order"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology study execution and quality metrics including volume, critical findings, radiation safety, and PACS performance"
  source: "`vibe_healthcare_v1`.`radiology`.`study`"
  dimensions:
    - name: "study_status"
      expr: study_status
      comment: "Current status of the radiology study"
    - name: "priority"
      expr: priority
      comment: "Priority level of the study (STAT, urgent, routine)"
    - name: "pacs_status"
      expr: pacs_status
      comment: "Status of the study in the PACS system"
    - name: "report_status"
      expr: report_status
      comment: "Status of the associated radiology report"
    - name: "contrast_administered"
      expr: contrast_administered
      comment: "Whether contrast was administered during the study"
    - name: "critical_finding_flag"
      expr: critical_finding_flag
      comment: "Whether a critical finding was identified in the study"
    - name: "is_stat_read_completed"
      expr: is_stat_read_completed
      comment: "Whether a STAT read was completed for the study"
    - name: "is_external_import"
      expr: is_external_import
      comment: "Whether the study was imported from an external facility"
    - name: "laterality"
      expr: laterality
      comment: "Body side examined (left, right, bilateral)"
    - name: "referring_department"
      expr: referring_department
      comment: "Department that referred the patient for the study"
    - name: "patient_sex"
      expr: patient_sex
      comment: "Patient sex at time of study"
    - name: "study_year"
      expr: YEAR(study_date)
      comment: "Year the study was performed"
    - name: "study_month"
      expr: DATE_TRUNC('MONTH', study_date)
      comment: "Month the study was performed"
    - name: "study_date_day"
      expr: DATE_TRUNC('DAY', study_date)
      comment: "Date the study was performed"
  measures:
    - name: "total_studies"
      expr: COUNT(study_id)
      comment: "Total number of radiology studies performed"
    - name: "unique_patients_studied"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients who had studies performed"
    - name: "critical_finding_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(study_id), 0), 2)
      comment: "Percentage of studies with critical findings"
    - name: "stat_read_completion_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_stat_read_completed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(study_id), 0), 2)
      comment: "Percentage of studies where STAT read was completed"
    - name: "external_import_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_external_import = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(study_id), 0), 2)
      comment: "Percentage of studies imported from external facilities"
    - name: "contrast_administration_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN contrast_administered = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(study_id), 0), 2)
      comment: "Percentage of studies where contrast was administered"
    - name: "avg_study_to_report_finalized_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(report_finalized_timestamp) - UNIX_TIMESTAMP(start_timestamp)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average hours from study start to report finalization"
    - name: "avg_critical_finding_notification_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(critical_finding_notified_timestamp) - UNIX_TIMESTAMP(start_timestamp)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average hours from study start to critical finding notification"
    - name: "total_study_size_gb"
      expr: ROUND(SUM(CAST(size_mb AS DOUBLE)) / 1024.0, 2)
      comment: "Total storage size of all studies in gigabytes"
    - name: "avg_study_size_mb"
      expr: AVG(CAST(size_mb AS DOUBLE))
      comment: "Average storage size per study in megabytes"
    - name: "total_image_count"
      expr: SUM(CAST(image_count AS BIGINT))
      comment: "Total number of images across all studies"
    - name: "avg_images_per_study"
      expr: AVG(CAST(image_count AS DOUBLE))
      comment: "Average number of images per study"
    - name: "total_series_count"
      expr: SUM(CAST(series_count AS BIGINT))
      comment: "Total number of series across all studies"
    - name: "avg_series_per_study"
      expr: AVG(CAST(series_count AS DOUBLE))
      comment: "Average number of series per study"
    - name: "total_radiation_dose_ctdi_vol"
      expr: SUM(CAST(radiation_dose_ctdi_vol AS DOUBLE))
      comment: "Total cumulative CT Dose Index Volume across all studies"
    - name: "total_radiation_dose_dlp"
      expr: SUM(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Total cumulative Dose Length Product across all studies"
    - name: "avg_radiation_dose_ctdi_vol"
      expr: AVG(CAST(radiation_dose_ctdi_vol AS DOUBLE))
      comment: "Average CT Dose Index Volume per study"
    - name: "avg_radiation_dose_dlp"
      expr: AVG(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Average Dose Length Product per study"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_critical_result`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical radiology finding notification and compliance metrics including turnaround times, acknowledgment rates, and regulatory compliance"
  source: "`vibe_healthcare_v1`.`radiology`.`critical_result`"
  dimensions:
    - name: "finding_severity"
      expr: finding_severity
      comment: "Severity level of the critical finding"
    - name: "notification_status"
      expr: notification_status
      comment: "Status of the critical finding notification"
    - name: "notification_method"
      expr: notification_method
      comment: "Method used to notify provider of critical finding (phone, page, EMR alert)"
    - name: "acknowledgment_method"
      expr: acknowledgment_method
      comment: "Method by which provider acknowledged the critical finding"
    - name: "escalation_flag"
      expr: escalation_flag
      comment: "Whether the critical finding required escalation"
    - name: "escalation_reason"
      expr: escalation_reason
      comment: "Reason for escalating the critical finding notification"
    - name: "read_back_performed"
      expr: read_back_performed
      comment: "Whether read-back verification was performed"
    - name: "patient_safety_event_flag"
      expr: patient_safety_event_flag
      comment: "Whether the critical finding triggered a patient safety event"
    - name: "emtala_applicable"
      expr: emtala_applicable
      comment: "Whether EMTALA regulations apply to this critical finding"
    - name: "tjc_compliance_status"
      expr: tjc_compliance_status
      comment: "Joint Commission compliance status for critical result notification"
    - name: "modality"
      expr: modality
      comment: "Imaging modality that produced the critical finding"
    - name: "patient_care_setting"
      expr: patient_care_setting
      comment: "Care setting where patient was located (inpatient, ED, outpatient)"
    - name: "finding_year"
      expr: YEAR(finding_datetime)
      comment: "Year the critical finding was identified"
    - name: "finding_month"
      expr: DATE_TRUNC('MONTH', finding_datetime)
      comment: "Month the critical finding was identified"
  measures:
    - name: "total_critical_findings"
      expr: COUNT(critical_result_id)
      comment: "Total number of critical radiology findings"
    - name: "unique_patients_with_critical_findings"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with critical findings"
    - name: "notification_success_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN notification_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(critical_result_id), 0), 2)
      comment: "Percentage of critical findings successfully notified to providers"
    - name: "escalation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN escalation_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(critical_result_id), 0), 2)
      comment: "Percentage of critical findings requiring escalation"
    - name: "read_back_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN read_back_performed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(critical_result_id), 0), 2)
      comment: "Percentage of critical findings with read-back verification performed"
    - name: "patient_safety_event_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_safety_event_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(critical_result_id), 0), 2)
      comment: "Percentage of critical findings that triggered patient safety events"
    - name: "tjc_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN tjc_compliance_status = 'compliant' THEN 1 ELSE 0 END) / NULLIF(COUNT(critical_result_id), 0), 2)
      comment: "Percentage of critical findings meeting Joint Commission compliance standards"
    - name: "avg_notification_turnaround_minutes"
      expr: AVG(CAST(notification_turnaround_minutes AS DOUBLE))
      comment: "Average minutes from finding identification to provider notification"
    - name: "avg_acknowledgment_turnaround_minutes"
      expr: AVG(CAST(acknowledgment_turnaround_minutes AS DOUBLE))
      comment: "Average minutes from notification to provider acknowledgment"
    - name: "avg_notification_attempts"
      expr: AVG(CAST(notification_attempt_count AS DOUBLE))
      comment: "Average number of attempts required to notify provider of critical finding"
    - name: "avg_finding_to_notification_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(notification_datetime) - UNIX_TIMESTAMP(finding_datetime)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average hours from finding identification to notification"
    - name: "avg_notification_to_acknowledgment_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(acknowledgment_datetime) - UNIX_TIMESTAMP(notification_datetime)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average hours from notification to provider acknowledgment"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_contrast_admin`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Contrast agent administration safety and quality metrics including adverse reaction rates, protocol compliance, and patient safety"
  source: "`vibe_healthcare_v1`.`radiology`.`contrast_admin`"
  dimensions:
    - name: "administration_status"
      expr: administration_status
      comment: "Status of the contrast administration"
    - name: "agent_class"
      expr: agent_class
      comment: "Class of contrast agent (ionic, non-ionic, gadolinium-based)"
    - name: "agent_osmolality_type"
      expr: agent_osmolality_type
      comment: "Osmolality type of contrast agent (iso-osmolar, low-osmolar, high-osmolar)"
    - name: "route_of_administration"
      expr: route_of_administration
      comment: "Route by which contrast was administered (IV, oral, rectal)"
    - name: "modality"
      expr: modality
      comment: "Imaging modality for which contrast was administered"
    - name: "body_region"
      expr: body_region
      comment: "Body region being imaged with contrast"
    - name: "adverse_reaction_occurred"
      expr: adverse_reaction_occurred
      comment: "Whether an adverse reaction to contrast occurred"
    - name: "adverse_reaction_severity"
      expr: adverse_reaction_severity
      comment: "Severity of adverse reaction (mild, moderate, severe)"
    - name: "extravasation_occurred"
      expr: extravasation_occurred
      comment: "Whether contrast extravasation occurred"
    - name: "power_injector_used"
      expr: power_injector_used
      comment: "Whether a power injector was used for contrast administration"
    - name: "premedication_given"
      expr: premedication_given
      comment: "Whether premedication was given prior to contrast"
    - name: "informed_consent_obtained"
      expr: informed_consent_obtained
      comment: "Whether informed consent was obtained for contrast administration"
    - name: "pregnancy_status"
      expr: pregnancy_status
      comment: "Pregnancy status of patient at time of contrast administration"
    - name: "thyroid_disease_flag"
      expr: thyroid_disease_flag
      comment: "Whether patient has thyroid disease (relevant for iodinated contrast)"
    - name: "metformin_held"
      expr: metformin_held
      comment: "Whether metformin was held prior to contrast administration"
    - name: "administration_year"
      expr: YEAR(administration_datetime)
      comment: "Year contrast was administered"
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_datetime)
      comment: "Month contrast was administered"
  measures:
    - name: "total_contrast_administrations"
      expr: COUNT(contrast_admin_id)
      comment: "Total number of contrast agent administrations"
    - name: "unique_patients_receiving_contrast"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients who received contrast"
    - name: "adverse_reaction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN adverse_reaction_occurred = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(contrast_admin_id), 0), 2)
      comment: "Percentage of contrast administrations resulting in adverse reactions"
    - name: "severe_adverse_reaction_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN adverse_reaction_severity = 'severe' THEN 1 ELSE 0 END) / NULLIF(COUNT(contrast_admin_id), 0), 2)
      comment: "Percentage of contrast administrations resulting in severe adverse reactions"
    - name: "extravasation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN extravasation_occurred = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(contrast_admin_id), 0), 2)
      comment: "Percentage of contrast administrations with extravasation events"
    - name: "premedication_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN premedication_given = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(contrast_admin_id), 0), 2)
      comment: "Percentage of contrast administrations where indicated premedication was given"
    - name: "informed_consent_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN informed_consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(contrast_admin_id), 0), 2)
      comment: "Percentage of contrast administrations with documented informed consent"
    - name: "power_injector_utilization_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN power_injector_used = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(contrast_admin_id), 0), 2)
      comment: "Percentage of contrast administrations using power injector"
    - name: "total_contrast_volume_ml"
      expr: SUM(CAST(dose_volume_ml AS DOUBLE))
      comment: "Total volume of contrast administered in milliliters"
    - name: "avg_contrast_volume_ml"
      expr: AVG(CAST(dose_volume_ml AS DOUBLE))
      comment: "Average volume of contrast per administration in milliliters"
    - name: "total_contrast_dose_mg"
      expr: SUM(CAST(dose_amount_mg AS DOUBLE))
      comment: "Total dose of contrast administered in milligrams"
    - name: "avg_contrast_dose_mg"
      expr: AVG(CAST(dose_amount_mg AS DOUBLE))
      comment: "Average dose of contrast per administration in milligrams"
    - name: "avg_injection_rate_ml_per_sec"
      expr: AVG(CAST(injection_rate_ml_per_sec AS DOUBLE))
      comment: "Average injection rate in milliliters per second"
    - name: "avg_contrast_concentration_mg_per_ml"
      expr: AVG(CAST(concentration_mg_per_ml AS DOUBLE))
      comment: "Average contrast concentration in milligrams per milliliter"
    - name: "avg_extravasation_volume_ml"
      expr: AVG(CAST(extravasation_volume_ml AS DOUBLE))
      comment: "Average volume of contrast extravasated when extravasation occurs"
    - name: "avg_patient_weight_kg"
      expr: AVG(CAST(patient_weight_kg AS DOUBLE))
      comment: "Average patient weight at time of contrast administration in kilograms"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_modality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Imaging equipment utilization, maintenance, and operational performance metrics"
  source: "`vibe_healthcare_v1`.`radiology`.`modality`"
  dimensions:
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the modality (active, down, maintenance)"
    - name: "dicom_modality_code"
      expr: dicom_modality_code
      comment: "DICOM standard modality code (CT, MR, CR, DX, US, etc.)"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of imaging equipment"
    - name: "manufacturer"
      expr: manufacturer
      comment: "Equipment manufacturer"
    - name: "model_name"
      expr: model_name
      comment: "Equipment model name"
    - name: "is_mobile"
      expr: is_mobile
      comment: "Whether the modality is mobile/portable"
    - name: "contrast_capable"
      expr: contrast_capable
      comment: "Whether the modality supports contrast-enhanced imaging"
    - name: "radiation_emitting"
      expr: radiation_emitting
      comment: "Whether the modality emits ionizing radiation"
    - name: "dose_tracking_enabled"
      expr: dose_tracking_enabled
      comment: "Whether radiation dose tracking is enabled"
    - name: "acr_accreditation_status"
      expr: acr_accreditation_status
      comment: "ACR accreditation status of the modality"
    - name: "shared_service_indicator"
      expr: shared_service_indicator
      comment: "Whether the modality is shared across multiple departments"
    - name: "department_name"
      expr: department_name
      comment: "Department where the modality is located"
    - name: "building_code"
      expr: building_code
      comment: "Building code where the modality is located"
  measures:
    - name: "total_modalities"
      expr: COUNT(modality_id)
      comment: "Total number of imaging modalities"
    - name: "operational_modality_count"
      expr: SUM(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of modalities currently operational"
    - name: "operational_availability_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN operational_status = 'active' THEN 1 ELSE 0 END) / NULLIF(COUNT(modality_id), 0), 2)
      comment: "Percentage of modalities currently operational"
    - name: "mobile_modality_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_mobile = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(modality_id), 0), 2)
      comment: "Percentage of modalities that are mobile/portable"
    - name: "contrast_capable_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN contrast_capable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(modality_id), 0), 2)
      comment: "Percentage of modalities capable of contrast-enhanced imaging"
    - name: "radiation_emitting_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN radiation_emitting = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(modality_id), 0), 2)
      comment: "Percentage of modalities that emit ionizing radiation"
    - name: "dose_tracking_compliance_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN dose_tracking_enabled = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(modality_id), 0), 2)
      comment: "Percentage of radiation-emitting modalities with dose tracking enabled"
    - name: "acr_accreditation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN acr_accreditation_status = 'accredited' THEN 1 ELSE 0 END) / NULLIF(COUNT(modality_id), 0), 2)
      comment: "Percentage of modalities with current ACR accreditation"
    - name: "avg_scheduled_hours_per_day"
      expr: AVG(CAST(scheduled_hours_per_day AS DOUBLE))
      comment: "Average scheduled operating hours per day across modalities"
    - name: "avg_max_patient_weight_kg"
      expr: AVG(CAST(max_patient_weight_kg AS DOUBLE))
      comment: "Average maximum patient weight capacity in kilograms"
    - name: "avg_bore_diameter_cm"
      expr: AVG(CAST(bore_diameter_cm AS DOUBLE))
      comment: "Average bore diameter in centimeters for applicable modalities"
    - name: "avg_tesla_field_strength"
      expr: AVG(CAST(tesla_field_strength AS DOUBLE))
      comment: "Average magnetic field strength in Tesla for MRI modalities"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_appointment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology appointment scheduling efficiency and patient access metrics including no-show rates, wait times, and schedule adherence"
  source: "`vibe_healthcare_v1`.`radiology`.`radiology_appointment`"
  dimensions:
    - name: "appointment_status"
      expr: appointment_status
      comment: "Current status of the radiology appointment"
    - name: "appointment_type"
      expr: appointment_type
      comment: "Type of radiology appointment"
    - name: "modality_type"
      expr: modality_type
      comment: "Type of imaging modality scheduled"
    - name: "is_stat"
      expr: is_stat
      comment: "Whether the appointment is STAT priority"
    - name: "is_portable"
      expr: is_portable
      comment: "Whether the appointment is for portable/bedside imaging"
    - name: "contrast_required"
      expr: contrast_required
      comment: "Whether contrast is required for the appointment"
    - name: "laterality"
      expr: laterality
      comment: "Body side to be examined (left, right, bilateral)"
    - name: "body_part"
      expr: body_part
      comment: "Body part to be imaged"
    - name: "scheduling_source"
      expr: scheduling_source
      comment: "Source system or method used to schedule the appointment"
    - name: "patient_location"
      expr: patient_location
      comment: "Patient location at time of appointment"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for appointment cancellation"
    - name: "no_show_reason"
      expr: no_show_reason
      comment: "Reason for patient no-show"
    - name: "radiation_dose_flag"
      expr: radiation_dose_flag
      comment: "Whether the exam involves radiation dose"
    - name: "scheduled_year"
      expr: YEAR(scheduled_start_datetime)
      comment: "Year the appointment is scheduled"
    - name: "scheduled_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_datetime)
      comment: "Month the appointment is scheduled"
    - name: "scheduled_date"
      expr: DATE_TRUNC('DAY', scheduled_start_datetime)
      comment: "Date the appointment is scheduled"
  measures:
    - name: "total_appointments"
      expr: COUNT(radiology_appointment_id)
      comment: "Total number of radiology appointments scheduled"
    - name: "unique_patients_scheduled"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with radiology appointments"
    - name: "completed_appointment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appointment_status = 'completed' THEN 1 ELSE 0 END) / NULLIF(COUNT(radiology_appointment_id), 0), 2)
      comment: "Percentage of appointments that were completed"
    - name: "no_show_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appointment_status = 'no_show' THEN 1 ELSE 0 END) / NULLIF(COUNT(radiology_appointment_id), 0), 2)
      comment: "Percentage of appointments where patient did not show"
    - name: "cancellation_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN appointment_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(radiology_appointment_id), 0), 2)
      comment: "Percentage of appointments that were cancelled"
    - name: "stat_appointment_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_stat = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(radiology_appointment_id), 0), 2)
      comment: "Percentage of appointments marked as STAT priority"
    - name: "portable_exam_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN is_portable = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(radiology_appointment_id), 0), 2)
      comment: "Percentage of appointments for portable/bedside exams"
    - name: "avg_scheduled_duration_minutes"
      expr: AVG(CAST(scheduled_duration_minutes AS DOUBLE))
      comment: "Average scheduled duration of appointments in minutes"
    - name: "avg_actual_duration_minutes"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(actual_end_datetime) - UNIX_TIMESTAMP(actual_start_datetime)) / 60.0 AS DOUBLE)), 2)
      comment: "Average actual duration of completed appointments in minutes"
    - name: "avg_start_time_variance_minutes"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(actual_start_datetime) - UNIX_TIMESTAMP(scheduled_start_datetime)) / 60.0 AS DOUBLE)), 2)
      comment: "Average variance between scheduled and actual start time in minutes"
    - name: "on_time_start_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN (UNIX_TIMESTAMP(actual_start_datetime) - UNIX_TIMESTAMP(scheduled_start_datetime)) <= 900 THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN actual_start_datetime IS NOT NULL THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of appointments starting within 15 minutes of scheduled time"
    - name: "avg_reschedule_count"
      expr: AVG(CAST(reschedule_count AS DOUBLE))
      comment: "Average number of times appointments were rescheduled"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`radiology_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Radiology report quality, turnaround time, and clinical documentation metrics"
  source: "`vibe_healthcare_v1`.`radiology`.`report`"
  dimensions:
    - name: "report_status"
      expr: report_status
      comment: "Current status of the radiology report (preliminary, final, addended)"
    - name: "modality_code"
      expr: modality_code
      comment: "Imaging modality code for the report"
    - name: "critical_finding_flag"
      expr: critical_finding_flag
      comment: "Whether the report contains a critical finding"
    - name: "critical_finding_communicated_flag"
      expr: critical_finding_communicated_flag
      comment: "Whether critical finding was communicated to ordering provider"
    - name: "stat_priority_flag"
      expr: stat_priority_flag
      comment: "Whether the report was marked as STAT priority"
    - name: "contrast_administered_flag"
      expr: contrast_administered_flag
      comment: "Whether contrast was administered for the study"
    - name: "laterality"
      expr: laterality
      comment: "Body side examined (left, right, bilateral)"
    - name: "rads_category"
      expr: rads_category
      comment: "Radiology reporting and data system category (e.g., BI-RADS, LI-RADS)"
    - name: "addendum_type"
      expr: addendum_type
      comment: "Type of addendum if report was amended"
    - name: "follow_up_recommendation"
      expr: follow_up_recommendation
      comment: "Follow-up recommendation from the radiologist"
    - name: "report_year"
      expr: YEAR(attestation_timestamp)
      comment: "Year the report was attested/signed"
    - name: "report_month"
      expr: DATE_TRUNC('MONTH', attestation_timestamp)
      comment: "Month the report was attested/signed"
  measures:
    - name: "total_reports"
      expr: COUNT(report_id)
      comment: "Total number of radiology reports"
    - name: "unique_patients_reported"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with radiology reports"
    - name: "finalized_report_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN report_status = 'final' THEN 1 ELSE 0 END) / NULLIF(COUNT(report_id), 0), 2)
      comment: "Percentage of reports in final status"
    - name: "critical_finding_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(report_id), 0), 2)
      comment: "Percentage of reports with critical findings"
    - name: "critical_finding_communication_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN critical_finding_communicated_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN critical_finding_flag = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of critical findings that were communicated to providers"
    - name: "stat_report_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN stat_priority_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(report_id), 0), 2)
      comment: "Percentage of reports marked as STAT priority"
    - name: "addendum_rate_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN addendum_text IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(report_id), 0), 2)
      comment: "Percentage of reports that required an addendum"
    - name: "avg_dictation_to_transcription_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(transcription_timestamp) - UNIX_TIMESTAMP(dictation_timestamp)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average hours from dictation to transcription completion"
    - name: "avg_transcription_to_attestation_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(attestation_timestamp) - UNIX_TIMESTAMP(transcription_timestamp)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average hours from transcription to radiologist attestation"
    - name: "avg_study_to_preliminary_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(preliminary_timestamp) - UNIX_TIMESTAMP(study_datetime)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average hours from study completion to preliminary report"
    - name: "avg_study_to_final_report_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(attestation_timestamp) - UNIX_TIMESTAMP(study_datetime)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average hours from study completion to final report attestation"
    - name: "avg_critical_finding_communication_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(critical_finding_communicated_timestamp) - UNIX_TIMESTAMP(attestation_timestamp)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average hours from report attestation to critical finding communication"
    - name: "avg_addendum_turnaround_hours"
      expr: ROUND(AVG(CAST((UNIX_TIMESTAMP(addendum_timestamp) - UNIX_TIMESTAMP(attestation_timestamp)) / 3600.0 AS DOUBLE)), 2)
      comment: "Average hours from original attestation to addendum"
    - name: "total_radiation_dose_ctdi"
      expr: SUM(CAST(radiation_dose_ctdi AS DOUBLE))
      comment: "Total cumulative CT Dose Index documented in reports"
    - name: "total_radiation_dose_dlp"
      expr: SUM(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Total cumulative Dose Length Product documented in reports"
    - name: "avg_radiation_dose_ctdi"
      expr: AVG(CAST(radiation_dose_ctdi AS DOUBLE))
      comment: "Average CT Dose Index per report"
    - name: "avg_radiation_dose_dlp"
      expr: AVG(CAST(radiation_dose_dlp AS DOUBLE))
      comment: "Average Dose Length Product per report"
$$;