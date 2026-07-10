-- Metric views for domain: clinical | Business: Healthcare | Version: 2 | Generated on: 2026-07-02 09:11:47

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core diagnostic metrics tracking diagnosis volume, chronic condition burden, quality measure impact, and coding workflow efficiency across care settings and patient populations."
  source: "`vibe_healthcare_v1`.`clinical`.`diagnosis`"
  dimensions:
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis (e.g., primary, secondary, admitting, discharge)"
    - name: "clinical_status"
      expr: clinical_status
      comment: "Current clinical status of the diagnosis"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where diagnosis was recorded (inpatient, outpatient, ED, etc.)"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the diagnosis"
    - name: "diagnosis_year"
      expr: YEAR(diagnosis_date)
      comment: "Year the diagnosis was made"
    - name: "diagnosis_month"
      expr: DATE_TRUNC('MONTH', diagnosis_date)
      comment: "Month the diagnosis was made"
    - name: "chronic_condition_flag"
      expr: chronic_condition_flag
      comment: "Indicates whether diagnosis represents a chronic condition"
    - name: "principal_diagnosis_flag"
      expr: principal_diagnosis_flag
      comment: "Indicates whether this is the principal diagnosis for the encounter"
    - name: "quality_measure_flag"
      expr: quality_measure_flag
      comment: "Indicates diagnosis is relevant to quality measure reporting"
    - name: "drg_relevant_flag"
      expr: drg_relevant_flag
      comment: "Indicates diagnosis impacts DRG assignment and reimbursement"
    - name: "present_on_admission"
      expr: present_on_admission
      comment: "Present on admission indicator for hospital-acquired condition tracking"
    - name: "mcc_flag"
      expr: mcc_flag
      comment: "Major complication/comorbidity flag impacting severity and reimbursement"
    - name: "coding_status"
      expr: coding_status
      comment: "Status of diagnosis coding workflow (pending, final, amended)"
    - name: "cdi_query_status"
      expr: cdi_query_status
      comment: "Clinical documentation improvement query status"
  measures:
    - name: "total_diagnoses"
      expr: COUNT(1)
      comment: "Total number of diagnosis records"
    - name: "unique_patients_diagnosed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with diagnoses"
    - name: "chronic_condition_count"
      expr: SUM(CASE WHEN chronic_condition_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diagnoses representing chronic conditions"
    - name: "chronic_condition_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN chronic_condition_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diagnoses that are chronic conditions"
    - name: "quality_measure_diagnosis_count"
      expr: SUM(CASE WHEN quality_measure_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diagnoses relevant to quality measure reporting"
    - name: "drg_relevant_diagnosis_count"
      expr: SUM(CASE WHEN drg_relevant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diagnoses impacting DRG assignment and reimbursement"
    - name: "mcc_diagnosis_count"
      expr: SUM(CASE WHEN mcc_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of major complication/comorbidity diagnoses"
    - name: "cdi_query_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cdi_query_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diagnoses requiring clinical documentation improvement queries"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_procedure_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical and procedural volume, efficiency, revenue, and quality metrics tracking procedure throughput, duration, cancellations, and charge capture across service lines."
  source: "`vibe_healthcare_v1`.`clinical`.`procedure_event`"
  dimensions:
    - name: "procedure_status"
      expr: procedure_status
      comment: "Status of the procedure (completed, cancelled, in-progress, scheduled)"
    - name: "procedure_type"
      expr: procedure_type
      comment: "Type or category of procedure performed"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where procedure was performed (OR, ambulatory, bedside, etc.)"
    - name: "service_line"
      expr: service_line
      comment: "Clinical service line responsible for the procedure"
    - name: "procedure_year"
      expr: YEAR(procedure_date)
      comment: "Year the procedure was performed"
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_date)
      comment: "Month the procedure was performed"
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Type of anesthesia used (general, regional, local, sedation)"
    - name: "asa_classification"
      expr: asa_classification
      comment: "ASA physical status classification indicating patient risk"
    - name: "priority"
      expr: priority
      comment: "Procedure priority (elective, urgent, emergent)"
    - name: "laterality"
      expr: laterality
      comment: "Body side for bilateral procedures (left, right, bilateral)"
    - name: "consent_obtained"
      expr: consent_obtained
      comment: "Indicates whether informed consent was obtained"
    - name: "timeout_performed"
      expr: timeout_performed
      comment: "Indicates whether surgical timeout was performed (safety measure)"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for procedure cancellation if applicable"
  measures:
    - name: "total_procedures"
      expr: COUNT(1)
      comment: "Total number of procedure events"
    - name: "completed_procedures"
      expr: SUM(CASE WHEN procedure_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed procedures"
    - name: "cancelled_procedures"
      expr: SUM(CASE WHEN procedure_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled procedures"
    - name: "procedure_cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN procedure_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of procedures that were cancelled"
    - name: "unique_patients_with_procedures"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients who had procedures"
    - name: "total_procedure_charges"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges for all procedures"
    - name: "avg_procedure_charge"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per procedure"
    - name: "total_rvu_work"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work relative value units for procedures"
    - name: "avg_rvu_work"
      expr: AVG(CAST(rvu_work AS DOUBLE))
      comment: "Average work RVUs per procedure"
    - name: "avg_procedure_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average procedure duration in minutes"
    - name: "timeout_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN timeout_performed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of procedures with documented surgical timeout (safety quality metric)"
    - name: "consent_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of procedures with documented informed consent"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care coordination and population health metrics tracking care plan activation, goal achievement, readmission risk, and care gap closure across patient populations and programs."
  source: "`vibe_healthcare_v1`.`clinical`.`care_plan`"
  dimensions:
    - name: "care_plan_status"
      expr: care_plan_status
      comment: "Current status of the care plan (active, completed, cancelled, suspended)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of care plan (chronic disease, post-discharge, preventive, etc.)"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where plan is managed"
    - name: "population_health_program"
      expr: population_health_program
      comment: "Population health program associated with care plan"
    - name: "readmission_risk_level"
      expr: readmission_risk_level
      comment: "Patient readmission risk stratification (low, medium, high)"
    - name: "plan_year"
      expr: YEAR(effective_start_date)
      comment: "Year the care plan became effective"
    - name: "plan_month"
      expr: DATE_TRUNC('MONTH', effective_start_date)
      comment: "Month the care plan became effective"
    - name: "aco_attributed"
      expr: aco_attributed
      comment: "Indicates whether patient is attributed to an ACO"
    - name: "advance_directive_on_file"
      expr: advance_directive_on_file
      comment: "Indicates whether advance directive is documented"
    - name: "patient_consent_obtained"
      expr: patient_consent_obtained
      comment: "Indicates whether patient consent for care plan was obtained"
    - name: "transitions_of_care_flag"
      expr: transitions_of_care_flag
      comment: "Indicates care plan involves care transitions"
    - name: "sdoh_flag"
      expr: sdoh_flag
      comment: "Indicates care plan addresses social determinants of health"
  measures:
    - name: "total_care_plans"
      expr: COUNT(1)
      comment: "Total number of care plans"
    - name: "active_care_plans"
      expr: SUM(CASE WHEN care_plan_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active care plans"
    - name: "unique_patients_with_care_plans"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with care plans"
    - name: "high_risk_readmission_plans"
      expr: SUM(CASE WHEN readmission_risk_level = 'high' THEN 1 ELSE 0 END)
      comment: "Count of care plans for high readmission risk patients"
    - name: "avg_care_gaps_per_plan"
      expr: AVG(CAST(care_gap_count AS DOUBLE))
      comment: "Average number of care gaps per care plan"
    - name: "avg_goals_per_plan"
      expr: AVG(CAST(goal_count AS DOUBLE))
      comment: "Average number of goals per care plan"
    - name: "avg_goals_achieved_per_plan"
      expr: AVG(CAST(goals_achieved_count AS DOUBLE))
      comment: "Average number of goals achieved per care plan"
    - name: "aco_attributed_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN aco_attributed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans for ACO-attributed patients"
    - name: "advance_directive_documentation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN advance_directive_on_file = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans with advance directive on file"
    - name: "patient_consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN patient_consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans with documented patient consent"
    - name: "sdoh_care_plan_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN sdoh_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans addressing social determinants of health"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_immunization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Immunization coverage, compliance, and public health reporting metrics tracking vaccination rates, series completion, adverse reactions, and registry reporting across patient populations."
  source: "`vibe_healthcare_v1`.`clinical`.`immunization`"
  dimensions:
    - name: "immunization_status"
      expr: immunization_status
      comment: "Status of the immunization (completed, not-done, entered-in-error)"
    - name: "administration_status"
      expr: administration_status
      comment: "Administration status of the vaccine"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where immunization was administered"
    - name: "series_name"
      expr: series_name
      comment: "Name of the vaccine series (e.g., COVID-19, Influenza, Pediatric)"
    - name: "series_completion_status"
      expr: series_completion_status
      comment: "Status of series completion (complete, incomplete, not-applicable)"
    - name: "administration_year"
      expr: YEAR(administration_timestamp)
      comment: "Year the immunization was administered"
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_timestamp)
      comment: "Month the immunization was administered"
    - name: "consent_obtained"
      expr: consent_obtained
      comment: "Indicates whether patient consent was obtained"
    - name: "reaction_observed"
      expr: reaction_observed
      comment: "Indicates whether adverse reaction was observed"
    - name: "iis_reported"
      expr: iis_reported
      comment: "Indicates whether immunization was reported to immunization information system"
    - name: "vaers_reported"
      expr: vaers_reported
      comment: "Indicates whether adverse event was reported to VAERS"
    - name: "vfc_eligibility_code"
      expr: vfc_eligibility_code
      comment: "Vaccines for Children program eligibility code"
  measures:
    - name: "total_immunizations"
      expr: COUNT(1)
      comment: "Total number of immunization administrations"
    - name: "completed_immunizations"
      expr: SUM(CASE WHEN immunization_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of successfully completed immunizations"
    - name: "unique_patients_immunized"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients who received immunizations"
    - name: "series_completed_count"
      expr: SUM(CASE WHEN series_completion_status = 'complete' THEN 1 ELSE 0 END)
      comment: "Count of completed vaccine series"
    - name: "series_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN series_completion_status = 'complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vaccine series that are completed"
    - name: "adverse_reaction_count"
      expr: SUM(CASE WHEN reaction_observed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of immunizations with observed adverse reactions"
    - name: "adverse_reaction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reaction_observed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of immunizations with adverse reactions"
    - name: "iis_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN iis_reported = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of immunizations reported to immunization information system"
    - name: "vaers_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN vaers_reported = TRUE THEN 1 ELSE 0 END) / NULLIF(SUM(CASE WHEN reaction_observed = TRUE THEN 1 ELSE 0 END), 0), 2)
      comment: "Percentage of adverse reactions reported to VAERS"
    - name: "consent_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of immunizations with documented patient consent"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_allergy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allergy documentation and medication safety metrics tracking allergy prevalence, severity, reconciliation status, and clinical decision support alert effectiveness."
  source: "`vibe_healthcare_v1`.`clinical`.`allergy`"
  dimensions:
    - name: "allergy_status"
      expr: allergy_status
      comment: "Current status of the allergy (active, inactive, resolved)"
    - name: "allergen_type"
      expr: allergen_type
      comment: "Type of allergen (drug, food, environmental, etc.)"
    - name: "severity"
      expr: severity
      comment: "Severity classification of the allergy"
    - name: "criticality"
      expr: criticality
      comment: "Criticality level indicating potential for life-threatening reaction"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where allergy was documented"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the allergy (confirmed, unconfirmed, refuted)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Medication reconciliation status for allergy"
    - name: "is_no_known_allergy"
      expr: is_no_known_allergy
      comment: "Indicates no known allergies documented"
    - name: "is_no_known_drug_allergy"
      expr: is_no_known_drug_allergy
      comment: "Indicates no known drug allergies documented"
    - name: "recorded_year"
      expr: YEAR(recorded_date)
      comment: "Year the allergy was recorded"
    - name: "recorded_month"
      expr: DATE_TRUNC('MONTH', recorded_date)
      comment: "Month the allergy was recorded"
  measures:
    - name: "total_allergies"
      expr: COUNT(1)
      comment: "Total number of allergy records"
    - name: "active_allergies"
      expr: SUM(CASE WHEN allergy_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of currently active allergies"
    - name: "unique_patients_with_allergies"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with documented allergies"
    - name: "severe_allergy_count"
      expr: SUM(CASE WHEN severity = 'severe' THEN 1 ELSE 0 END)
      comment: "Count of severe allergies"
    - name: "high_criticality_allergy_count"
      expr: SUM(CASE WHEN criticality = 'high' THEN 1 ELSE 0 END)
      comment: "Count of high-criticality allergies with life-threatening potential"
    - name: "drug_allergy_count"
      expr: SUM(CASE WHEN allergen_type = 'drug' THEN 1 ELSE 0 END)
      comment: "Count of drug allergies"
    - name: "verified_allergy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN verification_status = 'confirmed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allergies that are confirmed/verified"
    - name: "reconciled_allergy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reconciliation_status = 'reconciled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allergies that have been reconciled"
    - name: "nka_documentation_count"
      expr: SUM(CASE WHEN is_no_known_allergy = TRUE THEN 1 ELSE 0 END)
      comment: "Count of no known allergy documentation"
    - name: "nkda_documentation_count"
      expr: SUM(CASE WHEN is_no_known_drug_allergy = TRUE THEN 1 ELSE 0 END)
      comment: "Count of no known drug allergy documentation"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_vital_sign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vital signs monitoring and early warning metrics tracking vital sign capture frequency, abnormal value rates, early warning score trends, and remote patient monitoring engagement."
  source: "`vibe_healthcare_v1`.`clinical`.`vital_sign`"
  dimensions:
    - name: "observation_type"
      expr: observation_type
      comment: "Type of vital sign observation (blood pressure, temperature, pulse, etc.)"
    - name: "observation_status"
      expr: observation_status
      comment: "Status of the vital sign observation"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where vital sign was captured"
    - name: "care_unit"
      expr: care_unit
      comment: "Care unit where vital sign was captured"
    - name: "measurement_year"
      expr: YEAR(measurement_timestamp)
      comment: "Year the vital sign was measured"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month the vital sign was measured"
    - name: "abnormal_flag"
      expr: abnormal_flag
      comment: "Indicates whether vital sign value is abnormal"
    - name: "is_patient_reported"
      expr: is_patient_reported
      comment: "Indicates vital sign was patient-reported"
    - name: "is_telemetry_derived"
      expr: is_telemetry_derived
      comment: "Indicates vital sign was derived from telemetry monitoring"
    - name: "rpm_device_source_flag"
      expr: rpm_device_source_flag
      comment: "Indicates vital sign was captured via remote patient monitoring device"
    - name: "ews_score_type"
      expr: ews_score_type
      comment: "Type of early warning score system used"
    - name: "patient_position"
      expr: patient_position
      comment: "Patient position during vital sign measurement"
  measures:
    - name: "total_vital_signs"
      expr: COUNT(1)
      comment: "Total number of vital sign measurements"
    - name: "unique_patients_monitored"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with vital sign measurements"
    - name: "abnormal_vital_sign_count"
      expr: SUM(CASE WHEN abnormal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of abnormal vital sign measurements"
    - name: "abnormal_vital_sign_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN abnormal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vital signs that are abnormal"
    - name: "patient_reported_vital_count"
      expr: SUM(CASE WHEN is_patient_reported = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patient-reported vital signs"
    - name: "rpm_vital_sign_count"
      expr: SUM(CASE WHEN rpm_device_source_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vital signs captured via remote patient monitoring"
    - name: "rpm_engagement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN rpm_device_source_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of vital signs captured via remote patient monitoring devices"
    - name: "telemetry_vital_count"
      expr: SUM(CASE WHEN is_telemetry_derived = TRUE THEN 1 ELSE 0 END)
      comment: "Count of vital signs derived from telemetry monitoring"
    - name: "avg_numeric_value"
      expr: AVG(CAST(numeric_value AS DOUBLE))
      comment: "Average numeric value across all vital sign measurements"
$$;