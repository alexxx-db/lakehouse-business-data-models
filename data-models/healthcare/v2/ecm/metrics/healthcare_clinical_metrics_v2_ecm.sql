-- Metric views for domain: clinical | Business: Healthcare | Version: 2 | Generated on: 2026-07-10 14:53:25

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_diagnosis`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical diagnosis KPIs for documentation quality, coding integrity, and quality-measure capture that steer CDI programs and HAC/quality risk mitigation."
  source: "`vibe_healthcare_v1`.`clinical`.`diagnosis`"
  dimensions:
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting in which the diagnosis was recorded (inpatient, outpatient, ED)."
    - name: "diagnosis_type"
      expr: diagnosis_type
      comment: "Type of diagnosis (principal, secondary, admitting) for coding analysis."
    - name: "coding_status"
      expr: coding_status
      comment: "Coding lifecycle status used to monitor coding backlog and completeness."
    - name: "clinical_status"
      expr: clinical_status
      comment: "Clinical status of the diagnosis (active, resolved) for population health."
    - name: "diagnosis_month"
      expr: DATE_TRUNC('MONTH', diagnosis_date)
      comment: "Diagnosis month for trending diagnosis volumes and coding turnaround."
  measures:
    - name: "Diagnosis Count"
      expr: COUNT(1)
      comment: "Total number of diagnoses recorded; baseline volume for coding workload."
    - name: "HAC Diagnosis Count"
      expr: COUNT(CASE WHEN hac_flag = TRUE THEN 1 END)
      comment: "Hospital-acquired condition diagnoses; directly tied to CMS penalty risk."
    - name: "HAC Diagnosis Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN hac_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of diagnoses flagged HAC; a leadership quality/risk steering metric."
    - name: "CDI Query Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cdi_query_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of diagnoses generating a CDI query; measures documentation gaps."
    - name: "MCC Diagnosis Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN mcc_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Share of diagnoses that are major complications/comorbidities; DRG revenue driver."
    - name: "Quality Measure Diagnosis Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN quality_measure_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of diagnoses linked to a quality measure; monitors quality capture."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_cdi_query`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical Documentation Integrity query KPIs measuring physician responsiveness and financial reimbursement impact that steer CDI staffing and revenue integrity."
  source: "`vibe_healthcare_v1`.`clinical`.`cdi_query`"
  dimensions:
    - name: "query_status"
      expr: query_status
      comment: "Lifecycle status of the CDI query (open, responded, expired)."
    - name: "query_type"
      expr: query_type
      comment: "Type/classification of the CDI query for workflow analysis."
    - name: "query_outcome"
      expr: query_outcome
      comment: "Outcome of the query (agreed, disagreed, no change) for effectiveness."
    - name: "encounter_type"
      expr: encounter_type
      comment: "Encounter type associated with the query for service-line CDI focus."
    - name: "query_issue_month"
      expr: DATE_TRUNC('MONTH', query_issue_date)
      comment: "Month the query was issued for CDI trend analysis."
  measures:
    - name: "CDI Query Count"
      expr: COUNT(1)
      comment: "Total CDI queries issued; baseline CDI program volume."
    - name: "Expected Reimbursement Impact"
      expr: SUM(CAST(expected_reimbursement_impact AS DOUBLE))
      comment: "Total expected reimbursement impact from CDI queries; revenue integrity driver."
    - name: "Actual Reimbursement Impact"
      expr: SUM(CAST(actual_reimbursement_impact AS DOUBLE))
      comment: "Total realized reimbursement impact from CDI queries."
    - name: "Avg Actual Reimbursement Impact"
      expr: AVG(CAST(actual_reimbursement_impact AS DOUBLE))
      comment: "Average realized reimbursement per query; measures per-query value."
    - name: "Query Response Rate Pct"
      expr: ROUND(100.0 * COUNT(query_response_date) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of queries that received a physician response; responsiveness KPI."
    - name: "Coding Impact Query Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN coding_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of queries that changed coding; effectiveness of CDI program."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_hai_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Healthcare-associated infection KPIs tracking infection burden, NHSN reporting compliance, and mortality that steer infection prevention and VBP penalty avoidance."
  source: "`vibe_healthcare_v1`.`clinical`.`hai_event`"
  dimensions:
    - name: "infection_type"
      expr: infection_type
      comment: "Primary HAI infection type (CLABSI, CAUTI, SSI, etc.)."
    - name: "event_status"
      expr: event_status
      comment: "Lifecycle status of the HAI event for surveillance tracking."
    - name: "nhsn_reporting_status"
      expr: nhsn_reporting_status
      comment: "NHSN submission status for regulatory reporting compliance."
    - name: "infection_onset_setting"
      expr: infection_onset_setting
      comment: "Setting where infection onset occurred for attribution analysis."
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_date)
      comment: "Month of the HAI event for infection trend surveillance."
  measures:
    - name: "HAI Event Count"
      expr: COUNT(1)
      comment: "Total HAI events; core infection prevention burden metric."
    - name: "Distinct Patients Affected"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with an HAI event; measures patient-level impact."
    - name: "NHSN Definition Met Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN nhsn_definition_met = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of events meeting NHSN definitions; reportable-case surveillance KPI."
    - name: "VBP Penalty Event Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN vbp_penalty_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of HAI events flagged for VBP penalty; direct financial risk driver."
    - name: "Outbreak-Linked Event Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN outbreak_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of HAI events tied to an outbreak; escalation-signal metric."
    - name: "Present On Admission Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN present_on_admission = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of events present on admission (not facility-attributable); attribution KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_procedure_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Procedure event KPIs covering surgical volume, charge capture, RVU productivity, and safety-timeout compliance that steer OR utilization and revenue capture."
  source: "`vibe_healthcare_v1`.`clinical`.`procedure_event`"
  dimensions:
    - name: "procedure_status"
      expr: procedure_status
      comment: "Status of the procedure (completed, cancelled, scheduled)."
    - name: "procedure_category"
      expr: procedure_category
      comment: "Category of procedure for service-line volume analysis."
    - name: "service_line"
      expr: service_line
      comment: "Service line performing the procedure for productivity comparison."
    - name: "anesthesia_type"
      expr: anesthesia_type
      comment: "Anesthesia type used, for perioperative resource analysis."
    - name: "procedure_month"
      expr: DATE_TRUNC('MONTH', procedure_date)
      comment: "Month of procedure for volume and productivity trending."
  measures:
    - name: "Procedure Count"
      expr: COUNT(1)
      comment: "Total procedures performed; baseline OR/procedural volume."
    - name: "Total Charge Amount"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total charges generated by procedures; revenue capture driver."
    - name: "Total Work RVU"
      expr: SUM(CAST(rvu_work AS DOUBLE))
      comment: "Total work RVUs; physician productivity and compensation driver."
    - name: "Avg Charge Amount"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per procedure; case-mix and pricing insight."
    - name: "Timeout Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN timeout_performed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of procedures with a surgical safety timeout; patient-safety KPI."
    - name: "Consent Obtained Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of procedures with documented consent; compliance risk metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_immunization`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Immunization KPIs for administration volume, series completion, and registry reporting compliance that steer population health and public-health obligations."
  source: "`vibe_healthcare_v1`.`clinical`.`immunization`"
  dimensions:
    - name: "administration_status"
      expr: administration_status
      comment: "Status of the immunization administration (administered, refused, not given)."
    - name: "series_completion_status"
      expr: series_completion_status
      comment: "Series completion status for vaccine-series tracking."
    - name: "series_name"
      expr: series_name
      comment: "Vaccine series name for coverage analysis."
    - name: "administration_month"
      expr: DATE_TRUNC('MONTH', administration_timestamp)
      comment: "Month of administration for immunization trend analysis."
  measures:
    - name: "Immunization Count"
      expr: COUNT(1)
      comment: "Total immunization records; baseline administration volume."
    - name: "Distinct Patients Immunized"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients immunized; population coverage sizing."
    - name: "IIS Reporting Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN iis_reported = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of immunizations reported to the state registry; compliance KPI."
    - name: "Consent Obtained Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN consent_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of immunizations with documented consent; compliance metric."
    - name: "Reaction Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN reaction_observed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of immunizations with an observed reaction; safety surveillance KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_care_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan KPIs measuring active care management, review timeliness, and readmission risk stratification that steer population health and value-based care."
  source: "`vibe_healthcare_v1`.`clinical`.`care_plan`"
  dimensions:
    - name: "plan_status"
      expr: plan_status
      comment: "Status of the care plan (active, completed, on-hold)."
    - name: "plan_type"
      expr: plan_type
      comment: "Type of care plan for program-level analysis."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting for the plan for coordination context."
    - name: "readmission_risk_level"
      expr: readmission_risk_level
      comment: "Readmission risk stratification level for intervention targeting."
    - name: "authored_month"
      expr: DATE_TRUNC('MONTH', authored_date)
      comment: "Month the plan was authored for care-management trending."
  measures:
    - name: "Care Plan Count"
      expr: COUNT(1)
      comment: "Total care plans; baseline care-management volume."
    - name: "Patient Consent Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_consent_obtained = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of care plans with obtained patient consent; engagement KPI."
    - name: "ACO Attributed Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN aco_attributed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of care plans attributed to an ACO; value-based-care alignment."
    - name: "Transitions Of Care Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN transitions_of_care_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of plans flagged for transitions of care; readmission-prevention KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_care_plan_goal`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Care plan goal KPIs measuring goal achievement and patient agreement that steer care-coordination effectiveness and outcomes."
  source: "`vibe_healthcare_v1`.`clinical`.`care_plan_goal`"
  dimensions:
    - name: "goal_status"
      expr: goal_status
      comment: "Current status of the goal (in-progress, achieved, cancelled)."
    - name: "achievement_status"
      expr: achievement_status
      comment: "Achievement status classification for outcome measurement."
    - name: "priority"
      expr: priority
      comment: "Priority of the goal for care-team focus."
    - name: "target_month"
      expr: DATE_TRUNC('MONTH', target_date)
      comment: "Target month for goal-timeliness analysis."
  measures:
    - name: "Goal Count"
      expr: COUNT(1)
      comment: "Total care plan goals; baseline goal-management volume."
    - name: "Goal Achievement Rate Pct"
      expr: ROUND(100.0 * COUNT(achieved_date) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of goals with a recorded achievement date; outcome effectiveness KPI."
    - name: "Patient Agreement Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_agreement = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of goals with patient agreement; engagement and shared-decision KPI."
    - name: "Care Gap Related Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN care_gap_related = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of goals addressing a care gap; quality-improvement targeting."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_note`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical note KPIs measuring documentation timeliness, signature/cosignature compliance, and CDI impact that steer documentation governance."
  source: "`vibe_healthcare_v1`.`clinical`.`note`"
  dimensions:
    - name: "note_type"
      expr: note_type
      comment: "Type of clinical note for documentation-mix analysis."
    - name: "note_status"
      expr: note_status
      comment: "Status of the note (draft, signed, amended)."
    - name: "care_setting"
      expr: care_setting
      comment: "Care setting where the note was authored."
    - name: "authored_month"
      expr: DATE_TRUNC('MONTH', authored_timestamp)
      comment: "Month the note was authored for documentation trending."
  measures:
    - name: "Note Count"
      expr: COUNT(1)
      comment: "Total clinical notes; baseline documentation volume."
    - name: "Signed Note Rate Pct"
      expr: ROUND(100.0 * COUNT(signed_timestamp) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of notes with a signature timestamp; documentation-completeness KPI."
    - name: "Late Entry Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_late_entry = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of notes flagged as late entries; timeliness and compliance risk KPI."
    - name: "CDI Query Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN cdi_query_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of notes generating a CDI query; documentation-quality signal."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_allergy`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Allergy KPIs measuring reconciliation completeness and criticality that steer medication safety and CPOE alerting."
  source: "`vibe_healthcare_v1`.`clinical`.`allergy`"
  dimensions:
    - name: "clinical_status"
      expr: clinical_status
      comment: "Clinical status of the allergy (active, inactive, resolved)."
    - name: "criticality"
      expr: criticality
      comment: "Criticality classification for safety-alert prioritization."
    - name: "verification_status"
      expr: verification_status
      comment: "Verification status of the allergy record."
    - name: "recorded_month"
      expr: DATE_TRUNC('MONTH', recorded_date)
      comment: "Month the allergy was recorded for trend analysis."
  measures:
    - name: "Allergy Count"
      expr: COUNT(1)
      comment: "Total allergy records; baseline allergy-documentation volume."
    - name: "Distinct Patients With Allergies"
      expr: COUNT(DISTINCT demographics_id)
      comment: "Distinct patients with documented allergies; safety-coverage sizing."
    - name: "Reconciled Allergy Rate Pct"
      expr: ROUND(100.0 * COUNT(reconciliation_date) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of allergies with a reconciliation date; medication-safety KPI."
    - name: "Confirmed Allergy Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN verification_status = 'confirmed' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of allergies confirmed; data-quality and safety metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_outbreak`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outbreak KPIs tracking case burden, mortality, and containment/reporting compliance that steer infection prevention and public-health response."
  source: "`vibe_healthcare_v1`.`clinical`.`outbreak`"
  dimensions:
    - name: "outbreak_status"
      expr: outbreak_status
      comment: "Status of the outbreak (active, contained, resolved)."
    - name: "pathogen_type"
      expr: pathogen_type
      comment: "Pathogen type driving the outbreak for response planning."
    - name: "severity_level"
      expr: severity_level
      comment: "Severity level classification for escalation."
    - name: "detection_month"
      expr: DATE_TRUNC('MONTH', detection_date)
      comment: "Month the outbreak was detected for surveillance trending."
  measures:
    - name: "Outbreak Count"
      expr: COUNT(1)
      comment: "Total outbreaks; baseline outbreak surveillance volume."
    - name: "Avg Case Fatality Rate"
      expr: AVG(CAST(case_fatality_rate AS DOUBLE))
      comment: "Average case fatality rate across outbreaks; severity and outcome KPI."
    - name: "Public Health Alert Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN public_health_alert_issued_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of outbreaks with a public-health alert issued; reporting compliance KPI."
    - name: "Source Identified Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN source_identified_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of outbreaks with an identified source; investigation-effectiveness KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_nursing_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Nursing assessment KPIs measuring risk-screening completion, safety compliance, and patient education that steer nursing quality and patient safety."
  source: "`vibe_healthcare_v1`.`clinical`.`nursing_assessment`"
  dimensions:
    - name: "assessment_type"
      expr: assessment_type
      comment: "Type of nursing assessment performed."
    - name: "assessment_status"
      expr: assessment_status
      comment: "Status of the assessment (completed, in-progress)."
    - name: "fall_risk_category"
      expr: fall_risk_category
      comment: "Fall-risk category for risk-stratified nursing intervention."
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_timestamp)
      comment: "Month of assessment for nursing-quality trending."
  measures:
    - name: "Assessment Count"
      expr: COUNT(1)
      comment: "Total nursing assessments; baseline nursing-workload volume."
    - name: "Distinct Patients Assessed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients assessed; nursing-coverage sizing."
    - name: "Safety Check Completion Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN safety_check_completed = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assessments with a completed safety check; patient-safety KPI."
    - name: "Patient Education Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN patient_education_provided = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assessments with patient education provided; engagement KPI."
    - name: "Joint Commission Compliance Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN joint_commission_compliant = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of assessments meeting Joint Commission standards; accreditation KPI."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_observation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Clinical observation KPIs measuring critical-value burden and amendment rates that steer clinical safety and data-quality governance."
  source: "`vibe_healthcare_v1`.`clinical`.`observation`"
  dimensions:
    - name: "observation_category"
      expr: observation_category
      comment: "Category of observation for clinical-domain analysis."
    - name: "observation_status"
      expr: observation_status
      comment: "Status of the observation (final, preliminary, amended)."
    - name: "body_system"
      expr: body_system
      comment: "Body system observed for clinical grouping."
    - name: "observed_month"
      expr: DATE_TRUNC('MONTH', datetime)
      comment: "Month of the observation for trend analysis."
  measures:
    - name: "Observation Count"
      expr: COUNT(1)
      comment: "Total observations; baseline clinical-data volume."
    - name: "Distinct Patients Observed"
      expr: COUNT(DISTINCT mpi_record_id)
      comment: "Distinct patients with observations; population sizing."
    - name: "Critical Value Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_critical_value = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of observations that are critical values; clinical-safety escalation KPI."
    - name: "Amendment Rate Pct"
      expr: ROUND(100.0 * COUNT(CASE WHEN is_amended = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percent of observations amended; data-quality and integrity metric."
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_care_plan_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key quality indicators for care plans"
  source: "`vibe_healthcare_v1`.`clinical`.`care_plan`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Care site associated with the care plan"
    - name: "care_plan_type"
      expr: plan_type
      comment: "Type/category of the care plan"
    - name: "effective_start_month"
      expr: DATE_TRUNC('month', effective_start_date)
      comment: "Month when the care plan became effective"
    - name: "readmission_risk_level"
      expr: readmission_risk_level
      comment: "Risk level for patient readmission"
  measures:
    - name: "care_plan_count"
      expr: COUNT(1)
      comment: "Total number of care plans"
    - name: "advance_directive_on_file_count"
      expr: SUM(CASE WHEN advance_directive_on_file THEN 1 ELSE 0 END)
      comment: "Count of care plans with an advance directive on file"
    - name: "patient_consent_obtained_count"
      expr: SUM(CASE WHEN patient_consent_obtained THEN 1 ELSE 0 END)
      comment: "Count of care plans where patient consent was obtained"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_observation_numeric`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregates for numeric clinical observations"
  source: "`vibe_healthcare_v1`.`clinical`.`observation`"
  dimensions:
    - name: "loinc_code_id"
      expr: loinc_code_id
      comment: "LOINC code identifying the observation type"
    - name: "observation_status"
      expr: observation_status
      comment: "Status of the observation (e.g., final, preliminary)"
  measures:
    - name: "avg_numeric_value"
      expr: AVG(CAST(value_numeric AS DOUBLE))
      comment: "Average numeric observation value"
    - name: "observation_count"
      expr: COUNT(1)
      comment: "Number of observation records"
$$;

CREATE OR REPLACE VIEW `vibe_healthcare_v1`.`_metrics`.`clinical_procedure_financials`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance of clinical procedures"
  source: "`vibe_healthcare_v1`.`clinical`.`procedure_event`"
  dimensions:
    - name: "care_site_id"
      expr: care_site_id
      comment: "Identifier of the care site where the procedure occurred"
    - name: "procedure_month"
      expr: DATE_TRUNC('month', procedure_date)
      comment: "Month of the procedure date"
  measures:
    - name: "total_procedure_charge"
      expr: SUM(CAST(charge_amount AS DOUBLE))
      comment: "Total dollar amount charged for procedures"
    - name: "average_procedure_charge"
      expr: AVG(CAST(charge_amount AS DOUBLE))
      comment: "Average charge per procedure record"
    - name: "procedure_count"
      expr: COUNT(1)
      comment: "Number of procedure events recorded"
$$;