-- Metric views for domain: encounter | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 16:17:39

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core visit-level KPIs tracking volume, length of stay, readmissions, and observation status for inpatient and outpatient encounters"
  source: "`vibe_healthcare_v1`.`encounter`.`visit`"
  dimensions:
    - name: "visit_type"
      expr: visit_type
      comment: "Type of visit (inpatient, outpatient, emergency, observation)"
    - name: "admission_type"
      expr: admission_type
      comment: "Type of admission (elective, urgent, emergency, trauma)"
    - name: "admission_source"
      expr: admission_source
      comment: "Source of admission (emergency department, physician referral, transfer)"
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Disposition at discharge (home, SNF, AMA, expired, transfer)"
    - name: "financial_class"
      expr: financial_class
      comment: "Financial class or payer category for the visit"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where visit occurred"
    - name: "visit_status"
      expr: visit_status
      comment: "Current status of the visit (active, discharged, cancelled)"
    - name: "readmission_flag"
      expr: readmission_flag
      comment: "Flag indicating if this visit is a readmission"
    - name: "observation_status"
      expr: observation_status
      comment: "Flag indicating if patient is under observation status"
    - name: "emtala_compliant"
      expr: emtala_compliant
      comment: "Flag indicating EMTALA compliance for emergency visits"
    - name: "two_midnight_compliant"
      expr: two_midnight_compliant
      comment: "Flag indicating compliance with two-midnight rule for inpatient admission"
    - name: "admission_date"
      expr: DATE(admission_timestamp)
      comment: "Date of admission"
    - name: "discharge_date"
      expr: DATE(discharge_timestamp)
      comment: "Date of discharge"
    - name: "admission_year_month"
      expr: DATE_TRUNC('MONTH', admission_timestamp)
      comment: "Year-month of admission for trending"
  measures:
    - name: "total_visits"
      expr: COUNT(1)
      comment: "Total number of visits"
    - name: "total_length_of_stay_days"
      expr: SUM(CAST(REGEXP_REPLACE(length_of_stay_days, '[^0-9.]', '') AS DOUBLE))
      comment: "Total length of stay in days across all visits"
    - name: "avg_length_of_stay_days"
      expr: AVG(CAST(REGEXP_REPLACE(length_of_stay_days, '[^0-9.]', '') AS DOUBLE))
      comment: "Average length of stay in days per visit"
    - name: "total_observation_hours"
      expr: SUM(CAST(observation_hours AS DOUBLE))
      comment: "Total observation hours across all visits"
    - name: "avg_observation_hours"
      expr: AVG(CAST(observation_hours AS DOUBLE))
      comment: "Average observation hours per visit"
    - name: "readmission_count"
      expr: SUM(CASE WHEN readmission_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of visits flagged as readmissions"
    - name: "observation_status_count"
      expr: SUM(CASE WHEN observation_status = TRUE THEN 1 ELSE 0 END)
      comment: "Count of visits under observation status"
    - name: "emtala_compliant_count"
      expr: SUM(CASE WHEN emtala_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of EMTALA-compliant emergency visits"
    - name: "two_midnight_compliant_count"
      expr: SUM(CASE WHEN two_midnight_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of visits compliant with two-midnight rule"
    - name: "avg_readmission_risk_score"
      expr: AVG(CAST(readmission_risk_score AS DOUBLE))
      comment: "Average readmission risk score across visits"
    - name: "avg_drg_weight"
      expr: AVG(CAST(drg_weight AS DOUBLE))
      comment: "Average DRG weight per visit, indicating case complexity"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with visits"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_adt_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "ADT event-level KPIs tracking patient movement, bed requests, transfers, and EMTALA compliance across the care continuum"
  source: "`vibe_healthcare_v1`.`encounter`.`adt_event`"
  dimensions:
    - name: "event_type_code"
      expr: event_type_code
      comment: "ADT event type code (admit, discharge, transfer, etc.)"
    - name: "event_type_description"
      expr: event_type_description
      comment: "Human-readable description of the ADT event type"
    - name: "event_status"
      expr: event_status
      comment: "Status of the ADT event (completed, cancelled, pending)"
    - name: "patient_class_code"
      expr: patient_class_code
      comment: "Patient class at time of event (inpatient, outpatient, emergency, observation)"
    - name: "admission_source_code"
      expr: admission_source_code
      comment: "Source of admission for admit events"
    - name: "discharge_disposition_code"
      expr: discharge_disposition_code
      comment: "Discharge disposition for discharge events"
    - name: "transition_type"
      expr: transition_type
      comment: "Type of patient transition (unit-to-unit, facility-to-facility)"
    - name: "from_unit_code"
      expr: from_unit_code
      comment: "Unit code patient is transferring from"
    - name: "to_unit_code"
      expr: to_unit_code
      comment: "Unit code patient is transferring to"
    - name: "isolation_flag"
      expr: isolation_flag
      comment: "Flag indicating if patient requires isolation"
    - name: "emtala_compliant"
      expr: emtala_compliant
      comment: "Flag indicating EMTALA compliance for the event"
    - name: "ama_flag"
      expr: ama_flag
      comment: "Flag indicating patient left against medical advice"
    - name: "event_date"
      expr: DATE(event_timestamp)
      comment: "Date of the ADT event"
    - name: "event_year_month"
      expr: DATE_TRUNC('MONTH', event_timestamp)
      comment: "Year-month of ADT event for trending"
  measures:
    - name: "total_adt_events"
      expr: COUNT(1)
      comment: "Total number of ADT events"
    - name: "transfer_event_count"
      expr: SUM(CASE WHEN event_type_code IN ('A02', 'A06', 'A07') THEN 1 ELSE 0 END)
      comment: "Count of transfer events (internal and external)"
    - name: "admission_event_count"
      expr: SUM(CASE WHEN event_type_code IN ('A01', 'A04') THEN 1 ELSE 0 END)
      comment: "Count of admission events"
    - name: "discharge_event_count"
      expr: SUM(CASE WHEN event_type_code = 'A03' THEN 1 ELSE 0 END)
      comment: "Count of discharge events"
    - name: "isolation_event_count"
      expr: SUM(CASE WHEN isolation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of events requiring patient isolation"
    - name: "emtala_compliant_event_count"
      expr: SUM(CASE WHEN emtala_compliant = TRUE THEN 1 ELSE 0 END)
      comment: "Count of EMTALA-compliant events"
    - name: "ama_event_count"
      expr: SUM(CASE WHEN ama_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of against-medical-advice events"
    - name: "distinct_patients_with_events"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with ADT events"
    - name: "distinct_visits_with_events"
      expr: COUNT(DISTINCT visit_id)
      comment: "Distinct count of visits with ADT events"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_bed_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bed assignment KPIs tracking bed utilization, turnaround time, assignment duration, and capacity management across units"
  source: "`vibe_healthcare_v1`.`encounter`.`bed_assignment`"
  dimensions:
    - name: "unit_code"
      expr: unit_code
      comment: "Code identifying the clinical unit"
    - name: "unit_name"
      expr: unit_name
      comment: "Name of the clinical unit"
    - name: "bed_type"
      expr: bed_type
      comment: "Type of bed (ICU, medical-surgical, telemetry, etc.)"
    - name: "bed_class"
      expr: bed_class
      comment: "Class of bed (private, semi-private, ward)"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of the bed assignment (active, completed, cancelled)"
    - name: "patient_class"
      expr: patient_class
      comment: "Patient class during bed assignment"
    - name: "is_isolation_bed"
      expr: is_isolation_bed
      comment: "Flag indicating if bed is designated for isolation"
    - name: "is_private_room"
      expr: is_private_room
      comment: "Flag indicating if bed is in a private room"
    - name: "is_telemetry_monitored"
      expr: is_telemetry_monitored
      comment: "Flag indicating if bed has telemetry monitoring"
    - name: "is_observation_status"
      expr: is_observation_status
      comment: "Flag indicating if patient is under observation status"
    - name: "admission_date"
      expr: admission_date
      comment: "Date of admission for the bed assignment"
    - name: "discharge_date"
      expr: discharge_date
      comment: "Date of discharge from the bed assignment"
    - name: "assignment_year_month"
      expr: DATE_TRUNC('MONTH', assignment_start_timestamp)
      comment: "Year-month of bed assignment start for trending"
  measures:
    - name: "total_bed_assignments"
      expr: COUNT(1)
      comment: "Total number of bed assignments"
    - name: "total_los_days"
      expr: SUM(CAST(los_days AS DOUBLE))
      comment: "Total length of stay in days across all bed assignments"
    - name: "avg_los_days"
      expr: AVG(CAST(los_days AS DOUBLE))
      comment: "Average length of stay in days per bed assignment"
    - name: "isolation_bed_count"
      expr: SUM(CASE WHEN is_isolation_bed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of isolation bed assignments"
    - name: "private_room_count"
      expr: SUM(CASE WHEN is_private_room = TRUE THEN 1 ELSE 0 END)
      comment: "Count of private room bed assignments"
    - name: "telemetry_monitored_count"
      expr: SUM(CASE WHEN is_telemetry_monitored = TRUE THEN 1 ELSE 0 END)
      comment: "Count of telemetry-monitored bed assignments"
    - name: "observation_status_count"
      expr: SUM(CASE WHEN is_observation_status = TRUE THEN 1 ELSE 0 END)
      comment: "Count of observation status bed assignments"
    - name: "distinct_patients_assigned"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with bed assignments"
    - name: "distinct_visits_assigned"
      expr: COUNT(DISTINCT visit_id)
      comment: "Distinct count of visits with bed assignments"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_drg_assignment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "DRG assignment KPIs tracking case mix, reimbursement, length of stay variance, outliers, and coding quality for inpatient encounters"
  source: "`vibe_healthcare_v1`.`encounter`.`drg_assignment`"
  dimensions:
    - name: "drg_description"
      expr: drg_description
      comment: "Description of the assigned DRG"
    - name: "mdc_code"
      expr: mdc_code
      comment: "Major Diagnostic Category code"
    - name: "mdc_description"
      expr: mdc_description
      comment: "Major Diagnostic Category description"
    - name: "assignment_status"
      expr: assignment_status
      comment: "Status of DRG assignment (preliminary, final, appealed)"
    - name: "assignment_type"
      expr: assignment_type
      comment: "Type of DRG assignment (initial, revised, final)"
    - name: "cc_mcc_flag"
      expr: cc_mcc_flag
      comment: "Flag indicating presence of complications or major complications"
    - name: "is_outlier"
      expr: is_outlier
      comment: "Flag indicating if case is a cost or length-of-stay outlier"
    - name: "drg_changed_flag"
      expr: drg_changed_flag
      comment: "Flag indicating if DRG was changed from initial assignment"
    - name: "patient_type"
      expr: patient_type
      comment: "Type of patient (Medicare, Medicaid, commercial, etc.)"
    - name: "grouping_year_month"
      expr: DATE_TRUNC('MONTH', grouping_date)
      comment: "Year-month of DRG grouping for trending"
  measures:
    - name: "total_drg_assignments"
      expr: COUNT(1)
      comment: "Total number of DRG assignments"
    - name: "total_drg_weight"
      expr: SUM(CAST(drg_weight AS DOUBLE))
      comment: "Total DRG weight representing case mix complexity"
    - name: "avg_drg_weight"
      expr: AVG(CAST(drg_weight AS DOUBLE))
      comment: "Average DRG weight per case, indicating average case complexity"
    - name: "total_expected_reimbursement"
      expr: SUM(CAST(expected_reimbursement AS DOUBLE))
      comment: "Total expected reimbursement across all DRG assignments"
    - name: "avg_expected_reimbursement"
      expr: AVG(CAST(expected_reimbursement AS DOUBLE))
      comment: "Average expected reimbursement per DRG assignment"
    - name: "total_outlier_payment"
      expr: SUM(CAST(outlier_payment AS DOUBLE))
      comment: "Total outlier payment for high-cost or long-stay cases"
    - name: "total_actual_los"
      expr: SUM(CAST(actual_los AS DOUBLE))
      comment: "Total actual length of stay in days"
    - name: "avg_actual_los"
      expr: AVG(CAST(actual_los AS DOUBLE))
      comment: "Average actual length of stay per case"
    - name: "total_geometric_mean_los"
      expr: SUM(CAST(geometric_mean_los AS DOUBLE))
      comment: "Total geometric mean length of stay benchmark"
    - name: "avg_geometric_mean_los"
      expr: AVG(CAST(geometric_mean_los AS DOUBLE))
      comment: "Average geometric mean length of stay benchmark per case"
    - name: "cc_mcc_case_count"
      expr: SUM(CASE WHEN cc_mcc_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases with complications or major complications"
    - name: "outlier_case_count"
      expr: SUM(CASE WHEN is_outlier = TRUE THEN 1 ELSE 0 END)
      comment: "Count of outlier cases (cost or LOS)"
    - name: "drg_changed_count"
      expr: SUM(CASE WHEN drg_changed_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cases where DRG was changed from initial assignment"
    - name: "distinct_patients"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with DRG assignments"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_triage_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emergency department triage KPIs tracking acuity, door-to-triage time, sepsis/stroke alerts, and left-without-being-seen rates"
  source: "`vibe_healthcare_v1`.`encounter`.`triage_assessment`"
  dimensions:
    - name: "esi_level"
      expr: esi_level
      comment: "Emergency Severity Index level (1-5, 1 being most critical)"
    - name: "triage_category"
      expr: triage_category
      comment: "Triage category assigned to the patient"
    - name: "triage_status"
      expr: triage_status
      comment: "Status of the triage assessment (completed, in-progress, cancelled)"
    - name: "arrival_mode"
      expr: arrival_mode
      comment: "Mode of arrival (ambulance, walk-in, helicopter, etc.)"
    - name: "chief_complaint"
      expr: chief_complaint
      comment: "Chief complaint as stated by patient or documented by triage nurse"
    - name: "sepsis_alert_flag"
      expr: sepsis_alert_flag
      comment: "Flag indicating sepsis alert triggered at triage"
    - name: "stroke_alert_flag"
      expr: stroke_alert_flag
      comment: "Flag indicating stroke alert triggered at triage"
    - name: "trauma_activation_flag"
      expr: trauma_activation_flag
      comment: "Flag indicating trauma activation at triage"
    - name: "trauma_level"
      expr: trauma_level
      comment: "Level of trauma activation (Level 1, 2, 3)"
    - name: "mental_health_flag"
      expr: mental_health_flag
      comment: "Flag indicating mental health concern identified at triage"
    - name: "isolation_required_flag"
      expr: isolation_required_flag
      comment: "Flag indicating isolation required based on triage assessment"
    - name: "lwbs_flag"
      expr: lwbs_flag
      comment: "Flag indicating patient left without being seen"
    - name: "ama_flag"
      expr: ama_flag
      comment: "Flag indicating patient left against medical advice"
    - name: "triage_date"
      expr: DATE(triage_timestamp)
      comment: "Date of triage assessment"
    - name: "triage_year_month"
      expr: DATE_TRUNC('MONTH', triage_timestamp)
      comment: "Year-month of triage for trending"
  measures:
    - name: "total_triage_assessments"
      expr: COUNT(1)
      comment: "Total number of triage assessments"
    - name: "esi_1_count"
      expr: SUM(CASE WHEN esi_level = '1' THEN 1 ELSE 0 END)
      comment: "Count of ESI Level 1 (most critical) triage assessments"
    - name: "esi_2_count"
      expr: SUM(CASE WHEN esi_level = '2' THEN 1 ELSE 0 END)
      comment: "Count of ESI Level 2 (emergent) triage assessments"
    - name: "sepsis_alert_count"
      expr: SUM(CASE WHEN sepsis_alert_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of triage assessments with sepsis alert"
    - name: "stroke_alert_count"
      expr: SUM(CASE WHEN stroke_alert_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of triage assessments with stroke alert"
    - name: "trauma_activation_count"
      expr: SUM(CASE WHEN trauma_activation_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of triage assessments with trauma activation"
    - name: "mental_health_count"
      expr: SUM(CASE WHEN mental_health_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of triage assessments with mental health concern"
    - name: "isolation_required_count"
      expr: SUM(CASE WHEN isolation_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of triage assessments requiring isolation"
    - name: "lwbs_count"
      expr: SUM(CASE WHEN lwbs_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patients who left without being seen"
    - name: "ama_count"
      expr: SUM(CASE WHEN ama_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patients who left against medical advice"
    - name: "avg_temperature_celsius"
      expr: AVG(CAST(temperature_celsius AS DOUBLE))
      comment: "Average temperature in Celsius at triage"
    - name: "avg_spo2_percent"
      expr: AVG(CAST(spo2_percent AS DOUBLE))
      comment: "Average oxygen saturation percentage at triage"
    - name: "avg_weight_kg"
      expr: AVG(CAST(weight_kg AS DOUBLE))
      comment: "Average patient weight in kilograms at triage"
    - name: "distinct_patients_triaged"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients triaged"
    - name: "distinct_visits_triaged"
      expr: COUNT(DISTINCT visit_id)
      comment: "Distinct count of visits with triage assessments"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit diagnosis KPIs tracking diagnosis volume, chronic conditions, HCC flags, quality measures, and social determinants of health"
  source: "`vibe_healthcare_v1`.`encounter`.`visit_diagnosis`"
  dimensions:
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis (admitting, principal, secondary, complication)"
    - name: "primary_diagnosis_flag"
      expr: primary_diagnosis_flag
      comment: "Flag indicating if this is the primary diagnosis for the visit"
    - name: "poa_indicator"
      expr: poa_indicator
      comment: "Present on admission indicator (Y, N, U, W, exempt)"
    - name: "chronic_condition_flag"
      expr: chronic_condition_flag
      comment: "Flag indicating if diagnosis is a chronic condition"
    - name: "hcc_flag"
      expr: hcc_flag
      comment: "Flag indicating if diagnosis maps to a Hierarchical Condition Category"
    - name: "hcc_category_code"
      expr: hcc_category_code
      comment: "HCC category code for risk adjustment"
    - name: "cc_mcc_indicator"
      expr: cc_mcc_indicator
      comment: "Complication or Major Complication indicator (CC, MCC, none)"
    - name: "drg_relevance_flag"
      expr: drg_relevance_flag
      comment: "Flag indicating if diagnosis is relevant to DRG assignment"
    - name: "quality_measure_flag"
      expr: quality_measure_flag
      comment: "Flag indicating if diagnosis is part of a quality measure"
    - name: "mental_health_flag"
      expr: mental_health_flag
      comment: "Flag indicating if diagnosis is mental health related"
    - name: "substance_use_flag"
      expr: substance_use_flag
      comment: "Flag indicating if diagnosis is substance use related"
    - name: "sdoh_flag"
      expr: sdoh_flag
      comment: "Flag indicating if diagnosis relates to social determinants of health"
    - name: "hai_flag"
      expr: hai_flag
      comment: "Flag indicating if diagnosis is a hospital-acquired infection"
    - name: "reportable_condition_flag"
      expr: reportable_condition_flag
      comment: "Flag indicating if diagnosis is a reportable condition to public health"
    - name: "coded_year_month"
      expr: DATE_TRUNC('MONTH', coded_date)
      comment: "Year-month of diagnosis coding for trending"
  measures:
    - name: "total_diagnoses"
      expr: COUNT(1)
      comment: "Total number of visit diagnoses"
    - name: "primary_diagnosis_count"
      expr: SUM(CASE WHEN primary_diagnosis_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of primary diagnoses"
    - name: "chronic_condition_count"
      expr: SUM(CASE WHEN chronic_condition_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of chronic condition diagnoses"
    - name: "hcc_diagnosis_count"
      expr: SUM(CASE WHEN hcc_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diagnoses mapping to HCC categories for risk adjustment"
    - name: "cc_diagnosis_count"
      expr: SUM(CASE WHEN cc_mcc_indicator = 'CC' THEN 1 ELSE 0 END)
      comment: "Count of diagnoses classified as complications"
    - name: "mcc_diagnosis_count"
      expr: SUM(CASE WHEN cc_mcc_indicator = 'MCC' THEN 1 ELSE 0 END)
      comment: "Count of diagnoses classified as major complications"
    - name: "drg_relevant_diagnosis_count"
      expr: SUM(CASE WHEN drg_relevance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diagnoses relevant to DRG assignment"
    - name: "quality_measure_diagnosis_count"
      expr: SUM(CASE WHEN quality_measure_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diagnoses tied to quality measures"
    - name: "mental_health_diagnosis_count"
      expr: SUM(CASE WHEN mental_health_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of mental health diagnoses"
    - name: "substance_use_diagnosis_count"
      expr: SUM(CASE WHEN substance_use_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of substance use diagnoses"
    - name: "sdoh_diagnosis_count"
      expr: SUM(CASE WHEN sdoh_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diagnoses related to social determinants of health"
    - name: "hai_diagnosis_count"
      expr: SUM(CASE WHEN hai_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hospital-acquired infection diagnoses"
    - name: "reportable_condition_count"
      expr: SUM(CASE WHEN reportable_condition_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of reportable condition diagnoses"
    - name: "distinct_patients_with_diagnoses"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with visit diagnoses"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_visit_procedure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Visit procedure KPIs tracking procedure volume, surgical outcomes, complications, RVU productivity, and implant utilization"
  source: "`vibe_healthcare_v1`.`encounter`.`visit_procedure`"
  dimensions:
    - name: "procedure_type"
      expr: procedure_type
      comment: "Type of procedure (surgical, diagnostic, therapeutic)"
    - name: "procedure_status"
      expr: procedure_status
      comment: "Status of the procedure (completed, cancelled, in-progress)"
    - name: "is_principal_procedure"
      expr: is_principal_procedure
      comment: "Flag indicating if this is the principal procedure for the visit"
    - name: "is_elective"
      expr: is_elective
      comment: "Flag indicating if procedure was elective"
    - name: "is_cancelled"
      expr: is_cancelled
      comment: "Flag indicating if procedure was cancelled"
    - name: "complication_flag"
      expr: complication_flag
      comment: "Flag indicating if procedure had complications"
    - name: "implant_flag"
      expr: implant_flag
      comment: "Flag indicating if procedure involved an implant"
    - name: "drg_relevant_flag"
      expr: drg_relevant_flag
      comment: "Flag indicating if procedure is relevant to DRG assignment"
    - name: "surgical_approach"
      expr: surgical_approach
      comment: "Surgical approach (open, laparoscopic, robotic, endoscopic)"
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Type of anesthesia used (general, regional, local, MAC)"
    - name: "asa_class"
      expr: asa_class
      comment: "ASA physical status classification"
    - name: "wound_class"
      expr: wound_class
      comment: "Wound classification (clean, clean-contaminated, contaminated, dirty)"
    - name: "laterality"
      expr: laterality
      comment: "Laterality of procedure (left, right, bilateral)"
    - name: "body_site"
      expr: body_site
      comment: "Body site where procedure was performed"
    - name: "procedure_year_month"
      expr: DATE_TRUNC('MONTH', procedure_date)
      comment: "Year-month of procedure for trending"
  measures:
    - name: "total_procedures"
      expr: COUNT(1)
      comment: "Total number of visit procedures"
    - name: "principal_procedure_count"
      expr: SUM(CASE WHEN is_principal_procedure = TRUE THEN 1 ELSE 0 END)
      comment: "Count of principal procedures"
    - name: "elective_procedure_count"
      expr: SUM(CASE WHEN is_elective = TRUE THEN 1 ELSE 0 END)
      comment: "Count of elective procedures"
    - name: "cancelled_procedure_count"
      expr: SUM(CASE WHEN is_cancelled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of cancelled procedures"
    - name: "complication_count"
      expr: SUM(CASE WHEN complication_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of procedures with complications"
    - name: "implant_procedure_count"
      expr: SUM(CASE WHEN implant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of procedures involving implants"
    - name: "drg_relevant_procedure_count"
      expr: SUM(CASE WHEN drg_relevant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of procedures relevant to DRG assignment"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charge amount for all procedures"
    - name: "avg_charge_amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge amount per procedure"
    - name: "total_rvu_work"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work RVUs representing physician productivity"
    - name: "avg_rvu_work"
      expr: AVG(CAST(rvu_work AS DOUBLE))
      comment: "Average work RVUs per procedure"
    - name: "total_rvu_total"
      expr: SUM(CAST(rvu_total AS DOUBLE))
      comment: "Total RVUs (work + practice expense + malpractice)"
    - name: "avg_rvu_total"
      expr: AVG(CAST(rvu_total AS DOUBLE))
      comment: "Average total RVUs per procedure"
    - name: "distinct_patients_with_procedures"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with procedures"
$$;


CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`encounter_discharge_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Discharge summary KPIs tracking documentation timeliness, care transitions, medication reconciliation, and follow-up compliance"
  source: "`vibe_healthcare_v1`.`encounter`.`discharge_summary`"
  dimensions:
    - name: "summary_status"
      expr: summary_status
      comment: "Status of discharge summary (draft, finalized, amended, signed)"
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Disposition at discharge (home, SNF, rehab, hospice, expired)"
    - name: "discharge_condition"
      expr: discharge_condition
      comment: "Patient condition at discharge (improved, stable, worsened)"
    - name: "discharge_instructions_issued"
      expr: discharge_instructions_issued
      comment: "Flag indicating if discharge instructions were issued"
    - name: "medication_reconciliation_completed"
      expr: medication_reconciliation_completed
      comment: "Flag indicating if medication reconciliation was completed"
    - name: "follow_up_scheduled"
      expr: follow_up_scheduled
      comment: "Flag indicating if follow-up appointment was scheduled"
    - name: "care_transition_plan_completed"
      expr: care_transition_plan_completed
      comment: "Flag indicating if care transition plan was completed"
    - name: "patient_education_provided"
      expr: patient_education_provided
      comment: "Flag indicating if patient education was provided"
    - name: "home_health_referral_made"
      expr: home_health_referral_made
      comment: "Flag indicating if home health referral was made"
    - name: "compliance_flag"
      expr: compliance_flag
      comment: "Flag indicating compliance with discharge summary documentation requirements"
    - name: "discharge_year_month"
      expr: DATE_TRUNC('MONTH', discharge_date)
      comment: "Year-month of discharge for trending"
  measures:
    - name: "total_discharge_summaries"
      expr: COUNT(1)
      comment: "Total number of discharge summaries"
    - name: "discharge_instructions_issued_count"
      expr: SUM(CASE WHEN discharge_instructions_issued = TRUE THEN 1 ELSE 0 END)
      comment: "Count of discharges with instructions issued"
    - name: "medication_reconciliation_completed_count"
      expr: SUM(CASE WHEN medication_reconciliation_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of discharges with medication reconciliation completed"
    - name: "follow_up_scheduled_count"
      expr: SUM(CASE WHEN follow_up_scheduled = TRUE THEN 1 ELSE 0 END)
      comment: "Count of discharges with follow-up scheduled"
    - name: "care_transition_plan_completed_count"
      expr: SUM(CASE WHEN care_transition_plan_completed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of discharges with care transition plan completed"
    - name: "patient_education_provided_count"
      expr: SUM(CASE WHEN patient_education_provided = TRUE THEN 1 ELSE 0 END)
      comment: "Count of discharges with patient education provided"
    - name: "home_health_referral_made_count"
      expr: SUM(CASE WHEN home_health_referral_made = TRUE THEN 1 ELSE 0 END)
      comment: "Count of discharges with home health referral made"
    - name: "compliance_count"
      expr: SUM(CASE WHEN compliance_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of discharge summaries meeting compliance requirements"
    - name: "avg_time_to_completion_hours"
      expr: AVG(CAST(time_to_completion_hours AS DOUBLE))
      comment: "Average time to complete discharge summary in hours"
    - name: "distinct_patients_discharged"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with discharge summaries"
$$;
