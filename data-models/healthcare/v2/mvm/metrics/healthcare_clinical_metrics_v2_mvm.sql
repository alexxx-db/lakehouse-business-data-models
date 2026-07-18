-- Metric views for domain: clinical | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 16:17:39

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core diagnostic metrics tracking diagnosis volume, chronic condition burden, quality measure impact, and clinical documentation integrity across care settings and diagnosis types."
  source: "`vibe_healthcare_v1`.`clinical`.`diagnosis`"
  dimensions:
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis (e.g., primary, secondary, admitting, discharge)"
    - name: "clinical_status"
      expr: clinical_status
      comment: "Current clinical status of the diagnosis (active, resolved, recurrence)"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where diagnosis was documented (inpatient, outpatient, ED, etc.)"
    - name: "diagnosis_year"
      expr: YEAR(diagnosis_date)
      comment: "Year the diagnosis was made"
    - name: "diagnosis_month"
      expr: DATE_TRUNC('MONTH', diagnosis_date)
      comment: "Month the diagnosis was made"
    - name: "is_chronic_condition"
      expr: chronic_condition_flag
      comment: "Whether diagnosis represents a chronic condition"
    - name: "is_principal_diagnosis"
      expr: principal_diagnosis_flag
      comment: "Whether this is the principal diagnosis for the encounter"
    - name: "is_quality_measure_relevant"
      expr: quality_measure_flag
      comment: "Whether diagnosis impacts quality measure reporting"
    - name: "is_drg_relevant"
      expr: drg_relevant_flag
      comment: "Whether diagnosis impacts DRG assignment and reimbursement"
    - name: "present_on_admission"
      expr: present_on_admission
      comment: "Present on admission indicator (Y/N/U/W) for hospital-acquired condition tracking"
    - name: "is_complication_comorbidity"
      expr: complication_comorbidity_flag
      comment: "Whether diagnosis qualifies as a complication or comorbidity (CC/MCC)"
    - name: "is_mcc"
      expr: mcc_flag
      comment: "Whether diagnosis is a major complication or comorbidity"
    - name: "is_hac"
      expr: hac_flag
      comment: "Whether diagnosis is a hospital-acquired condition"
    - name: "cdi_query_status"
      expr: cdi_query_status
      comment: "Clinical documentation improvement query status"
    - name: "coding_status"
      expr: coding_status
      comment: "Status of diagnosis coding (final, pending, query)"
    - name: "severity"
      expr: severity
      comment: "Severity level of the diagnosis"
    - name: "is_sdoh_related"
      expr: sdoh_flag
      comment: "Whether diagnosis relates to social determinants of health"
  measures:
    - name: "total_diagnoses"
      expr: COUNT(1)
      comment: "Total number of diagnosis records"
    - name: "unique_patients_diagnosed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with diagnoses"
    - name: "chronic_condition_count"
      expr: SUM(CASE WHEN chronic_condition_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diagnoses flagged as chronic conditions"
    - name: "chronic_condition_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN chronic_condition_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of diagnoses that are chronic conditions"
    - name: "quality_measure_diagnosis_count"
      expr: SUM(CASE WHEN quality_measure_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diagnoses impacting quality measures"
    - name: "drg_relevant_diagnosis_count"
      expr: SUM(CASE WHEN drg_relevant_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diagnoses impacting DRG assignment and reimbursement"
    - name: "hospital_acquired_condition_count"
      expr: SUM(CASE WHEN hac_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of hospital-acquired conditions (HACs) - key quality and penalty metric"
    - name: "hac_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN hac_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Hospital-acquired condition rate - critical quality and reimbursement metric"
    - name: "mcc_diagnosis_count"
      expr: SUM(CASE WHEN mcc_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of major complications/comorbidities - impacts severity and reimbursement"
    - name: "cc_mcc_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN complication_comorbidity_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Complication/comorbidity rate - case mix and severity indicator"
    - name: "cdi_query_count"
      expr: SUM(CASE WHEN cdi_query_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of diagnoses with CDI queries - documentation quality indicator"
    - name: "cdi_query_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN cdi_query_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "CDI query rate - measures documentation improvement opportunity"
    - name: "sdoh_diagnosis_count"
      expr: SUM(CASE WHEN sdoh_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of social determinants of health diagnoses - population health metric"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_procedure_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Surgical and procedural volume, efficiency, quality, and revenue metrics tracking procedure throughput, duration, cancellations, and charge capture across service lines."
  source: "`vibe_healthcare_v1`.`clinical`.`procedure_event`"
  dimensions:
    - name: "procedure_status"
      expr: procedure_status
      comment: "Status of the procedure (completed, cancelled, in-progress, scheduled)"
    - name: "procedure_type"
      expr: procedure_type
      comment: "Type or category of procedure performed"
    - name: "procedure_category"
      expr: procedure_category
      comment: "High-level procedure category for grouping"
    - name: "service_line"
      expr: service_line
      comment: "Clinical service line (cardiology, orthopedics, general surgery, etc.)"
    - name: "procedure_year"
      expr: YEAR(procedure_date)
      comment: "Year the procedure was performed"
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_date)
      comment: "Month the procedure was performed"
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Type of anesthesia used (general, regional, local, MAC)"
    - name: "asa_classification"
      expr: asa_classification
      comment: "ASA physical status classification - patient risk indicator"
    - name: "approach"
      expr: approach
      comment: "Surgical approach (open, laparoscopic, robotic, endoscopic)"
    - name: "laterality"
      expr: laterality
      comment: "Body side for bilateral procedures (left, right, bilateral)"
    - name: "priority"
      expr: priority
      comment: "Procedure priority (elective, urgent, emergent)"
    - name: "wound_classification"
      expr: wound_classification
      comment: "Surgical wound classification (clean, clean-contaminated, contaminated, dirty)"
    - name: "is_timeout_performed"
      expr: timeout_performed
      comment: "Whether surgical timeout was performed - safety metric"
    - name: "is_specimen_collected"
      expr: specimen_collected
      comment: "Whether specimen was collected during procedure"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason for procedure cancellation if applicable"
  measures:
    - name: "total_procedures"
      expr: COUNT(1)
      comment: "Total number of procedure events"
    - name: "unique_patients_with_procedures"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients who had procedures"
    - name: "completed_procedures"
      expr: SUM(CASE WHEN procedure_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed procedures"
    - name: "cancelled_procedures"
      expr: SUM(CASE WHEN procedure_status = 'cancelled' THEN 1 ELSE 0 END)
      comment: "Count of cancelled procedures - efficiency and access metric"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN procedure_status = 'cancelled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Procedure cancellation rate - operational efficiency indicator"
    - name: "total_procedure_minutes"
      expr: SUM(CAST(duration_minutes AS DOUBLE))
      comment: "Total procedure duration in minutes across all procedures"
    - name: "avg_procedure_duration_minutes"
      expr: AVG(CAST(duration_minutes AS DOUBLE))
      comment: "Average procedure duration in minutes - efficiency metric"
    - name: "total_charge_amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total procedure charge amount - revenue metric"
    - name: "avg_charge_per_procedure"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per procedure - pricing and revenue metric"
    - name: "total_rvu_work"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work relative value units - productivity and reimbursement metric"
    - name: "avg_rvu_per_procedure"
      expr: AVG(CAST(rvu_work AS DOUBLE))
      comment: "Average work RVUs per procedure - complexity and value indicator"
    - name: "total_estimated_blood_loss_ml"
      expr: SUM(CAST(estimated_blood_loss_ml AS DOUBLE))
      comment: "Total estimated blood loss across procedures - quality and safety metric"
    - name: "avg_blood_loss_ml"
      expr: AVG(CAST(estimated_blood_loss_ml AS DOUBLE))
      comment: "Average estimated blood loss per procedure - surgical quality indicator"
    - name: "timeout_compliance_count"
      expr: SUM(CASE WHEN timeout_performed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of procedures with documented timeout - safety compliance metric"
    - name: "timeout_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN timeout_performed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Surgical timeout compliance rate - critical safety metric"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_allergy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allergy documentation and patient safety metrics tracking allergy prevalence, severity distribution, alert overrides, and reconciliation status for medication safety."
  source: "`vibe_healthcare_v1`.`clinical`.`allergy`"
  dimensions:
    - name: "allergen_type"
      expr: allergen_type
      comment: "Type of allergen (drug, food, environmental, etc.)"
    - name: "category"
      expr: allergy_category
      comment: "Allergy category classification"
    - name: "clinical_status"
      expr: clinical_status
      comment: "Clinical status of the allergy (active, inactive, resolved)"
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status (confirmed, unconfirmed, refuted)"
    - name: "severity"
      expr: severity
      comment: "Severity level of allergic reaction (mild, moderate, severe)"
    - name: "criticality"
      expr: criticality
      comment: "Criticality assessment (low, high, unable-to-assess)"
    - name: "reconciliation_status"
      expr: reconciliation_status
      comment: "Medication reconciliation status for the allergy"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where allergy was documented"
    - name: "recorded_year"
      expr: YEAR(recorded_date)
      comment: "Year the allergy was recorded"
    - name: "recorded_month"
      expr: DATE_TRUNC('MONTH', recorded_date)
      comment: "Month the allergy was recorded"
    - name: "is_no_known_allergy"
      expr: is_no_known_allergy
      comment: "Whether this is a no known allergy record"
    - name: "is_no_known_drug_allergy"
      expr: is_no_known_drug_allergy
      comment: "Whether this is a no known drug allergy record"
    - name: "is_deleted"
      expr: is_deleted
      comment: "Whether the allergy record has been deleted"
    - name: "has_data_quality_flag"
      expr: data_quality_flag
      comment: "Whether allergy record has data quality issues"
    - name: "alert_override_reason"
      expr: alert_override_reason
      comment: "Reason for overriding allergy alert if applicable"
  measures:
    - name: "total_allergy_records"
      expr: COUNT(1)
      comment: "Total number of allergy records"
    - name: "unique_patients_with_allergies"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct count of patients with documented allergies"
    - name: "active_allergies"
      expr: SUM(CASE WHEN clinical_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active allergy records"
    - name: "severe_allergies"
      expr: SUM(CASE WHEN severity = 'severe' THEN 1 ELSE 0 END)
      comment: "Count of severe allergies - patient safety metric"
    - name: "severe_allergy_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN severity = 'severe' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of allergies classified as severe"
    - name: "high_criticality_allergies"
      expr: SUM(CASE WHEN criticality = 'high' THEN 1 ELSE 0 END)
      comment: "Count of high criticality allergies - safety priority metric"
    - name: "unverified_allergies"
      expr: SUM(CASE WHEN verification_status = 'unconfirmed' THEN 1 ELSE 0 END)
      comment: "Count of unverified allergy records - documentation quality metric"
    - name: "verification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN verification_status = 'confirmed' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Allergy verification rate - documentation quality indicator"
    - name: "alert_overrides"
      expr: SUM(CASE WHEN alert_override_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of allergy alert overrides - safety monitoring metric"
    - name: "alert_override_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN alert_override_reason IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Allergy alert override rate - medication safety indicator"
    - name: "reconciled_allergies"
      expr: SUM(CASE WHEN reconciliation_status = 'reconciled' THEN 1 ELSE 0 END)
      comment: "Count of reconciled allergy records"
    - name: "reconciliation_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reconciliation_status = 'reconciled' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Allergy reconciliation rate - medication safety and transitions of care metric"
    - name: "data_quality_issues"
      expr: SUM(CASE WHEN data_quality_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of allergy records with data quality flags"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care coordination and population health metrics tracking care plan utilization, goal achievement, readmission risk, and value-based care program participation."
  source: "`vibe_healthcare_v1`.`clinical`.`care_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Current status of the care plan (active, completed, cancelled, on-hold)"
    - name: "plan_type"
      expr: plan_type
      comment: "Type of care plan (chronic disease, post-discharge, palliative, etc.)"
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for the plan (inpatient, outpatient, home health, etc.)"
    - name: "intent"
      expr: intent
      comment: "Intent of the care plan (proposal, plan, order, option)"
    - name: "population_health_program"
      expr: population_health_program
      comment: "Associated population health program (diabetes, CHF, COPD, etc.)"
    - name: "readmission_risk_level"
      expr: readmission_risk_level
      comment: "Patient readmission risk level (low, medium, high)"
    - name: "discharge_disposition"
      expr: discharge_disposition
      comment: "Discharge disposition for care planning"
    - name: "authored_year"
      expr: YEAR(authored_date)
      comment: "Year the care plan was authored"
    - name: "authored_month"
      expr: DATE_TRUNC('MONTH', authored_date)
      comment: "Month the care plan was authored"
    - name: "is_aco_attributed"
      expr: aco_attributed
      comment: "Whether patient is attributed to an ACO - value-based care indicator"
    - name: "has_advance_directive"
      expr: advance_directive_on_file
      comment: "Whether advance directive is on file"
    - name: "has_behavioral_health_flag"
      expr: behavioral_health_flag
      comment: "Whether patient has behavioral health needs"
    - name: "has_sdoh_flag"
      expr: sdoh_flag
      comment: "Whether patient has social determinants of health needs"
    - name: "has_transitions_of_care_flag"
      expr: transitions_of_care_flag
      comment: "Whether plan involves transitions of care"
    - name: "cdi_review_status"
      expr: cdi_review_status
      comment: "Clinical documentation improvement review status"
  measures:
    - name: "total_care_plans"
      expr: COUNT(1)
      comment: "Total number of care plans"
    - name: "unique_patients_with_care_plans"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct count of patients with care plans"
    - name: "active_care_plans"
      expr: SUM(CASE WHEN plan_status = 'active' THEN 1 ELSE 0 END)
      comment: "Count of active care plans - care coordination workload metric"
    - name: "high_risk_readmission_plans"
      expr: SUM(CASE WHEN readmission_risk_level = 'high' THEN 1 ELSE 0 END)
      comment: "Count of care plans for high readmission risk patients - quality focus metric"
    - name: "high_risk_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN readmission_risk_level = 'high' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of care plans for high-risk patients"
    - name: "aco_attributed_plans"
      expr: SUM(CASE WHEN aco_attributed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of care plans for ACO-attributed patients - value-based care metric"
    - name: "aco_attribution_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN aco_attributed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "ACO attribution rate - value-based care penetration metric"
    - name: "sdoh_flagged_plans"
      expr: SUM(CASE WHEN sdoh_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of care plans addressing social determinants of health"
    - name: "behavioral_health_plans"
      expr: SUM(CASE WHEN behavioral_health_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of care plans with behavioral health component"
    - name: "transitions_of_care_plans"
      expr: SUM(CASE WHEN transitions_of_care_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of care plans involving care transitions - readmission prevention metric"
    - name: "advance_directive_on_file_count"
      expr: SUM(CASE WHEN advance_directive_on_file = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patients with advance directive on file"
    - name: "advance_directive_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN advance_directive_on_file = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Advance directive documentation rate - quality and compliance metric"
    - name: "total_goals"
      expr: SUM(CAST(goal_count AS DOUBLE))
      comment: "Total number of care plan goals across all plans"
    - name: "total_goals_achieved"
      expr: SUM(CAST(goals_achieved_count AS DOUBLE))
      comment: "Total number of achieved care plan goals"
    - name: "avg_goals_per_plan"
      expr: AVG(CAST(goal_count AS DOUBLE))
      comment: "Average number of goals per care plan"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_immunization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Immunization coverage and public health reporting metrics tracking vaccination rates, series completion, adverse reactions, and registry reporting compliance."
  source: "`vibe_healthcare_v1`.`clinical`.`immunization`"
  dimensions:
    - name: "administration_status"
      expr: administration_status
      comment: "Status of vaccine administration (completed, not-done, entered-in-error)"
    - name: "series_name"
      expr: series_name
      comment: "Name of the vaccine series (e.g., COVID-19, influenza, HPV)"
    - name: "series_completion_status"
      expr: series_completion_status
      comment: "Whether vaccine series is complete, in-progress, or incomplete"
    - name: "funding_source_code"
      expr: funding_source_code
      comment: "Funding source for vaccine (private, VFC, state, etc.)"
    - name: "vfc_eligibility_code"
      expr: vfc_eligibility_code
      comment: "Vaccines for Children program eligibility code"
    - name: "administration_year"
      expr: YEAR(administration_timestamp)
      comment: "Year the vaccine was administered"
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_timestamp)
      comment: "Month the vaccine was administered"
    - name: "administration_route_code"
      expr: administration_route_code
      comment: "Route of administration (IM, SC, oral, intranasal)"
    - name: "administration_site_code"
      expr: administration_site_code
      comment: "Body site where vaccine was administered"
    - name: "is_consent_obtained"
      expr: consent_obtained
      comment: "Whether patient consent was obtained"
    - name: "is_reaction_observed"
      expr: reaction_observed
      comment: "Whether adverse reaction was observed"
    - name: "is_iis_reported"
      expr: iis_reported
      comment: "Whether immunization was reported to immunization information system"
    - name: "is_vaers_reported"
      expr: vaers_reported
      comment: "Whether adverse event was reported to VAERS"
    - name: "not_given_reason_code"
      expr: not_given_reason_code
      comment: "Reason vaccine was not given if applicable"
  measures:
    - name: "total_immunizations"
      expr: COUNT(1)
      comment: "Total number of immunization records"
    - name: "unique_patients_immunized"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients who received immunizations"
    - name: "completed_immunizations"
      expr: SUM(CASE WHEN administration_status = 'completed' THEN 1 ELSE 0 END)
      comment: "Count of completed immunizations"
    - name: "series_completed_count"
      expr: SUM(CASE WHEN series_completion_status = 'complete' THEN 1 ELSE 0 END)
      comment: "Count of completed vaccine series - coverage metric"
    - name: "series_completion_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN series_completion_status = 'complete' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Vaccine series completion rate - public health coverage indicator"
    - name: "adverse_reactions"
      expr: SUM(CASE WHEN reaction_observed = TRUE THEN 1 ELSE 0 END)
      comment: "Count of immunizations with observed adverse reactions - safety metric"
    - name: "adverse_reaction_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reaction_observed = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Adverse reaction rate - vaccine safety monitoring metric"
    - name: "iis_reported_count"
      expr: SUM(CASE WHEN iis_reported = TRUE THEN 1 ELSE 0 END)
      comment: "Count of immunizations reported to immunization registry"
    - name: "iis_reporting_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN iis_reported = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Immunization registry reporting rate - public health compliance metric"
    - name: "vaers_reported_count"
      expr: SUM(CASE WHEN vaers_reported = TRUE THEN 1 ELSE 0 END)
      comment: "Count of adverse events reported to VAERS"
    - name: "consent_obtained_count"
      expr: SUM(CASE WHEN consent_obtained = TRUE THEN 1 ELSE 0 END)
      comment: "Count of immunizations with documented consent"
    - name: "consent_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN consent_obtained = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Consent documentation rate - compliance and patient safety metric"
    - name: "vfc_eligible_immunizations"
      expr: SUM(CASE WHEN vfc_eligibility_code IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of VFC-eligible immunizations - program utilization metric"
    - name: "total_dose_quantity"
      expr: SUM(CAST(dose_quantity AS DOUBLE))
      comment: "Total vaccine dose quantity administered"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_vital_sign`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vital signs monitoring and early warning metrics tracking vital sign capture frequency, abnormal values, early warning scores, and telemetry utilization for patient surveillance."
  source: "`vibe_healthcare_v1`.`clinical`.`vital_sign`"
  dimensions:
    - name: "observation_type"
      expr: observation_type
      comment: "Type of vital sign observation (blood pressure, heart rate, temperature, etc.)"
    - name: "observation_status"
      expr: observation_status
      comment: "Status of the observation (final, preliminary, amended, cancelled)"
    - name: "care_unit"
      expr: care_unit
      comment: "Care unit where vital sign was captured"
    - name: "measurement_year"
      expr: YEAR(measurement_timestamp)
      comment: "Year the vital sign was measured"
    - name: "measurement_month"
      expr: DATE_TRUNC('MONTH', measurement_timestamp)
      comment: "Month the vital sign was measured"
    - name: "is_abnormal"
      expr: abnormal_flag
      comment: "Whether vital sign value is outside normal range"
    - name: "is_patient_reported"
      expr: is_patient_reported
      comment: "Whether vital sign was patient-reported vs clinician-measured"
    - name: "is_telemetry_derived"
      expr: is_telemetry_derived
      comment: "Whether vital sign was derived from telemetry monitoring"
    - name: "measurement_method"
      expr: measurement_method
      comment: "Method used to measure vital sign (manual, automated, telemetry)"
    - name: "patient_position"
      expr: patient_position
      comment: "Patient position during measurement (sitting, standing, supine)"
    - name: "body_site"
      expr: body_site
      comment: "Body site where measurement was taken"
    - name: "oxygen_delivery_method"
      expr: oxygen_delivery_method
      comment: "Oxygen delivery method if applicable (room air, nasal cannula, mask, etc.)"
    - name: "pain_scale_type"
      expr: pain_scale_type
      comment: "Pain scale used if pain assessment (numeric, FLACC, Wong-Baker)"
    - name: "ews_score_type"
      expr: ews_score_type
      comment: "Early warning score type (NEWS, MEWS, PEWS)"
    - name: "gcs_component"
      expr: gcs_component
      comment: "Glasgow Coma Scale component if neurological assessment"
  measures:
    - name: "total_vital_signs"
      expr: COUNT(1)
      comment: "Total number of vital sign measurements"
    - name: "unique_patients_monitored"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct count of patients with vital sign measurements"
    - name: "abnormal_vital_signs"
      expr: SUM(CASE WHEN abnormal_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of abnormal vital sign values - clinical surveillance metric"
    - name: "abnormal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN abnormal_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Abnormal vital sign rate - patient acuity indicator"
    - name: "telemetry_derived_count"
      expr: SUM(CASE WHEN is_telemetry_derived = TRUE THEN 1 ELSE 0 END)
      comment: "Count of telemetry-derived vital signs"
    - name: "telemetry_utilization_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN is_telemetry_derived = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Telemetry utilization rate - monitoring technology adoption metric"
    - name: "patient_reported_count"
      expr: SUM(CASE WHEN is_patient_reported = TRUE THEN 1 ELSE 0 END)
      comment: "Count of patient-reported vital signs"
    - name: "avg_numeric_value"
      expr: AVG(CAST(numeric_value AS DOUBLE))
      comment: "Average numeric value across all vital sign measurements"
    - name: "avg_supplemental_oxygen_flow"
      expr: AVG(CAST(supplemental_oxygen_flow_rate AS DOUBLE))
      comment: "Average supplemental oxygen flow rate - respiratory support metric"
    - name: "measurements_with_ews_score"
      expr: SUM(CASE WHEN ews_score_type IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of vital signs with early warning score calculated"
    - name: "ews_score_capture_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN ews_score_type IS NOT NULL THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Early warning score capture rate - patient safety surveillance metric"
    - name: "amended_measurements"
      expr: SUM(CASE WHEN amended_reason IS NOT NULL THEN 1 ELSE 0 END)
      comment: "Count of amended vital sign measurements - data quality metric"
$$;
