-- Metric views for domain: digital_health | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 07:21:53

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_device_reading`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RPM device reading KPIs: abnormal/out-of-range rates and alert triggering used to steer remote monitoring effectiveness and clinical escalation."
  source: "`vibe_healthcare_v1`.`digital_health`.`device_reading`"
  dimensions:
    - name: "reading_month"
      expr: DATE_TRUNC('MONTH', reading_timestamp)
      comment: "Month of the reading based on reading_timestamp for trending monitoring volume."
    - name: "measure_type"
      expr: measure_type
      comment: "Type of physiologic measure captured (e.g. BP, glucose, weight)."
    - name: "device_type"
      expr: device_type
      comment: "Category of RPM device that produced the reading."
    - name: "data_source"
      expr: data_source
      comment: "Origin of the reading data (device transmission vs manual entry)."
    - name: "reading_type"
      expr: reading_type
      comment: "Specific reading classification for cohorting."
  measures:
    - name: "Total Readings"
      expr: COUNT(1)
      comment: "Total number of device readings — baseline monitoring volume."
    - name: "Monitored Patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients generating readings — reach of the RPM program."
    - name: "Abnormal Reading Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN abnormal_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of readings flagged abnormal — clinical risk indicator that triggers review."
    - name: "Out Of Range Reading Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN out_of_range_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of readings outside configured thresholds — data quality and escalation signal."
    - name: "Alert Triggered Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN alert_triggered_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of readings that triggered a clinical alert — workflow/escalation load."
    - name: "Manual Entry Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN manual_entry_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of readings entered manually vs auto-transmitted — data reliability and device connectivity health."
    - name: "Avg Systolic Value"
      expr: ROUND(AVG(CAST(systolic_value AS DOUBLE)), 2)
      comment: "Average systolic blood pressure across readings for population trend monitoring."
    - name: "Avg Glucose Value"
      expr: ROUND(AVG(CAST(glucose_value AS DOUBLE)), 2)
      comment: "Average glucose reading for diabetes program population trending."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_rpm_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RPM enrollment KPIs: consent capture, billing eligibility, adherence and disenrollment used to steer program growth and reimbursement."
  source: "`vibe_healthcare_v1`.`digital_health`.`rpm_enrollment`"
  dimensions:
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month of enrollment for cohort and growth trending."
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the RPM enrollment (active, disenrolled, etc.)."
    - name: "program_type"
      expr: program_type
      comment: "RPM program type for segmentation."
    - name: "monitored_condition"
      expr: monitored_condition
      comment: "Clinical condition under remote monitoring."
    - name: "billing_program_code"
      expr: billing_program_code
      comment: "Billing program code associated with the enrollment."
  measures:
    - name: "Total Enrollments"
      expr: COUNT(1)
      comment: "Total RPM enrollments — program scale."
    - name: "Enrolled Patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients enrolled — program reach."
    - name: "Consent Obtained Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of enrollments with documented consent — compliance prerequisite for billing."
    - name: "Billing Eligible Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN billing_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of enrollments eligible for reimbursement — revenue capture indicator."
    - name: "Reimbursement Eligible Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reimbursement_eligible_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of enrollments qualifying for reimbursement — financial performance driver."
    - name: "Disenrollment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN disenrollment_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of enrollments that disenrolled — retention/churn indicator."
    - name: "Avg Adherence Rate"
      expr: ROUND(AVG(CAST(adherence_rate AS DOUBLE)), 2)
      comment: "Average patient adherence to monitoring protocol — clinical engagement and billing threshold driver."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_portal_engagement_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient portal engagement KPIs: login, messaging, scheduling and bill-pay activity used to steer digital adoption and self-service."
  source: "`vibe_healthcare_v1`.`digital_health`.`portal_engagement_event`"
  dimensions:
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Month of the engagement event for adoption trending."
    - name: "event_category"
      expr: event_category
      comment: "High-level category of the engagement event."
    - name: "event_type"
      expr: event_type
      comment: "Specific engagement event type."
    - name: "channel"
      expr: channel
      comment: "Channel through which the patient engaged."
    - name: "device_platform"
      expr: device_platform
      comment: "Device platform used (web, mobile) for channel-mix analysis."
  measures:
    - name: "Total Engagement Events"
      expr: COUNT(1)
      comment: "Total portal engagement events — overall digital activity."
    - name: "Active Portal Users"
      expr: COUNT(DISTINCT portal_account_id)
      comment: "Distinct portal accounts engaging — digital adoption reach."
    - name: "Message Sent Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN message_sent_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of events involving secure messaging — patient-provider communication uptake."
    - name: "Appointment Booked Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN appointment_booked_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of events that booked an appointment — self-service scheduling conversion."
    - name: "Bill Paid Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN bill_paid_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of events resulting in a bill payment — digital revenue-cycle self-service."
    - name: "Result Viewed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN result_viewed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of events where results were viewed — transparency and patient activation."
    - name: "Avg Engagement Score"
      expr: ROUND(AVG(CAST(engagement_score AS DOUBLE)), 2)
      comment: "Average engagement score per event — composite digital activation measure."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_portal_session`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Portal session security and access KPIs: MFA verification, consent acknowledgement and proxy access used to steer digital security posture."
  source: "`vibe_healthcare_v1`.`digital_health`.`portal_session`"
  dimensions:
    - name: "login_month"
      expr: DATE_TRUNC('MONTH', login_timestamp)
      comment: "Month of session login for security trend analysis."
    - name: "access_channel"
      expr: access_channel
      comment: "Channel used to access the portal."
    - name: "authentication_method"
      expr: authentication_method
      comment: "Authentication method used for the session."
    - name: "session_status"
      expr: session_status
      comment: "Status of the portal session."
    - name: "session_type"
      expr: session_type
      comment: "Type of portal session for segmentation."
  measures:
    - name: "Total Sessions"
      expr: COUNT(1)
      comment: "Total portal sessions — digital usage volume."
    - name: "MFA Verified Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mfa_verified = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of sessions with MFA verified — security compliance indicator."
    - name: "Consent Acknowledged Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_acknowledged = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of sessions with acknowledged consent — governance/compliance coverage."
    - name: "Proxy Access Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN proxy_access_indicator = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of sessions via proxy access — caregiver access monitoring and privacy oversight."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_prom_response`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Patient-reported outcome (PROM) KPIs: completion rate and score trends used to steer outcome-based care and value-based programs."
  source: "`vibe_healthcare_v1`.`digital_health`.`prom_response`"
  dimensions:
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administered_timestamp)
      comment: "Month the PROM was administered for outcome trending."
    - name: "instrument_name"
      expr: instrument_name
      comment: "Name of the PROM instrument administered."
    - name: "severity_category"
      expr: severity_category
      comment: "Severity band derived from the score for cohorting."
    - name: "administration_mode"
      expr: administration_mode
      comment: "Mode of administration (self, clinician-assisted) for method analysis."
    - name: "completion_status"
      expr: completion_status
      comment: "Completion status of the PROM response."
  measures:
    - name: "Total PROM Responses"
      expr: COUNT(1)
      comment: "Total PROM responses collected — outcome-measurement volume."
    - name: "Patients Assessed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with a PROM response — outcome program reach."
    - name: "Completion Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN completed_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of PROMs completed — survey engagement and data completeness."
    - name: "Baseline Assessment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN baseline_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of responses that are baseline assessments — enables longitudinal outcome tracking."
    - name: "Avg Total Numeric Score"
      expr: ROUND(AVG(CAST(numeric_score AS DOUBLE)), 2)
      comment: "Average numeric PROM score — population outcome level."
    - name: "Avg T Score"
      expr: ROUND(AVG(CAST(t_score AS DOUBLE)), 2)
      comment: "Average standardized T-score — normalized outcome benchmark across instruments."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`digital_health_rpm_device`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "RPM device fleet KPIs: activation and connectivity health used to steer device logistics and monitoring reliability."
  source: "`vibe_healthcare_v1`.`digital_health`.`rpm_device`"
  dimensions:
    - name: "issued_month"
      expr: DATE_TRUNC('MONTH', issued_date)
      comment: "Month the device was issued for logistics trending."
    - name: "device_type"
      expr: device_type
      comment: "Type of RPM device."
    - name: "device_status"
      expr: device_status
      comment: "Operational status of the device."
    - name: "connectivity_type"
      expr: connectivity_type
      comment: "Connectivity method of the device (cellular, bluetooth, etc.)."
    - name: "manufacturer"
      expr: manufacturer
      comment: "Device manufacturer for vendor analysis."
  measures:
    - name: "Total Devices"
      expr: COUNT(1)
      comment: "Total RPM devices in the fleet — inventory scale."
    - name: "Patients With Devices"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients assigned devices — deployment reach."
    - name: "Active Device Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_active_flag = TRUE THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of devices currently active — fleet utilization."
    - name: "Returned Device Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN returned_date IS NOT NULL THEN 1 END) / NULLIF(COUNT(1),0), 2)
      comment: "Percent of devices returned — churn and asset recovery indicator."
    - name: "Avg Battery Level Pct"
      expr: ROUND(AVG(CAST(battery_level_pct AS DOUBLE)), 2)
      comment: "Average device battery level — connectivity/reliability health signal."
$$;